package br.tear.evolution.functions;

import br.tear.evolution.Population;

public class Elitism {
	
	private static Object tempCromo;
		
	public Elitism(){
		tempCromo = null;		
	}

	public Object getTempCromo() {
		return this.tempCromo;
	}

	public void setTempCromo(Object tempCromo) {
		this.tempCromo = null;
		 this.tempCromo = tempCromo;
		 //System.out.println("Cromosomo recebido: " + this.tempCromo);
	}
	
	

}
