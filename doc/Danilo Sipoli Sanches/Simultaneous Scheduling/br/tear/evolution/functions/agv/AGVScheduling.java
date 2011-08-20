package br.tear.evolution.functions.agv;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.tear.cadastro.AGVCad;
import br.tear.cadastro.AGVTravelTime;

/*
 * Nesta classe sera informado a osição corrente do AGV e 
 * definira a regra de despacho
 */

public class AGVScheduling {
	
	private static List<Integer> availableAGV;

	AGVTravelTime travelTime;

	AGVCad agv;

	/*
	 * Map com a localização do AGV (Nro do AGV, Recurso)
	 */
	Map<Integer, Integer> localization;

	public AGVScheduling() {
		agv = new AGVCad();
		localization = new HashMap<Integer, Integer>();
		travelTime = new AGVTravelTime();
		availableAGV = new ArrayList<Integer>();
	}

	public Integer getLocalization(int agv) {
		return localization.get(agv);
	}

	public void setLocalization(int agv, int resource) {
		localization.put(agv, resource);
	}
	
	public void removeOldLocalization(int agv) {		
		localization.remove((Object) agv);		
	}
	
	/*
	 * Recurso 0 = L; 7 = U
	 */
	public void InitializeAGV(int agv){
		for(int i = 1;i<=agv;i++){
			localization.put(i, 0);
			addAvailableAGV(i);			
		}		
	}
	
	public void addAvailableAGV(int agv){
		availableAGV.add(agv);		
	}
	
	public void removeAvailableAGV(int agv){
		availableAGV.remove((Object) agv);		
	}
	
	public List<Integer> getAvailableAGV(){
		return availableAGV;
	}
	
	public void removeAll(){
		availableAGV.clear();
	}

}
