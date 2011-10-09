import java.io.IOException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;

import cs227b.teamIago.gameProver.GameSimulator;
import cs227b.teamIago.parser.Parser;
import cs227b.teamIago.resolver.Atom;
import cs227b.teamIago.resolver.ExpList;
import cs227b.teamIago.resolver.Expression;
import cs227b.teamIago.util.GameState;

public class GamePlayer extends AbstractGamePlayer {

	private String selectedMove = "bok";
	private String matchID;
	private String myRole;
	private ArrayList allRoles = new ArrayList();
	private String startClock;
	private long playClock;
	GameSimulator myGGP;
	Random rnd = new Random();
	GameState currentState;
	int currentStep;
	boolean singlePlayer;

	public GamePlayer(int port) throws IOException {
		super(port);
	}
	public GamePlayer() {}

	public void initGame(String msg) {

		int startIndex = msg.indexOf("START");
		int secondPharIndex = msg.indexOf("(", startIndex);
		String firstSub = msg.substring(startIndex, secondPharIndex);
		String[] idAndRole = firstSub.split(" ");

		matchID = idAndRole[1];
		myRole = idAndRole[2];
		System.out.println("My role is " + myRole);

		//System.out.println(idAndRole[0] + " " + idAndRole[1] + " " + idAndRole[2]);	

		int lastPharIndex = msg.lastIndexOf(")");
		int secLastPharIndex = msg.lastIndexOf(")", lastPharIndex-1);

		firstSub = msg.substring(secLastPharIndex, lastPharIndex);
		String[] startandPlay = firstSub.split(" ");

		startClock = startandPlay[1];
		playClock = Long.parseLong(startandPlay[2]);
		//playClock = myplayClock.longValue();

		//System.out.println(startClock + " " + playClock);

		String desc = msg.substring(secondPharIndex+1, secLastPharIndex);
		//System.out.println(desc);

		ArrayList tokenList = tokenize(desc);

		String packBegin = "(true (";
		String packEnd = ")) ";
		String state = "";
		for (int i=0; i<tokenList.size(); i++) {

			String nextLine = (String) tokenList.get(i);
			//System.out.println(nextLine);
			int firstPharIndex = nextLine.indexOf("(");
			int firstSpaceIndex = nextLine.indexOf(" ", firstPharIndex);
			String firstWord = 
				nextLine.substring(firstPharIndex+1, firstSpaceIndex);

			//System.out.println(firstWord);

			if (firstWord.equals("INIT")) {														
				String initMid = nextLine.substring(firstSpaceIndex+2, nextLine.length()-2);
				//(true (step 1)) (true (gold c)) (true (cell a))
				String initStr = packBegin + initMid + packEnd;
				state += initStr;
			}
			else if (firstWord.equals("ROLE")) {

				String otherRole = nextLine.substring(firstSpaceIndex+1, nextLine.length()-1);
				allRoles.add(otherRole);
				//System.out.println("other role: " + otherRole);							
			} 

		}
		//System.out.println(state);

		String move = "";
		System.out.println("move is:    " + move);
		startGame(desc, state);
		currentStep = 0;

	}

	public void startGame(String desc1, String state1) {

		boolean wantDebugPrintouts;
		ExpList roles, legalMoves, goalValues;

		wantDebugPrintouts = false;

		boolean useOptimization = true;		
		myGGP = new GameSimulator(wantDebugPrintouts, useOptimization);

		System.out.println("**************** Game Initialization of match " + matchID + " *****************");

		myGGP.ParseDescIntoTheory(desc1);		
		myGGP.ParseDescIntoTheory(state1);

		// Get all the available roles
		roles = myGGP.GetRoles();

		if (roles == null) {
			System.out.println("No playable roles found: aborting.");
			System.exit(-1);
		}

		int i;
		for (i = 0; i < roles.size(); i++)
		{

			Expression player = roles.get(i);

			System.out.println("Player " + player.toString());
			legalMoves =  myGGP.GetLegalMoves(player);
			if (legalMoves == null)
				System.out.println("No legal moves found.");
			else
				System.out.println("Legal moves: " + legalMoves.toString());

			goalValues = myGGP.GetGoalValues(player);
			if (goalValues == null)
				System.out.println("No goal values found.");
			else
				System.out.println("Goal values: " +
						goalValues.toString());
		}
		if (roles.size() == 1)
			singlePlayer = true;
		else
			singlePlayer = false;

		if (myGGP.IsTerminal()) {
			System.out.println("Game is in terminal state.");
			System.out.println("(Not calculating next state.)");
		}
		else
		{
			System.out.println("Game is in non-terminal state.");
		}
		currentState = myGGP.GetGameState();


		System.out.println("************* End of Inıtialization of match " + matchID + " *************");
		// TODO oyun adını yazdır
	}

