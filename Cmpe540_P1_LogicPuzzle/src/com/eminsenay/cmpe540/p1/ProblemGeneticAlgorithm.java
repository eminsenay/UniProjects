package com.eminsenay.cmpe540.p1;

/** A formulation and solution of the famous logic problem: "zebra puzle". */
public class ProblemGeneticAlgorithm {
	
	/** Allowed values of all variables.*/
	static int[] allowedValues = {1,2,3,4,5};
	
	/** This method sets all necessary constraints of the problem. */
	/** Initializes all constraints of the problem. */
	static void setConstraints(CSPModel myModel)
	{	
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
		
		GeneticAlgorithmSolver GS = new GeneticAlgorithmSolver(myModel);
		GS.solve();

	}
}
