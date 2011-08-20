package br.tear.cadastro;

import java.util.ArrayList;
import java.util.Vector;

public class Maquina {
	
	ArrayList<Object> dados;
	static Vector<Integer> codMaq, estadoMaq;
	static Vector<Integer> numMaq = new Vector<Integer>();
	static int qtdade;
	
	
	public Maquina(){
		dados = new ArrayList<Object>();		
		codMaq = new Vector<Integer>();
		estadoMaq = new Vector<Integer>();
	}	

	/**
	 * @return the numMaq
	 */
	public int getNumMaq(int numMaquina) {
		return numMaq.get(numMaquina);
	}


	/**
	 * @param numMaq the numMaq to set
	 */
	public void setNumMaq(int numMaquina) {
		numMaq.add(numMaquina);			
	}


	/**
	 * @return the codMaq
	 */
	public int getCodMaq(int codMaquina) {
		return codMaq.get(codMaquina);
	}


	/**
	 * @param codMaq the codMaq to set
	 */
	public void setCodMaq(int codMaquina) {
		codMaq.add(codMaquina);
	}


	/**
	 * @return the estadoMaq
	 */
	public int getEstadoMaq(int estadoMaq) {
		return this.estadoMaq.get(estadoMaq);
	}


	/**
	 * @param estadoMaq the estadoMaq to set
	 */
	public void setEstadoMaq(int estadoMaq) {
		this.estadoMaq.add(estadoMaq);
	}
	
	public int sizeMaq(){
		return this.numMaq.size();
	}
	
	public Vector<Integer> getValues(){
		return numMaq;
	}
	
	public void clear(){
		this.dados.clear();
		this.codMaq.clear();
		this.numMaq.clear();
		this.qtdade = 0;
	}

}
