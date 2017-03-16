package com.qtzk.system.utils;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.qtzk.system.bean.Page;

/**
 * 导出Excel文档工具类
 * @date 2014-8-6
 * */
public class ExcelUtil {

	private static final Logger logger = Logger.getLogger(ExcelUtil.class);
	/**每批次默认导出5000条数据*/
	private static final short BATCH_COUNT = 5000;

	/**
	 * 创建excel文档，
	 * @param list 数据
	 * @param keys list中map的key数组集合
	 * @param columnNames excel的列名
	 * */
	public static Workbook createWorkBook(List<Map<String, Object>> listMap, List<?> list) {
		// 创建excel工作簿
		Workbook wb = new HSSFWorkbook();
		// 创建第一个sheet（页），并命名
		Sheet sheet = wb.createSheet("数据");
		// 手动设置列宽。第一个参数表示要为第几列设；，第二个参数表示列的宽度，n为列高的像素数。
		/* for(int i=0;i<keys.length;i++){
		     sheet.setColumnWidth((short) i, (short) (35.7 * 150));
		 }*/

		// 创建第一行
		Row row = sheet.createRow((short) 0);

		// 创建两种单元格格式
		CellStyle cs = wb.createCellStyle();
		CellStyle cs2 = wb.createCellStyle();

		// 创建两种字体
		Font f = wb.createFont();
		Font f2 = wb.createFont();

		// 创建第一种字体样式（用于列名）
		f.setFontHeightInPoints((short) 10);
		f.setColor(IndexedColors.BLACK.getIndex());
		f.setBoldweight(Font.BOLDWEIGHT_BOLD);

		// 创建第二种字体样式（用于值）
		f2.setFontHeightInPoints((short) 10);
		f2.setColor(IndexedColors.BLACK.getIndex());

		//        Font f3=wb.createFont();
		//        f3.setFontHeightInPoints((short) 10);
		//        f3.setColor(IndexedColors.RED.getIndex());

		// 设置第一种单元格的样式（用于列名）
		cs.setFont(f);
		cs.setBorderLeft(CellStyle.BORDER_THIN);
		cs.setBorderRight(CellStyle.BORDER_THIN);
		cs.setBorderTop(CellStyle.BORDER_THIN);
		cs.setBorderBottom(CellStyle.BORDER_THIN);
		cs.setAlignment(CellStyle.ALIGN_CENTER);

		// 设置第二种单元格的样式（用于值）
		cs2.setFont(f2);
		cs2.setBorderLeft(CellStyle.BORDER_THIN);
		cs2.setBorderRight(CellStyle.BORDER_THIN);
		cs2.setBorderTop(CellStyle.BORDER_THIN);
		cs2.setBorderBottom(CellStyle.BORDER_THIN);
		cs2.setAlignment(CellStyle.ALIGN_CENTER);
		for (int i = 0; i < listMap.size(); i++) {
			if (Boolean.parseBoolean(listMap.get(i).get("hide") + "")) {
				listMap.remove(listMap.get(i));
			}
		}
		//设置列名
		for (int i = 0; i < listMap.size(); i++) {
			Cell cell = row.createCell(i);
			cell.setCellValue(listMap.get(i).get("name") + "");
			cell.setCellStyle(cs);
		}
		//设置每行每列的值
		for (short i = 0; i < list.size(); i++) {
			// Row 行,Cell 方格 , Row 和 Cell 都是从0开始计数的
			// 创建一行，在页sheet上
			Row row1 = sheet.createRow((short) i + 1);
			// 在row行上创建一个方格

			for (int j = 0; j < listMap.size(); j++) {
				Cell cell = row1.createCell(j);
				Map<String, Object> map = (Map<String, Object>) list.get(i);

				String valueText = map.get(listMap.get(j).get("colkey")) == null ? " " : map.get(listMap.get(j).get("colkey")).toString();

				if (listMap.get(j).containsKey("mapKey")) {
					Map mapKey = (Map) listMap.get(j).get("mapKey");
					valueText = mapKey.get(valueText) == null ? valueText : mapKey.get(valueText).toString();
				}
				cell.setCellValue(valueText);
				cell.setCellStyle(cs2);
			}
		}
		return wb;
	}

