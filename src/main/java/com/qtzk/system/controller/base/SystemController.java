package com.qtzk.system.controller.base;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.Right;
import com.qtzk.system.bean.Role;
import com.qtzk.system.bean.User;
import com.qtzk.system.service.RightService;
import com.qtzk.system.service.UserService;
import com.qtzk.system.utils.Constant;
import com.qtzk.system.utils.PhoneSmsNodeUtil;
import com.qtzk.system.utils.TreeUtil;

@Controller
@RequestMapping(value = "/")
public class SystemController extends BaseController {

	private final Logger logger = LoggerFactory.getLogger(SystemController.class);

	@Resource(name = "rightService")
	private RightService rightService;

	@Resource(name = "userService")
	private UserService userService;

	/**
	 * 
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月26日上午11:18:14
	 */
	@RequestMapping(value = { "/{login.shtml:login.shtml;?.*}" }, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String toLogin(Model model) {
		model.addAttribute("user", new User());
		return "login";
	}

	// 获取子系统及菜单信息
	@RequestMapping(value = { "/{login.shtml:login.shtml;?.*}" }, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public String toLogin(Model model, String nickname, String password, String checkcode) {
		//		Session session = SecurityUtils.getSubject().getSession();
		HttpSession session = this.getRequest().getSession();
		String exitsCheckCode = (String) session.getAttribute(Constant.CHECKCODE_SESSION_KEY);
		if (!checkcode.equalsIgnoreCase(exitsCheckCode)) {
			model.addAttribute("error", "验证码不正确！");
			return "login";
		}
		/*
		Subject 即“当前操作用户”。但是，在Shiro中，Subject这一概念并不仅仅指人，也可以是第三方进程、后台帐户（Daemon Account）或其他类似事物。
		它仅仅意味着“当前跟软件交互的东西”。但考虑到大多数目的和用途，你可以把它认为是Shiro的“用户”概念。
		 */
		Subject currentUser = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(nickname, password);
		try {
			//			token.setRememberMe(true);
			currentUser.login(token);
		} catch (LockedAccountException lae) {
			token.clear();
			model.addAttribute("error", "用户已经被锁定不能登录，请与管理员联系！");
			return "login";
		} catch (ExcessiveAttemptsException e) {
			token.clear();
			model.addAttribute("error", "账号：" + nickname + " 登录失败次数过多,锁定10分钟!");
			return "login";
		} catch (AuthenticationException e) {
			this.logger.error("exception-info", e);
			token.clear();
			model.addAttribute("error", "用户或密码不正确！");
			return "login";
		}
		return "redirect:index.shtml";
	}

	/**
	 * 登录成功后跳转到主页面
	 * @param model
	 * @return
	 * @throws Exception   
	 * @author JHONNY
	 * @date 2016年5月27日上午10:56:26
	 */
	@RequestMapping("/index.shtml")
	public String loginSuccess(Model model) throws Exception {
		PageData pd = this.getPageData();
		logger.info("parentId #########" + pd.getInteger("parentId"));
		//获取当前用户
		User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		if (currentUser == null) {
			return "login";
		}
		List<Right> list = null;
		if (currentUser.getNickname().equals(Constant.SUPER_ADMIN_NAME)) {
			list = rightService.getAllRight();
		} else {
			//获取当前用户的角色信息
			StringBuffer userRoleIds = new StringBuffer();
			for (Role role : currentUser.getRoleList()) {
				userRoleIds.append(role.getId());
				userRoleIds.append(",");
			}
			if (userRoleIds.length() > 0) {
				userRoleIds.deleteCharAt(userRoleIds.length() - 1);
			}
			list = rightService.getRightByRoleId(userRoleIds.toString());
		}
		TreeUtil treeUtil = new TreeUtil();
		List<Right> ns = treeUtil.getChildRights(list, 1);
		model.addAttribute("menuList", ns);
		model.addAttribute("manager", currentUser);
		return "index";
	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout() {
		// 使用权限管理工具进行用户的退出，注销登录
		SecurityUtils.getSubject().logout(); // session
		// 会销毁，在SessionListener监听session销毁，清理权限缓存
		return "redirect:login.shtml";
	}

	//获取子系统及菜单信息
	@RequestMapping("/getMenuList")
	@ResponseBody
	public String getMenuList(Model model) throws Exception {
		PageData pd = this.getPageData();
		int parentId = pd.getInteger("parentId");
		parentId = parentId == 0 ? 1 : parentId;
		//获取当前用户
		User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		List<Right> list = null;
		if (currentUser.getNickname().equals(Constant.SUPER_ADMIN_NAME)) {
			list = rightService.getAllRight();
		} else {
			//获取当前用户的角色信息
			StringBuffer userRoleIds = new StringBuffer();
			for (Role role : currentUser.getRoleList()) {
				userRoleIds.append(role.getId());
				userRoleIds.append(",");
			}
			if (userRoleIds.length() > 0) {
				userRoleIds.deleteCharAt(userRoleIds.length() - 1);
			}
			list = rightService.getRightByRoleId(userRoleIds.toString());
		}
		TreeUtil treeUtil = new TreeUtil();
		List<Right> ns = treeUtil.getChildRights(list, parentId);
		return JSONArray.toJSONString(ns);
	}

	/**
	 * 权限拒绝后显示的页面
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月12日上午11:43:07
	 */
	@RequestMapping(value = "/permissionRefuse")
	public String permissionRefuse() {
		return "denied";
	}

	/**
	 * 发送手机验短信证码
	 * @param request
	 * @param phoneNum
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月30日上午11:07:00
	 */
	@RequestMapping(value = "/sendSMSCode")
	@ResponseBody
	public JSONObject sendSMSCode(HttpServletRequest request, String phoneNum) {
		JSONObject result = new JSONObject();
		String checkCode = PhoneSmsNodeUtil.sendCode(phoneNum, null);
		logger.debug("checkCode=>" + checkCode + ",phoneNum=>" + phoneNum);
		if (checkCode == "input" || checkCode == "errorNUm") {
			result.put("data", "");
			result.put("status", "-2");
			result.put("message", "手机号有误!");
		} else {
			request.getSession().setAttribute(phoneNum, checkCode);// 把新生成的验证码添加到checkCode上
			result.put("status", "1");
			result.put("message", "");
		}
		return result;
	}

}