	private ArrayList tokenize(String msg) {

		int firstIndex = 0, lastIndex = 0, sum = 0;
		ArrayList tokenList = new ArrayList();

		for (int i=0; i<msg.length(); i++) {

			if (msg.charAt(i) == '(' || msg.charAt(i) == '[') {
				if (msg.charAt(firstIndex) != '(') {
					firstIndex = i;
				}
				sum++;
			} else
				if (msg.charAt(i) == ')' || msg.charAt(i) == ']') {
					sum--;
					if (sum==0) {
						lastIndex = i;
						//TODO

						String nextLine = msg.substring(firstIndex, lastIndex+1);
						nextLine = nextLine.trim();

						tokenList.add(nextLine);

						firstIndex = lastIndex + 1;
					}
				}
		}		

		return tokenList;
	}

	private String myReplace(String inpString, String delString, String repString) {

		int tmpLength = inpString.length();
		int indexOfKskn = inpString.indexOf(delString);
		String sub1 = inpString.substring(0, indexOfKskn);
		String sub2 = inpString.substring(indexOfKskn+delString.length(),tmpLength ); 

		return sub1 + repString + sub2;	
	}

	private ArrayList tokenizeMoves(String msg) {
		ArrayList tokens = new ArrayList();

		//msg = "(MARK 1 2) NOOP (MARK 2 3) NOOP";
		ArrayList tokensWithPhar = tokenize(msg);
		String temp = msg;

		for (int i=0; i<tokensWithPhar.size(); i++) {	
			String kskn = (String) tokensWithPhar.get(i);
			//String temp1 = temp.replace((String) tokensWithPhar.get(i), "");		
			temp = myReplace(temp, kskn, "");
		}
		temp = temp.trim();

		String[] tokensWithoutPhar = temp.split(" ");
		ArrayList tokensWithoutPharList = new ArrayList();
		for (int i = 0; i < tokensWithoutPhar.length; i++)
		{
			if (tokensWithoutPhar[i].trim().equals(""))
				continue;
			//System.out.println(tokensWithoutPhar[i]);
			if (!tokensWithoutPharList.contains(tokensWithoutPhar[i]))
				tokensWithoutPharList.add(tokensWithoutPhar[i]);					
		}						

		for (int i = 0; i < tokensWithoutPharList.size(); i++)
		{
			String lvnt = (String)tokensWithoutPharList.get(i);
			//String msg1 = msg.replace(lvnt, "[" + lvnt + "]");
			msg = myReplace(msg, lvnt, "[" + lvnt + "]");
		}

		ArrayList insallahLastList = tokenize(msg);
		for (int i = 0 ; i < insallahLastList.size(); i++)
		{
			String nextStr = (String)insallahLastList.get(i);
			if (nextStr.charAt(0) == '[')
				nextStr = nextStr.substring(1,nextStr.length()-1);
			//System.out.println(nextStr);

			tokens.add(nextStr);
		}

		return tokens;
	}	

	/**
	 * this method is called when a new match begins
	 */
	protected void commandStart(String msg){
		initGame(msg);
		return;
		// msg="(START <MATCH ID> <ROLE> <GAME DESCRIPTION> <STARTCLOCK> <PLAYCLOCK>)
		// e.g. msg="(START tictactoe1 white ((role white) (role black) ...) 1800 120)" means:
		//       - the current match is called "match0815"
		//       - your role is "white",
		//       - after at most 1800 seconds, you have to return from the commandStart method
		//       - for each move you have 120 seconds

		// TODO:
		//    - use the time to "contemplate" about the game description
		//      and return on time (before STARTCLOCK is over!)


	}

