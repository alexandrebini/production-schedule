package br.tear.cadastro;

import java.util.ArrayList;
import java.util.Map;
import java.util.Vector;
import java.util.HashMap;

public class Produto extends Roteiro {

	ArrayList<Object> dados;

	static Vector<Integer> codProd;

	static Vector<Integer> numProd = new Vector<Integer>();

	static int quantidade, atualizaQtdeRot;

	static Map<Integer, Integer> roteiro = new HashMap<Integer, Integer>();

	public Produto() {
		dados = new ArrayList<Object>();
		codProd = new Vector<Integer>();
		// roteiro = new HashMap<Integer,Integer>();
	}

	/**
	 * @return the numMaq
	 */
	public int getNumProd(int numProduto) {
		return numProd.get(numProduto);
	}

	/**
	 * @param numMaq
	 *            the numMaq to set
	 */
	public void setNumProd(int numProduto) {
		numProd.add(numProduto);
	}

	/**
	 * @return the codMaq
	 */
	public int getCodProd(int codProd) {
		return this.codProd.get(codProd);
	}

	/**
	 * @param codMaq
	 *            the codMaq to set
	 */
	public void setCodProd(int codProd) {
		this.codProd.add(codProd);
	}

	public int sizeProd() {
		return numProd.size();
	}

	/**
	 * @return the quantidade
	 */
	public int getQuantidade() {
		return numProd.size();
	}

	/**
	 * @param quantidade
	 *            the quantidade to set
	 */
	public void setQuantidade(int qtdade) {
		quantidade = qtdade;
	}

	public int getRoteiro(int product) {
		return roteiro.get((Object) product);
	}

	public void setRoteiro(int product) {
		if (roteiro.containsKey((Object) product)) {
			atualizaQtdeRot = roteiro.get((Object) product);
			atualizaQtdeRot++;
			roteiro.remove((Object) product);
			roteiro.put(product, atualizaQtdeRot);
		} else {
			roteiro.put(product, 1);
		}
	}

	public Vector<Integer> getValues() {
		return numProd;
	}
	
	public void clear(){
		this.dados.clear();
		this.codProd.clear();
		this.numProd.clear();
		this.quantidade = 0;
		this.atualizaQtdeRot = 0;
		this.roteiro.clear();
	}

}
