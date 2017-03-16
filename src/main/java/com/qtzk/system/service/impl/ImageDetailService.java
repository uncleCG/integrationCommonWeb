package com.qtzk.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.qtzk.system.bean.ImageDetail;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.dao.DaoSupport;

@Service("imageDetailService")
public class ImageDetailService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 
	 * @Title: ImageDetailList
	 * @author Eirc
	 * @date 
	 * @Description: 查询列表信息 
	 * @param PageData
	 * @return
	 *
	 */
	public List<ImageDetail> ImageDetailList(PageData pd) {
		List<ImageDetail> list = (List<ImageDetail>) dao.findForList("ImageDetailMapper.ImageDetailList", pd);
		return list;
	}
}
