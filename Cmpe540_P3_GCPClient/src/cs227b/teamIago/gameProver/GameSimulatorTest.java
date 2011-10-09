/*
 * Created on Apr 19, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package cs227b.teamIago.gameProver;

import cs227b.teamIago.parser.Parser;
import cs227b.teamIago.resolver.ExpList;
import cs227b.teamIago.resolver.Expression;
import cs227b.teamIago.util.GameState;

/**
 *
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class GameSimulatorTest
{
	public GameSimulatorTest(){}
	
	public void simulateGame(String desc1, String state1, String moves1) {
		GameSimulator myGGP;
		boolean wantDebugPrintouts;
		ExpList movesList, roles, legalMoves, goalValues;
		GameState nextState;

		wantDebugPrintouts = false;

		boolean useOptimization = true;
		myGGP = new GameSimulator(wantDebugPrintouts, useOptimization);

		System.out.println("**************** Game " + " *****************");
		// TODO Oyun adını yazdır
		myGGP.ParseDescIntoTheory(desc1);		
		myGGP.ParseDescIntoTheory(state1);
		movesList = Parser.parseDesc(moves1);

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

		if (myGGP.IsTerminal()) {
			System.out.println("Game is in terminal state.");
			System.out.println("(Not calculating next state.)");
		}
		else
		{
			System.out.println("Game is in non-terminal state.");

			GameState oldState;
			oldState = myGGP.GetGameState();
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
		}


		System.out.println("************* End of Game " + " *************");
		// TODO oyun adını yazdır
	}		
		
		
		

	// this main reads in an axiom file, a state file, and a moves file, and
	// prints out output according to the format specified in assignment 3
	public static void main(String args[])
	{


		String desc1 = 
			"(role robot)"
			+"(init (cell a))"
			+"(init (gold c))"
			+"(init (step 1))"
			+"(<= (next (cell ?y))"
			+"(does robot move)"
			+"(true (cell ?x))"
			+"(adjacent ?x ?y))"
			+"(<= (next (cell ?x))"
			+"(does robot grab)"
			+"(true (cell ?x)))"
			+"(<= (next (cell ?x))"
			+"(does robot drop)"
			+"(true (cell ?x)))"
			+"(<= (next (gold ?x))"
			+"(does robot move)"
			+"(true (gold ?x)))"
			+"(<= (next (gold i))"
			+"(does robot grab)"
			+"(true (cell ?x))"
			+"(true (gold ?x)))"
			+"(<= (next (gold i))"
			+"(does robot grab)"
			+"(true (gold i)))"
			+"(<= (next (gold ?y))"
			+"(does robot grab)"
			+"(true (cell ?x))"
			+"(true (gold ?y))"
			+"(distinct ?x ?y))"
			+"(<= (next (gold ?x))"
			+"(does robot drop)"
			+"(true (cell ?x))"
			+"(true (gold i)))"
			+"(<= (next (gold ?x))"
			+"(does robot drop)"
			+"(true (gold ?x))"
			+"(distinct ?x i))"
			+"(<= (next (step ?y))"
			+"(true (step ?x))"
			+"(succ ?x ?y))"
			+"(adjacent a b)"
			+"(adjacent b c)"
			+"(adjacent c d)"
			+"(adjacent d a)"
			+"(succ 1 2)"
			+"(succ 2 3)"
			+"(succ 3 4)"
			+"(succ 4 5)"
			+"(succ 5 6)"
			+"(succ 6 7)"
			+"(succ 7 8)"
			+"(succ 8 9)"
			+"(succ 9 10)"
			+"(<= (legal robot move))"
			+"(<= (legal robot grab)"
			+"(true (cell ?x))"
			+"(true (gold ?x)))"
			+"(<= (legal robot drop)"
			+"(true (gold i)))"
			+"(<= (goal robot 100)"
			+"(true (gold a)))"
			+"(<= (goal robot 0)"
			+"(true (gold ?x))"
			+"(distinct ?x a))"
			+"(<= terminal"
			+"(true (step 10)))"
			+"(<= terminal"
			+"(true (gold a)))";
		
		String state1 = "(true (step 1)) (true (gold c)) (true (cell a))";
		
		String moves1 = "(does robot move)";
		GameSimulatorTest gst = new GameSimulatorTest();
		gst.simulateGame(desc1, state1, moves1);
	}


}
