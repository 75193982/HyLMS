package com.jshpsoft.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
/**
 * @author  ww 
 * @date 2016年11月25日 上午9:19:06
 */
public class ExcelReader {
	
	/**
	 * 创建工作簿对象
	 * @param filePath
	 * @return
	 * @throws IOException
	 * @date	
	 */
	public static final Workbook createWb(String filePath) throws IOException {
		if(StringUtils.isBlank(filePath)) {
			throw new IllegalArgumentException("参数错误!!!") ;
		}
		if(filePath.trim().toLowerCase().endsWith("xls")) {
			return new HSSFWorkbook(new FileInputStream(filePath)) ;
		} else if(filePath.trim().toLowerCase().endsWith("xlsx")) {
			return new XSSFWorkbook(new FileInputStream(filePath)) ;
		} else {
			throw new IllegalArgumentException("不支持除：xls/xlsx以外的文件格式!!!") ;
		}
	}
	
	public static final Sheet getSheet(Workbook wb ,String sheetName) {
		return wb.getSheet(sheetName) ;
	}
	
	public static final Sheet getSheet(Workbook wb ,int index) {
		return wb.getSheetAt(index) ;
	}
	
	public static final List<Object[]> listFromSheet(Sheet sheet,int sheetIndex) {
		
		//int rowTotal = sheet.getPhysicalNumberOfRows() ;
		//Debug.printf("{}共有{}行记录！" ,sheet.getSheetName() ,rowTotal) ;
		List<Object[]> list = new ArrayList<Object[]>() ;
		for(int r = sheet.getFirstRowNum() ; r <= sheet.getLastRowNum() ; r ++) {
			Row row = sheet.getRow(r) ;
			if(row == null)continue ;
			//System.out.println("-----getLastCellNum----"+row.getLastCellNum());
			if(sheetIndex == 0)
			{
				if(row.getLastCellNum() < Constants.importExeclLength.priceLength)//车型
				{
					throw new RuntimeException("模板列数不匹配！");
				}
			}
			if(sheetIndex == 1)
			{
				if(row.getLastCellNum() != Constants.importExeclLength.priceLength)//单价
				{
					throw new RuntimeException("模板列数不匹配！");
				}
			}
			if(sheetIndex == 2)
			{
				if(row.getLastCellNum() != Constants.importExeclLength.totalPriceLength)//总价
				{
					throw new RuntimeException("模板列数不匹配！");
				}
			}
			// 不能用row.getPhysicalNumberOfCells()，可能会有空cell导致索引溢出
			// 使用row.getLastCellNum()至少可以保证索引不溢出，但会有很多Null值，如果使用集合的话，就不说了
			Object[] cells = new Object[row.getLastCellNum()] ;	
			for(int c = row.getFirstCellNum() ; c <= row.getLastCellNum() ; c++) {
				Cell cell = row.getCell(c) ;
				if(cell == null)continue ;
				cells[c] = getValueFromCell(cell) ;
			}
			list.add(cells) ;
		}
		
		return list ;
	}
	
	public static final List<Object[]> listFromSheet(Sheet sheet) {
		
		//int rowTotal = sheet.getPhysicalNumberOfRows() ;
		//Debug.printf("{}共有{}行记录！" ,sheet.getSheetName() ,rowTotal) ;
		List<Object[]> list = new ArrayList<Object[]>() ;
		for(int r = sheet.getFirstRowNum() ; r <= sheet.getLastRowNum() ; r ++) {
			Row row = sheet.getRow(r) ;
			if(row == null)continue ;
			//System.out.println("-----getLastCellNum----"+row.getLastCellNum());
			// 不能用row.getPhysicalNumberOfCells()，可能会有空cell导致索引溢出
			// 使用row.getLastCellNum()至少可以保证索引不溢出，但会有很多Null值，如果使用集合的话，就不说了
			Object[] cells = new Object[row.getLastCellNum()] ;	
			for(int c = row.getFirstCellNum() ; c <= row.getLastCellNum() ; c++) {
				Cell cell = row.getCell(c) ;
				if(cell == null)continue ;
				cells[c] = getValueFromIntCell(cell) ;
			}
			list.add(cells) ;
		}
		
		return list ;
	}
	
