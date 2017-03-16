package com.qtzk.system.utils;

import java.util.Random;

import org.apache.shiro.crypto.hash.Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Digests {

	private static Logger logger = LoggerFactory.getLogger(Digests.class);

	//生成8位数字的随机字符串
	public static String getRandomString() { //length表示生成字符串的长度
		int length = 8;
		return getRandomString(length);
	}

	public static String getRandomString(int length) { //length表示生成字符串的长度
		String base = "abcdefghijklmnopqrstuvwxyz0123456789";
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int number = random.nextInt(base.length());
			sb.append(base.charAt(number));
		}
		return sb.toString();
	}

	/**
	 * 根据传过来的随机字符串和密码组合在一起，通过加密算法经过一定的加密次数生成一个32位的密码
	 * @param password
	 * @param salt
	 * @return
	 */
	public static String encryptPassword(String password, String salt) {
		Hash hash = new SimpleHash(Constant.HASH_ALGORITHM, password, salt, Constant.HASH_INTERATIONS);
		return hash.toHex();
	}

	public static void main(String args[]) {
		String salt = getRandomString();
		salt = "christ";
		logger.debug("salt =========== " + salt);
		Hash hash = new SimpleHash(Constant.HASH_ALGORITHM, "111111", salt, Constant.HASH_INTERATIONS);
		logger.debug("password ======== " + hash.toHex());
	}

}
