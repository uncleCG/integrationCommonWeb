package com.qtzk.system.utils;

/**
 * ClassName: TokenProductFactory <br/>
 * Function: 生成Token 类 ，用于不同平台间安全验证<br/>
 * date: 2014-8-5 下午8:25:58 <br/>
 * 
 * @author hp
 */
public class TokenProductFactory {

	private static TokenBaseInter base64 = new TokenToolEncrypterBase64();

	public static void main(String[] args) {
		String[] s = { "卡号", "qtzk" };
		String ss = base64.productToken(s);
		System.out.println("加密后的值：" + ss);
		String gg = base64.decrypt(ss);
		System.out.println("解密后的值：" + gg);
	}

}
