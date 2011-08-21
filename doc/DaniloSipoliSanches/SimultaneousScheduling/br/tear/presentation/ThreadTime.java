/*
 * Classe responsável em capturar os tempos de execução do sistema.
 */

package br.tear.presentation;

import java.text.DecimalFormat;

import br.tear.evolution.functions.Makespan;

public class ThreadTime implements Runnable {

	Makespan makespan;
	
	//Defini o formato do valor
	DecimalFormat df = new DecimalFormat("0.00");
	
	String valor;

	public double time = 0;

	boolean shouldRun = true;
	
	
	public void run() {
		while (shouldRun) {
			try {
				time=time+0.1;
				Thread.sleep(100);				
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//Ajusta o valor de time para o formato pré-definido
		valor = df.format(time);
		System.out.println("Tempo de Execução: "+valor+" segundos.");
		
	}
	
	
	

}
