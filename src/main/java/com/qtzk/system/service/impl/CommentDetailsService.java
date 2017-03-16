package com.qtzk.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.User;
import com.qtzk.system.dao.DaoSupport;
import com.qtzk.system.utils.DateUtil;

@Service("commentDetailsService")
public class CommentDetailsService {

	private static final Logger logger = LoggerFactory.getLogger(CommentDetailsService.class);
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 分页获取评论信息
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月18日下午3:29:16
	 */
	public List<PageData> getCommentDetailsListPageable(Page page) {
		try {
			return (List<PageData>) dao.findForList("CommentDetailsMapper.getCommentByListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 审核评论内容
	 * @param pageData
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月1日下午5:53:50
	 */
	public JSONObject authComment(PageData pageData) {
		JSONObject result = new JSONObject();
		User manager = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		if (manager != null) {
			pageData.put("audit_at", manager.getId());//审核人id
			pageData.put("audit_time", DateUtil.getTime());//审核时间
			try {
				int rowNum = (int) dao.update("CommentDetailsMapper.update", pageData);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "");
				} else {
					result.put("status", -2);
					result.put("message", "操作记录异常");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "操作异常");
			}
		} else {
			result.put("status", -2);
			result.put("message", "获取审核人信息异常");
		}
		try {
			PageData logPd = new PageData();
			logPd.put("user_id", manager.getId());
			logPd.put("username", manager.getNickname());
			logPd.put("method", "authComment");
			logPd.put("log_time", DateUtil.getTime());
			logPd.put("module", "评价管理");
			logPd.put("remark", "评价审核");
			logPd.put("record_id", pageData.getString("id"));
			Integer audit = pageData.getInteger("audit");
			if (audit != null && audit == 1) {
				logPd.put("operation", "审核屏蔽");
			} else if (audit != null && audit == 2) {
				logPd.put("operation", "审核通过");
			}
			if (!StringUtils.isEmpty(result.getString("status")) && result.getIntValue("status") == 1) {
				logPd.put("result", "成功");
			} else {
				logPd.put("result", "失败");
			}
			dao.save("OperateLogMapper.insert", logPd);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return result;
	}

	/**
	 * 获取评论信息
	 * @param commentId
	 * @return 获取失败返回null，否则返回PageData对象
	 * @author JHONNY
	 * @date 2016年2月17日下午6:53:25
	 */
	public PageData getCommentdInfoById(String commentId) {
		PageData commentPd = null;
		if (!StringUtils.isEmpty(commentId)) {
			try {
				commentPd = (PageData) dao.findForObject("CommentDetailsMapper.getCommentInfoById", commentId);
			} catch (Exception e) {
				logger.error("exception-info", e);
			}
		}
		return commentPd;
	}
}
