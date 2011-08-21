package br.tear.evolution.functions;

import br.tear.evolution.Population;

public abstract class AbstractCrossFunction {

	/**
	 * cross over propability
	 */
	protected double crossOverProbability = 0.8;
	/**
	 * Reference to population after Cross Over
	 * @see population
	 */
	protected Population newPopulation = new Population();
	/**
	 * Reference to population before Cross Over
	 */
	protected Population oldPopulation;

	public AbstractCrossFunction() {
		super();
	}

	/**
	 * Return cross over propability
	 * @return Cross over propability
	 */
	public double getCrossOverProbability() {
	    return this.crossOverProbability;
	}

	/**
	 * Set Cross Over propability
	 * @param crossOverProbability Cross Over propability
	 */
	public void setCrossOverProbability(double crossOverProbability) {
	     this.crossOverProbability =  crossOverProbability;
	}

	/**
	 * Return population after Crossing Over
	 * @return Reference to population
	 * @see Population
	 */
	public Population getNewPopulation() {
	    return this.newPopulation;
	}

	/**
	* Return population before Crossing Over
	* @return reference to population
	* @see Population
	*/
	public Population getOldPopulation() {
	    return this.oldPopulation;
	}

	/**
	* Set Population which will be Crossing Over
	* @param oldPopulation Reference to population
	*/
	public void setOldPopulation(Population oldPopulation) {
	    this.oldPopulation = (Population) oldPopulation.clone();
	}

	public abstract void generateNewPopulation();
	
}