package br.tear.cadastro;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;


public class OperationTime {
	
	static Map<Integer,Integer> tempo = new HashMap<Integer,Integer>();
	int codigo;
	
	Random rand = new Random();
	
	public OperationTime(){
		
	}
	
	public void setTempo(int produto, int maquina, int tempoOP){
		codigo = Integer.parseInt(String.valueOf(produto)+String.valueOf(maquina));
		tempo.put(codigo, tempoOP);		
	}
	
	public Integer getTempo(Object cod){		
		return tempo.get((Object)cod);
		//return 400 + rand.nextInt(100);
		
	}
	
	public void clear(){
		this.tempo.clear();
	}
}
