package com.qtzk.system.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.MessageFormat;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;

import com.qtzk.system.bean.Returnsms;

/**
*    
* 类名称：PhoneSmsNodeUtil   
* 类描述：   手机验证码信息发送
* 创建人：hp   
* 创建时间：2015年6月29日 下午5:31:44   
* 修改人：hp   
* 修改时间：2015年6月29日 下午5:31:44   
* 修改备注：   
* @version    
*
 */
public class PhoneSmsNodeUtil {

	private static final Logger logger = Logger.getLogger(PhoneSmsNodeUtil.class);

	public static final String SMS_URL = PropertiesUtil.get("sms.url");
	public static final String SMS_ACCTION = PropertiesUtil.get("sms.account");
	public static final String SMS_PWD = PropertiesUtil.get("sms.password");
	public static final String SMS_TEMPLET = PropertiesUtil.get("sms.templet");

	/**
	 * 
	 * @Title: sendCode 
	 * @author hp
	 * @date 2015年6月29日 下午5:32:11 
	 * @Description: 手机验证码信息发送入口
	 * @param phoneNum 手机号
	 * @param templet 信息发送模板
	 * @return String
	 *
	 */
	public static String sendCode(String phoneNum, String templet) {
		String result = "";
		try {
			String randomNum = RandomStringUtils.randomNumeric(6);
			if (templet == null || templet.equals("")) {
				templet = SMS_TEMPLET;
			}
			String content = MessageFormat.format(templet, randomNum);
			result = sendMessage(phoneNum, content);
			//result = "success";
			logger.debug("手机验证码##########################=" + randomNum);
			if (result.equals("success")) {
				result = randomNum;
			}
		} catch (Exception e) {
			logger.error("Exception", e);
		}
		return result;
	}

	/**
	 * 
	 * @Title: sendMessage 
	 * @author hp
	 * @date 2015年6月29日 下午5:33:14 
	 * @Description: 短信发送
	 * @param phoneNum 手机号
	 * @param content 发送内容
	 * @return
	 * @throws IOException String
	 *
	 */
	public static String sendMessage(String phoneNum, String content) throws IOException {
		String postData = "userid=&account=" + SMS_ACCTION + "&password=" + SMS_PWD + "&mobile=" + phoneNum + "&sendTime=&content=" + java.net.URLEncoder.encode(content, "utf-8");
		logger.debug("postData=>" + postData);
		// 发送POST请求
		URL url = new URL(SMS_URL);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		conn.setRequestProperty("Connection", "Keep-Alive");
		conn.setUseCaches(false);
		conn.setDoOutput(true);

		conn.setRequestProperty("Content-Length", "" + postData.length());
		OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
		out.write(postData);
		out.flush();
		out.close();

		// 获取响应状态
		if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
			logger.warn("connect failed!");
			return "";
		}
		// 获取响应内容体
		String line, result = "";
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		while ((line = in.readLine()) != null) {
			result += line + "\n";
		}
		logger.debug("result=>" + result);
		in.close();
		Returnsms returnsms;
		try {
			returnsms = XMLStringToBean(result);
			if (returnsms != null) {
				if (returnsms.getReturnstatus().equals("Success")) {
					result = "success";
				} else {
					result = "errorNum";
				}
			} else {
				result = "input";
			}
		} catch (JAXBException e) {
			logger.error("JAXBException", e);
		} finally {
			IOUtils.closeQuietly(out);
		}
		return result;
	}

	/**
	 * 
	 * @Title: XMLStringToBean 
	 * @author hp
	 * @date 2015年6月29日 下午5:35:13 
	 * @Description: 解析返回xml
	 * @param xmlStr
	 * @return
	 * @throws JAXBException AppReturnsms
	 *
	 */
	public static Returnsms XMLStringToBean(String xmlStr) throws JAXBException {
		JAXBContext context = JAXBContext.newInstance(Returnsms.class);
		Unmarshaller unmarshaller = context.createUnmarshaller();
		Returnsms returnsms = (Returnsms) unmarshaller.unmarshal(new StringReader(xmlStr));
		logger.debug("returnsms.getMessage()=>" + returnsms.getMessage());
		return returnsms;
	}

	public static void main(String[] args) {
		String ret = sendCode("15210577298", null);
		logger.debug(ret);
		// 请自己反序列化返回的字符串并实现自己的逻辑
	}
}
