package com.qtzk.system.utils;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.apache.log4j.Logger;

/**
 * 
*    
* 类名称：PublicUtil   
* 类描述：   地址 共公类
* 创建人：hp   
* 创建时间：2015年6月26日 上午9:56:17   
* 修改人：hp   
* 修改时间：2015年6月26日 上午9:56:17   
* 修改备注：   
* @version    
*
 */
public class PublicUtil {

	private static final Logger logger = Logger.getLogger(PublicUtil.class);

	public static void main(String[] args) {
		logger.debug("本机的ip=" + PublicUtil.getIp());
		logger.debug("本机的ip=" + PublicUtil.getPorjectPath());
	}

	/**
	 * 
	 * @Title: getPorjectPath 
	 * @author hp
	 * @date 2015年6月26日 上午9:55:46 
	 * @Description: 获取 项目地址
	 * @return String
	 *
	 */
	public static String getPorjectPath() {
		String nowpath = "";
		nowpath = System.getProperty("user.dir") + "/";
		return nowpath;
	}

	/**
	 * 
	 * @Title: getIp 
	 * @author hp
	 * @date 2015年6月26日 上午9:54:53 
	 * @Description: 获取本机ip
	 * @return String
	 *
	 */
	public static String getIp() {
		String ip = "";
		try {
			InetAddress inet = InetAddress.getLocalHost();
			ip = inet.getHostAddress();
		} catch (UnknownHostException e) {
			logger.error("UnknownHostException caught!", e);
		}
		return ip;
	}

}