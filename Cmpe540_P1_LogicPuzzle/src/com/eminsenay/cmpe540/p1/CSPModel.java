package com.eminsenay.cmpe540.p1;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;

/** A constraint satisfaction model of the logic problem. */
public class CSPModel {
	
	/** Stores the values of the variables. */
	Hashtable<String, Integer> variables;
	
	/** Constraints of the problem. */
	ArrayList<Constraint> constraints;
	
	/** Goals of the problem. */
	ArrayList<String> goals;
	
	/** All possible values of the variables in the model. */
	int[] allowedValues;
	
	/** Used for initalizing a new CSP model.*/
	public CSPModel(int[] allowedValues)
	{
		goals = new ArrayList<String>();
		constraints = new ArrayList<Constraint>();
		variables = new Hashtable<String, Integer>();
		this.allowedValues = allowedValues;
	}
	
	/** Sets the value of a variable. */
	void setVariable(String varName, int value)
	{
		variables.put(varName, new Integer(value));
	}
	
	/** Returns the value of a variable. */
	int getVariable(String varName)
	{
		Integer tmp = variables.get(varName);
		return tmp.intValue();
	}
	
	/** Sets a new constraint to the model. Constraints are differed by type variable. 
	 * Posible constraints: 
	 * 1- varName1 = varName2
	 * 2- varName1 = value
	 * 3- varName1 != varName2
	 * 4- varName1 - varName2 = value
	 * 5- abs(varName1 - varName2) = value 
	 * These can be extended by extending the constraint class, if a logic puzzle needs more.
	 * In some xonstraints, varName2 or value are not needed. The initial values of them are not important.
	 * */ 
	void setConstraint(String varName1, String varName2, int value, int type)
	{
		Constraint newCons = new Constraint(this,varName1,varName2,value,type);
		constraints.add(newCons);
	}
	
	/** Checks the state of the model, i.e. values of all variables, and returns the name of the 
	 * variables which cause an inconsistency in the model. 
	 * */
	ArrayList<String> checkState()
	{
		ArrayList<String> conflictedVars = new ArrayList<String>();
		for (int i = 0; i < constraints.size(); i++) // check all constraints
		{
			Constraint nextConstraint = constraints.get(i);
			boolean hasConflict = nextConstraint.evaluate();
			if (hasConflict)
			{
				// add variables in this constraint to the conflictedVars ArrayList
				ArrayList<String> variablesInConflict = nextConstraint.getVariables();
				for (int j = 0; j < variablesInConflict.size(); j++)
				{
					String tmpVarName = variablesInConflict.get(j);
					if (!conflictedVars.contains(tmpVarName))
						conflictedVars.add(tmpVarName);
				}
			}
		}
		return conflictedVars;
	}
	
	/** Prints the values of goal variables. */
	void printGoalValues()
	{
		for (int i = 0; i < goals.size(); i++)
		{
			String varName = goals.get(i);
			int value = getVariable(varName);
			System.out.println("Value of " + varName + " is " + value);
			System.out.print("Variables having the same value: ");
			Enumeration<String> tmp = variables.keys();
			while (tmp.hasMoreElements())
			{
				String tmpVar = tmp.nextElement();
				int tmpVal = getVariable(tmpVar);
				if (tmpVal == value && !tmpVar.equals(varName))
				{
					System.out.print(tmpVar + " ");
				}
			}
			System.out.println();
		}
	}
	
	/** Returns the number of conflicts which are caused by a given variable.*/
	int checkConflicts(String variableName)
	{
		int numberOfConflicts = 0;
		for (int i = 0; i < constraints.size(); i++) // check all constraints
		{
			Constraint nextConstraint = constraints.get(i);
			if (nextConstraint.hasVariable(variableName))
			{
				boolean hasConflict = nextConstraint.evaluate();
				if (hasConflict)
				{
					numberOfConflicts++;
				}
			}
		}
		return numberOfConflicts;
	}
	
	/** Returns allowed values of the variables. */
	int[] getAllowedValues()
	{
		return allowedValues;
	}

	/** Adds a set of constraints for the model. These constraints restrict that the 
	 * variables in the given string array cannot have the same value. */
	void allDifferent(String[] vars)
	{
		for (int i = 0 ; i < vars.length; i++)
			for (int j = i+1; j < vars.length; j++)
			{
				Constraint newCons = new Constraint(this,vars[i],vars[j],-1,3);
				constraints.add(newCons);
			}
	}
	
	/** Adds a new goal variable. */
	void setGoal(String varName)
	{
		goals.add(varName);
	}
	
	/** Checks if the variable has a constraint like varName = value. If it has, it returns the value.*/
	int checkEquality(String varName)
	{
		for (int i = 0; i < constraints.size(); i++) // check all constraints
		{
			Constraint nextConstraint = constraints.get(i);
			if (nextConstraint.type == 2 && nextConstraint.hasVariable(varName))
				return nextConstraint.value;
		}
		return 10000;
	}
	
	void setState(Hashtable<String, Integer> ht)
	{
		variables = ht;
	}
}
