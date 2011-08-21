package br.tear.cadastro;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class AGVTravelTime {

	static Map<Integer, Integer> tempo = new HashMap<Integer, Integer>();

	int codigo;

	Random rand = new Random();

	public AGVTravelTime() {

	}

	public void setTempo(int originResource, int destinationResource,
			int timeTravel) {
		codigo = Integer.parseInt(String.valueOf(originResource)
				+ String.valueOf(destinationResource));
		tempo.put(codigo, timeTravel);		
	}

	public int getTempo(Object cod) {		
		return tempo.get((Object) cod);
	}
	
	public void clear(){
		this.tempo.clear();
	}

}
