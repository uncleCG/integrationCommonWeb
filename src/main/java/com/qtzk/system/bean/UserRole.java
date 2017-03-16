package com.qtzk.system.bean;

import java.util.Date;

/**
 * t_user_role 表对应的实体类
 *    
 * @author JHONNY
 * @date 2016年6月1日下午12:00:23
 */
public class UserRole {

	private Integer id;
	private Integer userId;
	private Integer roleId;
	private Date createdAt;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

}
