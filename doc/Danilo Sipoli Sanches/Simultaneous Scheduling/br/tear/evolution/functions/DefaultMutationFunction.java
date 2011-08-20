package br.tear.evolution.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Vector;

import br.tear.cadastro.Produto;
import br.tear.evolution.Population;

public class DefaultMutationFunction extends AbstractMutationFunction {
	Produto produto;

	int tamanho, subProgram, mutationPoint = 0;

	int indexC1 = 0, indexC2 = 0, indexC3 = 0, indexC4 = 0;

	Random random;

	Object codRoute = null;

	String verificaProd, tempRoteiro, tempRoteiroLimpo = null;

	double mutationParameter;

	Vector<Integer> chromosome, auxChromosome, auxConvert, auxCopyChromosome;

	List<Integer> subListaC1;

	List<Integer> tempSubList;

	Vector<Integer> convert;

	List<Integer> chromosomeGroup;

	int selectChromosome;

	OperatorsRate operatorsRate;

	public DefaultMutationFunction() {
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
	public DefaultMutationFunction(Population oldPopulation) {
		this.oldPopulation = (Population) oldPopulation.clone();
	}

	/**
	 * Starts Mutation
	 */
	@SuppressWarnings("unchecked")
	public void generateNewPopulation() {
		if (oldPopulation != null) {
			produto = new Produto();
			newPopulation = (Population) oldPopulation.clone();

			subProgram = oldPopulation.getChromosomeSize()
					/ produto.getQuantidade();
			random = new Random();
			chromosome = new Vector<Integer>();			
			auxChromosome = new Vector<Integer>();
			auxConvert = new Vector<Integer>();
			subListaC1 = new Vector<Integer>();
			convert = new Vector<Integer>();
			auxCopyChromosome = new Vector<Integer>();
			chromosomeGroup = new Vector<Integer>();
			tempSubList = new Vector<Integer>();

			String stringSelectChromosome = String.valueOf(Math
					.round((oldPopulation.size() * operatorsRate
							.getMutationRate())));
			int integerSelectChromosome = Integer
					.parseInt(stringSelectChromosome);

			for (int group = 0; group < integerSelectChromosome; group++) {

				selectChromosome = random.nextInt(newPopulation.size());
				chromosomeGroup.add(selectChromosome);
			}

			for (int i = 0; i < chromosomeGroup.size(); i++) {

				/* limpa todas as variaveis */
				clear();

				mutationParameter = random.nextDouble();
				chromosome = new Vector<Integer>();

				auxCopyChromosome.addAll((Vector<Integer>) newPopulation
						.getChromosome(chromosomeGroup.get(i)));

				/*
				 * Faz a copia do objeto para chromosome
				 */
				/*
				 * for(int iteration=0;iteration<auxCopyChromosome.size()-1;iteration++)
				 * chromosome.add(auxCopyChromosome.get(iteration));
				 */
				chromosome.addAll(auxCopyChromosome);

				mutationPoint = random.nextInt(produto.getQuantidade());

				if (mutationPoint == 0) {
					while (mutationPoint == 0) {
						mutationPoint = random
								.nextInt(produto.getQuantidade() + 1);
					}
				}

				/*
				 * Procura o produto sorteado pelo mutationPoint
				 */

				for (int point = 1; point <= mutationPoint; point++) {
					if (point == mutationPoint) {
						subListaC1.addAll(chromosome.subList(subProgram
								* mutationPoint - subProgram, (subProgram
								* mutationPoint - subProgram)
								+ subProgram));
						indexC1 = subProgram * mutationPoint - subProgram;
						tempSubList.addAll(subListaC1.subList(1, subListaC1
								.size()));
						/*
						 * if (subListaC1.get(0) == 4) {
						 * System.out.println(subListaC1);
						 * System.out.println(tempSubList); }
						 * 
						 * 
						 * tempRoteiro = String.valueOf(tempSubList);
						 * 
						 * tempRoteiroLimpo = String.valueOf(tempRoteiro
						 * .charAt(1));
						 * 
						 * for (int tempChangeValue = 4; tempChangeValue <
						 * tempRoteiro .length(); tempChangeValue += +3) {
						 * 
						 * if (tempChangeValue < tempRoteiro.length()) {
						 * tempRoteiroLimpo += String .valueOf(tempRoteiro
						 * .charAt(tempChangeValue)); } else { break; } }
						 * 
						 * for (int posTempRotLimpo = 0; posTempRotLimpo <
						 * tempRoteiroLimpo .length(); posTempRotLimpo++)
						 * convert.add(Integer.parseInt(String
						 * .valueOf(tempRoteiroLimpo
						 * .charAt(posTempRotLimpo))));
						 * 
						 * 
						 * System.out.println(tempRoteiro);
						 * System.out.println(tempRoteiroLimpo);
						 * System.out.println(convert); System.exit(0);
						 */
						// System.out.println("Convert: "+ convert);
						/*
						 * for (int qtdep = 1; qtdep <= produto
						 * .getQuantidade(); qtdep++) {
						 * 
						 * for (int qtder = 1; qtder <= produto
						 * .getRoteiro(produto.getNumProd(qtdep-1)); qtder++) {
						 * auxConvert.addAll(roteiro.getRoute(Integer
						 * .parseInt(String.valueOf(produto.getNumProd(qtdep-1)) +
						 * String.valueOf(qtder)))); if
						 * (auxConvert.equals(tempSubList)) { indexC2 =
						 * Integer.parseInt(String
						 * .valueOf(produto.getNumProd(qtdep-1)) +
						 * String.valueOf(qtder)); } auxConvert.clear(); } }
						 */

						for (int qtder = 1; qtder <= produto
								.getRoteiro(subListaC1.get(0)); qtder++) {
							auxConvert.addAll(roteiro.getRoute(Integer
									.parseInt(String.valueOf(subListaC1.get(0))
											+ String.valueOf(qtder))));
							if (auxConvert.equals(tempSubList)) {
								indexC2 = Integer.parseInt(String
										.valueOf(subListaC1.get(0))
										+ String.valueOf(qtder));
							}
							auxConvert.clear();
						}

						/*
						 * Procura qual o numero do roteiro do produto sorteado
						 * 
						 */
						verificaProd = String.valueOf(indexC2);
						indexC3 = Integer.parseInt(String.valueOf(verificaProd
								.charAt(0)));
						indexC4 = Integer.parseInt(String.valueOf(verificaProd
								.charAt(1)));
						tamanho = produto.getRoteiro(indexC3);

						int verifica = random.nextInt(tamanho + 1);
						if ((verifica == 0) || (verifica == indexC4)) {
							while ((verifica == 0) || (verifica == indexC4)) {
								verifica = random.nextInt(tamanho + 1);
							}
						}

						int mutation = Integer.parseInt(String.valueOf(indexC3)
								+ String.valueOf(verifica));

						/*
						 * Aplica a mutação
						 * 
						 */

						int posAuxChromo = 0;
						auxChromosome.addAll(roteiro.getRoute(mutation));
						for (int pos = indexC1 + 1; pos <= indexC1 + subProgram
								- 1; pos++) {
							// chromosome.removeElementAt(pos);
							chromosome
									.set(pos, auxChromosome.get(posAuxChromo));
							posAuxChromo++;
						}

					}
				}

				/*System.out.println("New antes: " + newPopulation);
				System.out.println("Muatação: " + " Posição: " + i + " "
						+ chromosome);*/

				newPopulation.replaceChromosome(chromosomeGroup.get(i),
						chromosome.clone());

				//System.out.println("New apos: " + newPopulation);

				chromosome.clear();
				auxChromosome.clear();
				auxCopyChromosome.clear();
				subListaC1.clear();
				auxChromosome.clear();
				tempSubList.clear();

			}
			chromosomeGroup.clear();

		}
	}

	public void clear() {
		indexC1 = 0;
		indexC2 = 0;
		indexC3 = 0;
		indexC4 = 0;

		codRoute = null;

		verificaProd = null;

		chromosome.clear();
		auxChromosome.clear();
		auxConvert.clear();
		auxCopyChromosome.clear();

		subListaC1.clear();

		tempSubList.clear();

		convert.clear();
	}
}
