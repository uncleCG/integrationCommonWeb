package com.qtzk.system.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.Right;
import com.qtzk.system.bean.Role;
import com.qtzk.system.bean.User;
import com.qtzk.system.dao.DAO;
import com.qtzk.system.service.UserService;
import com.qtzk.system.utils.DateUtil;
import com.qtzk.system.utils.Digests;

@Service(value = "userService")
public class UserServiceImpl implements UserService {

	@Resource(name = "daoSupport")
	private DAO dao;

	private Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Override
	public List<User> getUserListPage(Page page) {
		List<User> userList = (List<User>) dao.findForList("UserMapper.getUserListPage", page);
		return userList;
	}

	@Override
	public User getUserById(Integer userId) {
		User user = null;
		if (userId != null) {
			try {
				user = (User) dao.findForObject("UserMapper.getById", userId);
			} catch (Exception e) {
				logger.error("查询异常", e);
			}
		}
		return user;
	}

	@Override
	public JSONObject getuserByNickname(String nickname) {
		JSONObject result = new JSONObject();
		User user = (User) dao.findForObject("UserMapper.getByNickname", nickname);
		result.put("status", "1");
		result.put("message", "");
		result.put("data", user);
		return result;
	}

	@Override
	public List<Role> getRoleListByUserId(Integer userId) {
		List<Role> roleList = new ArrayList<Role>();
		if (userId != null) {
			roleList = (List<Role>) dao.findForList("UserMapper.getRoleListByUserId", userId);
		}
		return roleList;
	}

	@Override
	public JSONObject delUserById(Integer userId) {
		JSONObject result = new JSONObject();
		if (userId != null) {
			try {
				int rowNum = (int) dao.delete("UserMapper.delUserById", userId);
				if (rowNum == 1) {
					dao.delete("UserRoleMapper.clearRoleByUserId", userId);
					result.put("status", 1);
					result.put("message", "操作成功");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据操作异常，请稍候重试");
			}
		} else {
			result.put("status", -2);
			result.put("message", "参数异常");
		}
		return result;
	}

	@Override
	public JSONObject saveOrUpdateUser(User user, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		try {
			String[] userRoleIds = request.getParameterValues("roleIds");
			if (user.getId() != null) {//修改
				User dbUser = this.getUserById(user.getId());
				if (dbUser != null) {
					String dbPwd = dbUser.getPwd();
					//处理密码修改加密问题
					if (dbPwd != null && !dbPwd.equals(user.getPwd())) {
						user.setPwd(Digests.encryptPassword(user.getPwd(), user.getSalt()));
					}
				}
				int rowNum = (int) dao.update("UserMapper.update", user);
				if (rowNum == 1) {
					result.put("status", "1");
					result.put("message", "操作成功");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			} else {//增加
				Date nowDateTime = DateUtil.fomatDate(DateUtil.getTime(), "yyyy-MM-dd HH:mm:ss");
				user.setCreatedAt(nowDateTime);
				user.setPwd(Digests.encryptPassword(user.getPwd(), user.getSalt()));
				int rowNum = (int) dao.save("UserMapper.insert", user);
				if (rowNum == 1) {
					result.put("status", "1");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			}
			//维护 user 和 role 的关联关系表 t_user_role
			if (result.getIntValue("status") == 1) {
				//清除原有关联关系
				dao.delete("UserRoleMapper.clearRoleByUserId", user.getId());
				PageData userRolePd = new PageData();
				userRolePd.put("userId", user.getId());
				userRolePd.put("roleIds", userRoleIds);
				//建立新关联关系
				dao.save("UserRoleMapper.saveUserRole", userRolePd);
			}
		} catch (Exception e) {
			logger.error("保存User信息时异常", e);
			result.put("status", "-2");
			result.put("message", "数据操作异常，请稍候重试");
			throw new RuntimeException("手动抛出异常，回滚事务");
		}
		return result;
	}

	@Override
	public List<Right> getRightListByUserId(Integer userId) {
		List<Right> rightList = new ArrayList<Right>();
		if (userId != null) {
			rightList = (List<Right>) dao.findForList("UserMapper.getRightListByUserId", userId);
		}
		return rightList;
	}

	@Override
	public JSONObject editUserBase(User user) {
		JSONObject result = new JSONObject();
		user.setPwd(Digests.encryptPassword(user.getPwd(), user.getSalt()));
		int rowNum = (int) dao.update("UserMapper.update", user);
		if (rowNum == 1) {
			result.put("status", "1");
			result.put("message", "操作成功");
		} else {
			result.put("status", "-2");
			result.put("message", "执行结果异常，请稍候重试");
		}
		return result;
	}
}
