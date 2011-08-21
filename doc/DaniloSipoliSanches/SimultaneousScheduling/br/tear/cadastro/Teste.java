/*
 * Classe teste para geração de produto, maquinas, roteiros
 * e tempo de operações
 */

package br.tear.cadastro;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Teste {

	OperationTime op;

	Roteiro rot;

	Produto prod;

	Maquina maquina;

	Random rand;

	AGVCad agv;

	AGVTravelTime travelTime;

	Random random;

	int indexProduct;

	List<Integer> selectedProducts;

	public Teste() {

		op = new OperationTime();
		rot = new Roteiro();
		prod = new Produto();
		maquina = new Maquina();
		rand = new Random();
		agv = new AGVCad();
		travelTime = new AGVTravelTime();
		random = new Random();
		selectedProducts = new ArrayList<Integer>();

		prod.clear();
		maquina.clear();
		op.clear();
		agv.clear();
		travelTime.clear();
		selectedProducts.clear();

		// System.out.println(prod.sizeProd());
		// System.out.println(maquina.sizeMaq());

		/* Cria qtde de Maquinas e Produtos */
		/*
		 * for (int i = 1; i < 6; i++) { indexProduct = random.nextInt(7 + 1);
		 * if ((selectedProducts.contains(indexProduct)) &&
		 * (selectedProducts.size() < 5) || indexProduct == 0) { do {
		 * indexProduct = random.nextInt(7 + 1); } while
		 * (selectedProducts.contains(indexProduct) && (selectedProducts.size() <
		 * 5) || indexProduct == 0); }
		 * 
		 * selectedProducts.add(indexProduct); prod.setNumProd(indexProduct); }
		 */
		/* Ordenar lista de produtos antes */
		// System.out.println(selectedProducts);
		// System.exit(0);
		/*
		 * for (int m = 1; m < 7; m++) maquina.setNumMaq(m);
		 */

		/*
		 * Informa a qtde de AGVs
		 */
		agv.setAgvNumber(2);

		/*for (int m = 1; m < 7; m++) maquina.setNumMaq(m);
		 
		 for (int p = 1; p < 4; p++) prod.setNumProd(p);
		  
		  op.setTempo(1, 1, 434); op.setTempo(1, 2, 453); op.setTempo(1, 3,
		  400); op.setTempo(1, 4, 472); op.setTempo(1, 5, 460); op.setTempo(1,
		  6, 421); op.setTempo(2, 1, 458); op.setTempo(2, 2, 443);
		  op.setTempo(2, 3, 405); op.setTempo(2, 4, 485); op.setTempo(2, 5,
		  402); op.setTempo(2, 6, 435); op.setTempo(3, 1, 472); op.setTempo(3,
		  2, 465); op.setTempo(3, 3, 469); op.setTempo(3, 4, 459);
		  op.setTempo(3, 5, 432); op.setTempo(3, 6, 445);
		  
		  rot.setRoute(11, String.valueOf(12345)); rot.setRoute(12,
		  String.valueOf(1236)); rot.setRoute(21, String.valueOf(1456));
		  rot.setRoute(22, String.valueOf(2456)); rot.setRoute(23,
		  String.valueOf(3456)); rot.setRoute(31, String.valueOf(156));
		  rot.setRoute(32, String.valueOf(256)); rot.setRoute(33,
		  String.valueOf(3456));
		  
		  prod.setRoteiro(1); prod.setRoteiro(1); prod.setRoteiro(2);
		  prod.setRoteiro(2); prod.setRoteiro(2); prod.setRoteiro(3);
		  prod.setRoteiro(3); prod.setRoteiro(3);
		  
		  travelTime.setTempo(0,0,0);
		  travelTime.setTempo(0,1,10);
		  travelTime.setTempo(0,2,10);
		  travelTime.setTempo(0,3,6);
		  travelTime.setTempo(0,4,10);
		  travelTime.setTempo(0,5,12);
		  travelTime.setTempo(0,6,14);
		  travelTime.setTempo(0,7,6);
		  travelTime.setTempo(1,0,11);
		  travelTime.setTempo(1,1,0);
		  travelTime.setTempo(1,2,6);
		  travelTime.setTempo(1,3,5);
		  travelTime.setTempo(1,4,12);
		  travelTime.setTempo(1,5,11);
		  travelTime.setTempo(1,6,9);
		  travelTime.setTempo(1,7,14);
		  travelTime.setTempo(2,0,7);
		  travelTime.setTempo(2,1,14);
		  travelTime.setTempo(2,2,0);
		  travelTime.setTempo(2,3,14);
		  travelTime.setTempo(2,4,10);
		  travelTime.setTempo(2,5,12);
		  travelTime.setTempo(2,6,10);
		  travelTime.setTempo(2,7,5);
		  travelTime.setTempo(3,0,7);
		  travelTime.setTempo(3,1,13);
		  travelTime.setTempo(3,2,12);
		  travelTime.setTempo(3,3,0);
		  travelTime.setTempo(3,4,6);
		  travelTime.setTempo(3,5,7);
		  travelTime.setTempo(3,6,11);
		  travelTime.setTempo(3,7,8);
		  travelTime.setTempo(4,0,5);
		  travelTime.setTempo(4,1,9);
		  travelTime.setTempo(4,2,10);
		  travelTime.setTempo(4,3,7);
		  travelTime.setTempo(4,4,0);
		  travelTime.setTempo(4,5,12);
		  travelTime.setTempo(4,6,7);
		  travelTime.setTempo(4,7,8);
		  travelTime.setTempo(5,0,5);
		  travelTime.setTempo(5,1,7);
		  travelTime.setTempo(5,2,5);
		  travelTime.setTempo(5,3,6);
		  travelTime.setTempo(5,4,10);
		  travelTime.setTempo(5,5,0);
		  travelTime.setTempo(5,6,10);
		  travelTime.setTempo(5,7,7);
		  travelTime.setTempo(6,0,5);
		  travelTime.setTempo(6,1,9);
		  travelTime.setTempo(6,2,14);
		  travelTime.setTempo(6,3,7);
		  travelTime.setTempo(6,4,8);
		  travelTime.setTempo(6,5,10);
		  travelTime.setTempo(6,6,0);
		  travelTime.setTempo(6,7,14);
		  travelTime.setTempo(7,0,8);
		  travelTime.setTempo(7,1,11);
		  travelTime.setTempo(7,2,8);
		  travelTime.setTempo(7,3,6);
		  travelTime.setTempo(7,4,9);
		  travelTime.setTempo(7,5,8);
		  travelTime.setTempo(7,6,14);
		  travelTime.setTempo(7,7,0);*/
		
			

		/*
		 * ANA APAGOU DAQUI
		 */
		/*
		 * op.setTempo(1, 1, 427); op.setTempo(1, 2, 429); op.setTempo(1, 3,
		 * 401); op.setTempo(1, 4, 434); op.setTempo(1, 5, 496); op.setTempo(1,
		 * 6, 467); op.setTempo(2, 1, 429); op.setTempo(2, 2, 480);
		 * op.setTempo(2, 3, 430); op.setTempo(2, 4, 481); op.setTempo(2, 5,
		 * 471); op.setTempo(2, 6, 442); op.setTempo(3, 1, 413); op.setTempo(3,
		 * 2, 494); op.setTempo(3, 3, 422); op.setTempo(3, 4, 447);
		 * op.setTempo(3, 5, 456); op.setTempo(3, 6, 422);
		 */

		/* ATÉ AQUI */
		
		
		
		// Cenário grande 9 maqs e 9 produtos		
		for (int m = 1; m < 10; m++)
			maquina.setNumMaq(m);
		
		for (int p = 1; p < 10; p++)
			prod.setNumProd(p);
		
		op.setTempo(1,1,444);
		op.setTempo(1,2,468);
		op.setTempo(1,3,448);
		op.setTempo(1,4,498);
		op.setTempo(1,5,441);
		op.setTempo(1,6,414);
		op.setTempo(1,7,421);
		op.setTempo(1,8,491);
		op.setTempo(1,9,484);
		op.setTempo(2,1,411);
		op.setTempo(2,2,481);
		op.setTempo(2,3,498);
		op.setTempo(2,4,440);
		op.setTempo(2,5,402);
		op.setTempo(2,6,408);
		op.setTempo(2,7,446);
		op.setTempo(2,8,432);
		op.setTempo(2,9,446);
		op.setTempo(3,1,495);
		op.setTempo(3,2,497);
		op.setTempo(3,3,445);
		op.setTempo(3,4,469);
		op.setTempo(3,5,403);
		op.setTempo(3,6,472);
		op.setTempo(3,7,496);
		op.setTempo(3,8,437);
		op.setTempo(3,9,406);
		op.setTempo(4,1,444);
		op.setTempo(4,2,455);
		op.setTempo(4,3,403);
		op.setTempo(4,4,435);
		op.setTempo(4,5,433);
		op.setTempo(4,6,468);
		op.setTempo(4,7,404);
		op.setTempo(4,8,451);
		op.setTempo(4,9,490);
		op.setTempo(5,1,485);
		op.setTempo(5,2,459);
		op.setTempo(5,3,459);
		op.setTempo(5,4,493);
		op.setTempo(5,5,427);
		op.setTempo(5,6,489);
		op.setTempo(5,7,403);
		op.setTempo(5,8,499);
		op.setTempo(5,9,420);
		op.setTempo(6,1,431);
		op.setTempo(6,2,419);
		op.setTempo(6,3,489);
		op.setTempo(6,4,417);
		op.setTempo(6,5,453);
		op.setTempo(6,6,474);
		op.setTempo(6,7,474);
		op.setTempo(6,8,415);
		op.setTempo(6,9,477);
		op.setTempo(7,1,422);
		op.setTempo(7,2,425);
		op.setTempo(7,3,437);
		op.setTempo(7,4,415);
		op.setTempo(7,5,447);
		op.setTempo(7,6,471);
		op.setTempo(7,7,418);
		op.setTempo(7,8,449);
		op.setTempo(7,9,495);
		op.setTempo(8,1,491);
		op.setTempo(8,2,426);
		op.setTempo(8,3,402);
		op.setTempo(8,4,491);
		op.setTempo(8,5,440);
		op.setTempo(8,6,415);
		op.setTempo(8,7,455);
		op.setTempo(8,8,444);
		op.setTempo(8,9,492);
		op.setTempo(9,1,477);
		op.setTempo(9,2,493);
		op.setTempo(9,3,497);
		op.setTempo(9,4,416);
		op.setTempo(9,5,435);
		op.setTempo(9,6,441);
		op.setTempo(9,7,418);
		op.setTempo(9,8,407);
		op.setTempo(9,9,483);

		
		 rot.setRoute(11, String.valueOf(124579)); rot.setRoute(12,
		 String.valueOf(345689)); rot.setRoute(21, String.valueOf(1234567));
		 rot.setRoute(22, String.valueOf(235789)); rot.setRoute(31,
		 String.valueOf(45678)); rot.setRoute(32, String.valueOf(23789));
		 rot.setRoute(41, String.valueOf(23467)); rot.setRoute(42,
		 String.valueOf(15689)); rot.setRoute(51, String.valueOf(45789));
		 rot.setRoute(52, String.valueOf(12356)); rot.setRoute(61,
		 String.valueOf(2456789)); rot.setRoute(62, String.valueOf(136789));
		 rot.setRoute(71, String.valueOf(124569)); rot.setRoute(72,
		 String.valueOf(123789)); rot.setRoute(81, String.valueOf(456789));
		 rot.setRoute(82, String.valueOf(345789)); rot.setRoute(91,
		 String.valueOf(356789)); rot.setRoute(92, String.valueOf(246789)); 
		 prod.setRoteiro(1); prod.setRoteiro(1); prod.setRoteiro(2); 
		 prod.setRoteiro(2); prod.setRoteiro(3); prod.setRoteiro(3); 
		 prod.setRoteiro(4);
		 prod.setRoteiro(4); prod.setRoteiro(5); prod.setRoteiro(5);
		 prod.setRoteiro(6); prod.setRoteiro(6); prod.setRoteiro(7);
		 prod.setRoteiro(7); prod.setRoteiro(8); prod.setRoteiro(8);
		 prod.setRoteiro(9); prod.setRoteiro(9);
		 
		 travelTime.setTempo(0,0,0);
		 travelTime.setTempo(0,1,14);
		 travelTime.setTempo(0,2,5);
		 travelTime.setTempo(0,3,10);
		 travelTime.setTempo(0,4,12);
		 travelTime.setTempo(0,5,14);
		 travelTime.setTempo(0,6,10);
		 travelTime.setTempo(0,7,13);
		 travelTime.setTempo(0,8,11);
		 travelTime.setTempo(0,9,9);
		 travelTime.setTempo(0,10,13);
		 travelTime.setTempo(1,0,11);
		 travelTime.setTempo(1,1,0);
		 travelTime.setTempo(1,2,11);
		 travelTime.setTempo(1,3,6);
		 travelTime.setTempo(1,4,5);
		 travelTime.setTempo(1,5,6);
		 travelTime.setTempo(1,6,5);
		 travelTime.setTempo(1,7,9);
		 travelTime.setTempo(1,8,11);
		 travelTime.setTempo(1,9,6);
		 travelTime.setTempo(1,10,11);
		 travelTime.setTempo(2,0,6);
		 travelTime.setTempo(2,1,9);
		 travelTime.setTempo(2,2,0);
		 travelTime.setTempo(2,3,7);
		 travelTime.setTempo(2,4,5);
		 travelTime.setTempo(2,5,6);
		 travelTime.setTempo(2,6,10);
		 travelTime.setTempo(2,7,6);
		 travelTime.setTempo(2,8,9);
		 travelTime.setTempo(2,9,11);
		 travelTime.setTempo(2,10,13);
		 travelTime.setTempo(3,0,10);
		 travelTime.setTempo(3,1,7);
		 travelTime.setTempo(3,2,5);
		 travelTime.setTempo(3,3,0);
		 travelTime.setTempo(3,4,11);
		 travelTime.setTempo(3,5,5);
		 travelTime.setTempo(3,6,10);
		 travelTime.setTempo(3,7,12);
		 travelTime.setTempo(3,8,14);
		 travelTime.setTempo(3,9,8);
		 travelTime.setTempo(3,10,6);
		 travelTime.setTempo(4,0,7);
		 travelTime.setTempo(4,1,13);
		 travelTime.setTempo(4,2,8);
		 travelTime.setTempo(4,3,9);
		 travelTime.setTempo(4,4,0);
		 travelTime.setTempo(4,5,10);
		 travelTime.setTempo(4,6,11);
		 travelTime.setTempo(4,7,6);
		 travelTime.setTempo(4,8,14);
		 travelTime.setTempo(4,9,7);
		 travelTime.setTempo(5,0,9);
		 travelTime.setTempo(5,1,10);
		 travelTime.setTempo(5,2,8);
		 travelTime.setTempo(5,3,11);
		 travelTime.setTempo(5,4,10);
		 travelTime.setTempo(5,5,0);
		 travelTime.setTempo(5,6,7);
		 travelTime.setTempo(5,7,13);
		 travelTime.setTempo(5,8,9);
		 travelTime.setTempo(5,9,12);
		 travelTime.setTempo(5,10,9);
		 travelTime.setTempo(6,0,14);
		 travelTime.setTempo(6,1,11);
		 travelTime.setTempo(6,2,13);
		 travelTime.setTempo(6,3,7);
		 travelTime.setTempo(6,4,14);
		 travelTime.setTempo(6,5,6);
		 travelTime.setTempo(6,6,0);
		 travelTime.setTempo(6,7,12);
		 travelTime.setTempo(6,8,13);
		 travelTime.setTempo(6,9,14);
		 travelTime.setTempo(6,10,8);
		 travelTime.setTempo(7,0,10);
		 travelTime.setTempo(7,1,7);
		 travelTime.setTempo(7,2,9);
		 travelTime.setTempo(7,3,13);
		 travelTime.setTempo(7,4,5);
		 travelTime.setTempo(7,5,8);
		 travelTime.setTempo(7,6,10);
		 travelTime.setTempo(7,7,0);
		 travelTime.setTempo(7,8,8);
		 travelTime.setTempo(7,9,10);
		 travelTime.setTempo(7,10,13);
		 travelTime.setTempo(8,0,11);
		 travelTime.setTempo(8,1,6);
		 travelTime.setTempo(8,2,9);
		 travelTime.setTempo(8,3,6);
		 travelTime.setTempo(8,4,8);
		 travelTime.setTempo(8,5,10);
		 travelTime.setTempo(8,6,12);
		 travelTime.setTempo(8,7,13);
		 travelTime.setTempo(8,8,0);
		 travelTime.setTempo(8,9,9);
		 travelTime.setTempo(8,10,7);
		 travelTime.setTempo(9,0,6);
		 travelTime.setTempo(9,1,5);
		 travelTime.setTempo(9,2,6);
		 travelTime.setTempo(9,3,8);
		 travelTime.setTempo(9,4,9);
		 travelTime.setTempo(9,5,10);
		 travelTime.setTempo(9,6,9);
		 travelTime.setTempo(9,7,5);
		 travelTime.setTempo(9,8,4);
		 travelTime.setTempo(9,9,0);
		 travelTime.setTempo(9,10,8);
		 travelTime.setTempo(10,0,6);
		 travelTime.setTempo(10,1,5);
		 travelTime.setTempo(10,2,11);
		 travelTime.setTempo(10,3,8);
		 travelTime.setTempo(10,4,10);
		 travelTime.setTempo(10,5,11);
		 travelTime.setTempo(10,6,8);
		 travelTime.setTempo(10,7,5);
		 travelTime.setTempo(10,8,14);
		 travelTime.setTempo(10,9,13);
		 travelTime.setTempo(10,10,0);


		
		 /*
		  //Gera tempo do AGV aleatorio
		 int Time;

			for (int originResources = 0; originResources <= maquina.sizeMaq() + 1; originResources++) {
				for (int destinationResources = 0; destinationResources <= maquina
						.sizeMaq() + 1; destinationResources++) {
					// Começa com '0' // devido ao L/U
					if (originResources == destinationResources) {
						Time = 0;
						travelTime.setTempo(originResources, destinationResources,
								Time);
					} else {
						Time = 60 + rand.nextInt(10);
						travelTime.setTempo(originResources, destinationResources,
								Time);
					}
				}
			}
		*/
		
		
		/* Valores obtidos pelo Automod */	
		
		/* for (int m = 1; m < 7; m++) maquina.setNumMaq(m);
		 
		 for (int p = 1; p < 8; p++) prod.setNumProd(p);

			
		 op.setTempo(1,1,90000); op.setTempo(1,2,72000);
		 op.setTempo(1,3,78000); op.setTempo(1,5,102000);
		 op.setTempo(2,2,126000); op.setTempo(2,3,54000);
		 op.setTempo(2,4,96000); op.setTempo(2,6,111000);
		 op.setTempo(3,1,66000); op.setTempo(3,2,84000);
		 op.setTempo(3,3,78000); op.setTempo(3,4,126000);
		 op.setTempo(3,5,114000); op.setTempo(3,6,138000);
		 op.setTempo(4,1,102000); op.setTempo(4,3,126000);
		 op.setTempo(4,4,78000); op.setTempo(4,5,90000);
		 op.setTempo(5,1,108000); op.setTempo(5,2,57000);
		 op.setTempo(5,4,78000); op.setTempo(5,6,90000);
		 op.setTempo(6,3,78000); op.setTempo(6,4,114000);
		 op.setTempo(6,5,102000); op.setTempo(6,6,72000);
		 op.setTempo(7,1,126000); op.setTempo(7,3,54000);
		 op.setTempo(7,5,96000); op.setTempo(7,6,111000);
		 
		 rot.setRoute(11, String.valueOf(135)); rot.setRoute(12,
		 String.valueOf(235)); rot.setRoute(21, String.valueOf(2346));
		 rot.setRoute(22, String.valueOf(2346)); rot.setRoute(31,
		 String.valueOf(125)); rot.setRoute(32, String.valueOf(345));
		 rot.setRoute(33, String.valueOf(126)); rot.setRoute(34,
		 String.valueOf(346)); rot.setRoute(41, String.valueOf(145));
		 rot.setRoute(42, String.valueOf(345)); rot.setRoute(51,
		 String.valueOf(146)); rot.setRoute(52, String.valueOf(246));
		 rot.setRoute(61, String.valueOf(356)); rot.setRoute(62,
		 String.valueOf(456)); rot.setRoute(71, String.valueOf(1356));
		 rot.setRoute(72, String.valueOf(1356));
		 
		  prod.setRoteiro(1); prod.setRoteiro(1); prod.setRoteiro(2);
		  prod.setRoteiro(2); prod.setRoteiro(3); prod.setRoteiro(3);
		  prod.setRoteiro(3); prod.setRoteiro(3); prod.setRoteiro(4);
		  prod.setRoteiro(4); prod.setRoteiro(5); prod.setRoteiro(5);
		  prod.setRoteiro(6); prod.setRoteiro(6); prod.setRoteiro(7);
		  prod.setRoteiro(7);
		 

		// Cadastra os tempos de Viagem para AGV
		
		 travelTime.setTempo(0, 0, 0); travelTime.setTempo(0, 1, 50969);
		 travelTime.setTempo(0, 2, 64969); travelTime.setTempo(0, 3, 78969);
		 travelTime.setTempo(0, 4, 107046); travelTime.setTempo(0, 5, 121046);
		 travelTime.setTempo(0, 6, 135713); travelTime.setTempo(0, 7, 139607);
		 travelTime.setTempo(1, 0, 112589); travelTime.setTempo(1, 1, 0);
		 travelTime.setTempo(1, 2, 24249); travelTime.setTempo(1, 3, 38249);
		 travelTime.setTempo(1, 4, 66326); travelTime.setTempo(1, 5, 80326);
		 travelTime.setTempo(1, 6, 94993); travelTime.setTempo(1, 7, 98887);
		 travelTime.setTempo(2, 0, 98589); travelTime.setTempo(2, 1, 115927);
		 travelTime.setTempo(2, 2, 0); travelTime.setTempo(2, 3, 24249);
		 travelTime.setTempo(2, 4, 52326); travelTime.setTempo(2, 5, 66326);
		 travelTime.setTempo(2, 6, 80993); travelTime.setTempo(2, 7, 84887);
		 travelTime.setTempo(3, 0, 84589); travelTime.setTempo(3, 1, 101927);
		 travelTime.setTempo(3, 2, 115927); travelTime.setTempo(3, 3, 0);
		 travelTime.setTempo(3, 4, 38326); travelTime.setTempo(3, 5, 52326);
		 travelTime.setTempo(3, 6, 66993); travelTime.setTempo(3, 7, 70887);
		 travelTime.setTempo(4, 0, 173523); travelTime.setTempo(4, 1, 71183);
		 travelTime.setTempo(4, 2, 85183); travelTime.setTempo(4, 3, 99183);
		 travelTime.setTempo(4, 4, 0); travelTime.setTempo(4, 5, 21582);
		 travelTime.setTempo(4, 6, 36249); travelTime.setTempo(4, 7, 159821);
		 travelTime.setTempo(5, 0, 159523); travelTime.setTempo(5, 1, 57183);
		 travelTime.setTempo(5, 2, 71183); travelTime.setTempo(5, 3, 85183);
		 travelTime.setTempo(5, 4, 113260); travelTime.setTempo(5, 5, 0);
		 travelTime.setTempo(5, 6, 22249); travelTime.setTempo(5, 7, 145821);
		 travelTime.setTempo(6, 0, 144856); travelTime.setTempo(6, 1, 42517);
		 travelTime.setTempo(6, 2, 56517); travelTime.setTempo(6, 3, 70517);
		 travelTime.setTempo(6, 4, 98594); travelTime.setTempo(6, 5, 112593);
		 travelTime.setTempo(6, 6, 0); travelTime.setTempo(6, 7, 131154);
		 travelTime.setTempo(7, 0, 16702); travelTime.setTempo(7, 1, 64672);
		 travelTime.setTempo(7, 2, 78672); travelTime.setTempo(7, 3, 92672);
		 travelTime.setTempo(7, 4, 98594); travelTime.setTempo(7, 5, 134748);
		 travelTime.setTempo(7, 6, 149415); travelTime.setTempo(7, 7, 0);
		*/

		/*
		 * travelTime.setTempo(0,0,0); travelTime.setTempo(0,1,47969);
		 * travelTime.setTempo(0,2,61969); travelTime.setTempo(0,3,75969);
		 * travelTime.setTempo(0,4,104046); travelTime.setTempo(0,5,118046);
		 * travelTime.setTempo(0,6,132713); travelTime.setTempo(0,7,136607);
		 * travelTime.setTempo(1,0,109589); travelTime.setTempo(1,1,0);
		 * travelTime.setTempo(1,2,21249); travelTime.setTempo(1,3,35249);
		 * travelTime.setTempo(1,4,63326); travelTime.setTempo(1,5,77326);
		 * travelTime.setTempo(1,6,91993); travelTime.setTempo(1,7,95887);
		 * travelTime.setTempo(2,0,95589); travelTime.setTempo(2,1,112927);
		 * travelTime.setTempo(2,2,0); travelTime.setTempo(2,3,21249);
		 * travelTime.setTempo(2,4,49326); travelTime.setTempo(2,5,63326);
		 * travelTime.setTempo(2,6,77993); travelTime.setTempo(2,7,81887);
		 * travelTime.setTempo(3,0,81589); travelTime.setTempo(3,1,98927);
		 * travelTime.setTempo(3,2,112927); travelTime.setTempo(3,3,0);
		 * travelTime.setTempo(3,4,35326); travelTime.setTempo(3,5,49326);
		 * travelTime.setTempo(3,6,63993); travelTime.setTempo(3,7,67887);
		 * travelTime.setTempo(4,0,170523); travelTime.setTempo(4,1,68183);
		 * travelTime.setTempo(4,2,82183); travelTime.setTempo(4,3,96183);
		 * travelTime.setTempo(4,4,0); travelTime.setTempo(4,5,18582);
		 * travelTime.setTempo(4,6,33249); travelTime.setTempo(4,7,156821);
		 * travelTime.setTempo(5,0,156523); travelTime.setTempo(5,1,54183);
		 * travelTime.setTempo(5,2,68183); travelTime.setTempo(5,3,82183);
		 * travelTime.setTempo(5,4,110260); travelTime.setTempo(5,5,0);
		 * travelTime.setTempo(5,6,19249); travelTime.setTempo(5,7,142821);
		 * travelTime.setTempo(6,0,141856); travelTime.setTempo(6,1,39517);
		 * travelTime.setTempo(6,2,53517); travelTime.setTempo(6,3,67517);
		 * travelTime.setTempo(6,4,95594); travelTime.setTempo(6,5,109594);
		 * travelTime.setTempo(6,6,0); travelTime.setTempo(6,7,128154);
		 * travelTime.setTempo(7,0,13702); travelTime.setTempo(7,1,61672);
		 * travelTime.setTempo(7,2,75672); travelTime.setTempo(7,3,89672);
		 * travelTime.setTempo(7,4,117748); travelTime.setTempo(7,5,131748);
		 * travelTime.setTempo(7,6,146415); travelTime.setTempo(7,7,0);
		 */

		/* 5P e 6M */
		/*
		 * op.setTempo(1,1,90000); op.setTempo(1,3,78000);
		 * op.setTempo(1,5,102000); op.setTempo(1,2,72000);
		 * op.setTempo(1,3,78000); op.setTempo(1,5,102000);
		 * op.setTempo(2,2,126000); op.setTempo(2,3,54000);
		 * op.setTempo(2,4,96000); op.setTempo(2,6,111000);
		 * op.setTempo(3,1,102000); op.setTempo(3,4,78000);
		 * op.setTempo(3,5,90000); op.setTempo(3,3,126000);
		 * op.setTempo(3,4,78000); op.setTempo(3,5,90000);
		 * op.setTempo(4,1,108000); op.setTempo(4,4,78000);
		 * op.setTempo(4,6,90000); op.setTempo(4,2,57000);
		 * op.setTempo(4,4,78000); op.setTempo(4,6,90000);
		 * op.setTempo(5,4,114000); op.setTempo(5,3,78000);
		 * op.setTempo(5,5,102000); op.setTempo(5,6,72000);
		 * 
		 * 
		 * rot.setRoute(11, String.valueOf(135)); rot.setRoute(12,
		 * String.valueOf(235)); rot.setRoute(21, String.valueOf(2346));
		 * rot.setRoute(22, String.valueOf(2346)); rot.setRoute(31,
		 * String.valueOf(145)); rot.setRoute(32, String.valueOf(345));
		 * rot.setRoute(41, String.valueOf(146)); rot.setRoute(42,
		 * String.valueOf(246)); rot.setRoute(51, String.valueOf(356));
		 * rot.setRoute(52, String.valueOf(456));
		 * 
		 * prod.setRoteiro(1); prod.setRoteiro(1); prod.setRoteiro(2);
		 * prod.setRoteiro(2); prod.setRoteiro(3); prod.setRoteiro(3);
		 * prod.setRoteiro(4); prod.setRoteiro(4); prod.setRoteiro(5);
		 * prod.setRoteiro(5);
		 */

		// Cenário gerado aleatoriamente
		/*for (int m = 1; m < 10; m++)
			maquina.setNumMaq(m);
		
		for (int p = 1; p < 10; p++)
			prod.setNumProd(p);

		int tempoOP;

		for (int p = 1; p <= prod.sizeProd(); p++) {
			for (int m = 1; m <= maquina.sizeMaq(); m++) {
				tempoOP = 400 + rand.nextInt(100);
				op.setTempo(p, m, tempoOP);
			}
		}

		int Time;

		for (int originResources = 0; originResources <= maquina.sizeMaq() + 1; originResources++) {
			for (int destinationResources = 0; destinationResources <= maquina
					.sizeMaq() + 1; destinationResources++) {
				// Começa com '0' // devido ao L/U
				if (originResources == destinationResources) {
					Time = 0;
					travelTime.setTempo(originResources, destinationResources,
							Time);
				} else {
					Time = 60 + rand.nextInt(30);
					travelTime.setTempo(originResources, destinationResources,
							Time);
				}
			}
		}

		// Gera roteiros aleatorios

		Random random = new Random();
		int machine;
		String tempRoute = "";
		List<Integer> maqCadastrada = new ArrayList<Integer>();
		for (int i = 1; i <= prod.getQuantidade(); i++) {
			for (int j = 1; j <= 2; j++) {
				for (int z = 1; z <= maquina.sizeMaq(); z++) {
					machine = random.nextInt(maquina.sizeMaq() + 1);
					if ((machine == 0)
							|| (maqCadastrada.contains((Object) machine))) {
						while ((machine == 0)
								|| (maqCadastrada.contains((Object) machine))) {
							machine = random.nextInt(maquina.sizeMaq() + 1);
						}
					}
					maqCadastrada.add(machine);
					tempRoute += String.valueOf(machine);
				}
				rot.setRoute(Integer.parseInt(String.valueOf(i)
						+ String.valueOf(j)), String.valueOf(tempRoute));
				prod.setRoteiro(i);
				tempRoute = "";
				maqCadastrada.clear();
			}
		}
		*/
	}
}
