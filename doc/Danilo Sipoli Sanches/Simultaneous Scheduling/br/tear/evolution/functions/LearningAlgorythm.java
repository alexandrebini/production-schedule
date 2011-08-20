package br.tear.evolution.functions;

import java.util.ArrayList;

import br.tear.evolution.Population;

/*
 * import org.apache.log4j.BasicConfigurator; import org.apache.log4j.Level;
 * import org.apache.log4j.Logger;
 */

/**
 * Learning algorithm
 */
public class LearningAlgorythm {

	// static final Logger logger = Logger.getLogger(LearningAlgorythm.class);

	/**
	 * Filter for the iterations
	 */
	private int filter = 0;

	/**
	 * Reference to Reproduction model
	 */
	private AbstractReproductionFunction reproductionFunction;

	/**
	 * Reference to Cross Over function
	 */
	private AbstractCrossFunction crossFunction;

	/**
	 * Reference to Mutation function
	 */
	private AbstractMutationFunction mutationFunction;

	/**
	 * Reference to Population model
	 */
	private Population oldPopulation;

	/**
	 * Reference to Elitism model
	 */
	private Elitism elitism;

	/* Save elitism in attribute */
	private static Object saveElitism;

	/**
	 * Reference to OperatorsRate
	 */
	private OperatorsRate operatorsRate;

	/**
	 * New Population
	 */
	private Population newPopulation;

	/**
	 * Number of iterations
	 */
	private int maxIteration;

	/**
	 * Flag of reproducion
	 */
	private boolean makeReproduction;

	/**
	 * Flag of Cross Over
	 */
	private boolean makeCrossOver;

	/**
	 * Flag of Mutation
	 */
	private boolean makeMutation;

	/**
	 * Flag of Iteration
	 */
	private boolean iteration = false;

	/**
	 *Save best chromosome in generation
	 */
	private Object bestChromosome = null;

	/*
	 * Reference to Makespan Model
	 */
	private Makespan makespan;
	
	/*
	 * Get the best fitness value of the generation
	 */
	private int bestFitnessValue;


	/**
	 * Creates a new instance of LearningAlgorythm
	 * 
	 * @param oldPopulation
	 *            Old population
	 * @param maxIteration
	 *            Number of iteration
	 */
	public LearningAlgorythm(Population oldPopulation, int maxIteration) {
		bestChromosome = new ArrayList<Object>();
		this.makeReproduction = false;
		this.makeCrossOver = false;
		this.makeMutation = false;
		this.oldPopulation = (Population) oldPopulation.clone();
		this.maxIteration = maxIteration;
		operatorsRate = new OperatorsRate();
		elitism = new Elitism();
		saveElitism = null;
		makespan = new Makespan();
	}
	
	/**
	 * Return reference to Cross Over Function
	 * 
	 * @return Reference to cross over function
	 */
	public AbstractCrossFunction getCrossFunction() {
		return this.crossFunction;
	}

	/**
	 * Return number of iteration
	 * 
	 * @return Return number of iteration
	 */
	public int getMaxIteration() {
		return maxIteration;
	}

	/**
	 * Return reference to new population
	 * 
	 * @return Reference to new population
	 */
	public Population getNewPoplation() {
		return this.newPopulation;
	}

	/**
	 * Return reference to populatoin before learning
	 * 
	 * @return Reference to population before learning
	 */
	public Population getOldPopulation() {
		return this.oldPopulation;
	}

	/**
	 * Return reference to reproduction Function Model
	 * 
	 * @return Reference to reproducion function model
	 */
	public AbstractReproductionFunction getReproductionFunction() {
		return reproductionFunction;
	}

	/**
	 * Check if cross over is used in learning algorithm
	 * 
	 * @return return information about cross over
	 */
	public boolean isMakeCrossOver() {
		return this.makeCrossOver;
	}

