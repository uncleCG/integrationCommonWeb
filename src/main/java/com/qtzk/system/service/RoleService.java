package com.qtzk.system.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.Role;
import com.qtzk.system.bean.RoleRight;

/**
 * 角色相关业务接口
 *    
 * @author JHONNY
 * @date 2016年5月27日上午11:43:09
 */
public interface RoleService {

	/**
	 * 分页获取角色
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午5:45:14
	 */
	public List<Role> findByListPage(Page page);

	/**
	 * 根据id获取角色详细信息
	 * @param roleId
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午5:45:53
	 */
	public Role getRoleInfoById(int roleId);

	/**
	 * 保存角色信息（id值不为空，进行更新，否则进行新增操作）
	 * @param role
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午5:47:17
	 */
	public JSONObject saveOrUpdate(Role role);

	/**
	 * 根据角色id删除对应角色
	 * @param roleId
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午5:48:54
	 */
	public JSONObject delRoleById(int roleId);

	/**
	 * 获取角色所拥有的权限
	 * @param roleId
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午5:49:59
	 */
	public List<RoleRight> findAllRightByRoleId(int roleId);

	/**
	 * 为指定角色分配相应权限
	 * @param roleId
	 * @param rightIds
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午5:52:22
	 */
	public JSONObject saveAssignRight(int roleId, String rightIds);

	/**
	 * 获取所有角色列表
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月1日上午11:11:37
	 */
	public List<Role> findAllRole();

}
