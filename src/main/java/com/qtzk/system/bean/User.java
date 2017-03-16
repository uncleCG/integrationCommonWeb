package com.qtzk.system.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 用户表 t_user 实体
 *    
 * @author JHONNY
 * @date 2016年5月25日下午2:07:34
 */
public class User {

	private Integer id;
	private String name;
	private Integer portId;
	private String pwd;
	private String nickname;
	private String state;
	private String mobile;
	private String email;
	private Date createdAt;
	private Date updatedAt;
	private String portName;
	/**
	 * 用户拥有角色集合
	 */
	private List<Role> roleList = new ArrayList<Role>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getPortId() {
		return portId;
	}

	public void setPortId(Integer portId) {
		this.portId = portId;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getSalt() {
		return "christ";
	}

	public String getPortName() {
		return portName;
	}

	public void setPortName(String portName) {
		this.portName = portName;
	}

	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}

	/**
	 * 获取用户拥有的角色标识集合
	 * @return   
	 * @author JHONNY
	 * @date 2016年6月2日下午6:30:39
	 */
	public Set<String> getRolesDesc() {
		Set<String> rolesNameSet = new HashSet<String>();
		List<Role> roleList = this.getRoleList();
		for (Role role : roleList) {
			rolesNameSet.add(role.getDescription());
		}
		return rolesNameSet;
	}

}