	/**
	 * Check if mutation is used in learning algorithm
	 * 
	 * @return return information about mutation
	 */
	public boolean isMakeMutation() {
		return this.makeMutation;
	}

	/**
	 * Check if reproduction is used in learning algorithm
	 * 
	 * @return return information about reproduction
	 */
	public boolean isMakeReproduction() {
		return this.makeReproduction;
	}

	/**
	 * Start learning algorithm
	 */
	public void learn() {
		// BasicConfigurator.configure();
		// logger.setLevel(Level.INFO);
		
		double convergence = Double.MAX_VALUE;

		Population tempPopulation = (Population) oldPopulation.clone();

		/*
		 * Executa o nro de itera��es fornecidas Deve-se adiconar um teste para
		 * vereficar se encontrou um bom resultado antes das itera��es
		 */

		// for (int i = 0; i < maxIteration; i++) {
		int i = 0;
		double newPopulationAverage = 0.0, oldPopulationAverage = 0.0, oldCrossOver = 0.0, oldMutation = 0.0; 
		

		while ((i < maxIteration) && (convergence!=0.0)){//(filter != 1000)) {
			//System.out.println("Itera��o ["+i+"]");
			// logger.info("Iteration number: " + i);
			if (makeReproduction) {
				// logger.info("Sele��o...");
				reproductionFunction.setOldPopulation(tempPopulation);
				reproductionFunction.generateNewPopulation();
				/*System.out.println("tempPopulation Inicial \n" +
				 tempPopulation);*/
				tempPopulation = (Population) reproductionFunction
						.getNewPopulation().clone();
				saveElitism = elitism.getTempCromo();
				/*System.out.println("\ntempPopulation pos torneio: \n" +
				 tempPopulation);
				System.out.println("Cromosomome salvo pelo elitismo pos	roleta: " + saveElitism + " Elistimo da Classe: " +
				elitism.getTempCromo());*/
				// logger.info("Sele��o Finalizada");
			}
			
			// System.out.println("Cromosomome salvo pelo elitismo : " +
			// tempPopulation.getFitnessValue(saveElitism));			
			
			if (makeCrossOver) {
				// logger.info("Cruzamento...");
				crossFunction.setOldPopulation(tempPopulation);
				crossFunction.generateNewPopulation();
				tempPopulation = (Population) crossFunction.getNewPopulation()
						.clone();
				// logger.info("Cruzamento Finalizado");
				/* System.out.println("\ntempPopulation pos cruzamento: \n" +
				 tempPopulation);*/
				 
				// System.out.println("Cromosomome salvo pelo elitismo pos
				// cruzamento: " + elitism.getTempCromo() + " Elistimo da
				// Variavel: " + saveElitism);
			}

			/*
			 * Obtem o melhor fitness atual
			 */
			bestChromosome = tempPopulation.getBestChromosome();
			bestFitnessValue = tempPopulation.getFitnessValue(bestChromosome);			
						
			/*
			 * Verifica se houve melhora ou piora ap�s a aplica��o do cruzamento
			 */			
			if (oldCrossOver != 0.0) {
				if (verifyAboveRate(bestFitnessValue, oldCrossOver, tempPopulation
							.getMediaMakespan())) {
					if (operatorsRate.getCrossOverRate() > 0.5)
						operatorsRate.setCrossOverRate((operatorsRate
								.getCrossOverRate()) - 0.05);	
					//System.out.println("Cruzamento: "+operatorsRate.getCrossOverRate());
				} else if (verifyBelowRate(bestFitnessValue, oldCrossOver, tempPopulation
						.getMediaMakespan())) {
					if ((operatorsRate.getCrossOverRate() > 0.5)
							&& (operatorsRate.getCrossOverRate() < 1.0))
						operatorsRate.setCrossOverRate((operatorsRate
								.getCrossOverRate()) + 0.05);
					//System.out.println("Cruzamento: "+operatorsRate.getCrossOverRate());
				}
			}
			
			/*
			 * Obtem o melhor cromossomo apos o cruzamento
			 */			
			oldCrossOver = tempPopulation.getMediaMakespan() - bestFitnessValue;
			

			/*
			 * System.out.println("\nTaxa Cruzamento: " +
			 * operatorsRate.getCrossOverRate());
			 */

			/*
			 * System.out.println("OldPopulation: " + oldPopulationAverage + "
			 * Ap�s Cruzamento: " + tempPopulation.getMediaMakespan());
			 */

			// System.out.println("\nCromosomome salvo pelo elitismo: \n" +
			// tempPopulation.getFitnessValue(saveElitism));
			if (makeMutation) {
				// logger.info("Muta��o...");
				mutationFunction.setOldPopulation(tempPopulation);
				mutationFunction.generateNewPopulation();
				tempPopulation = (Population) mutationFunction
						.getNewPopulation().clone();
				// logger.info("Muta��o Finalizada");
				/* System.out.println("\ntempPopulation pos muta��o: \n" +
				  tempPopulation);*/
				 
				// System.out.println("Cromosomome salvo pelo elitismo pos
				// muta��o: " + saveElitism);}
			}

			
			/*
			 * Obtem o melhor fitness atual
			 */
			bestChromosome = tempPopulation.getBestChromosome();
			bestFitnessValue = tempPopulation.getFitnessValue(bestChromosome);
			
			/*
			 * Verifica se houve melhora ou piora ap�s a aplica��o da muta��o
			 */

			if (oldMutation != 0.0) {
				if (verifyAboveRate(bestFitnessValue, oldMutation, tempPopulation
						.getMediaMakespan())) {
					if (operatorsRate.getMutationRate() >= 0.005)
						operatorsRate.setMutationRate((operatorsRate
								.getMutationRate()) - 0.005);	
					//System.out.println("Muta��o: "+operatorsRate.getMutationRate());
				} else if (verifyBelowRate(bestFitnessValue, oldMutation, tempPopulation
						.getMediaMakespan())) {
					if ((operatorsRate.getMutationRate() >= 0.005)
							&& (operatorsRate.getMutationRate() < 0.2))
						operatorsRate.setMutationRate((operatorsRate
								.getMutationRate()) + 0.005);
					//System.out.println("Muta��o: "+operatorsRate.getMutationRate());
				}
			}
			
			/*
			 * Obtem o melhor cromossomo apos a muta��o
			 */			
			oldMutation = tempPopulation.getMediaMakespan() - bestFitnessValue;
			
			
			/*
			 * System.out.println("\nTaxa Muta��o: " +
			 * operatorsRate.getMutationRate());
			 */			

			if (tempPopulation.getMediaMakespan() - newPopulationAverage == 0)
				filter++;
			else
				filter = 0;

			/*/System.out.println("\nCromosomome salvo pelo elitismo: \n" +
			tempPopulation.getFitnessValue(saveElitism));*/
			tempPopulation.addChromosome(saveElitism);
			//bestChromosome.add((Object) (tempPopulation.getBestChromosome()));
			newPopulation = (Population) tempPopulation.clone();
			
			/*
			 * System.out.println("Elitismo: " +
			 * newPopulation.getChromosome(newPopulation.size()-1) + " Makespan : " +
			 * newPopulation.getFitnessValue(newPopulation.size()-1));
			 * System.out.println("\nNova Popula��o com Elitismo: \n" +
			 * newPopulation);
			 */
			newPopulationAverage = tempPopulation.getMediaMakespan();
			i++;

			/*
			 * if(i==6) System.exit(0);
			 */
			
			if(i==400){
				System.out.println("Chegou");
			}
			
			bestChromosome = newPopulation.getBestChromosome();
			bestFitnessValue = newPopulation.getFitnessValue(bestChromosome);
			makespan.setTempSolution(bestChromosome, bestFitnessValue, newPopulation.getMediaMakespan(),i);
			//System.out.println("Melhor Makespan : "+bestFitnessValue);
			convergence = newPopulation.getMediaMakespan() - bestFitnessValue;
			//System.out.println("Convergencia : "+ convergence);
			
			
			

		}

		makespan.setBestSolution();

		/*if (i == maxIteration) {
			System.out.println("Fim da Itera��o e n�o convergiu 1000 vezes : "
					+ i);
		} else {
			System.out.println("Convergiu a partir da itera��o: " + i);
		}*/
		
		if (convergence !=0.0) {
			System.out.println("Fim da Itera��o e n�o convergiu: "
					+ i);
		} else {
			System.out.println("Convergiu na itera��o: " + i);
		}	
	}

