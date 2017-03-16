package com.qtzk.system.utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

/**
*    
* 类名称：FileUpload   
* 类描述：   上传文件
* 创建人：hp   
* 创建时间：2015年6月25日 上午10:40:29   
* 修改人：hp   
* 修改时间：2015年6月25日 上午10:40:29   
* 修改备注：   
* @version    
*
 */
@SuppressWarnings("deprecation")
public class FileUpload {

	private static final Logger logger = Logger.getLogger(FileUpload.class);

	/**
	 * @param file 			//文件对象
	 * @param filePath		//上传路径
	 * @param fileName		//文件名
	 * @return  文件名
	 */
	public static String fileUp(MultipartFile file, String filePath, String fileName) {
		String extName = ""; // 扩展名格式：
		try {
			if (file.getOriginalFilename().lastIndexOf(".") >= 0) {
				extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			}
			copyFile(file.getInputStream(), filePath, fileName + extName).replaceAll("-", "");
		} catch (IOException e) {
			logger.error("IOException caught!", e);
		}
		return fileName + extName;
	}

	/**
	 * 写文件到当前目录的upload目录中
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 */
	private static String copyFile(InputStream in, String dir, String realName) throws IOException {
		File file = new File(dir, realName);
		if (!file.exists()) {
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			file.createNewFile();
		}
		FileUtils.copyInputStreamToFile(in, file);
		return realName;
	}

	/**
	 * 
	 * @Title: syncPost 
	 * @author hp
	 * @date 2015年6月26日 下午3:59:02 
	 * @Description: 文件同步上传
	 * @param file  文件对象
	 * @param fullPath  文件所在全路径
	 * @param filePathType 文件存放位置类型  upload 资源里
	 * @param fileName 文件名称
	 * @return int
	 *
	 */
	public static int syncPost(MultipartFile file, String fullPath, String filePathType, String fileName) {
		String ipPost = PropertiesUtil.get("upload.ip_post");
		if ("".equals(ipPost)) {
			return 0;
		}
		String[] ipArray = ipPost.replaceAll(" ", "").split(";");
		for (String ipUrl : ipArray) {
			post(file, ipUrl, fullPath, filePathType, fileName);
		}
		return 0;
	}

	/**
	 * 
	 * @Title: post 
	 * @author hp
	 * @date 2015年6月26日 下午4:00:28 
	 * @Description: 同步请求
	 * @param fileIn
	 * @param url  同步的IP及方法
	 * @param fullPath 文件全路径
	 * @param filePathType 文件存放位置类型  upload 资源里
	 * @param fileName void 文件名称
	 *
	 */
	private static void post(MultipartFile fileIn, String url, String fullPath, String filePathType, String fileName) {
		CloseableHttpClient httpClient = HttpClients.createDefault();
		try {
			FileBody bin = new FileBody(new File(fullPath));
			MultipartEntity multipartEntity = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE, "----------ThIs_Is_tHe_bouNdaRY_$", Charset.defaultCharset());
			multipartEntity.addPart("filePathType", new StringBody(filePathType, Charset.forName("UTF-8")));
			multipartEntity.addPart("fileName", new StringBody(fileName, Charset.forName("UTF-8")));
			multipartEntity.addPart("file", bin);

			HttpPost request = new HttpPost(url);
			request.setEntity(multipartEntity);
			request.addHeader("Content-Type", "multipart/form-data; boundary=----------ThIs_Is_tHe_bouNdaRY_$");

			CloseableHttpResponse response = httpClient.execute(request);
			IOUtils.closeQuietly(response);

		} catch (Exception e) {
			logger.error("post Exception caught!", e);
		} finally {
			IOUtils.closeQuietly(httpClient);
		}

	}

	public static void main(String[] args) {
		//syncPost();
		logger.debug(System.getProperty("user.dir"));
	}
}