	/**
	 * @Title: createWorkBookBatch
	 * @author aquarius
	 * @date 2016年4月25日 下午6:07:32 
	 * @Description: 分批次从数据库中读取数据写入Excel
	 */
	public static Workbook createWorkBookBatch(List<Map<String, Object>> listMap, String beanName, String methodName, Page page) {
		// 创建excel工作簿
		Workbook wb = new HSSFWorkbook();
		// 创建第一个sheet（页），并命名
		Sheet sheet = wb.createSheet("数据");
		// 创建第一行
		Row row = sheet.createRow((short) 0);

		// 创建两种单元格格式
		CellStyle cs = wb.createCellStyle();
		CellStyle cs2 = wb.createCellStyle();

		// 创建两种字体
		Font f = wb.createFont();
		Font f2 = wb.createFont();

		// 创建第一种字体样式（用于列名）
		f.setFontHeightInPoints((short) 10);
		f.setColor(IndexedColors.BLACK.getIndex());
		f.setBoldweight(Font.BOLDWEIGHT_BOLD);

		// 创建第二种字体样式（用于值）
		f2.setFontHeightInPoints((short) 10);
		f2.setColor(IndexedColors.BLACK.getIndex());

		// 设置第一种单元格的样式（用于列名）
		cs.setFont(f);
		cs.setBorderLeft(CellStyle.BORDER_THIN);
		cs.setBorderRight(CellStyle.BORDER_THIN);
		cs.setBorderTop(CellStyle.BORDER_THIN);
		cs.setBorderBottom(CellStyle.BORDER_THIN);
		cs.setAlignment(CellStyle.ALIGN_CENTER);

		// 设置第二种单元格的样式（用于值）
		cs2.setFont(f2);
		cs2.setBorderLeft(CellStyle.BORDER_THIN);
		cs2.setBorderRight(CellStyle.BORDER_THIN);
		cs2.setBorderTop(CellStyle.BORDER_THIN);
		cs2.setBorderBottom(CellStyle.BORDER_THIN);
		cs2.setAlignment(CellStyle.ALIGN_CENTER);
		for (int i = 0; i < listMap.size(); i++) {
			if (Boolean.parseBoolean(listMap.get(i).get("hide") + "")) {
				listMap.remove(listMap.get(i));
			}
		}
		//设置列名
		for (int i = 0; i < listMap.size(); i++) {
			Cell cell = row.createCell(i);
			cell.setCellValue(listMap.get(i).get("name") + "");
			cell.setCellStyle(cs);
		}

		for (int batch = 0;; batch++) {

			//通过反射获取结果列表
			List<?> list = null;
			try {
				Method method = SpringContextUtil.getBean(beanName).getClass().getMethod(methodName, page.getClass());
				page.getPd().put("startValue", BATCH_COUNT * batch);
				page.getPd().put("stepValue", BATCH_COUNT);
				list = (List<?>) method.invoke(SpringContextUtil.getBean(beanName), page);
			} catch (Exception ex) {
				logger.error("ExcelUtil-->createWorkBookBatch" + ex.getMessage());
			}

			//设置每行每列的值
			for (short i = 0; i < list.size(); i++) {
				// Row 行,Cell 方格 , Row 和 Cell 都是从0开始计数的
				// 创建一行，在页sheet上
				Row row1 = sheet.createRow((short) BATCH_COUNT * batch + i + 1);
				// 在row行上创建一个方格

				for (int j = 0; j < listMap.size(); j++) {
					Cell cell = row1.createCell(j);
					Map<String, Object> map = (Map<String, Object>) list.get(i);

					String valueText = map.get(listMap.get(j).get("colkey")) == null ? " " : map.get(listMap.get(j).get("colkey")).toString();

					if (listMap.get(j).containsKey("mapKey")) {
						Map mapKey = (Map) listMap.get(j).get("mapKey");
						valueText = mapKey.get(valueText) == null ? valueText : mapKey.get(valueText).toString();
					}
					cell.setCellValue(valueText);
					cell.setCellStyle(cs2);
				}
			}
			if (list.size() < BATCH_COUNT) {
				break;
			}
		}
		return wb;
	}

