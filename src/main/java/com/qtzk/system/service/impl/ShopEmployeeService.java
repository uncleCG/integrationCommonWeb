package com.qtzk.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.dao.DaoSupport;

@Service(value = "shopEmployeeService")
public class ShopEmployeeService {

	private static final Logger logger = LoggerFactory.getLogger(ShopEmployeeService.class);
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 获取商户员工信息
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月18日下午9:03:13
	 */
	public List<PageData> getShopEmployeePageable(Page page) {
		try {
			return (List<PageData>) dao.findForList("ShopEmployeeMapper.getEmployeeByListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 根据员工id获取员工在签约页面需要展示的信息
	 * @param employeeId
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月21日上午10:51:51
	 */
	public PageData getEmployeeSignInfoById(String employeeId) {
		try {
			return (PageData) dao.findForObject("ShopEmployeeMapper.getDetailById", employeeId);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 翻页获取所有商户管理员信息
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月22日下午4:13:25
	 */
	public List<PageData> getShopkeeperPageable(Page page) {
		try {
			return (List<PageData>) dao.findForList("ShopEmployeeMapper.getShopkeeperByListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 校验手机号是否存在
	 * @param nowMobile
	 * @return  status = 1 可以使用，否则不可用
	 * @author JHONNY
	 * @date 2016年1月25日上午11:43:57
	 */
	public JSONObject checkShopkeeperMobile(String nowMobile) {
		JSONObject result = new JSONObject();
		try {
			PageData pd = (PageData) dao.findForObject("ShopEmployeeMapper.getMobileNum", nowMobile);
			if (pd.getInteger("mobileNum") == 0) {
				result.put("status", 1);//可以使用
			} else {
				result.put("status", -1);
				result.put("shopkeeperId", pd.getInt("id"));
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
			result.put("status", -2);
		}
		return result;
	}

	/**
	 * 新增
	 * @param employeePd
	 * @return 返回操作影响记录数
	 * @author JHONNY
	 * @date 2016年2月29日下午6:34:13
	 */
	public int insertEmployee(PageData employeePd) {
		int rowNum = 0;
		try {
			rowNum = (int) dao.save("ShopEmployeeMapper.insert-employee", employeePd);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return rowNum;
	}

	/**
	 * 获取商户员工列表（关联商户）
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日下午5:44:18
	 */
	public List<PageData> getEmployeeListPage(Page page) {
		List<PageData> employeePdList = null;
		employeePdList = (List<PageData>) dao.findForList("ShopEmployeeMapper.getEmployeeListPage", page);
		return employeePdList;
	}

	/**
	 * 分页获取卖家列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月30日下午6:28:43
	 */
	public List<PageData> getSellerList(Page page) {
		List<PageData> list = (List<PageData>) dao.findForList("ShopEmployeeMapper.getSellerListPage", page);
		return list;
	}

	/**
	 * 根据id获取其详细信息
	 * @param id
	 * @return   
	 * @author Eric
	 * @date 2016年1月6日下午7:22:13
	 */
	public PageData getById(String id) {
		PageData shopEmployeePd = null;
		if (StringUtils.isNotEmpty(id)) {
			shopEmployeePd = (PageData) this.dao.findForObject("ShopEmployeeMapper.getById", id);
		}
		return shopEmployeePd;
	}

	/**
	 * 更新商户信息
	 * @param employeePd
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月31日下午2:36:20
	 */
	public int updateEmployee(PageData employeePd) {
		int rowNum = 0;
		try {
			rowNum = (int) dao.save("ShopEmployeeMapper.updateEmployee", employeePd);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return rowNum;
	}

}
