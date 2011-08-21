package br.tear.evolution.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import br.tear.cadastro.AGVCad;
import br.tear.cadastro.AGVTravelTime;
import br.tear.cadastro.GanttGraph;
import br.tear.cadastro.Maquina;
import br.tear.cadastro.OperationTime;
import br.tear.cadastro.Produto;
import br.tear.evolution.functions.agv.AGVScheduling;
import br.tear.evolution.functions.agv.DispatchingRules;

public class FitnessFunction implements IFitnessFunction {

	int im; // n�mero da m�quina

	int ip; // n�mero do produto

	int i, l, c, x; // �ndice

	int tc, top, tcAGV; // tempo corrente, T. Operacao, T. AGV

	int contador = 0;

	int fit; // fitness (makespan)

	int crom[]; // vetor cromossomo - posi��o 0 = makespan

	int tfCrom[]; // vt tempos finais de cada prod em cada maq

	int maq[][]; /*
					 * linhas = maq, col = numMaq, disp, tempo em q se tornar�
					 * dispon�vel
					 */

	int tempOp[][]; /*
					 * linhas=m�quinas, col=produtos tempos de opera��o
					 */

	int rot[]; /* qdo maq j� foi alocada, posi��o=1 */

	int maior = 0; // maior tempo final de um produto em uma m�quina

	int subProgram; // pega o indice de cada produto no cromosomo

	int selectAGV;// Seleciona AGV atraves da Regra de Despacho

	double agvTime = 0.0; // Pega o tempo de viagem do AGV

	Vector<Object> cromossomo;

	Vector<Object> convert;

	Vector<Integer> valuesGantt;

	/*
	 * Armazena os produtos que foram finalizados
	 */
	List<Integer> finishProduct;

	/*
	 * armazena informa�oes como disponibilidade do AGV
	 */

	AGVScheduling agvScheduling;

	/*
	 * Utiliza regras de despacho
	 */
	DispatchingRules dispatchingRules;

	/*
	 * Acessa dados do AGV
	 */
	AGVCad agv;

	/*
	 * Acessa o tempo de viagem do AGV
	 */
	AGVTravelTime travelTime;

	Produto produto;

	Maquina maquina;

	OperationTime op;

	GanttGraph gantt;

	boolean teste = true;

	boolean testeMaq = false;

	public FitnessFunction() {

		cromossomo = new Vector<Object>();
		produto = new Produto();
		maquina = new Maquina();
		maq = new int[maquina.sizeMaq()][3];
		tempOp = new int[maquina.sizeMaq()][produto.getQuantidade()];
		op = new OperationTime();
		valuesGantt = new Vector<Integer>();
		gantt = new GanttGraph();
		agvScheduling = new AGVScheduling();
		dispatchingRules = new DispatchingRules();
		agv = new AGVCad();
		travelTime = new AGVTravelTime();
		finishProduct = new ArrayList<Integer>();
	}

	/* Atribuir valores a um vetor cromossomo */

	@SuppressWarnings("unchecked")
	public int getValue(Object cromo) {

		/* Pega o cromossomo corrente para ser feito o calculo do fitness */
		cromossomo = (Vector<Object>) cromo;

		/* Busca quem s�o os produtos dentro do cromossomo */
		subProgram = cromossomo.size() / produto.getQuantidade();

		atribuiTfCromo(produto.getQuantidade());
		atribuiRot();
		iniciaMaq();

		/*
		 * Deixa todos os AGVs na esta��o L/U
		 */
		agvScheduling.InitializeAGV(agv.getAgvNumber());

		verifica();

		return calculaFitness();
	}

	/*
	 * Atribui valores ao vetor tfCrom vetor com tempos finais de cada prod em
	 * cada maq
	 */

	public void atribuiTfCromo(int produto) {
		tfCrom = new int[cromossomo.size()];
		int getProduto = subProgram;

		for (int i = 0; i < cromossomo.size(); i++) {
			if (i == getProduto - subProgram) {
				tfCrom[i] = (Integer) this.cromossomo.get(i);
				getProduto += subProgram;
			} else
				tfCrom[i] = 0;
		}

	}

