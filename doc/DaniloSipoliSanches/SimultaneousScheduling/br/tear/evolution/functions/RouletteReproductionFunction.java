package br.tear.evolution.functions;

import br.tear.evolution.GenerateCromosome;
import br.tear.evolution.Population;

/**
 * Rulette Reproduction function
 */
public class RouletteReproductionFunction extends AbstractReproductionFunction {

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
	 * Create New Cromosomes
	 */
	GenerateCromosome generateNewCromosome;

	/*
	 * Flag for roulette
	 */
	Boolean flag;

	/**
	 * Creates a new instance of RouletteReproductionFunction for specified
	 * population
	 */
	public RouletteReproductionFunction() {
		newPopulaton = new Population();
		elitism = new Elitism();
		tempOldPopulation = new Population();
		generateNewCromosome = new GenerateCromosome();
	}

	@Override
	public void setOldPopulation(Population oldPopulation) {
		super.setOldPopulation(oldPopulation);
		wheelValue = new Double[oldPopulation.size()];
	}

	/**
	 * Starts Reproduction according to roulette function
	 */
	public void generateNewPopulation() {
		flag = false;
		int chromosomeIndex = 0, max = 0, min = 0;
		double sum = 0, point = 0, wheelTemp = 0, tempValue = 0;
		java.util.Random random = new java.util.Random();

		/*
		 * Aplica Elitismo salvando o melhor cromossomo para a gera��o
		 * intermedi�ria
		 */
		elitism.setTempCromo(oldPopulation.getBestChromosome());

		newPopulaton = new Population();
		newPopulaton.setFitnessFunction(oldPopulation.getFitnessFunction());

		int oldPopulationSize = oldPopulation.size();
		int[] fitnessValue = new int[oldPopulationSize];
		int value = 0;

		max = oldPopulation.getFitnessValue(0);
		min = oldPopulation.getFitnessValue(0);
		for (int i = 1; i < oldPopulationSize; i++) {

			if (max < oldPopulation.getFitnessValue(i)) {
				max = oldPopulation.getFitnessValue(i);
			}

			if (min > oldPopulation.getFitnessValue(i)) {
				min = oldPopulation.getFitnessValue(i);
			}
		}

		/*
		 * Verifica se ocorre a sele��o
		 */

		// System.out.println("Antes da Sele��o:");
		// System.out.println(oldPopulation);
		// System.out.println(oldPopulation.getMediaMakespan());
		// melhor cromossomo de cada gera��o
		int melhor = oldPopulation.getFitnessValue(0);
		int imelhor = 0;

		/*
		 * Decrementa 1 devido ao elitismo
		 */
		for (int i = 0; i < oldPopulationSize - 1; i++) {
			value = oldPopulation.getFitnessValue(i);
			if (melhor > value) {
				melhor = value;
				imelhor = i;
			}
			// tempFitnessValue[i]=value;
			fitnessValue[i] = max - value + min;
			sum += fitnessValue[i];
		}

		// System.out.println("Melhor cromossomo: " +
		// oldPopulation.getChromosome(imelhor) +" - " + melhor);
		/*
		 * Decrementa 1 devido ao elitismo
		 */

		for (int i = 0; i < oldPopulationSize - 1; i++) {
			tempValue = fitnessValue[i] / sum;
			wheelTemp += tempValue;
			wheelValue[i] = wheelTemp;
			// System.out.println("FitnessValue("+i+") = "+tempFitnessValue[i]+
			// " TempValue = "+tempValue + " Soma: "+wheelValue[i]);
		}

		/*
		 * Faz a sele��o dos melhores indiv�duos -1 por que um cromosomo foi
		 * salve pelo elitismo
		 */
		for (int i = 0; i < oldPopulationSize - 1; i++) {
			point = random.nextDouble();
			for (int j = 0; j < oldPopulation.size(); j++) {
				if (wheelValue[j] >= point) {
					chromosomeIndex = j;
					flag = true;
					break;
				}
				// chromosomeIndex = 0;
				// chromosomeIndex = random.nextInt(oldPopulationSize);
			}
			/*
			 * if (!flag) { newPopulaton.addChromosome(generateNewCromosome
			 * .createCromossomos()); } else { tempOldPopulation = (Population)
			 * oldPopulation.clone(); Object choosenChromosome =
			 * tempOldPopulation .getChromosome(chromosomeIndex);
			 * newPopulaton.addChromosome(choosenChromosome); }
			 */
			tempOldPopulation = (Population) oldPopulation.clone();
			Object choosenChromosome = tempOldPopulation
					.getChromosome(chromosomeIndex);
			newPopulaton.addChromosome(choosenChromosome);
		}

		// System.out.println("Ap�s Sele��o:");
		// System.out.println(newPopulaton);

	}
}
