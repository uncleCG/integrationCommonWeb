package com.qtzk.system.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Right;

/**
 * 权限相关业务接口
 *    
 * @author JHONNY
 * @date 2016年5月27日上午11:43:09
 */
public interface RightService {

	/**
	 * 根据角色id获取其分配的权限
	 * @param roleId 多个角色id使用英文逗号分割连接
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月27日上午11:44:40
	 */
	public List<Right> getRightByRoleId(String roleId);

	/**
	 * 获取所有的权限
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月27日下午1:49:34
	 */
	public List<Right> getAllRight();

	/**
	 * 根据传入对象id值是否为空，新增或更新权限信息（新增时在id属性中返回新增数据id）。
	 * @param right
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月27日下午1:51:20
	 */
	public JSONObject saveOrUpdateRight(Right right);

	/**
	 * 根据id删除权限
	 * @param rightId
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月27日下午1:55:08
	 */
	public JSONObject delRightById(int rightId);

	/**
	 * 根据权限id获取其详细信息
	 * @param rightId
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午2:46:24
	 */
	public Right getRightById(int rightId);

}
