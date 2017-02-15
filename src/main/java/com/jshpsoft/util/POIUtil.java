package com.jshpsoft.util;

import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * POI工具类
 * 
 * @Description: POI工具类
 * @author army.liu
 */
public abstract class POIUtil {

	/**
	 * 导出excel
	 * 
	 * @Description: 导出excel
	 * @author army.liu
	 * @date 2016年4月14日 下午12:56:13
	 * @param formatData格式如下
	 *           { 
	 *            	sheetList : [ "","" ], 			--各个sheet名称 
	 *            	sheetData : { 
	 *            		title : "", 				--sheet中第一行 
	 *           	 	titleMergeSize : , 			--sheet中第一行的单元格合并个数
	 *            		tableHeader : [ "","" ], 	--sheet中表格头部
	 *            		tableData : [				--sheet中表格数据内容
	 *            			 	[ "","" ], 
	 *            				[ "","" ] 
	 *            		], 
	 *            		tableFooter : [ "","" ] 	--sheet中表格后面一行的数据内容 
	 *            	} 
	 *           } 
	 *           fileName --文件名 
	 *           fileExtend --文件扩展名
	 * 
	 * @return void
	 */
	public static void exportToExcel(HttpServletRequest request,
			HttpServletResponse response, Map<String, Object> formatData,
			String fileName, String fileExtend) throws Exception, IOException {

		POIUtil.addDownloadHeader(request, response, fileName, fileExtend);
		POIUtil.createTemplate(formatData, new HSSFWorkbook(),
				response.getOutputStream());

	}

