package com.qtzk.system.controller.base;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qtzk.system.utils.PropertiesUtil;

/**
 * 文集下载的控制器
 *    
 * @author JHONNY
 * @date 2016年7月6日下午3:44:59
 */
@Controller
@RequestMapping(value = "/downloadController")
public class DownloadController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(DownloadController.class);

	@RequestMapping(value = "/qrcodeDownload")
	public void fileDownload(String fileName, String downloadName, HttpServletRequest request, HttpServletResponse response) throws IOException {
		if (StringUtils.isEmpty(downloadName)) {
			return;
		}
		String basePath = PropertiesUtil.get("upload.projectName") + PropertiesUtil.get("upload.qrcodeImg");
		//根据不同浏览器处理下载时文件名乱码问题
		if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
			downloadName = URLEncoder.encode(downloadName, "UTF-8");
		} else {
			downloadName = new String(downloadName.getBytes("UTF-8"), "ISO8859-1");
		}
		InputStream is = null;
		OutputStream os = null;
		try {
			//		response.reset();
			//      response.setContentType("multipart/form-data");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-Disposition", "attachment;fileName=" + downloadName + ".jpg");
			File file = new File(request.getSession().getServletContext().getRealPath(basePath) + File.separatorChar + fileName);
			is = FileUtils.openInputStream(file);
			os = response.getOutputStream();
			byte[] b = new byte[1024];
			while ((is.read(b)) > 0) {
				os.write(b);
			}
			os.flush();
		} catch (Exception e) {
			logger.error("下载二维码异常", e);
		} finally {
			if (os != null) {
				os.close();
			}
			if (is != null) {
				is.close();
			}
		}
	}
}
