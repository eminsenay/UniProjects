import java.util.ArrayList;


public class Game1 {

	private String matchID = "";
	private String role = "";
	private ArrayList<String> truthList = new ArrayList<String>();
	private ArrayList<Rules> ruleList = new ArrayList<Rules>();
	private ArrayList<Legals> legalList = new ArrayList<Legals>();
	private ArrayList<Goals> goalList = new ArrayList<Goals>();
	private ArrayList<String> terminalList = new ArrayList<String>();
	private String startClock = "";
	private String playClock = "";


	public void parseGame(String msg) {
		/*
		 * 

		(
				START MATCH.3316980891 ROBOT 
				(
					(ROLE ROBOT) 
					(INIT (CELL A)) 
					(INIT (GOLD C)) 
					(INIT (STEP 1)) 
					(<= (NEXT (CELL ?Y)) (DOES ROBOT MOVE) (TRUE (CELL ?X)) (ADJACENT ?X ?Y)) 
					(<= (NEXT (CELL ?X)) (DOES ROBOT GRAB) (TRUE (CELL ?X))) 
					(<= (NEXT (CELL ?X)) (DOES ROBOT DROP) (TRUE (CELL ?X))) 
					(<= (NEXT (GOLD ?X)) (DOES ROBOT MOVE) (TRUE (GOLD ?X))) 
					(<= (NEXT (GOLD I)) (DOES ROBOT GRAB) (TRUE (CELL ?X)) (TRUE (GOLD ?X))) 
					(<= (NEXT (GOLD I)) (DOES ROBOT GRAB) (TRUE (GOLD I))) 
					(<= (NEXT (GOLD ?Y)) (DOES ROBOT GRAB) (TRUE (CELL ?X)) (TRUE (GOLD ?Y)) (DISTINCT ?X ?Y)) 
					(<= (NEXT (GOLD ?X)) (DOES ROBOT DROP) (TRUE (CELL ?X)) (TRUE (GOLD I))) 
					(<= (NEXT (GOLD ?X)) (DOES ROBOT DROP) (TRUE (GOLD ?X)) (DISTINCT ?X I))
					(<= (NEXT (STEP ?Y)) (TRUE (STEP ?X)) (SUCC ?X ?Y)) 
					(ADJACENT A B) 
					(ADJACENT B C) 
					(ADJACENT C D) 
					(ADJACENT D A) 
					(SUCC 1 2)
					(SUCC 2 3) 
					(SUCC 3 4) 
					(SUCC 4 5) 
					(SUCC 5 6) 
					(SUCC 6 7) 
					(SUCC 7 8) 
					(SUCC 8 9) 
					(SUCC 9 10) 
					(<= (LEGAL ROBOT MOVE)) 
					(<= (LEGAL ROBOT GRAB) (TRUE (CELL ?X)) (TRUE (GOLD ?X))) 
					(<= (LEGAL ROBOT DROP) (TRUE (GOLD I))) 
					(<= (GOAL ROBOT 100) (TRUE (GOLD A))) 
					(<= (GOAL ROBOT 0) (TRUE (GOLD ?X)) (DISTINCT ?X A)) 
					(<= TERMINAL (TRUE (STEP 10))) 
					(<= TERMINAL (TRUE (GOLD A)))
				)
				30 30
			)


		 *
		 */

		msg = 	"(START MATCH.3316980891 ROBOT "+
		"((ROLE ROBOT) (INIT (CELL A)) (INIT (GOLD C)) (INIT (STEP 1)) (<= (NEXT (CELL ?Y)) (DOES ROBOT MOVE) (TRUE (CELL ?X))" +
		"(ADJACENT ?X ?Y)) (<= (NEXT (CELL ?X)) (DOES ROBOT GRAB) (TRUE (CELL ?X))) (<= (NEXT (CELL ?X)) (DOES ROBOT DROP)"+ 
		"(TRUE (CELL ?X))) (<= (NEXT (GOLD ?X)) (DOES ROBOT MOVE) (TRUE (GOLD ?X))) (<= (NEXT (GOLD I)) (DOES ROBOT GRAB)" +
		"(TRUE (CELL ?X)) (TRUE (GOLD ?X))) (<= (NEXT (GOLD I)) (DOES ROBOT GRAB) (TRUE (GOLD I))) "+
		"(<= (NEXT (GOLD ?Y)) (DOES ROBOT GRAB) (TRUE (CELL ?X)) (TRUE (GOLD ?Y)) (DISTINCT ?X ?Y)) (<= (NEXT (GOLD ?X)) "+
		"(DOES ROBOT DROP) (TRUE (CELL ?X)) (TRUE (GOLD I))) (<= (NEXT (GOLD ?X)) (DOES ROBOT DROP) (TRUE (GOLD ?X)) (DISTINCT ?X I))"+
		"(<= (NEXT (STEP ?Y)) (TRUE (STEP ?X)) (SUCC ?X ?Y)) (ADJACENT A B) (ADJACENT B C) (ADJACENT C D) (ADJACENT D A) (SUCC 1 2)"+
		"(SUCC 2 3) (SUCC 3 4) (SUCC 4 5) (SUCC 5 6) (SUCC 6 7) (SUCC 7 8) (SUCC 8 9) (SUCC 9 10) (<= (LEGAL ROBOT MOVE))" +
		"(<= (LEGAL ROBOT GRAB) (TRUE (CELL ?X)) (TRUE (GOLD ?X))) (<= (LEGAL ROBOT DROP) (TRUE (GOLD I))) "+
		"(<= (GOAL ROBOT 100) (TRUE (GOLD A))) (<= (GOAL ROBOT 0) (TRUE (GOLD ?X)) (DISTINCT ?X A)) (<= TERMINAL (TRUE (STEP 10)))"+ 
		"(<= TERMINAL (TRUE (GOLD A))))"+
		" 30 30)";					

		int startIndex = msg.indexOf("START");
		int secondPharIndex = msg.indexOf("(", startIndex);
		String firstSub = msg.substring(startIndex, secondPharIndex);
		String[] idAndRole = firstSub.split(" ");

		matchID = idAndRole[1];
		role = idAndRole[2];

		//System.out.println(idAndRole[0] + " " + idAndRole[1] + " " + idAndRole[2]);	

		int lastPharIndex = msg.lastIndexOf(")");
		int secLastPharIndex = msg.lastIndexOf(")", lastPharIndex-1);

		firstSub = msg.substring(secLastPharIndex, lastPharIndex);
		String[] startandPlay = firstSub.split(" ");

		startClock = startandPlay[1];
		playClock = startandPlay[2];

		//System.out.println(startClock + " " + playClock);

		msg = msg.substring(secondPharIndex+1, secLastPharIndex);

		//System.out.println(msg);


		ArrayList<String> tokenList = tokenize(msg);

		int firstIndex = 0, lastIndex = 0, sum = 0 ;

		for (int i=0; i<tokenList.size(); i++) {

			//TODO

			String nextLine = tokenList.get(i);
			//System.out.println(nextLine);
			int firstPharIndex = nextLine.indexOf("(");
			int firstSpaceIndex = nextLine.indexOf(" ", firstPharIndex);
			String firstWord = 
				nextLine.substring(firstPharIndex+1, firstSpaceIndex);

			//System.out.println(firstWord);

			if (firstWord.equals("ROLE")) {

				role = nextLine.substring(firstSpaceIndex+1, nextLine.length()-1);
				//System.out.println(role);							
			} 
			else if (firstWord.equals("INIT")) {														
				truthList.add( nextLine.substring(firstSpaceIndex+2, nextLine.length()-2) );														
			} else if (firstWord.equals("<=")) {

				nextLine = nextLine.substring(4,nextLine.length()-1);
				//System.out.println(nextLine);
				
				ArrayList<String> inLineTokens = tokenize(nextLine);
				for(int j=0;j<inLineTokens.size();j++) {
					//System.out.println(inLineTokens.get(j));
					
				}

			}


		}


	}

	private ArrayList<String> tokenize(String msg) {

		int firstIndex = 0, lastIndex = 0, sum = 0;
		ArrayList<String> tokenList = new ArrayList<String>();

		for (int i=0; i<msg.length(); i++) {

			if (msg.charAt(i) == '(') {
				sum++;
			} else
				if (msg.charAt(i) == ')') {
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

	public static void main(String[] args) {

		Game1 g = new Game1();
		g.parseGame("am");

	}

}