	/* Atribui valores 0 ou -1 a rot */
	public void atribuiRot() {
		rot = new int[cromossomo.size()];

		int getProduto = subProgram;

		for (int i = 0; i < cromossomo.size(); i++) {
			if (i == getProduto - subProgram) {
				rot[i] = -1; // -1 para posi��es referentes ao produto
				getProduto += subProgram;
			} else {
				if ((Integer) cromossomo.get(i) == 0) {
					rot[i] = 1;
				} else {
					rot[i] = 0;
				}
			}
		} // fim if
	}

	/*
	 * Inicializa matriz M�quinas n�meroMaq, disponibilidade, TempoLibera��o
	 */

	/*
	 * Esta travado para 6 maquinas, precisa ser alterado
	 */

	public void iniciaMaq() {
		for (l = 0; l < maquina.sizeMaq(); l++) {
			maq[l][0] = l + 1; // numero da m�quina
			maq[l][1] = 1; // 1=dispon�vel
			maq[l][2] = 0;// tempo = 0
		}
	}

	public void aloca(int a, int b) {
		ip = (Integer) this.cromossomo.get(a); // ip=produto
		im = (Integer) this.cromossomo.get(b); // im = m�quina

		/* Aloca a m�quina im para o produto ip e computa tempo de opera��o */
		if (im != 0) { // se h� m�quinas no roteiro ainda

			if (maq[im - 1][1] == 1) { // se maq estiver dispon�vel
				maq[im - 1][1] = 0; // torna m�quina indispon�vel

				top = op.getTempo((Object) Integer.parseInt(String
							.valueOf(ip)
							+ String.valueOf(im)));
				
				//System.out.println("Indice Produto: "+ ip +" Indice maquina: "+im);

				/* Verifica se eh a 1 primeira maquina do roteiro */
				if (a == b-1) {
					// Pega AGV mais proximo de Load
					selectAGV = getAGV(agvScheduling.getAvailableAGV(), 0);
					agvTime = travelTime.getTempo((Object) Integer
							.parseInt(String.valueOf(agvScheduling
									.getLocalization(selectAGV))
									+ String.valueOf(0)));
					tcAGV += agvTime;

					agvScheduling.removeOldLocalization(selectAGV);

					agvScheduling.setLocalization(selectAGV, 0);
					
					//System.out.println("AGV: "+selectAGV+" Recurso: "+0+" Tempo: "+agvTime);

					/* Manda o AGV de Load ate a maquina que solicitou */
					agvTime = travelTime.getTempo((Object) Integer
							.parseInt(String.valueOf(0) + String.valueOf(im)));

					tcAGV += agvTime;

					agvScheduling.removeOldLocalization(selectAGV);

					agvScheduling.setLocalization(selectAGV, im);
					
					//System.out.println("AGV: "+selectAGV+" Recurso: "+im+" Tempo: "+agvTime);

				} else {
					selectAGV = getAGV(agvScheduling.getAvailableAGV(), (Integer) cromossomo.get(b-1));

					agvTime = travelTime.getTempo((Object) Integer
							.parseInt(String.valueOf(agvScheduling
									.getLocalization(selectAGV))
									+ String.valueOf(im)));

					tcAGV += agvTime;

					agvScheduling.removeOldLocalization(selectAGV);

					agvScheduling.setLocalization(selectAGV, im);
					
					//System.out.println("AGV: "+selectAGV+" Recurso: "+im+" Tempo: "+agvTime);
					
					//Pega os tempos para o Gantt
					/*valuesGantt.add(ip);
					valuesGantt.add(im);
					valuesGantt.add(selectAGV);
					valuesGantt.add(tc / 400 * 10);
					valuesGantt.add(((tc + top) / 400) * 10);					
					gantt.setValues(valuesGantt);
					valuesGantt = new Vector<Integer>();*/

				}

				checkLastMachine(im);

				maq[im - 1][2] = tc + top;/*
											 * //tempOp[im-1][ip-1]; // tempo q
											 * a maq ser� liberada
											 */
				tfCrom[b] = maq[im - 1][2]; // tempo final de op do prod ip na
				// maq im
				rot[b] = 1; // assinala q a maq j� foi alocada

				
				// ///////////////////////////
				if (tfCrom[b] > maior) {
					maior = tfCrom[b];
				} // fim if
			}
		}
	}// fim aloca

