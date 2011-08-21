package br.tear.cadastro;

import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class Roteiro {
	int numero;
	
	static Map<Integer, Vector<Integer>> routes = new HashMap<Integer, Vector<Integer>>();

	// static Map<Vector<Integer>,Integer> codes = new
	// HashMap<Vector<Integer>,Integer>();
	static Map<Integer, Integer> codes = new HashMap<Integer, Integer>();

	Vector<Integer> convert;

	Vector<Integer> size = new Vector<Integer>();

	Vector<Integer> troca = new Vector<Integer>();

	public Roteiro() {}
	
	@SuppressWarnings("unchecked")
	public void setRoute(int code, String route) {
		convert = new Vector<Integer>();
		for (int i = 0; i < route.length(); i++) {			
			convert.add(Integer.parseInt(String.valueOf(route.charAt(i))));
		}
		routes.put(code, convert);
		codes.put(Integer.parseInt(route), code);
	}

	public Vector<Integer> getRoute(int codigo) {
		return routes.get(codigo);
	}

	public Integer getCode(int codigo) {
		return codes.get(codigo);
	}

	public int getSize(int route) {		
		int tamanho =0;
		size.addAll(routes.get(route));
		tamanho = size.size();
		size.clear();
		return tamanho;
	}

	public void replace(int codigo) {
		troca = routes.get(codigo);
		troca.addElement(0);
		routes.remove((Object) codigo);
		routes.put(codigo, troca);
	}
	
	public void clear(){
		this.routes.clear();
		this.codes.clear();
		this.convert.clear();
		this.size.clear();
		this.troca.clear();
	}
}
