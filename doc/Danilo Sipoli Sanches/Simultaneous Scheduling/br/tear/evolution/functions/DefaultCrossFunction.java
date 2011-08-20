package br.tear.evolution.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Vector;

import br.tear.cadastro.Produto;
import br.tear.evolution.Population;

/**
 * Default Cross Over function
 */
public class DefaultCrossFunction extends AbstractCrossFunction {

	Vector<Object> firstChromosome, secondChromosome, auxCopyFirstChromosome,
			auxCopySecondChromosome;

	List<Object> subListaC1, subListaC2;
	
	List<Integer> chromosomeGroup;

	Produto produto;

	Random random;
	
	int selectChromosome, selectChromosomeC1, selectChromosomeC2;

	String convert = "";

	int k = 1, crossPoint = 0;

	double crossOverParameter;

	int indexC1 = 0, indexC2 = 0;

	OperatorsRate operatorsRate;

	public DefaultCrossFunction() {
		operatorsRate = new OperatorsRate();
	}

	/**
	 * Creates a new instance of DefaultCrossFunctionModel for specified
	 * population. Cross Over Propability is set to <I>1.0</I>
	 * 
	 * @param oldPopulation
	 *            reference to population
	 * @see Population
	 */
	public DefaultCrossFunction(Population oldPopulation) {
		this.oldPopulation = (Population) oldPopulation.clone();
	}

