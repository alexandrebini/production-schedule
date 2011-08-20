package br.tear.cadastro;

/*
 * Classe responsavel por adicionar as caracteristicas do AGV
 */

import java.util.HashMap;
import java.util.Map;

public class AGVCad {
	private static int agvNumber = 0;
	private static Map<Integer,Integer> velocity; //Mapa com as velocidades do AGV
	
	public AGVCad(){		
		velocity = new HashMap<Integer, Integer>();
	}

	public int getAgvNumber() {
		return agvNumber;
	}

	public void setAgvNumber(int agvNumber) {
		this.agvNumber = agvNumber;
	}

	public Integer getVelocity(Integer agv) {
		return velocity.get((Object) agv);
	}

	/*
	 * Alterar este metodo
	 */
	public void setVelocity(Map<Integer, Integer> velocity) {
		this.velocity = velocity;
	}
	
	public void clear(){
		this.velocity.clear();
		agvNumber = 0;
	}

}
