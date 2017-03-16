package com.qtzk.system.bean;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;

public class PageData extends HashMap<Object, Object> implements Map<Object, Object> {

	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(PageData.class);

	private Map<Object, Object> map = null;
	private HttpServletRequest request;

	public PageData(HttpServletRequest request) {
		this.request = request;
		Map<String, String[]> properties = request.getParameterMap();
		Map<Object, Object> returnMap = new HashMap<Object, Object>();
		logger.debug("request params=>" + JSONObject.toJSONString(returnMap));
		Iterator<Entry<String, String[]>> entries = properties.entrySet().iterator();
		Map.Entry<String, String[]> entry = null;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Map.Entry<String, String[]>) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i] + ",";
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString();
			}
			returnMap.put(name, value);
		}
		map = returnMap;
	}

	public PageData() {
		map = new HashMap<Object, Object>();
	}

	@Override
	public Object get(Object key) {
		Object obj = null;
		if (map.get(key) instanceof Object[]) {
			Object[] arr = (Object[]) map.get(key);
			obj = request == null ? arr : (request.getParameter((String) key) == null ? arr : arr[0]);
		} else {
			obj = map.get(key);
		}
		return obj;
	}

	public String getString(Object key) {
		if (get(key) != null) {
			return get(key).toString();
		}
		return "";
	}

	public double getDouble(Object key) {
		double result = 0.0;
		Object obj = get(key);
		if (obj != null) {
			try {
				result = Double.parseDouble(obj.toString());
			} catch (NumberFormatException e) {
				result = 0.0;
				logger.error("NumberFormatException", e);
			}
		}
		return result;
	}

	public int getInt(Object key) {
		int result = 0;
		Object obj = get(key);
		if (obj != null) {
			try {
				result = Integer.parseInt(obj.toString());
			} catch (NumberFormatException e) {
				result = 0;
				logger.error("NumberFormatException", e);
			}
		}
		return result;
	}

	public Integer getInteger(Object key) {
		Integer result = 0;
		Object obj = get(key);
		if (obj != null) {
			try {
				result = Float.valueOf(obj.toString()).intValue();
			} catch (NumberFormatException e) {
				logger.error("NumberFormatException", e);
			}
		}
		return result;
	}

	@Override
	public Object put(Object key, Object value) {
		return map.put(key, value);
	}

	@Override
	public Object remove(Object key) {
		return map.remove(key);
	}

	public void clear() {
		map.clear();
	}

	public boolean containsKey(Object key) {
		return map.containsKey(key);
	}

	public boolean containsValue(Object value) {
		return map.containsValue(value);
	}

	public Set<Map.Entry<Object, Object>> entrySet() {
		return map.entrySet();
	}

	public boolean isEmpty() {
		return map.isEmpty();
	}

	public Set<Object> keySet() {
		return map.keySet();
	}

	public void putAll(HashMap<Object, Object> t) {
		map.putAll(t);
	}

	public int size() {
		return map.size();
	}

	public Collection<Object> values() {
		return map.values();
	}

}
