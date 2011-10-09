package com.eminsenay.cmpe540.p1;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Random;

public class GeneticAlgorithmSolver {
	
	private double CROSSOVER_RATE = 1;
	private double MUTATION_RATE = 0.1;
	private int POPULATION_SIZE = 10;
	
	private String[] population;
	private double[] fitness;
	private double totalFitness;
	private double[] fitnessRate;
	
	/** For every individual, there is a table which stores the keys and the values of the state. */
	private Hashtable<String, Integer>[] states;
	private CSPModel model;
	
	private Random rnd;
	
	/** Initializes the solver. */
	public GeneticAlgorithmSolver(CSPModel model)
	{
		population = new String[POPULATION_SIZE];
		fitness = new double[POPULATION_SIZE];
		fitnessRate = new double[POPULATION_SIZE];
		states = new Hashtable[POPULATION_SIZE];
		for (int i = 0; i < POPULATION_SIZE; i++)
		{
			states[i] = new Hashtable<String, Integer>();
		}
		rnd = new Random();
		this.model = model;
	}
	
	/** Main model of the genetic algorithm solver. It continues 5000 step with a random
	 *  population and if it cannot find, it reinitializes the population. */
	public boolean solve()
	{
		boolean found = false;
		for (int l = 0; l < 100; l++)
		{
			initializePopulation();
			for (int i = 0; i < 5000; i++)
			{
				found = evaluateFitness();
				calculateFitness();
				if (found)
				{
					System.out.println("Solution is found.");
					break;
				}				
				crossover();
				mutate();
			}
			if (found)
			{
				break;
			}	
		}
		if (!found)
		{
			System.out.println("Solution cannot be found. Please try again.");
		}
		return found;
	}
	
	/** Creates a random individual. */
	private String createNewElement()
	{
		StringBuffer newMember = new StringBuffer(25);
		String[] nationalities = getRandomElements();
		String[] smoke = getRandomElements();
		String[] color = getRandomElements();
		String[] pet = getRandomElements();
		String[] drink = getRandomElements();
		for (int j = 0; j < nationalities.length; j++)
			newMember.append(nationalities[j]);
		for (int j = 0; j < smoke.length; j++)
			newMember.append(smoke[j]);
		for (int j = 0; j < color.length; j++)
			newMember.append(color[j]);
		for (int j = 0; j < pet.length; j++)
			newMember.append(pet[j]);
		for (int j = 0; j < drink.length; j++)
			newMember.append(drink[j]);
		return newMember.toString();
	}
	
	/** Creates POPULATION_SIZE random individuals.*/	
	private void initializePopulation()
	{
		for (int i = 0; i < POPULATION_SIZE; i++)
		{
			population[i] = createNewElement();
		}
	}
	
	/**Prepares and returns a random array having values 1,2,3,4 and 5.*/
	private String[] getRandomElements()
	{
		String[] mixedElements = new String[5];
		ArrayList<String> memberList = new ArrayList<String>();
		memberList.add("1");
		memberList.add("2");
		memberList.add("3");
		memberList.add("4");
		memberList.add("5");
		for (int i = 0; i < 5; i++)
		{
			int rndIndex = rnd.nextInt(memberList.size());
			mixedElements[i] = memberList.remove(rndIndex);
		}
		return mixedElements;
	}
	
	/** To use the general constraints, it decodes the individuals and inserts its 
	 * values into a hashtable.  */
	private void decode(String member, Hashtable<String, Integer> state)
	{
		char[] genes = new char[25];
		for (int i = 0; i < 25; i++)
		{
			genes[i] = member.charAt(i);
		}
		// First 5 characters represent nationalities, 
		// the others are cigarettes, colors of houses, pets and drinks, respectively.
		for (int i = 0; i < 5; i++)
		{
			String key = null;
			if (genes[i] == '1') { key = "English"; }
			else if (genes[i] == '2') { key = "Norwegian"; }
			else if (genes[i] == '3') { key = "Spaniard"; }
			else if (genes[i] == '4') { key = "Japanese"; }
			else if (genes[i] == '5') { key = "Ukranian"; }
			state.put(key, new Integer(i+1));
		}
		for (int i = 5; i < 10; i++)
		{
			String key = null;
			if (genes[i] == '1') { key = "Kools"; }
			else if (genes[i] == '2') { key = "Chesterfield"; }
			else if (genes[i] == '3') { key = "Winston"; }
			else if (genes[i] == '4') { key = "Lucky Strike"; }
			else if (genes[i] == '5') { key = "Parliament"; }
			state.put(key, new Integer(i-4));
		}
		for (int i = 10; i < 15; i++)
		{
			String key = null;
			if (genes[i] == '1') { key = "Yellow"; }
			else if (genes[i] == '2') { key = "Red"; }
			else if (genes[i] == '3') { key = "Blue"; }
			else if (genes[i] == '4') { key = "Green"; }
			else if (genes[i] == '5') { key = "Ivory"; }
			state.put(key, new Integer(i-9));
		}
		for (int i = 15; i < 20; i++)
		{
			String key = null;
			if (genes[i] == '1') { key = "Dog"; }
			else if (genes[i] == '2') { key = "Fox"; }
			else if (genes[i] == '3') { key = "Horse"; }
			else if (genes[i] == '4') { key = "Snails"; }
			else if (genes[i] == '5') { key = "Zebra"; }
			state.put(key, new Integer(i-14));
		}
		for (int i = 20; i < 25; i++)
		{
			String key = null;
			if (genes[i] == '1') { key = "Orange Juice"; }
			else if (genes[i] == '2') { key = "Tea"; }
			else if (genes[i] == '3') { key = "Coffee"; }
			else if (genes[i] == '4') { key = "Milk"; }
			else if (genes[i] == '5') { key = "Water"; }
			state.put(key, new Integer(i-19));
		}
	}
	
