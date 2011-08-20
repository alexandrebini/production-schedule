package br.tear.evolution.functions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import br.tear.evolution.Population;

public class TournamentReproductionFunction extends
		AbstractReproductionFunction {

	/**
	 * Array of weel value for each chromosome in population
	 */
	private Double[] wheelValue;

	/*
	 * Save oldPopulation
	 */
	Population tempOldPopulation;

	/*
	 * reference to Elitism Model
	 */
	private Elitism elitism;

	/*
	 * Atrubuttes for calcule elitism
	 */
	private int bestChromosome, indexBestChromosome;

	/*
	 * Save the best cromosome
	 */
	private Object melhorCromo;

	/*
	 * Generate the random chromosome for tournament
	 */
	private Random random;

	/*
	 * Save the chromosome for tournament
	 */
	private ArrayList<Integer> selectedChromosomes;

	/*
	 * Save the chromosome for tournament (HashMap)
	 */
	private Map<Integer, Object> selectedChromosomesMap;

	/**
	 * Creates a new instance of TournamentReproductionFunction for specified
	 * population
	 */
	public TournamentReproductionFunction() {
		newPopulaton = new Population();
		elitism = new Elitism();
		tempOldPopulation = new Population();
		random = new Random();
		selectedChromosomes = new ArrayList<Integer>();
		selectedChromosomesMap = new HashMap<Integer, Object>();
	}

	@Override
	public void setOldPopulation(Population oldPopulation) {
		super.setOldPopulation(oldPopulation);
		wheelValue = new Double[oldPopulation.size()];
	}

	/**
	 * Starts Reproduction according to tournament function
	 */
	public void generateNewPopulation() {
		int chromosomeIndex = 0, max = 0, min = 0;
		double sum = 0, point = 0, wheelTemp = 0, tempValue = 0;

		/*
		 * Aplica Elitismo salvando o melhor cromossomo para a geração
		 * intermediária
		 */
		elitism.setTempCromo(oldPopulation.getBestChromosome());

		newPopulaton = new Population();
		newPopulaton.setFitnessFunction(oldPopulation.getFitnessFunction());

		int oldPopulationSize = oldPopulation.size();

		/*
		 * Faz a seleção dos melhores indivíduos -1 por que um cromosomo foi
		 * salve pelo elitismo
		 */
		tempOldPopulation = (Population) oldPopulation.clone();		
		for (int i = 0; i < tempOldPopulation.size() - 1; i++) {
			Object choosenChromosome = getBestChromosome(tempOldPopulation);
			newPopulaton.addChromosome(choosenChromosome);
		}

	}

	public Object getBestChromosome(Population population) {
		int index, tempFitness, bestFitness = Integer.MAX_VALUE;
		Object bestChromosome = null;

		/*
		 * Add chromosomes random seleted
		 */
		for (int i = 0; i < 5; i++) {
			index = random.nextInt(population.size());
			//selectedChromosomesMap.put(index, population.getChromosome(index));
			selectedChromosomes.add(index);
		}
		
		for (int j : selectedChromosomes) {
			tempFitness = population.getFitnessValue(j);
			if (bestFitness > tempFitness) {
				bestFitness = tempFitness;
				bestChromosome = population.getChromosome(j);
			}
		}
		
			selectedChromosomes.clear();
			return bestChromosome;	
	}
	
}
