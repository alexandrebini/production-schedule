/*
 * Classe responsável pelo armazenamento do makespan
 */
package br.tear.evolution.functions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import br.tear.cadastro.GanttGraph;
import br.tear.presentation.GenerateExcel;

public class Makespan {

	// Armazena os melhores cromossomos
	static ArrayList<Object> cromossomo = new ArrayList<Object>();
	
	//Armazena os melhores Makespan de cada geração
	static List<Double> makespans = new ArrayList<Double>();	

	// Aramazena os cromossomos com o seu respectivo makespan
	static Map<Object, Integer> bestSolution = new HashMap<Object, Integer>();

	static Object tempCromo = null;

	Vector<Object> copyTempCromo = new Vector<Object>();

	String copyCromo = "";

	static int tempMK;

	static GenerateExcel excel = new GenerateExcel();;

	double time = 0.0;

	int generation = 0;

	static int temp = Integer.MAX_VALUE;

	GanttGraph gantt;

	public Makespan(){
		/*
		 * Nao deve estar aqui, esta classe deve futuramente ser chamada em
		 * outro ponto
		 */		
		gantt = new GanttGraph();		
	}

	public void setCromossomo(Object valor) {
		cromossomo.add(valor);
	}

	public void setMakespan(int ms) {
		cromossomo.add((Object) ms);
	}
	
	public Object getValues(int index) {
		return cromossomo.get(index);
	}

	public void setTempSolution(Object cromo, int makespan, double media, int iteration) {
		// Salva o Otimo Local
		if (temp > makespan) {
			temp = makespan;
		}

		tempCromo = cromo;
		tempMK = makespan;		
		/*cromossomo.add(cromo);
		cromossomo.add((Object) makespan);*/
		
		setDadoExcel(Double.valueOf(String.valueOf(media)),iteration);
		//setMakespans(media);
	}

	public void setBestSolution() {
		cromossomo.add(tempCromo);
		cromossomo.add((Object) tempMK);
	}

	public void setExecutionTime(double time) {
		this.time = time;
	}

	public Double getTime() {
		return time;
	}

	public int getSize() {
		return cromossomo.size();
	}

	// Exibe a solucao encontrada
	public void showAll() throws IOException {
		/*
		 * boolean flag = false; System.out.println("Melhor programação
		 * encontrada:"); Iterator i = cromossomo.iterator();
		 * while(i.hasNext()){ Object element = i.next(); if (flag == false){
		 * System.out.println("Cromossomo: "+element); flag = true; }else{
		 * System.out.println("Makespan: "+ element); flag = false; } }
		 * System.out.println("Melhor programação encontrada:");
		 * System.out.println("Geração:" + this.generation);
		 * System.out.println(cromossomo.get(0)); System.out.println("Makespan: " +
		 * cromossomo.get(1)); System.out.println("");
		 */
		
		if(temp!=tempMK){
			System.out.println("entrou");
		}

		gantt.setBestSolution(tempCromo);
		System.out.println("Otimo Local: " + temp);
		System.out.println("Melhor Cromossomo: " + tempCromo);
		System.out.println("Melhor Makespan: " + tempMK);
		/*System.out.println("Tempos Inicial e Final: ");*/

		copyCromo = String.valueOf(tempCromo);

		// Uso soh para exibir a sequencia dos produtos
		copyTempCromo.add(tempCromo);

		//System.out.println("Tamanho: " + copyCromo.length());
		/*if (copyCromo.length() == 60) {
			System.out.println("Sequencia dos Produtos: " + copyCromo.charAt(1)
					+ "," + copyCromo.charAt(13) + "," + copyCromo.charAt(25)
					+ "," + copyCromo.charAt(37) + "," + copyCromo.charAt(49));

		} else {
			System.out.println("Sequencia dos Produtos: " + copyCromo.charAt(1)
					+ "," + copyCromo.charAt(16) + "," + copyCromo.charAt(31)
					+ "," + copyCromo.charAt(46) + "," + copyCromo.charAt(61));
		}*/
		/*
		 * Armazena o melhor Makespan
		 */
		setBestMakespan(tempMK);
		
		System.out.println("Makespans armazenados: \n"+makespans);

		temp = Integer.MAX_VALUE;
		tempCromo = null;
		tempMK = 0;
		gantt.getValues();
	}

	/**
	 * @return the makespans
	 */
	public List<Double> getMakespans() {
		return makespans;
	}

	/**
	 * @param makespans the makespans to set
	 */
	public void setBestMakespan(double makespan) {
		makespans.add(makespan);
	}
	
	public void setDadoExcel(double mediaMakespan, int number) {			
		try {
			excel.setDados(mediaMakespan,number);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			
	}
}