	/**
	 * Set reference to Cross Over funciton
	 * 
	 * @param crossFunctionModel
	 *            reference to Cross Over Function
	 */
	public void setCrossFunction(AbstractCrossFunction crossFunctionModel) {
		this.crossFunction = crossFunctionModel;
		this.makeCrossOver = true;
	}

	/**
	 * Set reference to Mutation funciton
	 * 
	 * @param muatationFunctionModel
	 *            reference to Mutation Function
	 */
	public void setMutationFunction(
			AbstractMutationFunction mutationFunctionModel) {
		this.mutationFunction = mutationFunctionModel;
		this.makeMutation = true;
	}

	/**
	 * Set using cross over in learning
	 * 
	 * @param makeCrossOver
	 *            Set using cross over in learning
	 */
	public void setMakeCrossOver(boolean makeCrossOver) {
		this.makeCrossOver = makeCrossOver;
	}

	/**
	 * Set using mutation in learning
	 * 
	 * @param makeMutation
	 *            Set using mutation in learning
	 */
	public void setMakeMutation(boolean makeMutation) {
		this.makeMutation = makeMutation;
	}

	/**
	 * Set using reproducion in learning
	 * 
	 * @param makeReproduction
	 *            Set using reproducion in learning
	 */
	public void setMakeReproduction(boolean makeReproduction) {
		this.makeReproduction = makeReproduction;
	}

