package com.qtzk.system.controller.base;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.qtzk.system.utils.DateUtil;
import com.qtzk.system.utils.PathUtil;
import com.qtzk.system.utils.PropertiesUtil;

@Controller
@RequestMapping("/ckUploadController")
public class CkUploadController {

	private static Logger logger = LoggerFactory.getLogger(CkUploadController.class);
	protected MessageSource messageSource;

	protected String uploadRoot = PathUtil.getCkFilePath();

	@RequestMapping(value = "ckUpload", method = RequestMethod.POST)
	public String upload(@RequestParam("upload") MultipartFile uploadFile, @RequestParam(defaultValue = "image") String type, @RequestParam(value = "CKEditorFuncNum") String callback,
			HttpServletResponse response, Model model) {

		String path = "";
		if (uploadFile != null && !uploadFile.isEmpty()) {
			path = storeImage(uploadFile);
		}
		String imgUrl = PropertiesUtil.get("upload.CkUploadRoot");
		String res = callback(callback, imgUrl + path, "文件上传成功！");

		response.setContentType("text/html");
		try {
			response.getWriter().write(res);
		} catch (IOException e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	protected String callback(String callback, String url, String message) {
		StringBuilder sb = new StringBuilder();
		sb.append("<script type=\"text/javascript\">");
		sb.append("window.parent.CKEDITOR.tools.callFunction(").append(callback).append(", ");
		if (url != null) {
			sb.append("\"").append(url).append("\"").append(", ");
		}
		sb.append("\"").append(message).append("\"").append(");");
		sb.append("</script>");
		return sb.toString();
	}

	// file upload
	public String storeImage(MultipartFile file) {
		return storeUploadFile(getUUID(), file);
	}

	public static String getUUID() {
		String uuid = UUID.randomUUID().toString();
		return uuid.replaceAll("-", "");
	}

	public String storeUploadFile(String filename, MultipartFile file) {
		String path = gemPath(filename, file.getOriginalFilename(), uploadRoot);
		File f = new File(uploadRoot + path);

		try {
			f.createNewFile();
		} catch (IOException e) {
			logger.error("exception-info", e);
		}
		try {
			file.transferTo(f);
		} catch (IllegalStateException | IOException e) {
			logger.error("exception-info", e);
		}

		return path;
	}

	public static String gemPath(String solarId, String name, String rootPath) {
		Date date = new Date();
		String firstfolder = DateUtil.format(date, "yyyy") + "/";
		String secondfolder = DateUtil.format(date, "MMdd") + "/";
		name = name.substring(name.lastIndexOf("."));
		if (!"".equals(firstfolder)) {
			createDir(rootPath + firstfolder);
			if (!"".equals(secondfolder))
				createDir(rootPath + firstfolder + secondfolder);
		}
		return firstfolder + secondfolder + solarId + name;
	}

	/**
	 * 如果该文件夹不存在，创建新文件夹
	 * @param path
	 */
	public static void createDir(String path) {
		File file = new File(path);
		if (!file.exists())
			file.mkdirs();
	}

}
