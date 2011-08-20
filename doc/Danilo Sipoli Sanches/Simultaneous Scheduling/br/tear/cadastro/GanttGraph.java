package br.tear.cadastro;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Vector;

import br.tear.evolution.functions.FitnessFunction;

public class GanttGraph {
	
	//ArrayList<Vector<Integer>> gantt;// = new ArrayList<Vector<Integer>>();;
	static ArrayList<Object> gantt;// = new ArrayList<Vector<Integer>>();;
	Vector<Integer> temp = new Vector<Integer>();
	
	public GanttGraph(){
		gantt = new ArrayList<Object>();
		
	}
	
	public void setValues(Vector<Integer> values){		
		gantt.add(values);
	}
	
	public void getValues() throws IOException{
		for(int i = 0; i < gantt.size(); i++)
			System.out.println(gantt.get(i));
		//setFile();
	}
	
	public void setBestSolution(Object cromo)throws IOException{
		FitnessFunction fitness = new FitnessFunction();
		gantt = new ArrayList<Object>();
		fitness.getValue(cromo);
		//setFile();
	}
	
	public void setFile() throws IOException{
		String texto="";
		OutputStream os = new FileOutputStream("saida.txt");
		OutputStreamWriter osw = new OutputStreamWriter(os);
		BufferedWriter bw = new BufferedWriter(osw);
		for(int i = 0; i < gantt.size(); i++){
			temp = (Vector<Integer>) gantt.get(i);
			for(int vetor=0;vetor<temp.size();vetor++){
				texto +=String.valueOf(temp.get(vetor));
				//texto+=",";
			}
			bw.write(Integer.parseInt(texto));
			
		}	
		bw.close();
	}
	
}
