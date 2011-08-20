package br.tear.evolution.functions.agv;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import br.tear.cadastro.AGVCad;
import br.tear.cadastro.AGVTravelTime;

public class DispatchingRules {
	
	private AGVTravelTime travelTime;

	private AGVCad agv;	

	public DispatchingRules() {
		agv = new AGVCad();		
		travelTime = new AGVTravelTime();
	}
	
	/*
	 * Abaixo estão 2 regras de despacho
	 */

	/*
	 * Recebe os AGVs disponiveis e verifica qual esta mais proximo da maquina
	 * solitada
	 */
	public Integer shortestTimeRule(List<Integer> agv, AGVScheduling agvScheduling, int resource) {
		List<Integer> numberAGV = new ArrayList<Integer>();
		numberAGV.addAll(agv);
		int bestAGV = 0;
		int bestTime = Integer.MAX_VALUE;

		for (int i : numberAGV) {			
			if (bestTime > travelTime.getTempo((Object) Integer.parseInt(String
					.valueOf(agvScheduling.getLocalization(i))
					+ String.valueOf(resource)))) {
				bestTime = travelTime.getTempo((Object) Integer.parseInt(String
						.valueOf(agvScheduling.getLocalization(i))
						+ String.valueOf(resource)));
				bestAGV = i;
			}
		}		
		return bestAGV;
	}

	/*
	 * Faz escolha aleatoria quando os AGVs estao na estação L/U
	 */
	public Integer randomVehicleRule(List<Integer> agv) {
		Random random = new Random();
		
		/*
		 * Adiciona 1 para nao começar a contar do zero
		 */
		int chosenAGV = random.nextInt(agv.size()+1); 		
		
		if (chosenAGV == 0) {
			while (chosenAGV == 0) {
				chosenAGV = random.nextInt(agv.size()+1);
			}
		}

		return chosenAGV;
	}

}
