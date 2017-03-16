package com.qtzk.system.utils;

/**
 * className：TokenBaseInter
 * Function：
 * date: 2014-9-23-下午10:23:39
 * @author hp 
 */
public interface TokenBaseInter {

	public final String key = "qtzkkcqb";

	/**
	 * 解密
	 * 
	 * @param str
	 * @return
	 */
	@SuppressWarnings("restriction")
	public String decrypt(String str);

	/**
	 * 加密
	 * 
	 * @param str
	 * @return
	 */
	@SuppressWarnings("restriction")
	public String encrypt(String str);

	/**
	 * 放入各种定制的参数，生产Token
	 * @param pramaters
	 * @return
	 */
	public String productToken(String[] pramaters);

	/**
	 * 放入各种定制的参数，生产Token
	 * @param userNo
	 * @return
	 */
	public String productToken(String pix, String userNo);
}
