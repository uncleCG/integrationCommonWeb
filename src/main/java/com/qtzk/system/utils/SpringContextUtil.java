package com.qtzk.system.utils;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * @ClassName: SpringContextUtil 
 * @Description: Spring获取JavaBean工具类
 * @author aquarius
 * @date 2016年4月25日 下午4:38:04 
 */
public class SpringContextUtil implements ApplicationContextAware {

	private static ApplicationContext applicationContext;

	/** 
	 * 实现ApplicationContextAware接口的回调方法，设置上下文环境 
	 *  
	 * @param applicationContext 
	 */
	public void setApplicationContext(ApplicationContext applicationContext) {
		SpringContextUtil.applicationContext = applicationContext;
	}

	/** 
	 * @return ApplicationContext 
	 */
	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}

	/** 
	 * 获取对象 
	 * @param name 
	 * @return Object
	 * @throws BeansException 
	 */
	public static Object getBean(String name) throws BeansException {
		return applicationContext.getBean(name);
	}
}