	/**
	 * 设置文件下载头信息
	 * 
	 * @param request
	 * @param response
	 * @param fileName
	 *            文件名:
	 * @param fileExtend
	 *            文件类型 ：
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public static void addDownloadHeader(HttpServletRequest request,
			HttpServletResponse response, String fileName, String fileExtend)
			throws Exception {

		response.setContentType("application/octet-stream");
		response.setStatus(response.SC_OK);

		String agent = request.getHeader("USER-AGENT");
		if (null != agent && -1 != agent.indexOf("MSIE")) { // IE
			response.setHeader("Content-Disposition", "attachment; filename="
					+ URLEncoder.encode(fileName, "UTF-8") + "." + fileExtend);

		} else if (null != agent && -1 != agent.indexOf("Mozilla")) { // FireFox,Chrome,360
			String codedFileName = new String(fileName.getBytes("UTF-8"),
					"ISO8859-1");
			response.setHeader("Content-Disposition", "attachment; filename="
					+ codedFileName + "." + fileExtend);
		}

	}

	/**
	 * 创建导出excel的模板
	 * 
	 * @param request
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void createTemplate(Map<String, Object> formatData,
			HSSFWorkbook workbook, ServletOutputStream outStream) {
		List<String> sheetList = (List<String>) formatData.get("sheetList");// sheet大小
		Map<String, Object> sheetData = (Map<String, Object>) formatData
				.get("sheetData");// sheet内容
		String titleHead = (String) sheetData.get("title");// 第一行标题
		int titleMergeSize = (Integer) sheetData.get("titleMergeSize");// 第一行标题的单元格合并大小
		List<String> header = (List<String>) sheetData.get("tableHeader");// 表格头
		List<List<Object>> table = (List<List<Object>>) sheetData
				.get("tableData");// 表格内容
		List<Object> footer = (List<Object>) sheetData.get("tableFooter");// 表尾内容
		HSSFRow titleHeadRow = null;

		try {
			// 标题样式
			CellStyle titleHeadCellStyle = workbook.createCellStyle();
			titleHeadCellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 水平布局：居中

			// 字体
			Font titleHeadFont = workbook.createFont();
			titleHeadFont.setFontHeightInPoints((short) 22);
			titleHeadFont.setFontName("方正小标宋简体");
			titleHeadCellStyle.setFont(titleHeadFont);

			// 标题内容样式
			CellStyle titleBodyCellStyle = workbook.createCellStyle();
			// 字体
			Font titleBodyFont = workbook.createFont();
			titleBodyFont.setFontHeightInPoints((short) 12);
			titleBodyFont.setFontName("仿宋_GB2312");
			titleBodyCellStyle.setFont(titleBodyFont);

			// 表头样式
			CellStyle headCellStyle = workbook.createCellStyle();
			// 边框
			headCellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框
			headCellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);// 左边框
			headCellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);// 上边框
			headCellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);// 右边
			// 字体
			Font headFont = workbook.createFont();
			headFont.setFontHeightInPoints((short) 12);
			headFont.setFontName("仿宋_GB2312");
			headCellStyle.setFont(headFont);
			headCellStyle.setWrapText(true);// 自动换行
			headCellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直
			headCellStyle.setAlignment(CellStyle.ALIGN_CENTER);// 居中

			// 表内容样式
			CellStyle bodyCellStyle = workbook.createCellStyle();
			bodyCellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框
			bodyCellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);// 左边框
			bodyCellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);// 上边框
			bodyCellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);// 右边
			// 表内容字体
			Font bodyFont = workbook.createFont();
			bodyFont.setFontName("仿宋_GB2312");
			bodyFont.setFontHeightInPoints((short) 12);
			bodyCellStyle.setFont(bodyFont);

			for (int m = 0; m < sheetList.size(); m++) {
				HSSFSheet sheet = workbook.createSheet(sheetList.get(m));
				// 第一行：标题
				titleHeadRow = sheet.createRow(0);
				titleHeadRow.setHeight((short) (15.625 * 40));
				HSSFCell titleHeadCell = titleHeadRow.createCell(0);
				titleHeadCell.setCellValue(titleHead);
				titleHeadCell.setCellStyle(titleHeadCellStyle);
				// 第一行的单元格合并
				sheet.addMergedRegion(new CellRangeAddress(0, // first row
																// (0-based)
						0, // last row (0-based)
						0, // first column (0-based)
						titleMergeSize - 1 // last column (0-based)
				));

				// 第二行开始：表头
				HSSFRow headerFirstRow = null;
				if (null != header && header.size() > 0) {
					headerFirstRow = sheet.createRow(1);// 创建第二行
					headerFirstRow.setHeight((short) (15.625 * 40));

					for (int i = 0; i < header.size(); i++) {
						HSSFCell cell4First = headerFirstRow.createCell(i);
						cell4First.setCellStyle(headCellStyle);
						cell4First.setCellValue(header.get(i));
					}
				}

				// 第三行开始：表内容
				HSSFRow tableBodyRow = null;
				HSSFCell cell = null;
				if (null != table && table.size() > 0) {
					for (int j = 0; j < table.size(); j++) {
						tableBodyRow = sheet.createRow(j + 2); // 创建第三行
						tableBodyRow.setHeight((short) (15.625 * 20));
						for (int k = 0; k < header.size(); k++) {
							cell = tableBodyRow.createCell(k);
							Object object = table.get(j).get(k);
							String obj = (String) object;
							cell.setCellValue(obj);
							cell.setCellStyle(bodyCellStyle);
						}
					}
				}

				// 最后一行开始：表尾
				HSSFRow footerFirstRow = null;
				if (null != footer && footer.size() > 0) {
					footerFirstRow = sheet.createRow(table.size() + 2);// 创建最后一行
					footerFirstRow.setHeight((short) (15.625 * 20));

					for (int i = 0; i < footer.size(); i++) {
						HSSFCell cell4First = footerFirstRow.createCell(i);
						cell4First.setCellStyle(bodyCellStyle);
						cell4First.setCellValue((String) footer.get(i));
					}
				}

				// 自动调整列宽
				for (int i = 0; i < titleMergeSize; i++) {
					sheet.autoSizeColumn((short) i);
				}

			}

			workbook.write(outStream);
			outStream.flush();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (outStream != null) {
				try {
					outStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 导入excel
	 * 
	 * @Description: 导入excel
	 * @author army.liu
	 * @date 2016年4月14日 下午14:56:13
	 * @param  rowStartIndex 	--有效数据的起始行数
	 *         cellCount 		--有效数据的总列数
	 * 			sheetIndex      -- sheet页签
	 * @return Map
	 */
	public static Map<String, Object> importByExcel(HttpServletRequest request,
			int rowStartIndex, int cellCount,int sheetIndex) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");

		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
			for (Entry<String, MultipartFile> entry : fileMap.entrySet()) {
				MultipartFile multipartFile = entry.getValue();
				InputStream inputStream = multipartFile.getInputStream();

				Workbook hssfWorkbook = null;

				boolean fileType = multipartFile.getOriginalFilename()
						.endsWith(".xlsx");// 2007以上版本标记

				// 文件检查
				try {
					// 文件大小限制
					long size = multipartFile.getSize();
					if (size > 1024 * 1024 * 10) {
						result.put("code", "300");
						result.put("msg", "导入的文件大小超过限制! (最大为10M)");
						return result;
					}
					// 文件格式限制
					if (!multipartFile.getOriginalFilename().endsWith(".xls")
							&& !multipartFile.getOriginalFilename().endsWith(
									".xlsx")) {
						result.put("code", "300");
						result.put("msg",
								"导入的文件格式错误, 必须为excel文件, 格式为'.xls'或'.xlsx' !");
						return result;
					}

					if (fileType) {
						hssfWorkbook = new XSSFWorkbook(inputStream);
					} else {
						POIFSFileSystem poifsFileSystem = new POIFSFileSystem(
								inputStream);
						hssfWorkbook = new HSSFWorkbook(poifsFileSystem);
					}

				} catch (Exception e) {
					e.printStackTrace();
					result.put("code", "300");
					result.put("msg", "当前文件读取发生错误, 请检查文件是否正常!");
					return result;
				}

				Map<String, Object> sheetDatas = new HashMap<String, Object>();
				// 解析sheet数据
				/*for (int sheetIndex = 0; sheetIndex < hssfWorkbook
						.getNumberOfSheets(); sheetIndex++) {*/

					Sheet sheetAt = null;
					if (fileType) {
						sheetAt = (XSSFSheet) hssfWorkbook
								.getSheetAt(sheetIndex);
					} else {
						sheetAt = (HSSFSheet) hssfWorkbook
								.getSheetAt(sheetIndex);
					}

					List<List<String>> importData = new ArrayList<List<String>>();// 导入数据
					for (int rowIndex = rowStartIndex; rowIndex <= sheetAt
							.getLastRowNum(); rowIndex++) { // 最后一行也读

						Row row = null;
						if (fileType) {
							row = (XSSFRow) sheetAt.getRow(rowIndex);
						} else {
							row = (HSSFRow) sheetAt.getRow(rowIndex);
						}

						int lastCellNum = row.getLastCellNum();// 列数

						// 模版文件的列数检查
						if (cellCount != lastCellNum) {
							result.put("code", "300");
							result.put("msg", "导入失败: 当前文件的列数为" + lastCellNum
									+ "，请确认与模版一致!");
							return result;

						}

						// 当前行中格式不正确的信息
						List<String> data = new ArrayList<String>();
						for (int columnIndex = 0; columnIndex < lastCellNum; columnIndex++) {

							Cell cell = null;
							if (fileType) {
								cell = (XSSFCell) row.getCell(columnIndex);
							} else {
								cell = (HSSFCell) row.getCell(columnIndex);
							}

							String cellValue = null;

							if (cell != null) {
								// 注意：一定要设成这个，否则可能会出现乱码
								// cell.setEncoding(HSSFCell.ENCODING_UTF_16);

								// 处理字段
								switch (cell.getCellType()) {
								case HSSFCell.CELL_TYPE_STRING:
									cellValue = cell.getStringCellValue();
									break;

								case HSSFCell.CELL_TYPE_NUMERIC:
									if (HSSFDateUtil.isCellDateFormatted(cell)) {
										Date date = cell.getDateCellValue();
										if (date != null) {
											cellValue = new SimpleDateFormat(
													Constants.DATE_TIME_FORMAT_SHORT)
													.format(date);
										} else {
											cellValue = "";

										}

									} else {
										cellValue = new DecimalFormat(".####")
												.format(cell
														.getNumericCellValue());

									}
									break;

								case HSSFCell.CELL_TYPE_FORMULA:
									// 导入时如果为公式生成的数据则无值
									if (!cell.getStringCellValue().equals("")) {
										cellValue = cell.getStringCellValue();
									} else {
										cellValue = cell.getNumericCellValue()
												+ "";

									}
									break;

								case HSSFCell.CELL_TYPE_BLANK:
									break;

								case HSSFCell.CELL_TYPE_ERROR:
									cellValue = "";
									break;

								case HSSFCell.CELL_TYPE_BOOLEAN:
									cellValue = (cell.getBooleanCellValue() == true ? "Y"
											: "N");
									break;
								default:
									cellValue = "";

								}

								data.add(cellValue);

							}

						}
						importData.add(data);

					}
					sheetDatas.put(sheetIndex + "", importData);

				//}
				result.put("data", sheetDatas);

			}

