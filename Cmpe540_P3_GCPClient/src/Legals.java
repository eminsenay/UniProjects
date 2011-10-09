import java.util.ArrayList;


public class Legals {
	
	/*
	 * 		(<= (LEGAL ROBOT GRAB) (TRUE (CELL ?X)) (TRUE (GOLD ?X))) 
	 * 		satırını tutacak.
	 * 		
	 * 		name = "ROBOT GRAB"
	 * 		requirements = CELL ?X, GOLD ?X
	 */
	
	private String name = "";
	private ArrayList<String> requirements = new ArrayList<String>();
	private boolean available = false;
	
	
		
	public boolean isAvailable() {
		return available;
	}
	public void setAvailable(boolean available) {
		this.available = available;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public ArrayList<String> getRequirements() {
		return requirements;
	}
	public void setRequirements(ArrayList<String> requirements) {
		this.requirements = requirements;
	} 
	

}