	/** Finds the fitness values of all individuals and if solution is found, 
	 * it displays the elements.*/
	private boolean evaluateFitness()
	{
		totalFitness = 0;
		for (int i = 0; i < POPULATION_SIZE; i++)
		{
			decode(population[i],states[i]);
			double fitnessValue = fitness(states[i]);
			if (fitnessValue == 1)
			{
				Enumeration<String> tmp = states[i].keys();
				while (tmp.hasMoreElements())
				{
					String tmpVar = tmp.nextElement();
					int tmpVal = model.getVariable(tmpVar);
					System.out.println(tmpVar + " : " + tmpVal);
				}
				return true;
			}
			fitness[i] = fitnessValue;
			totalFitness += fitnessValue;
		}
		for (int i = 0; i < POPULATION_SIZE; i++)
		{
			fitnessRate[i] = (fitness[i]*100/totalFitness);
		}
		return false;
	}
	/** Calculates the fitness rates of all individuals. */
	private void calculateFitness()
	{
		totalFitness = 0;
		for (int i = 0; i < POPULATION_SIZE; i++)
		{
			totalFitness += fitness[i];
		}
		for (int i = 0; i < POPULATION_SIZE; i++)
		{
			fitnessRate[i] = (fitness[i]*100/totalFitness);
		}
	}
	/** Returns a fitness number based on 1/(1+numberofconflicts). */
	private double fitness(Hashtable<String, Integer> state)
	{
		model.setState(state);
		ArrayList<String> numberOfConflicts = model.checkState();
		return 1.0/(1.0+numberOfConflicts.size());
	}
	
	/** Takes a random individual and exchanges two keys of the same type, i.e. color of the houses.
	 * This operation is done (POPULATION_SIZE*MUTATION_RATE) times.*/
	private void mutate()
	{
		for (int i = 0; i < (POPULATION_SIZE*MUTATION_RATE); i++)
		{
			int randomMemberIndex = rnd.nextInt(POPULATION_SIZE);
			char[] memberArr = population[randomMemberIndex].toCharArray();
			
			int rndGenePlace = rnd.nextInt(5)*5;
			int mutateIndex1 = rnd.nextInt(5);
			int mutateIndex2 = mutateIndex1;
			while (mutateIndex2 == mutateIndex1)
				mutateIndex2 = rnd.nextInt(5);
				
			char tmp1 = memberArr[rndGenePlace+mutateIndex1];
			memberArr[rndGenePlace+mutateIndex1] = memberArr[rndGenePlace+mutateIndex2];
			memberArr[rndGenePlace+mutateIndex2] = tmp1;
			population[randomMemberIndex] = new String(memberArr);
		}
	}
	/** Takes two individuals, cuts these from a beginning of a random gene, and
	 *  exchanges the remaning genes. This operation is done (POPULATION_SIZE*CROSSOVER_RATE)/2 times.*/
	private void crossover()
	{
		String[] newPopulation = new String[POPULATION_SIZE];
		
		for (int i = 0; i < ((POPULATION_SIZE*CROSSOVER_RATE)/2); i++)
		{
			int populationIndex1 = findCrossoverIndividual();
			int populationIndex2 = populationIndex1;

			String individual1 = population[populationIndex1];
			String individual2 = population[populationIndex2];
			
			while (populationIndex1 == populationIndex2)// || individual1.equals(individual2))
			{
				populationIndex2 = findCrossoverIndividual();
				individual2 = population[populationIndex2];
			}
			
			int placeForCrossover = (rnd.nextInt(4) + 1)*5;
			
			String individual1beg = individual1.substring(0, placeForCrossover);
			String individual1end = individual1.substring(placeForCrossover);
			
			String individual2beg = individual2.substring(0, placeForCrossover);
			String individual2end = individual2.substring(placeForCrossover);
			
			String newMember1 = individual1beg + individual2end;
			String newMember2 = individual2beg + individual1end;

			newPopulation[2*i] = newMember1;
			newPopulation[2*i+1] = newMember2;
		}	
		for (int j = 0; j < newPopulation.length; j++)
		{
			if (newPopulation[j] != null)
				population[j] = newPopulation[j];
		}
	}
	
	/** Selects a random individual based on the fitness rate.*/
	private int findCrossoverIndividual()
	{
		int populationIndex = -1;
		while (populationIndex == -1)
		{
			int rndInt = rnd.nextInt(100);
			double sum = 0;
			for (int i = 0; i < POPULATION_SIZE; i++)
			{
				sum += fitnessRate[i];
				if (rndInt < sum)
				{
					populationIndex = i;
					break;
				}
			}
		}
		return populationIndex;
	}
}
