package com.eminsenay.cmpe540.p1;

import java.util.ArrayList;

/** This class is used for formulating the rules of the logic problem.*/
public class Constraint {
	
	/** First variable of the constraint.*/
	String varName1;
	/** Second variable of the constraint, if available.*/
	String varName2;
	
	/** Type of constraint.*/
	int type;
	
	/** Value of the first variable, if available.*/
	int value;
	
	/** CSP model used for getting the values of the variables. */
	CSPModel model;
	
	/** Checks whether the given variable is included in the constraint. */
	public boolean hasVariable(String varName)
	{
		boolean returnVal = false;
		if (type == 2) // variable2 is not used
		{
			if (varName1.equals(varName))
				returnVal = true;
		}
		else if (type == 1 || type == 3 || type == 4 || type == 5)
		{
			if (varName1.equals(varName) || varName2.equals(varName))
				returnVal = true;
		}
		// Other types must be added or they will return false
		return returnVal;	
	}
	
	/** Puts all variable names which are included in the constraint in an ArrayList.*/
	public ArrayList<String> getVariables()
	{
		ArrayList<String> variables = new ArrayList<String>();
		if (type == 2) // variable2 is not used
		{
			variables.add(varName1);
		}
		else if (type == 1 || type == 3 || type == 4 || type == 5)
		{
			variables.add(varName1);
			variables.add(varName2);
		}
		// Other types must be added or nothing will be returned
		return variables;
	}
	
	/** Returns the truth value of the constraint according to the values of the variables in the current model. 
	 * If there is a conflict, it returns true.*/
	public boolean evaluate()
	{
		boolean hasConflict = true;
		int value1;
		int value2;
		try {
			switch (type) {
	
			case 1: // varName1 = varName2
				value1 = model.getVariable(varName1);
				value2 = model.getVariable(varName2);
				if (value1 == value2)
					hasConflict = false;
				break;
			case 2: // varName1 = value
				value1 = model.getVariable(varName1);
				if (value1 == value)
					hasConflict = false;
				break;
			case 3: // varName1 != varName2
				value1 = model.getVariable(varName1);
				value2 = model.getVariable(varName2);
				if (value1 != value2)
					hasConflict = false;
				break;
			case 4: // varName1 - varName2 = value
				value1 = model.getVariable(varName1);
				value2 = model.getVariable(varName2);
				if ((value1 - value2) == value)
					hasConflict = false;
				break;
			case 5: // abs(varName1 - varName2) = value 
				value1 = model.getVariable(varName1);
				value2 = model.getVariable(varName2);
				if (Math.abs(value1 - value2) == value)
					hasConflict = false;
				break;
			default: // wrong input
				break;
			}		
		} catch (NullPointerException e) {
			hasConflict = true;
		}
		return hasConflict;
	}
	
	/** Method which initializes the constraint. In constraints which do not need varName2 
	 * or value, one can initilize the unused variable whatever he wants.
	 * Possible types:
	 * 1- varName1 = varName2
	 * 2- varName1 = value
	 * 3- varName1 != varName2
	 * 4- varName1 - varName2 = value
	 * 5- abs(varName1 - varName2) = value 
	 * These can be extended by extending evaluate, getVariables 
	 * and hasVariable methods, if a logic puzzle needs more. 
	 * */ 
	public Constraint(CSPModel model, String varName1, String varName2, int value, int type)
	{
		this.model = model;
		this.varName1 = varName1;
		this.varName2 = varName2;
		this.value = value;
		this.type = type;
	}

}
