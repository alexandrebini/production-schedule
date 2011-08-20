package br.tear.presentation;

import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class TestExcel {

	public static void main(String[] args) throws IOException {

		HSSFWorkbook wb = new HSSFWorkbook();

        HSSFSheet sheet1 = wb.createSheet("Planilha Um");

        HSSFSheet sheet2 = wb.createSheet("Planilha Dois");

        HSSFSheet sheet3 = wb.createSheet("Planilha Tr�s");

        HSSFRow row = sheet1.createRow(0);

        row.createCell((short) 0).setCellValue("Isto � uma String");

        FileOutputStream stream = new FileOutputStream("/home/alexandre/Desktop/planilha.xls");

        wb.write(stream);

  }
}

////////////////Teste//////////////////////
/*public static void main(String[] args) throws FileNotFoundException,
IOException {

CellReference cellReference = new CellReference("B3");

POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(
	"c:/planilha.xls"));
HSSFWorkbook wb = new HSSFWorkbook(fs);
HSSFSheet sheet = wb.getSheetAt(0);
HSSFRow row = sheet.getRow(0);
//HSSFCell cell = row.getCell((short) 1);
HSSFCell cell = row.getCell((short) cellReference.getRow());
if (cell == null)
cell = row.createCell((short) 1);

cell.setCellType(HSSFCell.CELL_TYPE_STRING);
cell.setCellValue("a test 2");

// Write the output to a file
FileOutputStream fileOut = new FileOutputStream("c:/planilha.xls");
wb.write(fileOut);
fileOut.close();

}*/