	/**
	 * Set iteration number
	 * 
	 * @param maxIteration
	 *            Iteration number
	 */
	public void setMaxIteration(int maxIteration) {
		this.maxIteration = maxIteration;
	}

	/**
	 * Set old population
	 * 
	 * @param oldPopulation
	 *            Reference to population
	 */
	public void setOldPopulation(Population oldPopulation) {
		this.oldPopulation = (Population) oldPopulation.clone();
	}

	/**
	 * Set reproducion function model
	 * 
	 * @param reproductionFunciton
	 *            Reference to reproducion function model
	 */
	public void setReproductionFunction(
			AbstractReproductionFunction reproductionFunciton) {
		this.reproductionFunction = reproductionFunciton;
		this.makeReproduction = true;
	}

	/*
	 * Verify if average makespan its above to 10%
	 */
	public boolean verifyAboveRate(int bestFitness, double oldFitness, double popAverage) {
		/*System.out.println("Atual: "+(popAverage - bestFitness)+" Antigo: "+oldFitness);
		System.out.println(popAverage - bestFitness+" = "+((oldFitness) + oldFitness * 0.1));*/
		if (Math.round(popAverage - bestFitness) > Math
				.round(((oldFitness) + oldFitness * 0.1))) {			
			return true;
		} else
			return false;
	}

	/*
	 * Verify if average makespan its below to 10%
	 */
	public boolean verifyBelowRate(int bestFitness, double oldFitness, double popAverage) {
		/*System.out.println("Atual: "+(popAverage - bestFitness)+" Antigo: "+oldFitness);
		System.out.println(popAverage - bestFitness+" = "+((oldFitness) + oldFitness * 0.1));*/
		if (Math.round(popAverage - bestFitness) < Math
				.round(((oldFitness) + oldFitness * 0.1))) {			
			return true;
		} else
			return false;
	}

}
