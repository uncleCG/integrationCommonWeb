package com.qtzk.system.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.Right;
import com.qtzk.system.dao.DAO;
import com.qtzk.system.service.RightService;

/**
 * 权限相关业务接口实现类
 *    
 * @author JHONNY
 * @date 2016年5月27日下午1:56:21
 */
@Service(value = "rightService")
public class RightServiceImpl implements RightService {

	private Logger logger = LoggerFactory.getLogger(RightServiceImpl.class);

	@Resource(name = "daoSupport")
	private DAO dao;

	@Override
	public List<Right> getRightByRoleId(String roleId) {
		List<Right> rightList = new ArrayList<Right>();
		if (StringUtils.isNotEmpty(roleId)) {
			PageData rolePd = new PageData();
			rolePd.put("roleIds", roleId);
			rightList = (List<Right>) dao.findForList("RightMapper.getRightByRoleId", rolePd);
		}
		return rightList;
	}

	@Override
	public List<Right> getAllRight() {
		List<Right> rightList = (List<Right>) dao.findForList("RightMapper.findAllRight", "");
		return rightList;
	}

	@Override
	public JSONObject saveOrUpdateRight(Right right) {
		JSONObject result = new JSONObject();
		try {
			if (right.getId() != null) {//修改
				int rowNum = (int) dao.update("RightMapper.update", right);
				if (rowNum == 1) {
					result.put("status", "1");
					result.put("message", "操作成功");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			} else {//增加
				int rowNum = (int) dao.save("RightMapper.insert", right);
				if (rowNum == 1) {
					result.put("status", "1");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			}
		} catch (Exception e) {
			logger.error("保存权限异常", e);
			result.put("status", "-2");
			result.put("message", "数据操作异常，请稍候重试");
		}
		return result;
	}

	@Override
	public JSONObject delRightById(int rightId) {
		JSONObject result = new JSONObject();
		try {
			int rowNum = (int) dao.delete("RightMapper.delRightById", rightId);
			if (rowNum == 1) {
				result.put("status", "1");
				result.put("message", "操作成功");
			} else {
				result.put("status", "-2");
				result.put("message", "执行结果异常，请稍候重试");
			}
		} catch (Exception e) {
			logger.error("删除权限异常", e);
			result.put("status", "-2");
			result.put("message", "数据操作异常，请稍候重试");
		}
		return result;
	}

	@Override
	public Right getRightById(int rightId) {
		Right right = null;
		right = (Right) dao.findForObject("RightMapper.getRightById", rightId);
		return right;
	}

}