	private int getAGV(List<Integer> agv, int machine) {
		int numberAGVLU = 0; // AGVs que esta no L/U
		for (int i : agv) {
			if (agvScheduling.getLocalization(i) == 0)
				numberAGVLU++;
		}

		if (numberAGVLU == agv.size())
			return dispatchingRules.randomVehicleRule(agv);
		else
			return dispatchingRules.shortestTimeRule(agv, agvScheduling,
					machine);
	}

	/* Calcula o fitness de um cromossomo */
	public int calculaFitness() {
		tc = 0;
		tcAGV = 0;
		int inctc = 0;
		maior = 0;
		contador = 0;
						
		while (teste == false) { // while 1
			i = 0; // Produto
			x = i + 1; // M�quina

			while (i < cromossomo.size()) // while 2
			{
				if ((Integer) this.cromossomo.get(x) != 0) // se h� uma m�quina
				// v�lida no roteiro
				{
					if (rot[x] == 0) // se a m�quina n�o foi alocada
					{
						// System.out.println("tfCrom["+x+"]="+tfCrom[x]);
						if (tfCrom[x] <= tc) {
							aloca(i, x);
							i = i + subProgram; // muda para proximo produto
							x = i + 1; // Pega a primeira m�quina do sub-vetor
						}
					} else // se rot[x] == 1
					{
						if (tfCrom[x] <= tc) {
							// System.out.println("tfCrom["+x+"]="+tfCrom[x]);
							while ((rot[x] > 0 && tfCrom[x] <= tc)
									&& (x < cromossomo.size() - 1)) {
								x = x + 1;
							}
							if (rot[x] == 0)
								aloca(i, x);
							i = i + subProgram;
							x = i + 1;
						} // fim do if
						else // se tfcrom[x] > tc
						{
							i = i + subProgram;
							x = i + 1;
						} // fim else
					} // fim else
				} else // se crom[x] == 0; O idel seria o AGV pegar o produto
				// finalizado e deixa-lo na L/U
				{
					i = i + subProgram;
					x = i + 1;
				} // fim else
			} // fim While 2

			/*
			 * /* incrementa tempo corrente e libera m�quinas que j� terminaram
			 * opera��o
			 */
			// tc++;
			// System.out.println("tempo corrente anterior: " + tc);
			// encontra o tempo de libera��o da primeira maq <> 0
			int j = 0;
			while (maq[j][2] == 0) {				
				j++;				
			}

			inctc = maq[j][2];
			// System.out.println("inctc: " + inctc);

			// Acha o menor tempo de libera��o de m�quinas <> 0
			for (i = 0; i < maquina.sizeMaq(); i++) {
				if (maq[i][2] != 0) {
					if (maq[i][2] < inctc) {
						inctc = maq[i][2];
					}
				}
				// System.out.println("tempo maq " + i + ": " + maq[i][2]);
			}
			// System.out.println("Menor tempo: " + inctc);

			// incrementa tc
			if (inctc != 0) {
				tc = inctc;
			}

			// System.out.println("tempo corrente: " + tc);

			/*
			 * Verifica qual maquina terminou primeiro
			 */
			/*
			 * Utilizo um valor fora dos padroes (Integer.MAX_VALUE)devido ao
			 * problema de nao entrar dentro do if e dar problemas na hora de
			 * percorrer o cromossomo
			 */
			// int selectMachine = Integer.MAX_VALUE;
			for (i = 0; i < maquina.sizeMaq(); i++) {
				if (maq[i][2] == tc) {
					maq[i][1] = 1;
					maq[i][2] = 0; // zera tempo de libera��o da m�quina
					// selectMachine = i + 1;// +1 pq maq inicia com 0
					// System.out.println(i+1);
					contador++;
				}
			}

			verificaRoteiro();

		} // fim while 1

		// System.out.println("Makespan: " + maior);

		/* Zera as listas de AGV e ultimas maquinas de cada roteiro */
		agvScheduling.removeAll();
		/*
		 * if(finishProduct.size()<produto.sizeProd()){
		 * System.out.println("Falha"); //System.out.println(finishProduct);
		 * //System.out.println(cromossomo); System.exit(0); }else{
		 * System.out.println("Normal"); System.out.println(finishProduct);
		 * System.out.println(cromossomo); }
		 */
		finishProduct.clear();
		
		//System.out.println(maior);
		return fit = maior + tcAGV;		
	}

