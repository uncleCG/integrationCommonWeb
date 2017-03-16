package com.qtzk.system.shiro.filter;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.PathMatchingFilter;

import com.qtzk.system.service.UserService;

public class SysUserFilter extends PathMatchingFilter {

	@Resource(name = "userService")
	private UserService userService;

	@Override
	protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {

		String username = (String) SecurityUtils.getSubject().getPrincipal();
		request.setAttribute("user", userService.getuserByNickname(username));
		return true;
	}
}