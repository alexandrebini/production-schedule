package br.tear.presentation;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

public class GenerateExcel {
	
	private static int colunaConv, colunaProp;
	POIFSFileSystem fs;
	HSSFWorkbook wb;
	HSSFSheet sheet;		
	HSSFRow row;
	String basePath = "/home/alexandre/Desktop/";
	
	public GenerateExcel(){		
		this.colunaConv = 0;
		this.colunaProp = 0;
	}
	
	public void setDados(double value, double time) throws IOException{
		fs = new POIFSFileSystem(new FileInputStream(basePath + "propostaAGV.xls"));
		wb = new HSSFWorkbook(fs);
		sheet = wb.getSheetAt(0);
		row = sheet.createRow((short)this.colunaProp);		
		row.createCell((short) 0).setCellValue(value);				
		row = sheet.createRow((short)this.colunaProp);		
		row.createCell((short) 1).setCellValue(time);
		
		// Write the output to a file
		FileOutputStream fileOut = new FileOutputStream(basePath + "propostaAGV.xls");
		wb.write(fileOut);
		fileOut.close();
		this.colunaProp++;
	}
	
	public void setDados(double value, int iteration) throws IOException{
		fs = new POIFSFileSystem(new FileInputStream(basePath + "PlanilhaConvergencia.xls"));
		wb = new HSSFWorkbook(fs);
		sheet = wb.getSheetAt(0);
		row = sheet.createRow((short)this.colunaConv);		
		row.createCell((short) 0).setCellValue(value);				
		row = sheet.createRow((short)this.colunaConv);		
		row.createCell((short) 1).setCellValue(iteration);
		
		// Write the output to a file
		FileOutputStream fileOut = new FileOutputStream(basePath + "PlanilhaConvergencia.xls");
		wb.write(fileOut);
		fileOut.close();
		this.colunaConv++;
	}
	
}
