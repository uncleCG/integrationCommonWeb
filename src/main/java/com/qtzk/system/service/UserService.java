package com.qtzk.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.Right;
import com.qtzk.system.bean.Role;
import com.qtzk.system.bean.User;

public interface UserService {

	/**
	 * 分页获取账户信息
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月23日下午5:14:55
	 */
	public List<User> getUserListPage(Page page);

	/**
	 * 保存信息（id 属性值为空，执行新增，否则更新）
	 * @param user
	 * @param request
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月1日上午11:16:54
	 */
	public JSONObject saveOrUpdateUser(User user, HttpServletRequest request);

	/**
	 * 获取账户详情
	 * @param userId
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月23日下午5:11:09
	 */
	public User getUserById(Integer userId);

	/**
	 * 根据昵称获取用户信息
	 * @param nickname
	 * @return  
	 * @author JHONNY
	 * @date 2016年5月25日下午4:22:35
	 */
	public JSONObject getuserByNickname(String nickname);

	/**
	 * 根据userId获取其对应的角色集合
	 * @param userId
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月29日下午5:41:19
	 */
	public List<Role> getRoleListByUserId(Integer userId);

	/**
	 * 删除指定id用户
	 * @param userId
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月1日上午11:01:10
	 */
	public JSONObject delUserById(Integer userId);

	/**
	 * 根据userId获取其对应的权限集合
	 * @param id
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月3日上午11:46:57
	 */
	public List<Right> getRightListByUserId(Integer id);

	/**
	 * 更新用户信息（不涉及关联表业务处理）
	 * @param user
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月1日上午11:16:54
	 */
	public JSONObject editUserBase(User user);

}
