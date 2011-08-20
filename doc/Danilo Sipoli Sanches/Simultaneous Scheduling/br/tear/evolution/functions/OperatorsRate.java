package br.tear.evolution.functions;

public class OperatorsRate {
	
	private static Double mutationRate;
	
	private static Double crossOverRate;
	
	
	/*
	 * Start the attributes with default rate
	 */
	public OperatorsRate(Double mutationRate, Double crossOverRate){		
		this.mutationRate = mutationRate;
		this.crossOverRate = crossOverRate;		
	}
		
	/*
	 * This method its used just to access the attributes without initialize it
	 */
	public OperatorsRate(){		
				
	}


	public Double getCrossOverRate() {
		return crossOverRate;
	}


	public void setCrossOverRate(Double crossOverRate) {
		//System.out.println("Ajuste de Cruzamento de " + this.crossOverRate + " para " + crossOverRate);
		this.crossOverRate = crossOverRate;
	}


	public Double getMutationRate() {
		return mutationRate;
	}


	public void setMutationRate(Double mutationRate) {
		//System.out.println("Ajuste de Mutação de " + this.mutationRate + " para " + mutationRate);
		this.mutationRate = mutationRate;
	}
	
	

}
