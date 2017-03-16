package com.qtzk.system.utils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Administrator
 *	反射工具
 */
public class ReflectHelper {

	private final static Logger logger = LoggerFactory.getLogger(ReflectHelper.class);

	/**
	 * 获取obj对象fieldName的Field
	 * @param obj
	 * @param fieldName
	 * @return
	 */
	public static Field getFieldByFieldName(Object obj, String fieldName) {
		for (Class<?> superClass = obj.getClass(); superClass != Object.class; superClass = superClass.getSuperclass()) {
			try {
				return superClass.getDeclaredField(fieldName);
			} catch (NoSuchFieldException e) {
			}
		}
		return null;
	}

	/**
	 * 获取obj对象fieldName的属性值
	 * @param obj
	 * @param fieldName
	 * @return
	 * @throws SecurityException
	 * @throws NoSuchFieldException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public static Object getValueByFieldName(Object obj, String fieldName) throws SecurityException, NoSuchFieldException, IllegalArgumentException, IllegalAccessException {
		Field field = getFieldByFieldName(obj, fieldName);
		Object value = null;
		if (field != null) {
			if (field.isAccessible()) {
				value = field.get(obj);
			} else {
				field.setAccessible(true);
				value = field.get(obj);
				field.setAccessible(false);
			}
		}
		return value;
	}

	/**
	 * 设置obj对象fieldName的属性值
	 * @param obj
	 * @param fieldName
	 * @param value
	 * @throws SecurityException
	 * @throws NoSuchFieldException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public static void setValueByFieldName(Object obj, String fieldName, Object value) throws SecurityException, NoSuchFieldException, IllegalArgumentException, IllegalAccessException {
		Field field = obj.getClass().getDeclaredField(fieldName);
		if (field.isAccessible()) {
			field.set(obj, value);
		} else {
			field.setAccessible(true);
			field.set(obj, value);
			field.setAccessible(false);
		}
	}

	/**
	 * 输出一个实体类的全部属性
	 * @param model
	 */
	public static void print(Object model) {
		Class cls = model.getClass();
		Field[] fields = cls.getDeclaredFields();
		logger.debug("###################### " + model.getClass().getName() + " ####################");
		for (Field field : fields) {
			char[] buffer = field.getName().toCharArray();
			buffer[0] = Character.toUpperCase(buffer[0]);
			String mothodName = "get" + new String(buffer);
			try {
				Method method = cls.getDeclaredMethod(mothodName);
				Object resutl = method.invoke(model, null);
				logger.debug(field.getName() + ": " + resutl);
			} catch (Exception e) {
				logger.error("exception-info", e);
			}
		}
		logger.debug("###################### End ####################");
	}
}
