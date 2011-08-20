package br.tear.evolution.functions;

import br.tear.cadastro.Roteiro;
import br.tear.evolution.Population;

public abstract class AbstractMutationFunction {
	
	/**
	 * mutation propability
	 */
	protected double mutationProbability = 0.2;
	/**
	 * Reference to population after Mutation
	 * @see population
	 */
	protected Population newPopulation = new Population();
	/**
	 * Reference to population before Mutation
	 */
	protected Population oldPopulation;
	
	protected Roteiro roteiro = new Roteiro(); 

	public AbstractMutationFunction() {
		super();
	}

	/**
	 * Return Mutation propability
	 * @return Mutation propability
	 */
	public double getMutationProbability() {
	    return this.mutationProbability;
	}

	/**
	 * Set Mutation propability
	 * @param crossOverProbability Mutation propability
	 */
	public void setMutationProbability(double mutationProbability) {
	     this.mutationProbability =  mutationProbability;
	}

	/**
	 * Return population after Mutation
	 * @return Reference to population
	 * @see Population
	 */
	public Population getNewPopulation() {
	    return this.newPopulation;
	}

	/**
	* Return population before Mutation
	* @return reference to population
	* @see Population
	*/
	public Population getOldPopulation() {
	    return this.oldPopulation;
	}

	/**
	* Set Population which will be Mutation
	* @param oldPopulation Reference to population
	*/
	public void setOldPopulation(Population oldPopulation) {
	    this.oldPopulation = (Population) oldPopulation.clone();
	}

	public abstract void generateNewPopulation();
	
}
	

