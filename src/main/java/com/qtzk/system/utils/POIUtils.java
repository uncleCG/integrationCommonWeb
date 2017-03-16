package com.qtzk.system.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.qtzk.system.bean.Page;

/**
 * 读写EXCEL文件
 */
public class POIUtils {

	private static final Logger logger = LoggerFactory.getLogger(POIUtils.class);

	/**
	 * @author lijianning
	 * Email：mmm333zzz520@163.com
	 * date：2015-11-11
	 * @param exportData 列表头
	 * @param lis 数据集
	 * @param fileName 文件名
	 * 
	 */
	public static void exportToExcel(HttpServletResponse response, List<Map<String, Object>> exportData, List<?> lis, String fileName) {
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			ExcelUtil.createWorkBook(exportData, lis).write(os);
			byte[] content = os.toByteArray();
			InputStream is = new ByteArrayInputStream(content);
			// 设置response参数，可以打开下载页面
			response.reset();
			response.setContentType("application/vnd.ms-excel;charset=utf-8");
			response.setHeader("Content-Disposition", "attachment;filename=" + new String((fileName + ".xls").getBytes(), "iso-8859-1"));
			ServletOutputStream out = response.getOutputStream();
			bis = new BufferedInputStream(is);
			bos = new BufferedOutputStream(out);
			byte[] buff = new byte[2048];
			int bytesRead;
			// Simple read/write loop.
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (IOException e) {
			logger.error("exception-info", e);
		} finally {
			try {
				if (bis != null)
					bis.close();
				if (bos != null)
					bos.close();
			} catch (IOException e) {
			}

		}
	}

	/**
	 * @Title: exportToExcelBatch
	 * @author aquarius
	 * @date 2016年4月25日 下午6:07:32 
	 * @Description: 分批次从数据库中读取数据写入Excel
	 */
	public static void exportToExcelBatch(HttpServletResponse response, List<Map<String, Object>> exportData, String fileName, String beanName, String methodName, Page page) {
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			ExcelUtil.createWorkBookBatch(exportData, beanName, methodName, page).write(os);
			byte[] content = os.toByteArray();
			InputStream is = new ByteArrayInputStream(content);
			// 设置response参数，可以打开下载页面
			response.reset();
			response.setContentType("application/vnd.ms-excel;charset=utf-8");
			response.setHeader("Content-Disposition", "attachment;filename=" + new String((fileName + ".xls").getBytes(), "iso-8859-1"));
			ServletOutputStream out = response.getOutputStream();
			bis = new BufferedInputStream(is);
			bos = new BufferedOutputStream(out);
			byte[] buff = new byte[2048];
			int bytesRead;
			// Simple read/write loop.
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (IOException e) {
			logger.error("exception-info", e);
		} finally {
			try {
				if (bis != null)
					bis.close();
				if (bos != null)
					bos.close();
			} catch (IOException e) {
			}

		}
	}

}