	int turnNo = 0;
	Expression noopExpression;
	private boolean myTurn = true;
	private int terminal;
	long startTime;
	/**
	 * this method is called once for each move
	 * @return the move of this player
	 */
	public String commandPlay(String msg){

		startTime = Calendar.getInstance().getTimeInMillis();
		turnNo++;
		// msg="(PLAY <MATCH ID> <JOINT MOVE>)
		// <JOINT MOVE> will be NIL for the first PLAY message and the list of the moves of all the players in the previous state
		// e.g. msg="(PLAY tictactoe1 NIL)" for the first PLAY message
		//   or msg="(PLAY tictactoe1 ((MARK 1 2) NOOP))" if white marked cell (1,2) and black did a "noop".

		// TODO:
		//    - calculate the new state from the old one and the <JOINT MOVE>
		//    - use the time to find the best of your possible moves in the current state
		//    - return your move (instead of "NIL") on time (before PLAYCLOCK is over!)

		System.out.println("-------------next turn------------");
		myGGP.SetGameState(currentState);
		currentStep++;
		/*
		 * Önce verilen harekete göre mevcut durumu güncelle.
		 * Sonra bu duruma göre olabilecek hareketleri belirle.
		 * Sonra bunların birini random seç burada return et.
		 * 
		 * */
		ArrayList moveList = tokenizePlay(msg);
		if (moveList != null) // Oyun yeni başlıyorsa null gelecek
		{					
			// Hareketlere göre state güncelle

			String updateStateMoves = "";
			for ( int i=0; i< allRoles.size(); i++) {
				updateStateMoves += ("(DOES " + allRoles.get(i) + " "
						+ (String)moveList.get(i) + ") ");			
			}
			updateStateMoves = updateStateMoves.trim();


			GameState oldState;
			oldState = myGGP.GetGameState();
			ExpList movesList;
			GameState nextState;
			movesList = Parser.parseDesc(updateStateMoves);
			myGGP.SimulateStep(movesList);

			nextState = myGGP.GetGameState();
			if (nextState == null)
				System.out.println("Could not calculate next state.");
			else
			{
				System.out.println("Next state: " + nextState);
				System.out.println("GGP's old state after Simulate:");
				System.out.println(oldState);
			}
			myGGP.SetGameState(nextState);
			currentState = nextState;
		}
		// Elimizdeki state e göre olabilecek hareketleri belirleyeceğiz.
		ExpList eL = myGGP.GetRoles(); //olabilecek bütün playerları veriyor
		Atom myAtm = null;
		Atom oppnAtm = null;
		String move = "";
		for (int i = 0; i < eL.size(); i++)
		{
			Atom atm = (Atom)eL.get(i);  // bir oyuncu
			//System.out.println("Literal:   " + atm.getLiteral());
			String nextRole = atm.getLiteral(); // oyuncunun string hali
			if (nextRole.equals(myRole)) {
				myAtm = atm;
				if (turnNo == 1) {
					if (i == 1) { 
						myTurn = false;			
					}
				}
			}
			else
			{
				oppnAtm = atm;
				if (turnNo == 1) {
					if (i == 1) { // Opponent ikinci oyuncu, önce bekleyip sonraki el başlayacak
						myTurn = true;
					}
				}
			}
		}
		ExpList myLegalMoves = myGGP.GetLegalMoves(myAtm);
		if (myLegalMoves == null)
		{
			System.out.println("No legal moves found...");
		}
		else
		{
			System.out.println("my legal moves are: " + myLegalMoves.toString());

			ArrayList myLegalMovesList = tokenize(myLegalMoves.toString());					

			/* Bu bulduğumuz updateStateMoves ile oyunun durumunu güncelleyeceğiz.*/

			//System.out.println("Minimax a giriyoruz...");
			if (myTurn)
			{
				// Iterative deepening
				int depth = 2;
				long currentTime = Calendar.getInstance().getTimeInMillis();
				while( (currentTime - startTime)  <= 0.3*playClock*1000 ) {  

					move = MiniMaxDecision(currentStep, singlePlayer, myAtm, oppnAtm,depth);
					
					// Does XPlayer mark 1 1 iken mark 1 1 veriyor
					move = (move.substring(move.indexOf(" ",move.indexOf(" ") + 1), move.length()-2)).trim();
					depth++;
					currentTime = Calendar.getInstance().getTimeInMillis();
					System.out.println("end of depth " + depth);
					System.out.println(currentTime - startTime);
					System.out.println(playClock);
				}
				if (!singlePlayer)
					myTurn = false;
			}
			else
			{
				move = (String)myLegalMovesList.get(0);
				move = (move.substring(move.indexOf(" ",move.indexOf(" ") + 1), move.length()-2)).trim();				
				myTurn = true;
			}
			System.out.println("My move is: " + move);
		}	
		return move;
	}

