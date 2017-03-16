package com.qtzk.system.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.User;
import com.qtzk.system.controller.base.BaseController;
import com.qtzk.system.service.RoleService;
import com.qtzk.system.service.UserService;
import com.qtzk.system.utils.Digests;

@Controller
@RequestMapping(value = "/managerController")
public class ManagerController extends BaseController {

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "roleService")
	private RoleService roleService;

	/**
	 * 分页获取用户列表
	 * @param model
	 * @param page
	 * @return
	 * @throws Exception   
	 * @author JHONNY
	 * @date 2016年6月1日上午10:09:34
	 */
	@RequestMapping(value = "/getManagerList")
	public String getUserList(Model model, Page page) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<User> userList = userService.getUserListPage(page);
		model.addAttribute("page", page);
		model.addAttribute("list", userList);
		return "/system/manager/manager-list";
	}

	/**
	 * 根据id删除对应数据
	 * @param userId
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月1日上午10:58:47
	 */
	@RequestMapping(value = "/delById")
	@ResponseBody
	public JSONObject delManagerById(Integer userId) {
		return userService.delUserById(userId);
	}

	/**
	 * 根据id获取用户详情
	 * @param userId
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月1日上午11:14:01
	 */
	@RequestMapping(value = "/preEdit")
	public String getUserInfoById(Integer userId, Model model) {
		User user = null;
		if (userId != null) {//修改
			user = userService.getUserById(userId);
		} else {//新增
			user = new User();
		}
		model.addAttribute("manager", user);
		// 获取管理员角色
		model.addAttribute("roleList", roleService.findAllRole());
		//获取可用港口
		return "/system/manager/manager-add";
	}

	/**
	 * 保存信息（id 属性值为空，执行新增，否则更新）
	 * @param user
	 * @param request
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月1日上午11:14:34
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public JSONObject saveOrUpdate(User user, HttpServletRequest request) {
		JSONObject result = null;
		try {
			result = userService.saveOrUpdateUser(user, request);
		} catch (Exception e) {
			result = new JSONObject();
			result.put("status", "-2");
			result.put("message", "操作异常，请稍候重试");
		}
		return result;
	}

	/**
	 * 修改个人信息跳转页面
	 * @param userId
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月1日上午11:38:29
	 */
	@RequestMapping(value = "/preEditPwd")
	public String preEditPwd(String userId, Model model) {
		try {
			Integer.valueOf(userId);
		} catch (Exception e) {
			model.addAttribute("error", "User Id 异常");
		}
		model.addAttribute("userId", userId);
		return "/system/manager/manager-edit-pwd";
	}

	/**
	 * 更新用户基本信息（不涉及关联表业务处理）
	 * @param user
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月4日下午3:49:23
	 */
	@RequestMapping(value = "/editUserBase")
	@ResponseBody
	public JSONObject editUserBase(User user, String oldpwd) {
		JSONObject result = null;
		try {
			if (StringUtils.isNotEmpty(oldpwd)) {
				//修改密码
				User dbUser = userService.getUserById(user.getId());
				String encryptOldpwd = Digests.encryptPassword(oldpwd, user.getSalt());
				//比较加密后的旧密码是否和数据库一致，不一致则返回修改页面
				if (!encryptOldpwd.equals(dbUser.getPwd())) {
					result = new JSONObject();
					result.put("status", "-1");
					result.put("message", "旧密码输入错误");
					return result;
				}
			}

			result = userService.editUserBase(user);
		} catch (Exception e) {
			result = new JSONObject();
			result.put("status", "-2");
			result.put("message", "操作异常，请稍候重试");
		}
		return result;
	}

}
