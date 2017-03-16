package com.qtzk.system.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.Right;
import com.qtzk.system.bean.Role;
import com.qtzk.system.bean.RoleRight;
import com.qtzk.system.controller.base.BaseController;
import com.qtzk.system.service.RightService;
import com.qtzk.system.service.RoleService;

@Controller
@RequestMapping(value = "/roleController")
public class RoleController extends BaseController {

	private final Logger logger = LoggerFactory.getLogger(RoleController.class);
	@Resource(name = "roleService")
	private RoleService roleService;

	@Resource(name = "rightService")
	private RightService rightService;

	/**
	 * 翻页获取角色列表
	 * @param model
	 * @param page
	 * @return
	 * @author JHONNY
	 * @date 2016年5月30日下午9:35:00
	 */
	@RequestMapping(value = "/getRoleList")
	public String getRoleList(Model model, Page page) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<Role> roleList = roleService.findByListPage(page);
		model.addAttribute("page", page);
		model.addAttribute("list", roleList);
		return "/system/role/role-list";
	}

	/**
	 * 到信息展示页
	 * @param roleId
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午9:37:07
	 */
	@RequestMapping(value = "/preEdit")
	public String preEditRole(Integer roleId, Model model) {
		Role role = null;
		if (roleId != null) {//修改
			role = roleService.getRoleInfoById(roleId);
		} else {//新增
			role = new Role();
		}
		model.addAttribute("role", role);
		return "/system/role/role-add";
	}

	/**
	 * 保存角色信息（id属性值非空进行修改，否则进行新增）
	 * @param role
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午9:37:31
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public JSONObject saveOrUpdate(Role role) {
		return roleService.saveOrUpdate(role);
	}

	/**
	 * 到信息展示页
	 * @param roleId
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月30日下午9:40:58
	 */
	@RequestMapping(value = "/delById")
	@ResponseBody
	public JSONObject delRoleById(Integer roleId) {
		return roleService.delRoleById(roleId);
	}

	/**
	 * 到权限分配页面
	 * @param roleId
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月7日下午8:16:58
	 */
	@RequestMapping(value = "/preAssignPermission")
	public String preAssignPremission(Integer roleId, Model model) {
		try {
			List<Right> rightList = rightService.getAllRight();//查询所有权限
			model.addAttribute("rightList", rightList);
			if (roleId != null) {//查询角色已有权限
				List<RoleRight> roleRightList = roleService.findAllRightByRoleId(roleId);
				model.addAttribute("roleRightList", roleRightList);
			}
		} catch (Exception e) {
			this.logger.error("exception-info", e);
		}
		model.addAttribute("roleId", roleId);
		return "/system/role/assign-permission";
	}

	/**
	 * 保存角色分配的权限
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月8日下午2:18:06
	 */
	@RequestMapping(value = "/assignPermission")
	@ResponseBody
	public JSONObject saveAssignPermission(Integer roleId, String rightIds) {
		return roleService.saveAssignRight(roleId, rightIds);
	}
}
