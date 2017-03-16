package com.qtzk.system.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.Role;
import com.qtzk.system.bean.RoleRight;
import com.qtzk.system.dao.DAO;
import com.qtzk.system.service.RoleService;
import com.qtzk.system.utils.DateUtil;

@Service(value = "roleService")
public class RoleServiceImpl implements RoleService {

	private static Logger logger = LoggerFactory.getLogger(RoleService.class);

	@Resource(name = "daoSupport")
	private DAO dao;

	@Override
	public List<Role> findByListPage(Page page) {
		List<Role> roleList = null;
		roleList = (List<Role>) dao.findForList("RoleMapper.findByListPage", page);
		return roleList;
	}

	@Override
	public Role getRoleInfoById(int roleId) {
		Role role = null;
		role = (Role) dao.findForObject("RoleMapper.getRoleById", roleId);
		return role;
	}

	@Override
	public JSONObject saveOrUpdate(Role role) {
		JSONObject result = new JSONObject();
		try {
			if (role.getId() != null) {//修改
				int rowNum = (int) dao.update("RoleMapper.update", role);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "操作成功");
					result.put("role", role);
				} else {
					result.put("status", -2);
					result.put("message", "执行结果异常，请稍候重试");
				}
			} else {//增加
				Date nowDateTime = DateUtil.fomatDate(DateUtil.getTime(), "yyyy-MM-dd HH:mm:ss");
				role.setCreatedAt(nowDateTime);
				int rowNum = (int) dao.save("RoleMapper.insert", role);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "操作成功");
					result.put("role", role);
				} else {
					result.put("status", -2);
					result.put("message", "执行结果异常，请稍候重试");
				}
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
			result.put("status", -2);
			result.put("message", "数据操作异常，请稍候重试");
		}
		return result;
	}

	@Override
	public JSONObject delRoleById(int roleId) {
		JSONObject result = new JSONObject();
		int userNum = (int) dao.findForObject("UserMapper.getUserNumByRoleId", roleId);
		if (userNum > 0) {
			result.put("status", "-1");
			result.put("message", "此角色有管理员帐号正在使用，请先删除相关的管理员再删除此角色。");
			return result;
		}
		try {
			int rowNum = (int) dao.delete("RoleMapper.delRoleById", roleId);
			if (rowNum == 1) {
				result.put("status", 1);
				result.put("message", "操作成功");
			} else {
				result.put("status", "-2");
				result.put("message", "执行结果异常，请稍候重试");
			}
		} catch (Exception e) {
			logger.error("删除角色异常", e);
			result.put("status", -2);
			result.put("message", "数据操作异常，请稍候重试");
		}
		return result;
	}

	@Override
	public List<RoleRight> findAllRightByRoleId(int roleId) {
		List<RoleRight> roleRightList = null;
		roleRightList = (List<RoleRight>) dao.findForList("RoleRightMapper.findAllRightByRoleId", roleId);
		return roleRightList;
	}

	@Override
	public JSONObject saveAssignRight(int roleId, String rightIds) {
		JSONObject result = new JSONObject();
		if (!StringUtils.isEmpty(rightIds)) {
			try {
				dao.delete("RoleRightMapper.clearByRoleId", roleId);
				PageData pd = new PageData();
				pd.put("roleId", roleId);
				pd.put("rightIds", rightIds.split(","));
				dao.save("RoleRightMapper.insert", pd);
				result.put("status", "1");
				result.put("message", "");
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", "-2");
				result.put("message", "数据操作异常，请稍后重试");
			}
		} else {
			result.put("status", "-2");
			result.put("message", "参数异常，请稍后重试");
		}
		return result;
	}

	@Override
	public List<Role> findAllRole() {
		List<Role> roleList = null;
		roleList = (List<Role>) dao.findForList("RoleMapper.findAllRole", null);
		return roleList;
	}

}
