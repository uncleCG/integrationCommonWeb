package com.qtzk.system.service;

import java.io.File;
import java.io.IOException;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.qtzk.system.utils.Constant;
import com.qtzk.system.utils.FileUpload;
import com.qtzk.system.utils.MatrixToImageWriter;
import com.qtzk.system.utils.PropertiesUtil;

/**
 * 二维码生成Service
 *    
 * @author JHONNY
 * @date 2016年7月1日下午2:06:35
 */
@Service(value = "qrCodeService")
public class QrCodeService {

	private Logger logger = LoggerFactory.getLogger(QrCodeService.class);

	/**
	 * 创建图片二维码文件
	 * @param request
	 * @param qrcodeImage 图片名称
	 * @param qrcodeContent 存储内容
	 * @param format 图片格式
	 */
	public void createQrcodeImageFile(HttpServletRequest request, String qrcodeImage, String qrcodeContent, String format) {
		int width = 380;
		int height = 380;
		File outputFile = null;
		String qrcodePath = PropertiesUtil.get("upload.pathLevel") + PropertiesUtil.get("upload.projectName") + PropertiesUtil.get("upload.qrcodeImg");
		File dir = new File(request.getSession().getServletContext().getRealPath(qrcodePath));
		if (!dir.exists()) {
			dir.mkdirs();
		}
		String path = qrcodePath + qrcodeImage;
		try {
			Hashtable<EncodeHintType, String> hints = new Hashtable<EncodeHintType, String>();
			// 内容所使用编码
			hints.put(EncodeHintType.CHARACTER_SET, Constant.ENCODING_UTF8);
			BitMatrix bitMatrix = new MultiFormatWriter().encode(qrcodeContent, BarcodeFormat.QR_CODE, width, height, hints);
			bitMatrix = MatrixToImageWriter.deleteWhite(bitMatrix);
			// 生成二维码
			outputFile = new File(request.getSession().getServletContext().getRealPath(path));
			MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);

			//同步图片
			FileUpload.syncPost(null, outputFile.getPath(), PropertiesUtil.get("upload.qrcodeImg"), qrcodeImage.substring(0, qrcodeImage.indexOf(".")));

		} catch (WriterException e) {
			logger.error("WriterException", e);
		} catch (IOException e) {
			logger.error("IOException", e);
		}
	}
}
