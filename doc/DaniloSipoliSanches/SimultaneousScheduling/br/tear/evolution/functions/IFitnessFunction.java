package br.tear.evolution.functions;

import br.tear.evolution.GenerateCromosome;


/**
 * Fitness Function interface
 * 
 */

public interface IFitnessFunction {
    /**
     * Return value of fitness function for specified chromosome
     * @param chromosome chromosome
     * @return fitness value
     */
    public int getValue(Object chromosome);
}