	/**
	 * @param numSteps Oyun kaçıncı adımda
	 * @param playerName Hangi oyuncu oynuyor
	 * */
	public String MiniMaxDecision(int numSteps, boolean singlePlayer, Atom playerName, Atom opponent, int depth) {		
		GameState initialState = myGGP.GetGameState();

		// Initial olarak depth = 1, currDepth = 1; 
		// daha sonra iterative deepening çalıştırılırken 2,1; 3,1.. gider.
		float maxValue = maxValue(initialState, numSteps, singlePlayer, playerName, opponent, depth, 1);
		//System.out.println("Bunu bulabildik: " + maxValue);
		//System.out.println("budur: " + selectedMove);

		myGGP.SetGameState(initialState);
		return selectedMove;
	}

	/**
	 * 
	 * @param state Şu anki state
	 * @param numSteps Oyun kaçıncı adımda
	 * @param selectedMove En kazançlı hareket
	 * @param singlePlayer Oyun tek kişilik ise true değilse false olur
	 * @return
	 */
	private float maxValue(GameState state, int numSteps, boolean singlePlayer, Atom playerName, Atom opponentName, int depth, int currDepth) {
		//System.out.println("Şu anki selected move: " + selectedMove);
		numSteps++;

		float maxValue = Float.NEGATIVE_INFINITY;
		String slMov = "";

		if (myGGP.IsTerminal()) {

			//System.out.println();
			//System.out.println("Terminalim ben...");
			terminal++;
			if (terminal%1000 == 0)
				System.out.println(terminal);
			//System.out.println("state: " + state.toString() + " numsteps: " + numSteps + " depth: " + depth + " currDepth: " + currDepth);
			// Buraya hesaplamanın cidden bittiğini gösteren global değişken konacak
			return getGoalValue(playerName) / numSteps;

		} else if (depth < currDepth) {
			return getGoalValue(playerName) / numSteps;

		} else {
			currDepth++;
			GameState oldState = myGGP.GetGameState(); //Geri dönmek için.

			myGGP.SetGameState(state);
			ExpList legalMoves = myGGP.GetLegalMoves(playerName);

			ExpList opponentMoves = null;
			if (!singlePlayer)
			{
				opponentMoves = myGGP.GetLegalMoves(opponentName);
			}

			for (int i = 0; i < legalMoves.size(); i++) {

				long currentTime = Calendar.getInstance().getTimeInMillis();
				if ( (currentTime - startTime)  > playClock*1000 - 10 )
					break;

				myGGP.SetGameState(state);

				Expression[] nextMove = null; 				
				
				if (singlePlayer)
				{
					nextMove = new Expression[1]; 
					nextMove[0] = legalMoves.get(i);	
				}
				else
				{
					nextMove = new Expression[2]; 
					nextMove[0] = legalMoves.get(i);
					nextMove[1] = opponentMoves.get(0);	
				}
				ExpList nextMoveList = new ExpList(nextMove);



				myGGP.SimulateStep(nextMoveList);
				GameState nextState = myGGP.GetGameState();

				//System.out.println("CurrDepth : " + currDepth + " Yaptığım hareket : " + nextMove[0].toString());

				String tempMove = nextMove[0].toString();

				float tempVal;				
				if(!singlePlayer) {


					tempVal =  minValue(nextState, numSteps, singlePlayer, playerName, opponentName, depth, currDepth);										
				} else {
					tempVal =  maxValue(nextState, numSteps, singlePlayer, playerName, opponentName, depth, currDepth);
				}
				/*				if (currDepth == 2)
				{
					System.out.println("tempVal:   " + tempVal + " after move " + nextMove[0].toString());
				}*/
				if ( tempVal > maxValue ) {
					selectedMove = tempMove;
					maxValue = tempVal;
					slMov = selectedMove;
				}
			}

			selectedMove = slMov;
			myGGP.SetGameState(oldState);

		}
		//System.out.println("Adım : " + numSteps + " Selected move is: " + selectedMove);					
		return maxValue;
	}
	/**
	 * 
	 * @param nextState
	 * @param numSteps
	 * @param tempMove
	 * @param singlePlayer
	 * @param playerName
	 * @return
	 */
	private float minValue(GameState state, int numSteps, boolean singlePlayer, Atom playerName, Atom opponentName, int depth, int currDepth) {

		numSteps++;
		float minValue = Float.POSITIVE_INFINITY;
		String slMov = "";

		if (myGGP.IsTerminal()) {
			//System.out.println();
			//System.out.println("Terminalim ben...");
			terminal++;
			if (terminal%1000 == 0)
				System.out.println(terminal);
			//System.out.println("state: " + state.toString() + " numsteps: " + numSteps + " depth: " + depth + " currDepth: " + currDepth);
			// Buraya hesaplamanın cidden bittiğini gösteren global değişken konacak
			return getGoalValue(playerName) / numSteps; 
		} else if (depth < currDepth) {

			return getGoalValue(playerName) / numSteps;

		} else {

			//System.out.println("Terminal değil ama ne? " + myGGP.GetGameState());

			currDepth++;

			GameState oldState = myGGP.GetGameState(); //Geri dönmek için.

			myGGP.SetGameState(state);
			ExpList legalMoves = myGGP.GetLegalMoves(opponentName);
			ExpList opponentMoves = myGGP.GetLegalMoves(playerName);

			for (int i = 0; i < legalMoves.size(); i++) {
				
				long currentTime = Calendar.getInstance().getTimeInMillis();
				if ( (currentTime - startTime)  > playClock*1000 - 10 )
					break;
				
				myGGP.SetGameState(state);

				Expression[] nextMove = null; 				
				
				if (singlePlayer)
				{
					nextMove = new Expression[1]; 
					nextMove[0] = legalMoves.get(i);	
				}
				else
				{
					nextMove = new Expression[2]; 
					nextMove[0] = legalMoves.get(i);
					nextMove[1] = opponentMoves.get(0);	
				}
				ExpList nextMoveList = new ExpList(nextMove);


				myGGP.SimulateStep(nextMoveList);
				GameState nextState = myGGP.GetGameState();

				//System.out.println("CurrDepth : " + currDepth + " Yaptığım hareket : " + nextMove[0].toString());

				String tempMove = nextMove[0].toString();

				float tempVal;				
				if(!singlePlayer) {					
					tempVal =  maxValue(nextState, numSteps, singlePlayer, playerName, opponentName, depth, currDepth);										
				} else {
					// singlePlayer ise bu method aslında hiç çağrılmayacak. Ama yine de götü garantiye alalım dedik.
					tempVal =  maxValue(nextState, numSteps, singlePlayer, playerName, opponentName, depth, currDepth);
				}

				if ( tempVal < minValue ) {
					selectedMove = tempMove;
					minValue = tempVal;
					slMov = selectedMove;
				}
			}
			selectedMove = slMov;
			myGGP.SetGameState(oldState);
		}


		return minValue;
	}
	public float getGoalValue(Atom atm) {
		ExpList goalVals = myGGP.GetGoalValues(atm);
		float retVal = -1;		
		if (goalVals != null)
		{	
			for (int i = 0; i < goalVals.size(); i++)
			{
				Expression nextExp = (Expression)goalVals.get(i);
				retVal = Float.parseFloat(nextExp.toString());
				if (retVal == 0)
					retVal = -100;
			}
		}
		return retVal;
	}
	public ArrayList tokenizePlay(String playMsg) {
		// msg=(PLAY <MATCH ID> <JOINT MOVE>)
		int firstPharIndex = playMsg.indexOf('(');
		int lastPharIndex = playMsg.lastIndexOf(')');
		String newMsg = playMsg.substring(firstPharIndex+1, lastPharIndex);
		//System.out.println(newMsg);
		firstPharIndex = newMsg.indexOf('(');
		lastPharIndex = newMsg.lastIndexOf(')');
		if (firstPharIndex == -1) // NIL gelmiş
			return null;
		newMsg = newMsg.substring(firstPharIndex+1, lastPharIndex);
		//System.out.println(newMsg);

		ArrayList playTokens = tokenizeMoves(newMsg);
		/*for (int i = 0; i < playTokens.size(); i++)
		{
			System.out.println(playTokens.get(i));
		}*/
		return playTokens;
	}

	/**
	 * this method is called if the match is over
	 */
	protected void commandStop(String msg){
		System.out.println("you loser");
		return;
		// msg="(STOP <MATCH ID> <JOINT MOVE>)

		// TODO:
		//    - clean up the GamePlayer for the next match
		//    - be happy if you have won, think about what went wrong if you have lost ;-)
	}

	/**
	 * starts the game player and waits for messages from the game master <br>
	 * Command line options: [port]
	 */
	public static void main(String[] args){
		try{
			int port=4001;
			if(args.length>=1){
				port=Integer.parseInt(args[0]);
			}
			GamePlayer gp=new GamePlayer(port);
			gp.waitForExit();
		}catch(Exception ex){
			ex.printStackTrace();
			System.exit(-1);
		}
	}
}