	/**
	 * 获取单元格内文本信息  数字取double
	 * @param cell
	 * @return
	 * @date	
	 */
	public static final String getValueFromCell(Cell cell) {
		if(cell == null) {
			System.out.println("Cell is null !!!") ;
			return null ;
		}
		String value = null ;
		switch(cell.getCellType()) {
			case Cell.CELL_TYPE_NUMERIC :	// 数字
				if(HSSFDateUtil.isCellDateFormatted(cell)) {		// 如果是日期类型
					value = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_SHORT).format(cell.getDateCellValue()) ;
				} else 	value = String.valueOf(cell.getNumericCellValue());
				break ;
			case Cell.CELL_TYPE_STRING:		// 字符串
				value = cell.getStringCellValue() ;
				break ;
			case Cell.CELL_TYPE_FORMULA:	// 公式
				// 用数字方式获取公式结果，根据值判断是否为日期类型
				double numericValue = cell.getNumericCellValue() ;
				if(HSSFDateUtil.isValidExcelDate(numericValue)) {	// 如果是日期类型
					value = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_SHORT).format(cell.getDateCellValue()) ;
				} else 	value = String.valueOf(numericValue) ;
				break ;
			case Cell.CELL_TYPE_BLANK:				// 空白
				value = "" ;
				break ;
			case Cell.CELL_TYPE_BOOLEAN:			// Boolean
				value = String.valueOf(cell.getBooleanCellValue()) ;
				break ;
			case Cell.CELL_TYPE_ERROR:				// Error，返回错误码
				value = String.valueOf(cell.getErrorCellValue()) ;
				break ;
			default:value = StringUtils.EMPTY ;break ;
		}
		// 使用[]记录坐标
		return value;
		//+ "["+cell.getRowIndex()+","+cell.getColumnIndex()+"]" ;
	}
	
	/**
	 * 获取单元格内文本信息  数字取整形
	 * @param cell
	 * @return
	 * @date	
	 */
	public static final String getValueFromIntCell(Cell cell) {
		if(cell == null) {
			System.out.println("Cell is null !!!") ;
			return null ;
		}
		String value = null ;
		switch(cell.getCellType()) {
			case Cell.CELL_TYPE_NUMERIC :	// 数字
				if(HSSFDateUtil.isCellDateFormatted(cell)) {		// 如果是日期类型
					value = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_SHORT).format(cell.getDateCellValue()) ;
				} else 	value = String.valueOf(new Double(cell.getNumericCellValue()).intValue());
				break ;
			case Cell.CELL_TYPE_STRING:		// 字符串
				value = cell.getStringCellValue() ;
				break ;
			case Cell.CELL_TYPE_FORMULA:	// 公式
				// 用数字方式获取公式结果，根据值判断是否为日期类型
				double numericValue = cell.getNumericCellValue() ;
				if(HSSFDateUtil.isValidExcelDate(numericValue)) {	// 如果是日期类型
					value = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_SHORT).format(cell.getDateCellValue()) ;
				} else 	value = String.valueOf(numericValue) ;
				break ;
			case Cell.CELL_TYPE_BLANK:				// 空白
				value = "" ;
				break ;
			case Cell.CELL_TYPE_BOOLEAN:			// Boolean
				value = String.valueOf(cell.getBooleanCellValue()) ;
				break ;
			case Cell.CELL_TYPE_ERROR:				// Error，返回错误码
				value = String.valueOf(cell.getErrorCellValue()) ;
				break ;
			default:value = StringUtils.EMPTY ;break ;
		}
		// 使用[]记录坐标
		return value;
		//+ "["+cell.getRowIndex()+","+cell.getColumnIndex()+"]" ;
	}

}
