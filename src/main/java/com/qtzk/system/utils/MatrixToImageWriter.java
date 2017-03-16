package com.qtzk.system.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.log4j.Logger;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.Result;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;

/**
 * 生成二维码工具类
 *    
 * @author JHONNY
 * @date 2016年7月1日上午9:41:59
 */
public class MatrixToImageWriter {

	private static final Logger logger = Logger.getLogger(MatrixToImageWriter.class);

	private static final int BLACK = 0xFF000000;

	private static final int WHITE = 0xFFFFFFFF;

	public static BufferedImage toBufferedImage(BitMatrix matrix) {
		int width = matrix.getWidth();
		int height = matrix.getHeight();
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				image.setRGB(x, y, matrix.get(x, y) ? BLACK : WHITE);
			}
		}
		return image;
	}

	public static void writeToFile(BitMatrix matrix, String format, File file) throws IOException {
		BufferedImage image = toBufferedImage(matrix);
		if (!ImageIO.write(image, format, file)) {
			throw new IOException("Could not write an image of format " + format + " to " + file);
		}
	}

	public static void writeToStream(BitMatrix matrix, String format, OutputStream stream) throws IOException {
		BufferedImage image = toBufferedImage(matrix);
		if (!ImageIO.write(image, format, stream)) {
			throw new IOException("Could not write an image of format " + format);
		}
	}

	public static BitMatrix deleteWhite(BitMatrix matrix) {
		int[] rec = matrix.getEnclosingRectangle();
		int resWidth = rec[2] + 1;
		int resHeight = rec[3] + 1;

		BitMatrix resMatrix = new BitMatrix(resWidth, resHeight);
		resMatrix.clear();
		for (int i = 0; i < resWidth; i++) {
			for (int j = 0; j < resHeight; j++) {
				if (matrix.get(i + rec[0], j + rec[1]))
					resMatrix.set(i, j);
			}
		}
		return resMatrix;
	}

	public static Map<String, Object> decode(File file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("url", "");
		resultMap.put("height", 0);
		resultMap.put("width", 0);
		BufferedImage image = null;
		try {
			if (file == null || file.exists() == false) {
				throw new Exception(" File not found:" + file.getPath());
			}
			image = ImageIO.read(file);
			LuminanceSource source = new BufferedImageLuminanceSource(image);
			BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
			Result result = null;
			// 解码设置编码方式为：utf-8，  
			Hashtable<DecodeHintType, String> hints = new Hashtable<DecodeHintType, String>();
			hints.put(DecodeHintType.CHARACTER_SET, "utf-8");
			result = new MultiFormatReader().decode(bitmap, hints);
			logger.debug("width=>" + image.getWidth() + ",height=>" + image.getHeight());
			resultMap.put("url", result.getText());
			resultMap.put("height", image.getHeight());
			resultMap.put("width", image.getWidth());
		} catch (Exception e) {
			logger.error("Exception", e);
		}
		return resultMap;
	}

	public static void main(String[] args) throws Exception {
		//		String text = "http://www.baidu.com";
		//		String text = "http://www.qtzhongka.com/appDownload.jsp";
		//String text = "http://www.qtzhongka.com/downloadShForward.jsp";
		//http://123.56.142.230/uploadFile 
		String mobile = "17090131721";
		//String text = "http://123.56.142.230/download?mobile=" + mobile;
		String text = "http://123.56.142.230/index?mobile=" + mobile;
		int width = 200;
		int height = 200;
		// 二维码的图片格式
		String format = "jpg";
		Hashtable hints = new Hashtable();
		// 内容所使用编码
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		BitMatrix bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
		bitMatrix = MatrixToImageWriter.deleteWhite(bitMatrix);
		// 生成二维码
		File outputFile = new File("D:\\qrcode\\" + mobile + "_index." + format);
		MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
		//	}

		//	public static void main(String[] args) {
		//File file = new File("D:\\Roy_workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\atlas\\statics\\qrcodeImg\\qrcode.gif");
		//logger.debug(MatrixToImageWriter.decode(file));
	}
	/*

	public static void main(String[] args) throws Exception {
		//账单编号|交易码|金额|卡类型
		String billCode = "41";
		String text = "41";
		int width = 200;
		int height = 200;
		// 二维码的图片格式
		String format = "jpg";
		Hashtable hints = new Hashtable();
		// 内容所使用编码
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		BitMatrix bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
		bitMatrix = MatrixToImageWriter.deleteWhite(bitMatrix);
		// 生成二维码
		File outputFile = new File("D:\\qrcode\\" + billCode + "." + format);
		MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
	}
	*/
}
