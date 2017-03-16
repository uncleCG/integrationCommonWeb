package com.qtzk.system.bean;

import java.util.Date;

/**
 * t_role_right 表对应的实体类
 *    
 * @author JHONNY
 * @date 2016年5月31日上午9:38:40
 */
public class RoleRight {

	private Integer id;
	private Integer roleId;
	private Integer rightId;
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

	public Integer getRightId() {
		return rightId;
	}

	public void setRightId(Integer rightId) {
		this.rightId = rightId;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

}
