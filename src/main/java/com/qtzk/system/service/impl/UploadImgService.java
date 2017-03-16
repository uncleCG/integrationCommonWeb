package com.qtzk.system.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.utils.FileUpload;
import com.qtzk.system.utils.PathUtil;
import com.qtzk.system.utils.SerialNum;

@Service("uploadImgService")
public class UploadImgService {

	private static final Logger logger = LoggerFactory.getLogger(UploadImgService.class);

	/**
	 * 上传图片
	 * @param request
	 * @return status = 1 成功;status = -1 文件大于1M，{status:'',imageName:'',message:''} 
	 * @author JHONNY
	 * @date 2016年1月26日下午3:17:56
	 */
	public JSONObject uploadImg(HttpServletRequest request) {
		JSONObject result = new JSONObject();
		String uploadPathKey = request.getParameter("uploadPathKey");
		String image = request.getParameter("image"); //拿到字符串格式的图片
		if (StringUtils.isEmpty(uploadPathKey) || StringUtils.isEmpty(image)) {
			result.put("status", -2);
			result.put("message", "参数异常");
			return result;
		}
		// 只允许image  
		String header = "data:image";
		String[] imageArr = image.split(",");
		if (imageArr[0].contains(header)) {//是img的
			//data:image/png;base64
			String extName = imageArr[0].split("/")[1].split(";")[0];
			// 去掉头部  
			image = imageArr[1];
			//image = image.substring(header.length());
			byte[] decodedBytes = Base64.decodeBase64(image);
			if (decodedBytes != null && decodedBytes.length > 1048576) {
				result.put("status", -1);
				result.put("message", "上传文件大小大于 1M");
				return result;
			}
			// 保存新图片 
			String filePath = PathUtil.getFilePath(uploadPathKey); //文件上传路径
			String fileName = SerialNum.getMoveOrderNo("");
			String fileAllName = fileName + "." + extName;
			File tempOutFile = new File(filePath);
			if (!tempOutFile.exists()) {
				tempOutFile.mkdirs();
			}
			FileOutputStream fos = null;
			try {
				String imgFilePath = filePath + fileAllName;
				fos = new FileOutputStream(imgFilePath);
				fos.write(decodedBytes);//图片写到本地
				FileUpload.syncPost(null, imgFilePath, uploadPathKey, fileName);//同步图片
				result.put("status", 1);
				result.put("imageName", fileAllName);
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "生成图片异常");
			} finally {
				if (fos != null) {
					try {
						fos.close();
					} catch (IOException e) {
						logger.error("exception-info", e);
						result.put("status", -2);
						result.put("message", "关闭资源异常");
					}
				}
			}
		}
		return result;
	}
}
