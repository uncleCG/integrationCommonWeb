package com.qtzk.system.service.impl;

import java.text.DecimalFormat;
import java.util.Date;
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
import com.qtzk.system.utils.DateUtil;
import com.qtzk.system.utils.HttpRequestUtil;
import com.qtzk.system.utils.PropertiesUtil;

@Service("daqUserService")
public class DaqUserService {
	private static final Logger logger = LoggerFactory.getLogger(DaqUserService.class);
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 获取市场人员列表
	 * @param page
	 * @return
	 * @author JHONNY
	 * @date 2016年2月24日下午1:59:41
	 */
	public List<PageData> findDaqUserListPage(Page page) {
		List<PageData> daqUserPdList = null;
		try {
			daqUserPdList = (List<PageData>) dao.findForList("DaqUserMapper.findDaqUserListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
			//throw new RuntimeException("获取BD人员列表异常", e);
		}
		return daqUserPdList;
	}

	/**
	 * 获取市场人员详情
	 * @param daqUserPd
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月24日下午2:03:08
	 */
	public PageData getDaqUserDetail(String daqUserId) {
		PageData daqUserPd = null;
		if (!StringUtils.isEmpty(daqUserId)) {
			try {
				daqUserPd = (PageData) dao.findForObject("DaqUserMapper.getDaqUserDetailById", daqUserId);
			} catch (Exception e) {
				logger.error("exception-info", e);
				//throw new RuntimeException("获取BD人员详情异常", e);
			}
		}
		return daqUserPd;
	}

	/**
	 * 保存市场人员id
	 * @param daqUserPd
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月24日下午2:15:34
	 */
	public JSONObject saveOrUpdateDaqUser(PageData daqUserPd) {
		JSONObject result = new JSONObject();
		String daqUserId = daqUserPd.getString("daqUserId");
		try {
			int rowNum = 0;
			if (StringUtils.isEmpty(daqUserId)) {//添加
				daqUserPd.put("passwd", MD5Util.getMD5Str(daqUserPd.getString("mobile").substring(5, 11)));//设置登录密码
				rowNum = (int) dao.save("DaqUserMapper.save", daqUserPd);
				if (rowNum == 1) {//设置 BD 人员编码
					daqUserId = daqUserPd.getString("id");
					//生成二维码
					HttpRequestUtil.sendPost(PropertiesUtil.get("upload.DOMAIN") + "atlas/app/appDaqCreateQrcode", "daqId=" + daqUserId);
					//生成员工编号
					PageData updateDaqUserPd = new PageData();
					updateDaqUserPd.put("daqUserId", daqUserId);
					DecimalFormat df = new DecimalFormat("00000");// 转换方法
					String formatId = df.format(Integer.valueOf(daqUserId));// 5位id，不足5位用零左补齐
					updateDaqUserPd.put("employee_code", formatId);
					dao.update("DaqUserMapper.update", updateDaqUserPd);
				}
			} else {//修改
				String passwd = daqUserPd.getString("passwd");
				if (!StringUtils.isEmpty(passwd)) {//修改密码
					daqUserPd.put("passwd", MD5Util.getMD5Str(daqUserPd.getString(passwd)));
				}
				rowNum = (int) dao.update("DaqUserMapper.update", daqUserPd);
			}
			if (rowNum == 1) {
				result.put("status", 1);
				result.put("message", "");
			} else {
				result.put("status", -2);
				result.put("message", "数据操作记录数异常");
			}
		} catch (Exception e) {
			result.put("status", -2);
			result.put("message", "数据操作异常");
			logger.error("exception-info", e);
		}
		return result;
	}

	/**
	 * 获取daqUser关联数据列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月25日下午3:31:58
	 */
	public List<PageData> getDaqRelateDataList(Page page) {
		List<PageData> carsInfoPdList = null;
		try {
			carsInfoPdList = (List<PageData>) dao.findForList("DaqUserMapper.getDaqRelateDataListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return carsInfoPdList;
	}

	/**
	 * 保存daqUserId关联的车队、商户的关联关系
	 * @param pageData
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月25日下午3:57:40
	 */
	public JSONObject saveRelationship(PageData pageData) {
		JSONObject result = new JSONObject();
		String daqUserId = pageData.getString("daqUserId");
		String operate = pageData.getString("operate");//操作类型标记：1、修改关联车队；2、添加关联车队；3、修改关联商户；4、添加关联商户
		String relateIds = pageData.getString("relateIds");
		if (!StringUtils.isEmpty(daqUserId) && !StringUtils.isEmpty(operate) && !StringUtils.isEmpty(relateIds)) {
			try {
				PageData relationshipPd = new PageData();
				String[] relateIdArr = relateIds.split(",");
				relationshipPd.put("relateIds", relateIdArr);
				relationshipPd.put("daqUserId", daqUserId);
				relationshipPd.put("operate", operate);
				PageData carsInfoPd = new PageData();
				carsInfoPd.put("relateIds", relateIdArr);
				carsInfoPd.put("operate", operate);
				switch (operate) {
				case "1"://修改关联车队
					relationshipPd.put("type", 1);
					dao.save("DaqUserMapper.endDaqRelationship", relationshipPd);
					carsInfoPd.put("daqUserId", null);
					carsInfoPd.put("relevanTime", null);
					dao.update("DaqUserMapper.modifyDaqRelationship", carsInfoPd);
					result.put("status", 1);
					result.put("message", "");
					break;
				case "2"://添加关联车队
					relationshipPd.put("type", 1);
					dao.save("DaqUserMapper.beginDaqRelationship", relationshipPd);
					carsInfoPd.put("daqUserId", daqUserId);
					carsInfoPd.put("relevanTime", DateUtil.getTime());
					dao.update("DaqUserMapper.modifyDaqRelationship", carsInfoPd);
					result.put("status", 1);
					result.put("message", "");
					break;
				case "3"://修改关联签约商户
				case "5"://修改关联跟进商户
					//解除旧关联关系
					relationshipPd.put("type", 2);
					dao.save("DaqUserMapper.endDaqRelationship", relationshipPd);
					carsInfoPd.put("daqUserId", null);
					carsInfoPd.put("relevanTime", null);
					dao.update("DaqUserMapper.modifyDaqRelationship", carsInfoPd);
					//建立新关联关系
					String acceptDaqId = pageData.getString("acceptDaqUserId");
					relationshipPd.put("type", 2);
					relationshipPd.put("daqUserId", acceptDaqId);
					dao.save("DaqUserMapper.beginDaqRelationship", relationshipPd);
					carsInfoPd.put("daqUserId", acceptDaqId);
					carsInfoPd.put("relevanTime", DateUtil.getTime());
					dao.update("DaqUserMapper.modifyDaqRelationship", carsInfoPd);

					result.put("status", 1);
					result.put("message", "");
					break;
				case "4"://添加关联商户
					relationshipPd.put("type", 2);
					dao.save("DaqUserMapper.beginDaqRelationship", relationshipPd);
					carsInfoPd.put("daqUserId", daqUserId);
					carsInfoPd.put("relevanTime", DateUtil.getTime());
					dao.update("DaqUserMapper.modifyDaqRelationship", carsInfoPd);
					result.put("status", 1);
					result.put("message", "");
					break;
				default:
					break;
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据操作异常");
			}
		} else {
			result.put("status", -2);
			result.put("message", "参数异常");
		}
		return result;
	}

	/**
	 * 获取未绑定后台管理员的DaqUser列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月26日上午9:47:30
	 */
	public List<PageData> getUnRelateDaqUserPageable(Page page) {
		List<PageData> daqUserPdList = null;
		try {
			daqUserPdList = (List<PageData>) dao.findForList("DaqUserMapper.getUnRelateDaqUserListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return daqUserPdList;
	}

	/**
	 * 校验手机号是否存在
	 * @param mobile
	 * @return status：1、可用；其它不可用
	 * @author JHONNY
	 * @date 2016年2月26日下午3:36:24
	 */
	public JSONObject isMobileExist(String mobile) {
		JSONObject result = new JSONObject();
		try {
			PageData pageData = (PageData) dao.findForObject("DaqUserMapper.getMobileCount", mobile);
			if (pageData != null && pageData.getInt("rowNum") == 0) {
				result.put("status", 1);//手机号可用
			} else {
				result.put("status", -1);
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
			result.put("status", -2);
		}
		return result;
	}

	/**
	 * 获取所有的商户负责人列表
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月27日下午1:06:10
	 */
	public List<PageData> getAllFollowDaqUserList() {
		List<PageData> followDaqUserList = null;
		try {
			followDaqUserList = (List<PageData>) dao.findForList("DaqUserMapper.getAllFollowDaqUserList", "");
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return followDaqUserList;
	}

	/**
	 * 获取刨除自己之外的所有在职BD用户列表（可接收离职BD跟进商户BD列表）
	 * @param dimissionDaqId 离职BD id
	 * @return   
	 * @author JHONNY
	 * @date 2016年5月13日下午2:11:56
	 */
	public List<PageData> getAcceptDaqUserList(String dimissionDaqId) {
		List<PageData> acceptDaqUserList = null;
		acceptDaqUserList = (List<PageData>) dao.findForList("DaqUserMapper.getAcceptDaqUserList", dimissionDaqId);
		return acceptDaqUserList;
	}

	/**
	 * 获取BD拉新数据
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年4月19日上午11:40:50
	 */
	public List<PageData> geDaqPerformanceListPage(Page page) {
		List<PageData> bdPerformancePdList = null;
		PageData params = page.getPd();
		String beginDate = params.getString("beginDate");
		String endDate = params.getString("endDate");
		if (StringUtils.isEmpty(beginDate)) {
			beginDate = DateUtil.getDay();
			beginDate = beginDate.substring(0, beginDate.length() - 2) + "01";
			params.put("beginDate", beginDate);
		}
		if (StringUtils.isEmpty(endDate)) {
			endDate = DateUtil.getDay();
			params.put("endDate", endDate);
		}
		page.setPd(params);
		bdPerformancePdList = (List<PageData>) dao.findForList("DaqUserMapper.geDaqPerformanceListPage", page);
		return bdPerformancePdList;
	}

	/**
	 * 获取BD拉新统计数对应的数据列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年4月19日下午5:28:16
	 */
	public List<PageData> getDaqPerformanceNumListPage(Page page) {
		String queryType = page.getPd().getString("type");
		List<PageData> dataPdList = null;
		if (StringUtils.isNotEmpty(queryType)) {
			PageData params = page.getPd();
			String beginDate = params.getString("beginDate");
			String endDate = params.getString("endDate");
			if (StringUtils.isEmpty(beginDate)) {
				beginDate = DateUtil.getDay();
				beginDate = beginDate.substring(0, beginDate.length() - 2) + "01";
				params.put("beginDate", beginDate);
			}
			if (StringUtils.isEmpty(endDate)) {
				endDate = DateUtil.getDay();
				params.put("endDate", endDate);
			}
			page.setPd(params);
			dataPdList = (List<PageData>) dao.findForList("DaqUserMapper.getDaqPerformanceNumListPage", page);
			switch (queryType) {
			case "1":
				break;

			default:
				break;
			}
		}
		return dataPdList;
	}

	/**
	 * @method: activityStaticsByDay
	 * @Description: 用户留存统计(按天统计)
	 * @author aquarius
	 * @date 2016年5月12日 下午15:30:59
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> activityStaticsByDay(Page page) {
		List<PageData> staticsResult = null;
		PageData params = page.getPd();
		String beginDate = params.getString("beginDate");
		String endDate = params.getString("endDate");
		String daqUserId = params.getString("daqUserId");

		if (StringUtils.isEmpty(beginDate)) {

			params.put("beginDate", DateUtil.format(DateUtil.addByDate(new Date(), -8), "yyyy-MM-dd"));
		}
		if (StringUtils.isEmpty(endDate)) {

			params.put("endDate", DateUtil.format(DateUtil.addByDate(new Date(), -2), "yyyy-MM-dd"));
		}
		if (StringUtils.isEmpty(daqUserId)) {
			params.put("daqUserId", "0");
		}
		page.setPd(params);
		staticsResult = (List<PageData>) dao.findForList("DaqUserStaticsMapper.dayStaticsListPage", page);
		return staticsResult;
	}

	/**
	 * @method: activityStaticsByWeek
	 * @Description: 用户留存统计(按周统计)
	 * @author aquarius
	 * @date 2016年5月12日 下午15:30:59
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> activityStaticsByWeek(Page page) {
		List<PageData> staticsResult = null;
		PageData params = page.getPd();
		String beginDate = params.getString("beginDate");
		String endDate = params.getString("endDate");
		String daqUserId = params.getString("daqUserId");
		if (StringUtils.isEmpty(beginDate)) {

			params.put("beginDate", DateUtil.format(DateUtil.addByDate(new Date(), -8), "yyyy-MM-dd"));
		}
		if (StringUtils.isEmpty(endDate)) {

			params.put("endDate", DateUtil.format(DateUtil.addByDate(new Date(), -2), "yyyy-MM-dd"));
		}
		if (StringUtils.isEmpty(daqUserId)) {
			params.put("daqUserId", "0");
		}
		page.setPd(params);
		staticsResult = (List<PageData>) dao.findForList("DaqUserStaticsMapper.weekStaticsListPage", page);
		return staticsResult;
	}

	/**
	 * @method: activityStaticsByMonth
	 * @Description: 用户留存统计(按月统计)
	 * @author aquarius
	 * @date 2016年5月12日 下午15:30:59
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> activityStaticsByMonth(Page page) {
		List<PageData> staticsResult = null;
		PageData params = page.getPd();
		String beginDate = params.getString("beginDate");
		String endDate = params.getString("endDate");
		String daqUserId = params.getString("daqUserId");
		if (StringUtils.isEmpty(beginDate)) {

			params.put("beginDate", DateUtil.format(DateUtil.addByDate(new Date(), -8), "yyyy-MM-dd"));
		}
		if (StringUtils.isEmpty(endDate)) {

			params.put("endDate", DateUtil.format(DateUtil.addByDate(new Date(), -2), "yyyy-MM-dd"));
		}
		if (StringUtils.isEmpty(daqUserId)) {
			params.put("daqUserId", "0");
		}
		page.setPd(params);
		staticsResult = (List<PageData>) dao.findForList("DaqUserStaticsMapper.monthStaticsListPage", page);
		return staticsResult;
	}

}
