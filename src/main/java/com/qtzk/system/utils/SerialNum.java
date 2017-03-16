package com.qtzk.system.utils;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SerialNum {

	private static final Logger logger = LoggerFactory.getLogger(SerialNum.class);
	private static String count = "000";
	private static String firstCount = "000";

	private static String dateValue = DateUtil.format(new Date(), "yyyyMMddHHmmss");

	/**
	 * 产生序列号
	 */
	public synchronized static String getMoveOrderNo(String noIndex) {
		long No = 0;
		String nowdate = DateUtil.format(new Date(), "yyyyMMddHHmmss").replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
		No = Long.parseLong(nowdate);
		if (!(String.valueOf(No)).equals(dateValue)) {
			count = firstCount;
			dateValue = String.valueOf(No);
		}
		String num = String.valueOf(No);
		num += getNo(count);
		num = noIndex + num;
		return num;
	}

	/**
	 * 返回当天的数+1
	 */
	public static String getNo(String s) {
		String rs = s;
		int i = Integer.parseInt(rs);
		i += 1;
		rs = "" + i;
		for (int j = rs.length(); j < firstCount.length(); j++) {
			rs = "0" + rs;
		}
		count = rs;
		return rs;
	}

	public static void main(String[] args) {
		for (int i = 0; i < 101; i++) {
			logger.debug(getMoveOrderNo("CD"));
		}
	}

}