	/*
	 * Verifica se foi a ultima maquina de um roteiro Manda o Produto para
	 * Unload (est� uma verdadeira gambiarra, mudar assim que possivel). Se a
	 * maquina que acabou de ser liberada estiver dentro do roteiro, verifica se
	 * a proxima posicao no cromossomo eh 0 ou o proximo produto
	 */
	public void checkLastMachine(int selectMachine) {
		for (int iteration = 0; iteration < cromossomo.size(); iteration += subProgram) {
			if (!finishProduct.contains(cromossomo.get(iteration))) {
				for (int findMachine = iteration; findMachine < iteration
						+ subProgram; findMachine++) {
					
					if ((selectMachine == (Integer) cromossomo.get(findMachine))
							&& ((((findMachine) == iteration + subProgram - 1))
									|| (cromossomo.indexOf(findMachine) == cromossomo
											.size() - 1) || ((Integer) cromossomo
									.get(findMachine + 1) == 0))
							&& (rot[findMachine - 1] == 1)) {
						/*
						 * iteration + subprogram-1 pois iteration ficava com 1
						 * a mais
						 */
						// System.out.println("Produto: " + (Integer)
						// cromossomo.get(iteration) + " Maquina: " +
						// selectMachine);
						finishProduct.add((Integer) cromossomo.get(iteration));
						selectAGV = getAGV(agvScheduling.getAvailableAGV(),
								selectMachine);

						agvTime = travelTime.getTempo((Object) Integer
								.parseInt(String.valueOf(agvScheduling
										.getLocalization(selectAGV))
										+ String.valueOf(selectMachine)));
						tcAGV += agvTime;

						agvScheduling.removeOldLocalization(selectAGV);

						agvScheduling.setLocalization(selectAGV, selectMachine);
						
						//System.out.println("AGV: "+selectAGV+" Recurso: "+selectMachine+" Tempo: "+agvTime);

						/*
						 * Manda o AGV da ultima maquina no roteiro para Unload
						 */
						agvTime = travelTime
								.getTempo((Object) Integer
										.parseInt(String.valueOf(selectMachine)
												+ String.valueOf(maquina
														.sizeMaq() + 1)));

						tcAGV += agvTime;

						agvScheduling.removeOldLocalization(selectAGV);

						/*agvScheduling.setLocalization(selectAGV, maquina
								.sizeMaq() + 1);*/
						/*Mando para Load - Processo igual ao adotado pelo Alcides*/
						agvScheduling.setLocalization(selectAGV, 0);
						
						//System.out.println("AGV: "+selectAGV+" Recurso: "+(maquina.sizeMaq()+1)+" Tempo: "+agvTime);

						selectMachine = Integer.MAX_VALUE;
					}
				}
			}
		}
	}

	/*
	 * verifica se ainda h� m�quinas n�o alocadas para produtos atrav�s do vetor
	 * tfCrom
	 */

	public void verifica() {
		teste = true;
		for (i = 1; i < cromossomo.size(); i++)
			if (tfCrom[i] == 0) {
				teste = false;
				return;
			}
	}

	public void verificaMaquina() {
		testeMaq = true;
		for (int contaBosta = 0; contaBosta < maquina.sizeMaq() - 1; contaBosta++) {
			if (maq[contaBosta][2] != 0) {
				testeMaq = false;
				return;
			}
		}
	}

	public void verificaRoteiro() {
		teste = true;
		for (i = 1; i < cromossomo.size(); i++)
			if (rot[i] == 0) {
				teste = false;
				return;
			}
	}

}