	/**
	 * Starts Crossing Over
	 */
	@SuppressWarnings("unchecked")
	public void generateNewPopulation() {
		if (oldPopulation != null) {
			produto = new Produto();
			newPopulation = (Population) oldPopulation.clone();

			int tamanho = oldPopulation.getChromosomeSize();
			int subProgram = tamanho / produto.getQuantidade();
			random = new Random();			
			firstChromosome = new Vector<Object>();
			secondChromosome = new Vector<Object>();
			auxCopyFirstChromosome = new Vector<Object>();
			auxCopySecondChromosome = new Vector<Object>();
			subListaC1 = new Vector<Object>();
			subListaC2 = new Vector<Object>();
			chromosomeGroup = new ArrayList<Integer>();

			String stringSelectChromosome = String.valueOf(Math.round((oldPopulation.size() * operatorsRate.getCrossOverRate())));
			int integerSelectChromosome = Integer.parseInt(stringSelectChromosome);
			if(integerSelectChromosome % 2!= 0)
				integerSelectChromosome++;
			else
				;
			
			for(int group =0; group<integerSelectChromosome;group++){
				selectChromosome = random.nextInt(newPopulation.size());
				chromosomeGroup.add(selectChromosome);
			}
			
				
			for (int i = 0; i < (chromosomeGroup.size()/2); i++) {
				
				/*
				 * Limpa os valores de firstChromosome e secondChromosome para
				 * serem copiados os objetos auxCopyFirstChromosome e
				 * auxCopySecondChromosome
				 */

				/*firstChromosome.clear();
				secondChromosome.clear();*/
				
				clear();
				
				//System.out.println("auxCopyFirstChromosome: "+ newPopulation.getChromosome(chromosomeGroup.get(i*2))+" indice: "+chromosomeGroup.get(i*2));
				//System.out.println("auxCopySecondChromosome: "+ newPopulation.getChromosome(chromosomeGroup.get(i*2+1))+" indice: "+chromosomeGroup.get(i*2+1));
				
				auxCopyFirstChromosome.addAll((Vector<Object>) newPopulation
						.getChromosome(chromosomeGroup.get(i*2)));
				auxCopySecondChromosome.addAll((Vector<Object>) newPopulation
						.getChromosome(chromosomeGroup.get(i * 2 + 1)));
				
				if(auxCopyFirstChromosome.size()<1)
					System.out.println(newPopulation);
				else if(auxCopySecondChromosome.size()<1)
					System.out.println(newPopulation);
				
				/*auxCopyFirstChromosome.addAll((Vector<Object>) newPopulation
						.getChromosome(i * 2));
				auxCopySecondChromosome.addAll((Vector<Object>) newPopulation
						.getChromosome(i * 2 + 1));
				*/
				/*
				 * Faz a copia do objeto para firstChromosome e secondChromosome
				 */

				/*
				 * for (int iteration1 = 0; iteration1 < auxCopyFirstChromosome
				 * .size(); iteration1++)
				 * firstChromosome.add(auxCopyFirstChromosome.get(iteration1));
				 * 
				 * for (int iteration2 = 0; iteration2 < auxCopySecondChromosome
				 * .size(); iteration2++)
				 * secondChromosome.add(auxCopySecondChromosome
				 * .get(iteration2));
				 */

				firstChromosome.addAll(auxCopyFirstChromosome);
				secondChromosome.addAll(auxCopySecondChromosome);

				/*
				 * Define o ponto de cruzamento
				 */
				crossPoint = random.nextInt(produto.getQuantidade() + 1);

				if (crossPoint == 0) {
					while (crossPoint == 0) {
						crossPoint = random
								.nextInt(produto.getQuantidade() + 1);
					}
				}

				/*
				 * Procura os mesmos produtos nos dois cromossomos e armazenam
				 * eles em uma subLista
				 */

				//System.out.println("Subprogram: "+subProgram +"  crossPoint: "+crossPoint);
				for (int point = 1; point <= crossPoint; point++) {
					if (point == crossPoint) {
						//System.out.println("firstChromosome: "+firstChromosome);
						//System.out.println("secondChromosome: "+secondChromosome);
						//System.out.println("Inicio: "+(subProgram * crossPoint - subProgram)+" Fim: "+((subProgram * crossPoint - subProgram)+subProgram));
						subListaC1.addAll(firstChromosome.subList(subProgram
								* crossPoint - subProgram, (subProgram
								* crossPoint - subProgram)
								+ subProgram));
						indexC1 = subProgram * crossPoint - subProgram;
						//System.out.println("subListaC1: "+subListaC1);
						for (int point2 = 0; point2 < secondChromosome.size(); point2 += subProgram) {
							if (secondChromosome.get(point2) == subListaC1
									.get(0)) {
								subListaC2.addAll(secondChromosome.subList(point2,
										(point2) + subProgram));

								indexC2 = point2;
							}
						}
						//System.out.println("subListaC2: "+subListaC2);
					}				
					
				}

				/*
				 * Faz a troca entre os cromossomos
				 * 
				 */

				for (int conv = 0; conv < subListaC1.size(); conv++)
					convert += String.valueOf(subListaC1.get(conv));

				int posSubListaC2 = 0;
				for (int geneC1 = indexC1; geneC1 < indexC1 + subProgram; geneC1++) {
					firstChromosome.set(geneC1, subListaC2.get(posSubListaC2));
					posSubListaC2++;
				}
				int posSubListaC1 = 0;

				for (int geneC2 = indexC2; geneC2 < indexC2 + subProgram; geneC2++) {
					secondChromosome.set(geneC2, Integer.parseInt(String
							.valueOf(convert.charAt(posSubListaC1))));// subListaC1.get(posSubListaC1));
					posSubListaC1++;
				}

				/*
				 * Atualiza os cromossomos após o cruzamento na população
				 */
				/*
				 * System.out.println("\nCromosomomo Pai(" + i * 2 + "): \n" +
				 * newPopulation.getChromosome(i * 2));
				 * System.out.println("\nCromosomomo Pai(" + (i * 2 + 1) + "):
				 * \n" + newPopulation.getChromosome(i * 2 + 1));
				 */
				/*System.out.println("First: "+ firstChromosome);
				System.out.println("Second: "+ secondChromosome);*/
				newPopulation.replaceChromosome(chromosomeGroup.get(i*2), firstChromosome);
				newPopulation.replaceChromosome(chromosomeGroup.get(i*2+1), secondChromosome);
				/*
				 * System.out.println("\nCromosomomo Filho(" + i * 2 + "): \n" +
				 * newPopulation.getChromosome(i * 2));
				 * System.out.println("\nCromosomomo Filho(" + (i * 2 + 1) + "):
				 * \n" + newPopulation.getChromosome(i * 2 + 1));
				 */
				
				/*Zera o valor das listas e de convert*/
				convert = "";				
				subListaC1.clear();
				subListaC2.clear();

			}

			/*
			 * System.out.println("Quantidade que vai cruzar: " +
			 * Math.round(oldPopulation.size() operatorsRate.getCrossOverRate() /
			 * 2));
			 */

		}
	}
	
	public void clear(){
		firstChromosome = new Vector<Object>();
		secondChromosome = new Vector<Object>();
		auxCopyFirstChromosome = new Vector<Object>();
		auxCopySecondChromosome = new Vector<Object>();
		subListaC1 = new Vector<Object>();
		subListaC2 = new Vector<Object>();
		
		firstChromosome.clear();
		secondChromosome.clear();
		auxCopyFirstChromosome.clear();
		auxCopySecondChromosome.clear();
		subListaC1.clear();
		subListaC2.clear();		
	}
}
