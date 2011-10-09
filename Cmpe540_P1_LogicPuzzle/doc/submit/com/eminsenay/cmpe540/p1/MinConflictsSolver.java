package com.eminsenay.cmpe540.p1;

import java.util.ArrayList;
import java.util.Random;

/**
 * The class is a possible implementation of the min-conflicts solver of a CSP.
 * A pseudocode can be found on the book "Artificial Intelligence - A modern Approach",
 * page 151.
 * */
public class MinConflictsSolver {
	
	/** Number of steps allowed before giving up */
	int maxSteps;
	
	/** An instance of a CSP model of com.eminsenay.cmpe540.p1.CSPModel*/
	CSPModel model;
	
	/** All Values of the variables in the CSP */
	int[] allowedValues;
	
	/** Number of conflicts of each allowed value */
	// int[] conflictNumbers; gerek yok gibi
	
	/** Initialization of the solver
	 * @param theModel An initialized CSPModel 
	 * @param maximumSteps Number of steps allowed before giving up
	 * */
	public MinConflictsSolver(CSPModel theModel, int maximumSteps)
	{
		maxSteps = maximumSteps;
		model = theModel;
		allowedValues = model.getAllowedValues();
	}
	
	/** Main method of min-conflicts solver. If it finds the solution it displays.
	 * */
	public boolean solve(Random rnd)
	{	
		// Initialize an arraylist which stores the variable names having conflicts 
		ArrayList<String> conflictedVars = null;
		
		// evaluate until break or maximum number of steps
		int i;
		for (i = 0 ; i < maxSteps ; i++) {
			// check if initial state is a solution
			conflictedVars = model.checkState();
			
			if (conflictedVars.size() == 0) { // is a solution	
				model.printGoalValues();
				break;
			} else {
			
				// Select a random element from conflicted variables				
				int randVal = rnd.nextInt(conflictedVars.size());
				String randVariable = conflictedVars.get(randVal);
				
				// Check the other possible configurations of the variable
				int minConflictValue = findMinConflict(randVariable);
					
				// Set the variable to the value that causes minimum conflicts
				// of the variable to the other variables.
				model.setVariable(randVariable, minConflictValue);			
			}	
		}
		if (i == maxSteps)
		{
			return false;
		}
		return true;
	}

	/** Finds a value of a variable which causes minimum conflicts in the problem.*/
	private int findMinConflict(String variable)
	{
		// Check equaliy constraint
		int equalityConstrintValue = model.checkEquality(variable);
		if (equalityConstrintValue != 10000)
			return equalityConstrintValue;
		
		int minConflicts = 10000; // an initial large value
		int minConflictsIndex = -1;
		
		// If there is more than one possible values, 
		// the value different than the old one should be preferred
		int oldValue = model.getVariable(variable);
		
		for (int i = 0; i < allowedValues.length; i++)
		{
			model.setVariable(variable, allowedValues[i]);
			int conflictno = model.checkConflicts(variable);
			if (conflictno < minConflicts)
			{				
				minConflicts = conflictno;
				minConflictsIndex = i;
			} else if (conflictno == minConflicts && allowedValues[i] != oldValue)
			{
				minConflicts = conflictno;
				minConflictsIndex = i;
			}
		}
		return allowedValues[minConflictsIndex];
	}
}
