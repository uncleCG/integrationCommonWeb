package com.qtzk.system.service.impl;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * MD5 算法
*/
public class MD5Util {

	private static final Logger logger = LoggerFactory.getLogger(MD5Util.class);

	public static String getMD5Str(String str) {
		MessageDigest messageDigest = null;

		try {
			messageDigest = MessageDigest.getInstance("MD5");

			messageDigest.reset();

			messageDigest.update(str.getBytes("UTF-8"));
		} catch (NoSuchAlgorithmException e) {
			logger.debug("NoSuchAlgorithmException caught!");
		} catch (UnsupportedEncodingException e) {
			logger.error("exception-info", e);
		}

		byte[] byteArray = messageDigest.digest();

		StringBuffer md5StrBuff = new StringBuffer();

		for (int i = 0; i < byteArray.length; i++) {
			if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)
				md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));
			else
				md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
		}

		return md5StrBuff.toString();
	}

	public static void main(String[] args) {
		logger.debug(getMD5Str("<?xml version=\"1.0\" encoding=\"UTF-8\"?><Order><OrderId>46</OrderId><OrdOprTime>2015-01-21 14:06</OrdOprTime><CusName>owen</CusName><MobNum>15001336894</MobNum><Province>北京市</Province><City>北京市</City><District>东城区</District><CusAdd>assdf</CusAdd><PostCode>100176</PostCode><Comments>111</Comments><SubOrd><ItemList><SubOrderId>46</SubOrderId><ProductId>CA2018</ProductId><ProductNum>4</ProductNum></ItemList></SubOrd></Order>10002UP8$Gwmpr9!I1vR3ti$9SifPdrsP8duk"));
	}
}
