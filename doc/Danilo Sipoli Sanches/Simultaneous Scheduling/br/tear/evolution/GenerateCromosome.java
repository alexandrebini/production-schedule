package br.tear.evolution;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.Vector;

import br.tear.cadastro.Produto;
import br.tear.cadastro.Roteiro;

public class GenerateCromosome {

	ArrayList<Object> roteiros;

	Produto prod;

	Roteiro rot;

	Random rand; //receberá os roterios de modo aleatório

	int produto, roteiro, codRoute;

	Vector<Integer> newVetor;//Vetor que representará o cromossomo

	Vector<Integer> readProducts;// Pega os produtos lidos

	Vector<Integer> readRoutes;// Pega os roteiros lidos

	Map<Integer, Integer> temp;

	int maior = 0, diferenca;

	public GenerateCromosome() {
		prod = new Produto();
		rot = new Roteiro();
		rand = new Random();
		newVetor = new Vector<Integer>();
		readProducts = new Vector<Integer>();// Pega os produtos lidos
		readRoutes = new Vector<Integer>();
		temp = new HashMap<Integer, Integer>();
		maior =0;
	}

	/*
	 * Cria o cromossomo a partir dos roteiros, maquinas e produtos cadastrados
	 */

	public Object createCromossomos() {
		newVetor = new Vector<Integer>();
		readProducts = new Vector<Integer>();// Pega os produtos lidos
		
		if (validate()) {//Verifica se todos os roteiros possuem mesmo tamanho

			produto = rand.nextInt(prod.getQuantidade());
			
			/*if (produto == 0) {
				while (produto == 0) {
					produto = rand.nextInt(prod.getQuantidade() + 1);
				}
			}*/

			roteiro = rand.nextInt(prod.getRoteiro(prod.getNumProd(produto)));

			if (roteiro == 0) {
				while (roteiro == 0) {
					roteiro = rand.nextInt(prod.getRoteiro(prod.getNumProd(produto) ));
				}
			}
			
			for (int contProd = 0; contProd < prod.getQuantidade(); contProd++) {

				if (readProducts.contains(produto) != true) {

					newVetor.add(prod.getNumProd(produto));

					codRoute = Integer.parseInt(String.valueOf(prod.getNumProd(produto))
							+ String.valueOf(roteiro));

					readRoutes = rot.getRoute(codRoute);
					
					//System.out.println(rot.getRoute(codRoute));

					for (int i = 0; i < readRoutes.size(); i++) {
						newVetor.add(readRoutes.get(i));
					}
					readProducts.add(produto);
				}

				produto = rand.nextInt(prod.getQuantidade());

				if ((readProducts.contains(produto))
						&& (readProducts.size() < prod.getQuantidade()))
						{
					do {
						produto = rand.nextInt(prod.getQuantidade());
					} while ((readProducts.contains(produto))
							&& (readProducts.size() < prod.getQuantidade()));							
				}

				roteiro = rand.nextInt(prod.getRoteiro(prod.getNumProd(produto)));

				if (roteiro == 0) {
					while (roteiro == 0) {
						roteiro = rand.nextInt(prod.getRoteiro(prod.getNumProd(produto)));
					}
				}
				
				/*
				 * System.out.println("Produto("+produto+")
				 * Roteiro("+roteiro+")"); try {
				 * Thread.currentThread().sleep(2000); } catch
				 * (InterruptedException e) { // TODO Auto-generated catch block
				 * e.printStackTrace(); }
				 */
			}			
			return newVetor;			
		}
		return null;
	}

	public boolean validate() {
		
		for (int i = 0; i <prod.getQuantidade(); i++) {			
			temp.put(prod.getNumProd(i), prod.getRoteiro(prod.getNumProd(i)));
		}

		// Encontra o maior roteiro
		for (int x = 0; x <prod.getQuantidade(); x++) {
			for (int y = 1; y <= temp.get((Object) prod.getNumProd(x)); y++) {
				/*System.out.println(rot.getSize(Integer.parseInt(String.valueOf(prod.getNumProd(x))
						+ String.valueOf(y))));*/
				//System.out.println("Produto: "+prod.getNumProd(x)+ " Roteiro: "+prod.getRoteiro(prod.getNumProd(x)));
				if (maior < rot.getSize(Integer.parseInt(String.valueOf(prod.getNumProd(x))
						+ String.valueOf(y)))) {
					maior = rot.getSize(Integer.parseInt(String.valueOf(prod.getNumProd(x))
							+ String.valueOf(y)));
				}
			}
		}

		// Deixa todos os roteiros com o mesmo tamanho
		for (int x = 0; x < prod.getQuantidade(); x++) {
			for (int y = 1; y <= temp.get((Object) prod.getNumProd(x)); y++) {
				diferenca = maior
						- rot.getSize(Integer.parseInt(String.valueOf(prod.getNumProd(x))
								+ String.valueOf(y)));
				for (int z = 1; z <= diferenca; z++) {
					rot.replace(Integer.parseInt(String.valueOf(prod.getNumProd(x))
							+ String.valueOf(y)));
				}
			}
		}

		// System.exit(0);
		return true;
	}

}