			result.put("code", "200");
			result.put("msg", "数据解析成功! ");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "300");
			result.put("msg", "导入失败: " + e.getMessage());
		}

		return result;
	}

	/*
	 * html转word
	 */
	public static void htmlToWord(
			HttpServletRequest request,HttpServletResponse response, 
			String fileName, String fileExtend,
			String htmlStr) throws Exception {
		
		POIUtil.addDownloadHeader(request, response, fileName, fileExtend);
		
		byte b[] = htmlStr.getBytes();
		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		POIFSFileSystem poifs = new POIFSFileSystem();
		DirectoryEntry directory = poifs.getRoot();
		directory.createDocument("WordDocument", bais);
		poifs.writeFilesystem(response.getOutputStream());
		bais.close();
		 
	}
	
	/**
	 * 生成复杂的excel
	 * @param root
	 * @param outPath
	 * @param request
	 * @return
	 */
	public  InputStream exportComplexExcel(Map<String, Object> root,String outPath,
			HttpServletRequest request) {
		InputStream ins=null;
	
		Configuration configuration = new Configuration();  
		configuration.setDefaultEncoding("UTF-8");  
		configuration.setClassForTemplateLoading(this.getClass(), "/com/jshpsoft/excel");  //FTL文件所存在的位置   
		Template t=null;  
		try {  
			  t = configuration.getTemplate((String)root.get("template")); //文件名   
		} catch (IOException e) {  
		     e.printStackTrace();  
		}
		File outFile = new File(request.getServletContext()
				.getRealPath("/")+outPath);  
		Writer out = null;  
		try {  
			   out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile),"utf-8")); 

			   
		} catch (Exception e1) {  
			   e1.printStackTrace();  
		}  
		try {  
			    t.process(root, out);  
			    ins = new FileInputStream(request.getServletContext()
						.getRealPath("/")+outPath); 
		} catch (TemplateException e) {  
			    e.printStackTrace();  
		} catch (IOException e) {  
			    e.printStackTrace();  
	    }  
		
		return ins;
	}
}
