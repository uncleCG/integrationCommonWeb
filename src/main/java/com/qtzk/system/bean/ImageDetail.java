package com.qtzk.system.bean;

import java.util.Date;

public class ImageDetail {

	private Integer id;
	private String source_table;
	private Integer source_id;
	private String type;
	private String image;
	private Date created_at;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSource_table() {
		return source_table;
	}

	public void setSource_table(String source_table) {
		this.source_table = source_table;
	}

	public Integer getSource_id() {
		return source_id;
	}

	public void setSource_id(Integer source_id) {
		this.source_id = source_id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
}
