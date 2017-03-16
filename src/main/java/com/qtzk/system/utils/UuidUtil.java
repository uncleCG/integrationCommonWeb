package com.qtzk.system.utils;

import java.util.UUID;

import org.apache.log4j.Logger;

public class UuidUtil {

	private static final Logger logger = Logger.getLogger(UuidUtil.class);

	public static String get32UUID() {
		String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");
		return uuid;
	}

	public static void main(String[] args) {
		logger.debug(get32UUID());
	}
}
