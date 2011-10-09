package com.eminsenay.cmpe540.p1;

import java.util.Random;

/** A formulation and solution of the famous logic problem: "zebra puzle". */
public class ProblemMinConflicts {
	
	/** The names of all variables. Used for generating random state. */
	static String[] allVariables = {"English", "Norwegian", "Spaniard", "Japanese", "Ukranian",
		"Kools", "Chesterfield", "Winston", "Lucky Strike", "Parliament",
		"Yellow", "Red", "Blue", "Green", "Ivory",
		"Dog", "Fox", "Horse", "Snails", "Zebra",
		"Orange Juice", "Tea", "Coffee", "Milk", "Water"
	};
	
	/** Allowed values of all variables.*/
	static int[] allowedValues = {1,2,3,4,5};
	
	/** Using allVariables and allowedValues, the method generates a random state 
	 * by initializing the values of all variables. */
	public static void GenerateRandomState(CSPModel model, Random rnd)
	{	
		for (int i = 0; i < allVariables.length; i++)
		{
			double rndNum = rnd.nextDouble();
			int allowedValuesIndex = (int)(rndNum * allowedValues.length);
			model.setVariable(allVariables[i], allowedValues[allowedValuesIndex]);
		}
	}
	
	/** This method sets all necessary constraints of the problem. */
	/** Initializes all constraints of the problem. */
	static void setConstraints(CSPModel myModel)
	{	
		String[] nationalities = {"English", "Norwegian", "Spaniard", "Japanese", "Ukranian"};
		String[] smoke = {"Kools", "Chesterfield", "Winston", "Lucky Strike", "Parliament"};
		String[] colorOfHouse = {"Yellow", "Red", "Blue", "Green", "Ivory"};
		String[] pets = {"Dog", "Fox", "Horse", "Snails", "Zebra"};
		String[] drinks = {"Orange Juice", "Tea", "Coffee", "Milk", "Water"};
		
		myModel.allDifferent(nationalities);
		myModel.allDifferent(smoke);
		myModel.allDifferent(colorOfHouse);
		myModel.allDifferent(pets);
		myModel.allDifferent(drinks);
		
		myModel.setConstraint("English", "Red", -1, 1);
		myModel.setConstraint("Spaniard", "Dog", -1, 1);
		myModel.setConstraint("Kools", "Yellow", -1, 1);
		myModel.setConstraint("Winston", "Snails", -1, 1);
		myModel.setConstraint("Lucky Strike", "Orange Juice", -1, 1);
		myModel.setConstraint("Ukranian", "Tea", -1, 1);
		myModel.setConstraint("Japanese", "Parliament", -1, 1);
		myModel.setConstraint("Coffee", "Green", -1, 1);
		myModel.setConstraint("Chesterfield", "Fox", 1, 5);
		myModel.setConstraint("Norwegian", "Blue", 1, 5);
		myModel.setConstraint("Kools", "Horse", 1, 5);
		myModel.setConstraint("Norwegian", "", 1, 2);
		myModel.setConstraint("Milk", "", 3, 2);
		myModel.setConstraint("Green", "Ivory", 1, 4);
	}
	
	/** Introduces the variables whose values wanted to be known.*/
	static void setGoals(CSPModel myModel)
	{
		myModel.setGoal("Zebra");
		myModel.setGoal("Water");
	}
	
	/** Main method of the problem. */
	public static void main(String[] args)
	{
		// Initialize the model
		CSPModel myModel = new CSPModel(allowedValues);
		
		// Set constraints and goals
		setConstraints(myModel);
		setGoals(myModel);
		
		Random rnd = new Random();
		
		// Try to solve the problem using 100 different states of the problem and 1000 steps for each state.
		for (int i = 0; i < 100; i++)
		{		
			GenerateRandomState(myModel,rnd);
			
			//	Try to solve the problem
			MinConflictsSolver mcs = new MinConflictsSolver(myModel,1000);
			boolean solutionFound = mcs.solve(rnd);
			if (solutionFound)
			{
				return;
			}
		}
		System.out.println("Couldn't find the solution...");
	}
}
