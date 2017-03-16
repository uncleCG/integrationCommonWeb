package com.qtzk.system.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import org.apache.log4j.Logger;

/**
 * 管理项目中 properties 文件的工具类 
 * @author JHONNY
 * @date 2016年6月16日下午4:37:19
 */
public class PropertiesUtil {

	private static final Logger logger = Logger.getLogger(PropertiesUtil.class);

	private Properties p = new Properties();
	private static PropertiesUtil pu = null;
	private static String filePath = null;

	//存放所有 properties 文件名称的 xml 文件名
	private static String fileName = "propertiesList.xml";

	//存放所有 properties 文件中的 key、value
	private Map<String, String> mapProperties = new HashMap<String, String>();

	// 项目 \WEB-INF\classes 的磁盘目录
	private static String classesPath = null;

	public static void main(String[] args) throws Exception {
		logger.debug(PropertiesUtil.get("weixin.WX_ACCESS_TOKEN_GET"));
		//logger.debug(pu.mapProperties);
		//logger.debug(pu.p);
	}

	/**
	 * 加载存放所有 properties 文件名称的 xml 文件
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月16日下午4:41:19
	 */
	public static synchronized PropertiesUtil getInstance() {
		if (pu == null) {
			//获取 项目 classes 文件（\WEB-INF\classes）的磁盘根目录
			classesPath = new File(PropertiesUtil.class.getResource("/").getPath()) + "";
			//替换 %20 为 " "
			classesPath = classesPath.replace("%20", " ");
			//拼接获取文件的磁盘路径
			filePath = classesPath + File.separatorChar + "config" + File.separatorChar + "properties" + File.separatorChar + fileName;
			reload();
		}
		return pu;
	}

	/**
	 * 加载 xml 中配置的 properties
	 *    
	 * @author JHONNY
	 * @date 2016年6月16日下午6:16:19
	 */
	private static synchronized void reload() {
		pu = new PropertiesUtil();
		try {
			File f = new File(filePath);
			InputStream is = null;
			if (!f.exists()) {
				f.createNewFile();
			}
			is = new FileInputStream(f);
			pu.p.loadFromXML(is);
		} catch (IOException e) {
			logger.error("Exception", e);
		}
		getProperties();
	}

	/**
	 * 加载 xml 中所有的 properties 文件属性
	 *    
	 * @author JHONNY
	 * @date 2016年6月16日下午6:12:47
	 */
	public static synchronized void getProperties() {
		Set<Entry<Object, Object>> set = pu.p.entrySet();
		Iterator<Entry<Object, Object>> iterator = set.iterator();
		while (iterator.hasNext()) {
			Entry<Object, Object> propertiesEntity = iterator.next();
			filePath = classesPath + File.separatorChar + "config" + File.separatorChar + "properties" + File.separatorChar + propertiesEntity.getValue().toString();
			reloadProperties();
		}
	}

	/**
	 * 将 properties 的属性值添加到全局 map 中
	 *    
	 * @author JHONNY
	 * @date 2016年6月16日下午6:13:55
	 */
	private static synchronized void reloadProperties() {
		try {
			File f = new File(filePath);
			InputStream is = null;
			if (!f.exists()) {
				f.createNewFile();
			}
			is = new FileInputStream(f);
			Properties ps = new Properties();
			ps.load(is);
			Map<String, String> map = (Map<String, String>) ps.clone();
			pu.mapProperties.putAll(map);
		} catch (Exception e) {
			logger.error("Exception", e);
		}
	}

	/**
	 * 获取 key 对应的 value 值， 如果 没有取到 返回为空
	 * @param key
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月16日下午6:14:58
	 */
	public static String get(String key) {
		pu = getInstance();
		if (contains(key)) {
			return pu.mapProperties.get(key).toString();
		} else {
			logger.debug("key=" + key + "资源信息没有找到！");
			return "";
		}
	}

	/**
	 * 判断 key 值是否存在
	 * @param key
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月16日下午6:15:42
	 */
	public static boolean contains(String key) {
		pu = getInstance();
		return pu.mapProperties.containsKey(key);
	}

}
