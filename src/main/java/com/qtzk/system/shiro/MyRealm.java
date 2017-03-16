package com.qtzk.system.shiro;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Right;
import com.qtzk.system.bean.Role;
import com.qtzk.system.bean.User;
import com.qtzk.system.service.UserService;
import com.qtzk.system.utils.Constant;

/**
 * 自定义Realm,进行数据源配置
 * 
 */
@Component
public class MyRealm extends AuthorizingRealm {

	@Resource(name = "userService")
	private UserService userService;

	private Logger logger = LoggerFactory.getLogger(MyRealm.class);

	/**
	 * 登录认证；
	 * 认证回调函数,登录时调用
	 * 首先根据传入的用户名获取User信息；然后如果user为空，那么抛出没找到帐号异常UnknownAccountException；
	 * 如果user找到但锁定了抛出锁定异常LockedAccountException；最后生成AuthenticationInfo信息，
	 * 交给间接父类AuthenticatingRealm使用CredentialsMatcher进行判断密码是否匹配，
	 * 如果不匹配将抛出密码错误异常IncorrectCredentialsException；
	 * 另外如果密码重试此处太多将抛出超出重试次数异常ExcessiveAttemptsException；
	 * 在组装SimpleAuthenticationInfo信息时， 需要传入：身份信息（用户名）、凭据（密文密码）、盐（salt，类似于加密密钥）；
	 * CredentialsMatcher使用盐加密传入的明文密码和此处的密文密码进行匹配。
	 */
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String nickname = (String) token.getPrincipal();
		JSONObject jo = userService.getuserByNickname(nickname);
		Integer resultStatus = jo.getInteger("status");
		User user = null;
		if (resultStatus != null && 1 == resultStatus) {
			user = jo.getObject("data", User.class);
		}
		if (user != null) {
			if (!"1".equals(user.getState())) {
				throw new LockedAccountException(); // 帐号锁定
			}
			// 从数据库查询出来的账号名和密码,与用户输入的账号和密码对比
			// 当用户执行登录时,在方法处理上要实现user.login(token)， 然后会自动进入这个类进行认证
			// 交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配，如果觉得人家的不好可以自定义实现
			SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo( //
					user.getNickname(), // 用户名
					user.getPwd(), // 密码
					getName() // realm name
			);
			//设置加密密钥
			authenticationInfo.setCredentialsSalt(Util.bytes(user.getSalt()));
			// 当验证都通过后，把用户信息放在session里
			Session session = SecurityUtils.getSubject().getSession();
			//获取用户拥有角色列表
			List<Role> roleList = userService.getRoleListByUserId(user.getId());
			user.setRoleList(roleList);
			session.setAttribute("userSession", user);
			session.setAttribute("userSessionId", user.getNickname());
			return authenticationInfo;
		} else {
			throw new UnknownAccountException();// 没找到帐号
		}
	}

	/**
	 * 权限认证；
	 * 每次需要校验权限时都会执行该方法，需要做缓存或其它方式处理
	 * 只有需要验证权限时才会调用, 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.在配有缓存的情况下，只加载一次.
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
		String loginName = SecurityUtils.getSubject().getPrincipal().toString();
		if (loginName != null) {
			User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
			// 权限信息对象info,用来存放查出的用户的所有的角色（role）及权限（permission）
			SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
			// 用户的角色集合
			authorizationInfo.setRoles(currentUser.getRolesDesc());
			// 用户的角色对应的所有权限，如果只使用角色定义访问权限
			List<Right> userRightList = userService.getRightListByUserId(currentUser.getId());
			Set<String> myRightDescSet = new HashSet<String>();
			for (Right right : userRightList) {
				if (StringUtils.isNotEmpty(right.getDescription())) {
					myRightDescSet.add(right.getDescription());
				}
			}
			authorizationInfo.setStringPermissions(myRightDescSet);
			return authorizationInfo;
		}
		return null;
	}

	/**
	 * 设定Password校验的Hash算法与迭代次数.
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(Constant.HASH_ALGORITHM);
		matcher.setHashIterations(Constant.HASH_INTERATIONS);
		setCredentialsMatcher(matcher);
	}

	/**
	 * 更新用户授权信息缓存.
	 */
	public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
		super.clearCachedAuthorizationInfo(principals);
	}

	/**
	 * 更新用户信息缓存.
	 */
	public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
		super.clearCachedAuthenticationInfo(principals);
	}

	/**
	 * 清除用户授权信息缓存.
	 */
	public void clearAllCachedAuthorizationInfo() {
		getAuthorizationCache().clear();
	}

	/**
	 * 清除用户信息缓存.
	 */
	public void clearAllCachedAuthenticationInfo() {
		getAuthenticationCache().clear();
	}

	/**
	 * 清空所有缓存
	 */
	public void clearCache(PrincipalCollection principals) {
		super.clearCache(principals);
	}

	/**
	 * 清空所有认证缓存
	 */
	public void clearAllCache() {
		clearAllCachedAuthenticationInfo();
		clearAllCachedAuthorizationInfo();
	}

}