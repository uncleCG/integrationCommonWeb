package com.qtzk.system.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 角色表 t_role 实体
 *    
 * @author JHONNY
 * @date 2016年5月25日下午2:07:56
 */
public class Role {

	private Integer id;
	private String name;
	private String description;
	private Date createdAt;
	private Date updatedAt;
	private List<Right> rightList = new ArrayList<Right>();

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public List<Right> getRightList() {
		return rightList;
	}

	public void setRightList(List<Right> rightList) {
		this.rightList = rightList;
	}

	/**
	 * 获取角色对应权限的名称
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月25日下午2:33:08
	 */
	public List<String> getRightsName() {
		List<String> rightsNameList = new ArrayList<String>();
		List<Right> rightList = this.getRightList();
		for (Right right : rightList) {
			rightsNameList.add(right.getName());
		}
		return rightsNameList;
	}

}
