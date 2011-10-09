import java.io.IOException;
import java.util.Calendar;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.DateFormat;

public abstract class AbstractGamePlayer extends NanoHTTPD {
	
	public AbstractGamePlayer(int port) throws IOException {
		super(port);
	}
	public AbstractGamePlayer() {
		
	}
	
	public Response serve( String uri, String method, Properties header, Properties parms, String data )
	{
		try{
			String response_string=null;
			if(data!=null){
				System.out.println(DateFormat.getTimeInstance(DateFormat.FULL).format(Calendar.getInstance().getTime()));
				System.out.println("Command: " + data);
				String command=getCommand(data);
				if(command==null){
					throw(new IllegalArgumentException("Unknown message format"));
				}else if(command.equals("START")){
					response_string="READY";
					commandStart(data);
				}else if(command.equals("PLAY")){
					response_string=commandPlay(data);
/*				}else if(command.equals("replay")){
					response_string=commandReplay(data);*/
				}else if(command.equals("STOP")){
					response_string="DONE";
					commandStop(data);
				}else{
					throw(new IllegalArgumentException("Unknown command:"+command));
				}
			}else{
				throw(new IllegalArgumentException("Message is empty!"));
			}
			System.out.println(DateFormat.getTimeInstance(DateFormat.FULL).format(Calendar.getInstance().getTime()));
			System.out.println("Response:"+response_string);
			if(response_string!=null && response_string.equals("")) response_string=null;
			return new Response( HTTP_OK, "text/acl", response_string );
		}catch(IllegalArgumentException ex){
			System.err.println(ex);
			ex.printStackTrace();
			return new Response( HTTP_BADREQUEST, "text/acl", "NIL" );
		}
	}

	abstract protected void commandStart(String msg);

	abstract protected String commandPlay(String msg);

	abstract protected void commandStop(String msg);

	private String getCommand(String msg){
		String cmd=null;
		try{
			Matcher m=Pattern.compile("\\(([^\\s]*)\\s").matcher(msg);
			if(m.lookingAt()){
				cmd=m.group(1);
			}
			cmd.toUpperCase();
		}catch(Exception ex){
			System.err.println("Pattern to extract command did not match!");
			ex.printStackTrace();
		}
		return cmd;
	}

	public void waitForExit(){
		try {
			server_thread.join(); // wait for server thread to exit
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}