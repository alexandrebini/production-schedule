/**
 * Classe responsável em armazenar as populações
 **/

package br.tear.evolution;

import java.util.ArrayList;
import java.util.Vector;

import br.tear.evolution.functions.IFitnessFunction;
import br.tear.evolution.functions.Makespan;


/**
 * Population which is a set of chromosomes
 * 
 */

public class Population implements Cloneable {

	private IFitnessFunction fitnessFunction;
	
	/**
	 * ArrayList of chromosome
	 */
	private ArrayList<Object> population;
	
	private Makespan makespan;

	/**
	 * Create new instance of population. Population size is set to <I>0</I>
	 */
	public Population() {
		population = new ArrayList<Object>();
		makespan = new Makespan();		
	}

	/**
	 * Add chromosome to the population at the end. Population size increments
	 * 
	 * @param tempChromosome
	 *            Reference to chromosome
	 */
	public void addChromosome(Object tempChromosome) {
		population.add(tempChromosome);
		
	}

		
	/**
	 * Create and return copy of population
	 * 
	 * @return copy of the population
	 */
	public Object clone() {
		Population populationCopy = new Population();
		populationCopy.fitnessFunction = fitnessFunction;
		for (int i = 0; i < size(); i++) {
			populationCopy.addChromosome(population.get(i));
		}
		return populationCopy;
	}

	/**
	 * Indicates whether some other object is "equal to" this network.
	 * 
	 * @param obj
	 *            the reference object to compare with
	 * @return <I>true</I> if this chromosome is the same as the obj argument;<I>
	 *         false</I> otherwise
	 */
	public boolean equals(Object obj) {
		if (obj instanceof Population) {
			Population tempPopulation = (Population) obj;
			if (size() != tempPopulation.size())
				return false;

			for (int i = 0; i < size(); i++) {
				if (!population.get(i).equals(tempPopulation.getChromosome(i)))
					return false;
			}
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Return reference to chromosome with best fitness function value
	 * 
	 * @return reference to chromosome
	 */
	public Object getBestChromosome() {
		Object bestChromosome = null;
		int bestFittnesValue = 0;
		
		bestChromosome = population.get(0);
		bestFittnesValue = getFitnessValue(0);
		
		for (int i = 1; i < size(); i++) {
			//System.out.println(bestChromosome+": "+bestFittnesValue+" < "+population.get(i)+": "+getFitnessValue(i));
			if (getFitnessValue(i) < bestFittnesValue) {
				bestChromosome = population.get(i);
				//bestFittnesValue = getFitnessValue(bestChromosome);
				bestFittnesValue = getFitnessValue(i);
			}
		}		
				
		return bestChromosome;
	}
	
	public Object getPoorChromosome() {
		Object poorChromosome = null;
		int poorFittnesValue = 0;
		
		poorChromosome = population.get(0);
		poorFittnesValue = getFitnessValue(0);
		
		for (int i = 1; i < size(); i++) {
			//System.out.println(bestChromosome+": "+bestFittnesValue+" < "+population.get(i)+": "+getFitnessValue(i));
			if (getFitnessValue(i) > poorFittnesValue) {
				poorChromosome = population.get(i);
				//bestFittnesValue = getFitnessValue(bestChromosome);
				poorFittnesValue = getFitnessValue(i);
			}
		}		
				
		return poorChromosome;
	}

	/**
	 * Return reference to chromosome specified by index
	 * 
	 * @param index
	 *            chromosome index
	 * @return reference to chromosome
	 */
	public Object getChromosome(int index) {
		return population.get(index);
	}
	
	
	/**
	 * Return size of chromosome
	 * 
	 * @return size of chromosome
	 */
	public int getChromosomeSize() {
		Vector<Object> tamanho = new Vector<Object>();
		if (size() > 0){
			tamanho = (Vector<Object>) population.get(0);
			return tamanho.size();
		}			
		else
			return 0;
	}
	
	public Double getMediaMakespan(){
		Double media=0.0;	
		for (int i = 0; i < size(); i++) {
			media +=getFitnessValue(i); 
		}
		return media/size();
	}

	public IFitnessFunction getFitnessFunction() {
		return fitnessFunction;
	}
			
	/*public double getFitnessValue(Object chromosome) {
		return fitnessFunction.getValue(chromosome);
	}*/

	public int getFitnessValue(int chromosomeNumber) {
		return fitnessFunction.getValue(population.get(chromosomeNumber));
	}
	
	public int getFitnessValue(Object chromosome) {
		return fitnessFunction.getValue(chromosome);
	}

	
	
	/**
	 * Return population size
	 * 
	 * @return population size
	 */
	public int size() {
		return population.size();
	}

	/**
	 * Clear population. Population size is set to <I>0</I>
	 */
	public void removeAllChromosome() {
		population.clear();
	}

	/**
	 * Remove chromosome specified by index. Population size is decrease.
	 * 
	 * @param index
	 *            index of the chromosome
	 */
	public void removeChromosome(int index) {
		population.remove(index);
	}

	/**
	 * Replece chromosome specified by index by chromosome
	 * 
	 * @param index
	 *            chromosome which must by replace
	 * @param tempChromosome
	 *            reference to new chromosome
	 */
	public void replaceChromosome(int index, Object tempChromosome) {
		population.set(index, tempChromosome);
	}

	public void setFitnessFunction(IFitnessFunction fitnessFunction) {
		this.fitnessFunction = fitnessFunction;
	}
	
	//public void setFitnessFunction(BitFitnessFunction fitnessFunction) {
	//	this.fitnessFunction = fitnessFunction;
	//}

	/**
	 * Return <I>String</I> representation of population
	 * 
	 * @return Strin representation of population
	 */
	public String toString() {
		String populationText = "";
		if (fitnessFunction != null) {
			for (int i = 0; i < size(); i++) {
				populationText += population.get(i).toString() + " - "
						+ getFitnessValue(i) + "\n";
			}
		} else {
			for (int i = 0; i < size(); i++) {
				populationText += population.get(i).toString() + "\n";
			}

		}
		return populationText;
	}
}
