package com.qtzk.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.dao.DaoSupport;

@Service(value = "operateLogService")
public class OperateLogService {

	private static final Logger logger = LoggerFactory.getLogger(OperateLogService.class);
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 根据 module 模块类型获取对应的操作记录
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月18日上午11:47:41
	 */
	public List<PageData> getOperateLogPageableByModule(Page page) {
		try {
			return (List<PageData>) dao.findForList("OperateLogMapper.getLogByListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 获取最近一次下架操作记录
	 * @param params
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月19日上午11:25:07
	 */
	public PageData getLastestOperateLogByPd(PageData params) {
		params.put("module", "商户信息管理");
		params.put("operation", "下架");
		PageData logPd = null;
		try {
			logPd = (PageData) dao.findForObject("OperateLogMapper.getLastestSwitchStateLog", params);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return logPd;
	}
}
