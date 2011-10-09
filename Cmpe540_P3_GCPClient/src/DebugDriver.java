
public class DebugDriver {
	public static void main (String[] args)
	{
		GamePlayer gp = new GamePlayer();
		String msg1 = 	"(START MATCH.3316980891 ROBOT "+
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
		
		//String msg = "(START MATCH.3378143762 XPLAYER ((ROLE XPLAYER) (ROLE OPLAYER) (INIT (CELL 1 1 B)) (INIT (CELL 1 2 B)) (INIT (CELL 1 3 B)) (INIT (CELL 2 1 B)) (INIT (CELL 2 2 B)) (INIT (CELL 2 3 B)) (INIT (CELL 3 1 B)) (INIT (CELL 3 2 B)) (INIT (CELL 3 3 B)) (INIT (CONTROL XPLAYER)) (<= (NEXT (CELL ?M ?N X)) (DOES XPLAYER (MARK ?M ?N)) (TRUE (CELL ?M ?N B))) (<= (NEXT (CELL ?M ?N O)) (DOES OPLAYER (MARK ?M ?N)) (TRUE (CELL ?M ?N B))) (<= (NEXT (CELL ?M ?N ?W)) (TRUE (CELL ?M ?N ?W)) (DISTINCT ?W B)) (<= (NEXT (CELL ?M ?N B)) (DOES ?W (MARK ?J ?K)) (TRUE (CELL ?M ?N B)) (OR (DISTINCT ?M ?J) (DISTINCT ?N ?K))) (<= (NEXT (CONTROL XPLAYER)) (TRUE (CONTROL OPLAYER))) (<= (NEXT (CONTROL OPLAYER)) (TRUE (CONTROL XPLAYER))) (<= (ROW ?M ?X) (TRUE (CELL ?M 1 ?X)) (TRUE (CELL ?M 2 ?X)) (TRUE (CELL ?M 3 ?X))) (<= (COLUMN ?N ?X) (TRUE (CELL 1 ?N ?X)) (TRUE (CELL 2 ?N ?X)) (TRUE (CELL 3 ?N ?X))) (<= (DIAGONAL ?X) (TRUE (CELL 1 1 ?X)) (TRUE (CELL 2 2 ?X)) (TRUE (CELL 3 3 ?X))) (<= (DIAGONAL ?X) (TRUE (CELL 1 3 ?X)) (TRUE (CELL 2 2 ?X)) (TRUE (CELL 3 1 ?X))) (<= (LINE ?X) (ROW ?M ?X)) (<= (LINE ?X) (COLUMN ?M ?X)) (<= (LINE ?X) (DIAGONAL ?X)) (<= OPEN (TRUE (CELL ?M ?N B))) (<= (LEGAL ?W (MARK ?X ?Y)) (TRUE (CELL ?X ?Y B)) (TRUE (CONTROL ?W))) (<= (LEGAL XPLAYER NOOP) (TRUE (CONTROL OPLAYER))) (<= (LEGAL OPLAYER NOOP) (TRUE (CONTROL XPLAYER))) (<= (GOAL XPLAYER 100) (LINE X)) (<= (GOAL XPLAYER 50) (NOT (LINE X)) (NOT (LINE O)) (NOT OPEN)) (<= (GOAL XPLAYER 0) (LINE O)) (<= (GOAL OPLAYER 100) (LINE O)) (<= (GOAL OPLAYER 50) (NOT (LINE X)) (NOT (LINE O)) (NOT OPEN)) (<= (GOAL OPLAYER 0) (LINE X)) (<= TERMINAL (LINE X)) (<= TERMINAL (LINE O)) (<= TERMINAL (NOT OPEN))) 5 10)";
		//String msg = "(START MATCH.3378143762 XPLAYER ((ROLE XPLAYER) (ROLE OPLAYER) (INIT (CELL 1 1 X)) (INIT (CELL 1 2 O)) (INIT (CELL 1 3 B)) (INIT (CELL 2 1 B)) (INIT (CELL 2 2 B)) (INIT (CELL 2 3 B)) (INIT (CELL 3 1 B)) (INIT (CELL 3 2 B)) (INIT (CELL 3 3 B)) (INIT (CONTROL XPLAYER)) (<= (NEXT (CELL ?M ?N X)) (DOES XPLAYER (MARK ?M ?N)) (TRUE (CELL ?M ?N B))) (<= (NEXT (CELL ?M ?N O)) (DOES OPLAYER (MARK ?M ?N)) (TRUE (CELL ?M ?N B))) (<= (NEXT (CELL ?M ?N ?W)) (TRUE (CELL ?M ?N ?W)) (DISTINCT ?W B)) (<= (NEXT (CELL ?M ?N B)) (DOES ?W (MARK ?J ?K)) (TRUE (CELL ?M ?N B)) (OR (DISTINCT ?M ?J) (DISTINCT ?N ?K))) (<= (NEXT (CONTROL XPLAYER)) (TRUE (CONTROL OPLAYER))) (<= (NEXT (CONTROL OPLAYER)) (TRUE (CONTROL XPLAYER))) (<= (ROW ?M ?X) (TRUE (CELL ?M 1 ?X)) (TRUE (CELL ?M 2 ?X)) (TRUE (CELL ?M 3 ?X))) (<= (COLUMN ?N ?X) (TRUE (CELL 1 ?N ?X)) (TRUE (CELL 2 ?N ?X)) (TRUE (CELL 3 ?N ?X))) (<= (DIAGONAL ?X) (TRUE (CELL 1 1 ?X)) (TRUE (CELL 2 2 ?X)) (TRUE (CELL 3 3 ?X))) (<= (DIAGONAL ?X) (TRUE (CELL 1 3 ?X)) (TRUE (CELL 2 2 ?X)) (TRUE (CELL 3 1 ?X))) (<= (LINE ?X) (ROW ?M ?X)) (<= (LINE ?X) (COLUMN ?M ?X)) (<= (LINE ?X) (DIAGONAL ?X)) (<= OPEN (TRUE (CELL ?M ?N B))) (<= (LEGAL ?W (MARK ?X ?Y)) (TRUE (CELL ?X ?Y B)) (TRUE (CONTROL ?W))) (<= (LEGAL XPLAYER NOOP) (TRUE (CONTROL OPLAYER))) (<= (LEGAL OPLAYER NOOP) (TRUE (CONTROL XPLAYER))) (<= (GOAL XPLAYER 100) (LINE X)) (<= (GOAL XPLAYER 50) (NOT (LINE X)) (NOT (LINE O)) (NOT OPEN)) (<= (GOAL XPLAYER 0) (LINE O)) (<= (GOAL OPLAYER 100) (LINE O)) (<= (GOAL OPLAYER 50) (NOT (LINE X)) (NOT (LINE O)) (NOT OPEN)) (<= (GOAL OPLAYER 0) (LINE X)) (<= TERMINAL (LINE X)) (<= TERMINAL (LINE O)) (<= TERMINAL (NOT OPEN))) 5 10)";
		//String msg = "(START MATCH.3378143762 XPLAYER ((ROLE XPLAYER) (ROLE OPLAYER) (INIT (CELL 1 1 X)) (INIT (CELL 1 2 O)) (INIT (CELL 1 3 X)) (INIT (CELL 2 1 X)) (INIT (CELL 2 2 O)) (INIT (CELL 2 3 B)) (INIT (CELL 3 1 O)) (INIT (CELL 3 2 B)) (INIT (CELL 3 3 B)) (INIT (CONTROL XPLAYER)) (<= (NEXT (CELL ?M ?N X)) (DOES XPLAYER (MARK ?M ?N)) (TRUE (CELL ?M ?N B))) (<= (NEXT (CELL ?M ?N O)) (DOES OPLAYER (MARK ?M ?N)) (TRUE (CELL ?M ?N B))) (<= (NEXT (CELL ?M ?N ?W)) (TRUE (CELL ?M ?N ?W)) (DISTINCT ?W B)) (<= (NEXT (CELL ?M ?N B)) (DOES ?W (MARK ?J ?K)) (TRUE (CELL ?M ?N B)) (OR (DISTINCT ?M ?J) (DISTINCT ?N ?K))) (<= (NEXT (CONTROL XPLAYER)) (TRUE (CONTROL OPLAYER))) (<= (NEXT (CONTROL OPLAYER)) (TRUE (CONTROL XPLAYER))) (<= (ROW ?M ?X) (TRUE (CELL ?M 1 ?X)) (TRUE (CELL ?M 2 ?X)) (TRUE (CELL ?M 3 ?X))) (<= (COLUMN ?N ?X) (TRUE (CELL 1 ?N ?X)) (TRUE (CELL 2 ?N ?X)) (TRUE (CELL 3 ?N ?X))) (<= (DIAGONAL ?X) (TRUE (CELL 1 1 ?X)) (TRUE (CELL 2 2 ?X)) (TRUE (CELL 3 3 ?X))) (<= (DIAGONAL ?X) (TRUE (CELL 1 3 ?X)) (TRUE (CELL 2 2 ?X)) (TRUE (CELL 3 1 ?X))) (<= (LINE ?X) (ROW ?M ?X)) (<= (LINE ?X) (COLUMN ?M ?X)) (<= (LINE ?X) (DIAGONAL ?X)) (<= OPEN (TRUE (CELL ?M ?N B))) (<= (LEGAL ?W (MARK ?X ?Y)) (TRUE (CELL ?X ?Y B)) (TRUE (CONTROL ?W))) (<= (LEGAL XPLAYER NOOP) (TRUE (CONTROL OPLAYER))) (<= (LEGAL OPLAYER NOOP) (TRUE (CONTROL XPLAYER))) (<= (GOAL XPLAYER 100) (LINE X)) (<= (GOAL XPLAYER 50) (NOT (LINE X)) (NOT (LINE O)) (NOT OPEN)) (<= (GOAL XPLAYER 0) (LINE O)) (<= (GOAL OPLAYER 100) (LINE O)) (<= (GOAL OPLAYER 50) (NOT (LINE X)) (NOT (LINE O)) (NOT OPEN)) (<= (GOAL OPLAYER 0) (LINE X)) (<= TERMINAL (LINE X)) (<= TERMINAL (LINE O)) (<= TERMINAL (NOT OPEN))) 5 10)";
		gp.initGame(msg1);
		
		String playMsg = "(PLAY MATCH.3378144573 NIL)";
		gp.commandPlay(playMsg);
		System.out.println();
		System.out.println();
		System.out.println();
		
/*		playMsg = "(PLAY MATCH.3378144573 ((MARK 1 1) NOOP))";
		gp.commandPlay(playMsg);
		System.out.println();
		System.out.println();
		System.out.println();
		
/*		playMsg = "(PLAY MATCH.3378144573 (NOOP (MARK 1 2)))";
		gp.commandPlay(playMsg);
		System.out.println();
		System.out.println();
		System.out.println();
		
		playMsg = "(PLAY MATCH.3378144573 ((MARK 1 3) NOOP))";
		gp.commandPlay(playMsg);
		System.out.println();
		System.out.println();
		System.out.println();
		
		playMsg = "(PLAY MATCH.3378144573 (NOOP (MARK 2 1)))";
		gp.commandPlay(playMsg);
		System.out.println();
		System.out.println();
		System.out.println();
		
		playMsg = "(PLAY MATCH.3378144573 ((MARK 2 2) NOOP))";
		gp.commandPlay(playMsg);
		System.out.println();
		System.out.println();
		System.out.println();
		
		playMsg = "(PLAY MATCH.3378144573 (NOOP (MARK 2 3)))";
		gp.commandPlay(playMsg);
		System.out.println();
		System.out.println();
		System.out.println();
		
		String stopMsg = "(STOP MATCH.3378144573 ((MARK 3 1) NOOP))";
		gp.commandStop(stopMsg);
		System.out.println();
		System.out.println();
		System.out.println();
		
		//String str = "(MARK 1 2) NOOP (MARK 2 3) NOOP";		
*/		
	
	}
	


}
