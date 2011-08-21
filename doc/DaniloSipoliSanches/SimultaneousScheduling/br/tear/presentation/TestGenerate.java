/*
 * Classe resposanvel pela execu��o do Algoritmo Gen�tico
 */

package br.tear.presentation;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import br.tear.cadastro.Produto;
import br.tear.cadastro.Teste;
import br.tear.evolution.GenerateCromosome;
import br.tear.evolution.Population;
import br.tear.evolution.functions.DefaultCrossFunction;
import br.tear.evolution.functions.DefaultMutationFunction;
import br.tear.evolution.functions.FitnessFunction;
import br.tear.evolution.functions.LearningAlgorythm;
import br.tear.evolution.functions.Makespan;
import br.tear.evolution.functions.OperatorsRate;
import br.tear.evolution.functions.TournamentReproductionFunction;

public class TestGenerate implements ThreadListener {

	List<Object> cromoGenerate;
	
	List<Double> executionTimeGenerated;
	
	List<Integer> bestMakespan;

	GenerateExcel excel;

	Population oldPopulation;

	FitnessFunction fitness;

	Produto produto;
	
	Makespan makespan;

	GenerateCromosome cromossomo;

	DefaultCrossFunction crossFunctionModel;

	//RouletteReproductionFunction reproductionModel;
	TournamentReproductionFunction reproductionModel;

	DefaultMutationFunction mutationFunctionModel;

	OperatorsRate operatorsRate;	

	ThreadTime time;

	String formatTime;

	double timeSystem = 0;

	Thread thread;

	double finishTime = 0.0;

	boolean finish = false;

	DecimalFormat df;
	
	Teste teste;

	public TestGenerate() throws IOException {		
		bestMakespan = new ArrayList<Integer>();
		executionTimeGenerated = new ArrayList<Double>();
		excel = new GenerateExcel();
		makespan = new Makespan();
		// time = new ThreadTime();
		// thread = new Thread(time);

		// inicia a captura pelo tempo de execu��o
		// thread.start();

		generateExecution();
	}

	public void generateExecution() throws IOException {
		/*
		 * Limpa a lista com os melhores makespan
		 */
		bestMakespan.clear();
		
		teste = new Teste();

		// Ser�o executados 35 testes para o problema proposto
		for (int numberTest = 1; numberTest <= 35; numberTest++) {
			
			System.out.println("Iniciando teste[" + numberTest + "]");			 
			
			double init = System.currentTimeMillis();
			
			/*
			 * Da um reset nas variaveis
			 */
			//teste = new Teste();
			cromoGenerate = new ArrayList<Object>();
			df = new DecimalFormat();
			oldPopulation = new Population();
			cromossomo = new GenerateCromosome();
			crossFunctionModel = new DefaultCrossFunction();
			//reproductionModel = new RouletteReproductionFunction();
			reproductionModel = new TournamentReproductionFunction();
			mutationFunctionModel = new DefaultMutationFunction();
			operatorsRate = new OperatorsRate(0.05, 0.6);
			fitness = new FitnessFunction();
			produto = new Produto();						
			
			// tamanho da popula��o igual a 40
			int populationSize = 40;

			// Gera 40 cromossomos para a popula��o
			for (int i = 0; i < populationSize; i++) {
				cromossomo = new GenerateCromosome();
				oldPopulation.addChromosome(cromossomo.createCromossomos());
				oldPopulation.setFitnessFunction(fitness);
			}

			// Ajusta o AG para 250 itera��es
			LearningAlgorythm learning = new LearningAlgorythm(oldPopulation, 1000);

			// Definido o modelo de Sele��o, Cruzamento e Muta��o
			learning.setReproductionFunction(reproductionModel);
			learning.setCrossFunction(crossFunctionModel);
			learning.setMutationFunction(mutationFunctionModel);

			// Inicia o processo de Busca
			learning.learn();
			// time.shouldRun = false;

			// finish = true;

			// Ap�s o fim, apresenta o melhor makespan encontrado
			makespan.showAll();
			//bestMakespan.add(makespan.getBestMakespan());
			//bestMakespan.addAll(makespan.getMakespans());
			//System.out.println(bestMakespan);

			//Pega o tempo de execu��o
			//formatTime = df.format(System.currentTimeMillis() - init);
			timeSystem = System.currentTimeMillis() - init;
			executionTimeGenerated.add(timeSystem);

			init = 0.0;
			
			System.out.println("Tempo de execu��o: " + timeSystem
					+ " milisegundos");

			System.out.println("");
			
			if (numberTest == 1) {
				setDadoExcel(executionTimeGenerated);
				System.exit(0);
			}

			/*
			 * try { Thread.currentThread().sleep(2000); } catch
			 * (InterruptedException e) { // TODO Auto-generated catch block
			 * e.printStackTrace(); }
			 */
			
			

		}

	}

	public void setDadoExcel(List<Double> time) {
		List<Double> dadosPlanilha = new ArrayList<Double>();
		List<Double> executionTime = new ArrayList<Double>();

		dadosPlanilha.addAll(makespan.getMakespans());
		executionTime.addAll(time);
		for (int i = 0; i < dadosPlanilha.size();i++) {
			try {				
				excel.setDados(dadosPlanilha.get(i),executionTime.get(i));
				//excel.setDados(dadosPlanilha.get(i),i);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void getData(double getData) {
		// System.out.println(getData);
		finishTime = getData;
	}

}