	/**
	 * 读取Excel数据内容
	 * @param InputStream
	 * @return Map 包含单元格数据内容的Map对象
	 */
	public Map<Integer, String> read03ExcelContent(InputStream is) {
		POIFSFileSystem fs = null;
		HSSFWorkbook wb = null;
		HSSFSheet sheet = null;
		HSSFRow row = null;
		Map<Integer, String> content = new HashMap<Integer, String>();
		String str = "";
		try {
			fs = new POIFSFileSystem(is);
			/**
			 * HSSFWorkbook:是操作Excel2003以前（包括2003）的版本，扩展名是.xls 
			XSSFWorkbook:是操作Excel2007的版本，扩展名是.xlsx
			 */
			wb = new HSSFWorkbook(fs);
			sheet = wb.getSheetAt(0);
			// 得到总行数
			int rowNum = sheet.getLastRowNum();
			row = sheet.getRow(0);
			int colNum = row.getPhysicalNumberOfCells();
			// 正文内容应该从第二行开始,第一行为表头的标题
			for (int i = 1; i <= rowNum; i++) {
				row = sheet.getRow(i);
				int j = 0;
				while (j < colNum) {
					str += getCellFormatValue(row.getCell((short) j)).trim() + "    ";
					j++;
				}
				content.put(i, str);
				str = "";
			}
		} catch (IOException e) {
			logger.error("IOException", e);
		} finally {
			IOUtils.closeQuietly(is);
		}
		return content;
	}

	public Map<Integer, String> read07ExcelContent(InputStream is) {
		XSSFWorkbook wb = null;
		XSSFSheet sheet = null;
		XSSFRow row = null;
		Map<Integer, String> content = new HashMap<Integer, String>();
		String str = "";
		try {
			/**
			 * HSSFWorkbook:是操作Excel2003以前（包括2003）的版本，扩展名是.xls 
			XSSFWorkbook:是操作Excel2007的版本，扩展名是.xlsx
			 */
			wb = new XSSFWorkbook(is);
			sheet = wb.getSheetAt(0);
			// 得到总行数
			int rowNum = sheet.getLastRowNum();
			row = sheet.getRow(0);
			int colNum = row.getPhysicalNumberOfCells();
			// 正文内容应该从第二行开始,第一行为表头的标题
			for (int i = 1; i <= rowNum; i++) {
				row = sheet.getRow(i);
				int j = 0;
				while (j < colNum) {
					str += getCellFormatValue(row.getCell((short) j)).trim() + "    ";
					j++;
				}
				content.put(i, str);
				str = "";
			}
		} catch (IOException e) {
			logger.error("IOException", e);
		} finally {
			IOUtils.closeQuietly(is);
		}
		return content;
	}

	/**
	 * 根据HSSFCell类型设置数据
	 * @param cell
	 * @return
	 */
	private String getCellFormatValue(Cell cell) {
		String cellvalue = "";
		if (cell != null) {
			// 判断当前Cell的Type
			switch (cell.getCellType()) {
			// 如果当前Cell的Type为NUMERIC
			case HSSFCell.CELL_TYPE_NUMERIC:
			case HSSFCell.CELL_TYPE_FORMULA: {
				// 判断当前的cell是否为Date
				if (HSSFDateUtil.isCellDateFormatted(cell)) {
					// 如果是Date类型则，转化为Data格式
					//方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
					//cellvalue = cell.getDateCellValue().toLocaleString();
					//方法2：这样子的data格式是不带带时分秒的：2011-10-12
					Date date = cell.getDateCellValue();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					cellvalue = sdf.format(date);
				}
				// 如果是纯数字
				else {
					// 取得当前Cell的数值
					cellvalue = String.valueOf(cell.getNumericCellValue());
				}
				break;
			}
			// 如果当前Cell的Type为STRIN
			case HSSFCell.CELL_TYPE_STRING:
				// 取得当前的Cell字符串
				cellvalue = cell.getRichStringCellValue().getString();
				break;
			// 默认的Cell值
			default:
				cellvalue = " ";
			}
		} else {
			cellvalue = "";
		}
		return cellvalue;
	}
}