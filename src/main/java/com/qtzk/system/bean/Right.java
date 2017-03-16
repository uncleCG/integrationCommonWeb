package com.qtzk.system.bean;

import java.util.Date;
import java.util.List;

/**
 * 权限表 t_permission 实体
 *    
 * @author JHONNY
 * @date 2016年5月25日下午2:08:32
 */
public class Right {

	private Integer id;
	private String name;
	private String description;
	private String link;
	private Integer parentId;
	private Integer type;
	private Integer seqnum;
	private int state;
	private Date createdAt;
	private Date updatedAt;
	//子级菜单
	private List<Right> children;

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

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSeqnum() {
		return seqnum;
	}

	public void setSeqnum(Integer seqnum) {
		this.seqnum = seqnum;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
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

	public List<Right> getChildren() {
		return children;
	}

	public void setChildren(List<Right> children) {
		this.children = children;
	}

}
