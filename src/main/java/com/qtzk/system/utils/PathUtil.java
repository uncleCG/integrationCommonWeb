package com.qtzk.system.utils;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
*    
* 类名称：PathUtil   
* 类描述：   路径工具类
* 创建人：hp   
* 创建时间：2015年6月26日 上午9:53:46   
* 修改人：hp   
* 修改时间：2015年6月26日 上午9:53:46   
* 修改备注：   
* @version    
*
 */
public class PathUtil {

	private static final Logger logger = Logger.getLogger(PathUtil.class);

	/**
	 * 图片访问路径
	 * @param pathType 图片类型 visit-访问；save-保存
	 * @param pathCategory 图片类别，如：话题图片-topic、话题回复图片-reply、商家图片
	 * @return
	 */
	public static String getPicturePath(String pathType, String pathCategory) {
		String strResult = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		StringBuffer strBuf = new StringBuffer();
		if ("visit".equals(pathType)) {
		} else if ("save".equals(pathType)) {
			String projectPath = PublicUtil.getPorjectPath().replaceAll("\\\\", "/");
			projectPath = splitString(projectPath, "bin/");

			strBuf.append(projectPath);
			strBuf.append("webapps/ROOT/");
		}

		strResult = strBuf.toString();

		return strResult;
	}

	private static String splitString(String str, String param) {
		String result = str;
		if (str.contains(param)) {
			int start = str.indexOf(param);
			result = str.substring(0, start);
		}
		return result;
	}

	/**
	 * 
	 * @Title: getClasspath 
	 * @author hp
	 * @date 2015年6月26日 上午9:50:50 
	 * @Description: 获取 项目 路径 
	 * @return String
	 *
	 */
	public static String getClasspath() {
		String path = (String.valueOf(Thread.currentThread().getContextClassLoader().getResource("")) + "../../").replaceAll("file:/", "").replaceAll("%20", " ").trim();
		if (path.indexOf(":") != 1) {
			path = File.separator + path;
		}
		return path;
	}

	/**
	 * 
	 * @Title: getClassResources 
	 * @author hp
	 * @date 2015年6月26日 上午9:51:39 
	 * @Description: 获取 Class  路径 
	 * @return String
	 *
	 */
	public static String getClassResources() {
		String path = (String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""))).replaceAll("file:/", "").replaceAll("%20", " ").trim();
		if (path.indexOf(":") != 1) {
			path = File.separator + path;
		}
		return path;
	}

	/**
	 * 
	 * @Title: PathAddress 
	 * @author hp
	 * @date 2015年6月26日 上午9:52:08 
	 * @Description: 获取本项目路径
	 * @return String
	 *
	 */
	public static String PathAddress() {
		String strResult = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		StringBuffer strBuf = new StringBuffer();
		strBuf.append(request.getScheme() + "://");
		strBuf.append(request.getServerName() + ":");
		strBuf.append(request.getServerPort() + "");
		strBuf.append(request.getContextPath() + "/");
		strResult = strBuf.toString();//加入项目的名称
		return strResult;
	}

	/**
	 * 
	 * @Title: PathImgProject 
	 * @author hp
	 * @date 2015年6月26日 上午9:52:08 
	 * @Description: 获取图片项目路径
	 * @return String
	 *
	 */
	public static String PathImgProject() {
		String strResult = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		StringBuffer strBuf = new StringBuffer();
		strBuf.append(request.getScheme() + "://");
		strBuf.append(request.getServerName() + ":");
		strBuf.append(request.getServerPort() + "/");
		strBuf.append(PropertiesUtil.get("upload.projectName") + "/");
		strResult = strBuf.toString();
		return strResult;
	}

	/**
	 * 
	 * @Title: getFilePath 
	 * @author hp
	 * @date 2016年1月13日 下午7:43:52 
	 * @Description: 取文件夹地址
	 * @param filePathType
	 * @return String
	 *
	 */
	public static String getFilePath(String filePathType) {
		String pathName = PropertiesUtil.get("upload.pathLevel") + PropertiesUtil.get("upload.projectName") + PropertiesUtil.get(filePathType);

		String filePath = PathUtil.getClasspath() + pathName; //文件上传路径
		return filePath;
	}

	/**
	 * 
	 * @Title: getCkFilePath 
	 * @author hp
	 * @date 2016年1月13日 下午7:43:52 
	 * @Description: 取文件夹地址
	 * @param filePathType
	 * @return String
	 *
	 */
	public static String getCkFilePath() {
		String pathName = PropertiesUtil.get("upload.CkFilePath");
		String filePath = PathUtil.getClasspath() + pathName; //文件上传路径
		return filePath;
	}

	public static void main(String[] args) {
		/*
		String path = (String.valueOf(Thread.currentThread().getContextClassLoader().getResource("")) + "../../").replaceAll("file:/", "").replaceAll("%20", " ").trim();
		if (path.indexOf(":") != 1) {
			path = File.separator + path;
		}
		*/
		String path = String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""));
		logger.debug(path);
	}

}
