package com.qtzk.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.ShopBill;
import com.qtzk.system.bean.User;
import com.qtzk.system.dao.DaoSupport;
import com.qtzk.system.utils.DateUtil;

@Service("shopService")
public class ShopService {

	private static final Logger logger = LoggerFactory.getLogger(ShopService.class);

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 翻页获取列表页数据
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月13日下午5:12:24
	 */
	public List<PageData> findByListPage(Page page) {
		List<PageData> pdList = null;
		try {
			pdList = (List<PageData>) dao.findForList("ShopMapper.findByListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return pdList;
	}

	/**
	 * 获取所有一级服务类型列表
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月14日下午8:26:54
	 */
	public List<PageData> findAllOneServiceType() {
		List<PageData> pdList = null;
		try {
			pdList = (List<PageData>) dao.findForList("ShopMapper.findAllOneServiceType", "");
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return pdList;
	}

	/**
	 * 获取所有二级服务类型列表
	 * @return   List<Map<parentId,List<Map<id,name>>>>
	 * @author JHONNY
	 * @date 2016年1月14日下午8:26:54
	 */
	public Map<Integer, List<Map<String, Object>>> findAllTwoServiceType() {
		Map<Integer, List<Map<String, Object>>> twoServiceTypeMap = null;
		try {
			List<PageData> pdList = (List<PageData>) dao.findForList("ShopMapper.findAllTwoServiceType", "");
			twoServiceTypeMap = new HashMap<Integer, List<Map<String, Object>>>();
			int parentId = 0;
			List<Map<String, Object>> tmpTwoServiceTypeList = null;
			for (PageData pageData : pdList) {
				if (parentId != pageData.getInt("parentId")) {
					//一组新二级服务类型开始，初始化
					parentId = pageData.getInt("parentId");
					tmpTwoServiceTypeList = new ArrayList<Map<String, Object>>();
					twoServiceTypeMap.put(parentId, tmpTwoServiceTypeList);
				}
				Map<String, Object> tmpMap = new HashMap<String, Object>();
				tmpMap.put("id", pageData.getInt("id"));
				tmpMap.put("name", pageData.getString("name"));
				tmpTwoServiceTypeList.add(tmpMap);
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return twoServiceTypeMap;
	}

	/**
	 * 获取所有品牌列表
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月15日下午3:50:30
	 */
	public List<PageData> findAllBrand() {
		List<PageData> pdList = null;
		try {
			pdList = (List<PageData>) dao.findForList("ShopMapper.findAllBrand", "");
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return pdList;
	}

	/**
	 * 保存商户信息
	 * @param request
	 * @param shopPd
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月16日下午3:34:04
	 */
	public JSONObject saveOrUpdateShopBase(HttpServletRequest request, PageData shopPd) {
		JSONObject result = new JSONObject();
		String[] oneServiceTypeArr = request.getParameterValues("oneServiceType");
		String[] twoServiceTypeArr = request.getParameterValues("twoServiceType");
		//获取当前用户
		User manager = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		shopPd.put("gatherer_id", manager.getId());
		//设置操作日志基本信息
		PageData logPd = new PageData();
		logPd.put("user_id", manager.getId());
		logPd.put("username", manager.getNickname());
		logPd.put("method", "saveOrUpdateShopBase");
		logPd.put("log_time", DateUtil.getTime());
		logPd.put("module", "商户信息管理");
		String province = shopPd.getString("province");
		if ("省份".equals(province)) {
			shopPd.put("province", null);
		}
		String city = shopPd.getString("city");
		if ("地级市".equals(city)) {
			shopPd.put("city", null);
		}
		String district = shopPd.getString("district");
		if ("市、县级市".equals(district)) {
			shopPd.put("district", null);
		}
		String confirmMoney = shopPd.getString("confirm_money");
		if (StringUtils.isEmpty(confirmMoney)) {
			shopPd.put("confirm_money", "0.00");
		}
		String contractBeginTime = shopPd.getString("contract_begin_time");
		if (StringUtils.isEmpty(contractBeginTime)) {
			shopPd.put("contract_begin_time", null);
		}
		String contractEndTime = shopPd.getString("contract_end_time");
		if (StringUtils.isEmpty(contractEndTime)) {
			shopPd.put("contract_end_time", null);
		}

		String shopkeeperTypeVal = shopPd.getString("shopkeeperType");
		// 保存
		if ("1".equals(shopkeeperTypeVal) && StringUtils.isEmpty(shopPd.getString("shopkeeper_id"))) {
			//新建管理人
			PageData shopkeeperPd = new PageData();
			shopkeeperPd.put("name", shopPd.getString("shopkeeper_name"));
			shopkeeperPd.put("mobile", shopPd.getString("shopkeeper_mobile"));
			shopkeeperPd.put("idcard", shopPd.getString("shopkeeper_idcard"));
			String idcardImg1 = shopPd.getString("idcard_img1");
			if (StringUtils.isNotEmpty(idcardImg1)) {
				shopkeeperPd.put("idcard_img1", idcardImg1);
			}
			String idcardImg2 = shopPd.getString("idcard_img2");
			if (!StringUtils.isEmpty(idcardImg2)) {
				shopkeeperPd.put("idcard_img2", idcardImg2);
			}
			shopkeeperPd.put("state", "1");
			shopkeeperPd.put("is_owner", "1");
			shopkeeperPd.put("created_at", DateUtil.getTime());
			shopkeeperPd.put("updated_at", DateUtil.getTime());
			dao.save("ShopEmployeeMapper.insert-employee", shopkeeperPd);
			//设置新增管理人id
			shopPd.put("shopkeeper_id", shopkeeperPd.getString("id"));
		} else if ("1".equals(shopkeeperTypeVal) && StringUtils.isNotEmpty(shopPd.getString("shopkeeper_id"))) {
			//修改管理人信息
			PageData shopkeeperPd = new PageData();
			shopkeeperPd.put("updated_at", DateUtil.getTime());
			shopkeeperPd.put("name", shopPd.getString("shopkeeper_name"));
			shopkeeperPd.put("mobile", shopPd.getString("shopkeeper_mobile"));
			shopkeeperPd.put("idcard", shopPd.getString("shopkeeper_idcard"));
			shopkeeperPd.put("id", shopPd.getString("shopkeeper_id"));
			String idcardImg1 = shopPd.getString("idcard_img1");
			if (StringUtils.isNotEmpty(idcardImg1)) {
				shopkeeperPd.put("idcard_img1", idcardImg1);
			}
			String idcardImg2 = shopPd.getString("idcard_img2");
			if (!StringUtils.isEmpty(idcardImg2)) {
				shopkeeperPd.put("idcard_img2", idcardImg2);
			}
			dao.update("ShopEmployeeMapper.updateEmployee", shopkeeperPd);
		} else {
			//关联管理人
		}

		if (StringUtils.isNotEmpty(shopPd.getString("shopId"))) {
			//修改
			try {
				dao.delete("ShopMapper.clear-shop-relationship", shopPd.getString("shopId"));
				int rowNum = (int) dao.update("ShopMapper.update", shopPd);
				logPd.put("operation", "信息修改");
				logPd.put("record_id", shopPd.getString("shopId"));
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "");
					result.put("shopId", shopPd.getString("shopId"));
					logPd.put("result", "成功");
					String oldShopkeeperId = shopPd.getString("oldShopkeeperId");
					if (StringUtils.isNotEmpty(oldShopkeeperId)) {
						//修改商户信息时，将首家店管理人关联为其它人，须更新原管理人首家店（shop_employee 的 shop_id）
						dao.update("ShopEmployeeMapper.changeFisrtShop", oldShopkeeperId);
					}
				} else {
					result.put("status", -2);
					result.put("message", "数据操作异常");
					logPd.put("result", "失败");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据库操作异常");
				logPd.put("result", "失败");
				throw new RuntimeException(e);
			}
		} else {
			//新增
			try {
				shopPd.put("state", -6);
				int rowNum = (int) dao.save("ShopMapper.insert-base", shopPd);
				logPd.put("operation", "信息添加");
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "");
					result.put("shopId", shopPd.getString("shopId"));//获取新增商户id
					if ("1".equals(shopkeeperTypeVal)) {
						PageData updateShopkeeperPd = new PageData();
						updateShopkeeperPd.put("id", shopPd.getString("shopkeeper_id"));
						updateShopkeeperPd.put("shop_id", shopPd.getString("shopId"));
						//更新新增管理人关联的商户id
						dao.update("ShopEmployeeMapper.updateEmployee", updateShopkeeperPd);
					}
					//记录操作日志
					logPd.put("result", "成功");
					logPd.put("record_id", shopPd.getString("shopId"));
				} else {
					result.put("status", -2);
					result.put("message", "数据操作异常");
					logPd.put("result", "失败");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据库操作异常");
				logPd.put("result", "失败");
				throw new RuntimeException(e);
			}
		}
		if (1 == result.getIntValue("status")) {
			try {
				//设置商户和一、二级服务项目及品牌的关联关系（shop_service_type，type：0、服务类型；1、品牌； 2、服务标签；）
				String shopId = shopPd.getString("shopId");
				if (oneServiceTypeArr != null) {
					PageData oneServiceTypePd = new PageData();
					oneServiceTypePd.put("shopId", shopId);
					oneServiceTypePd.put("type", 0);
					oneServiceTypePd.put("valArr", oneServiceTypeArr);
					dao.save("ShopMapper.insert-shop-relationship", oneServiceTypePd);
				}
				if (twoServiceTypeArr != null) {
					PageData twoServiceTypePd = new PageData();
					twoServiceTypePd.put("shopId", shopId);
					twoServiceTypePd.put("type", 2);
					twoServiceTypePd.put("valArr", twoServiceTypeArr);
					dao.save("ShopMapper.insert-shop-relationship", twoServiceTypePd);
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据库操作异常");
				throw new RuntimeException(e);
			}
			//记录操作日志
			dao.save("OperateLogMapper.insert", logPd);
		}
		return result;
	}

	/**
	 * 根据商户id获取商户基本信息
	 * @param shopId
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月16日下午5:29:25
	 */
	public PageData findShopBaseById(String shopId) {
		PageData shopPd = null;
		try {
			shopPd = (PageData) dao.findForObject("ShopMapper.getBaseById", shopId);
			List<PageData> pdList = (List<PageData>) dao.findForList("ShopMapper.find-shop-relationship", shopId);
			List<Integer> oneServiceTypeIds = new ArrayList<>();
			List<Integer> twoServiceTypeIds = new ArrayList<>();
			List<Integer> brandIds = new ArrayList<>();
			for (PageData tmpPd : pdList) {
				//处理商户的一二级服务类型及品牌关联关系
				Integer type = tmpPd.getInteger("type");
				Integer relationshipId = tmpPd.getInt("service_type_id");
				switch (type) {
				case 0:
					oneServiceTypeIds.add(relationshipId);
					break;
				case 1:
					brandIds.add(relationshipId);
					break;
				case 2:
					twoServiceTypeIds.add(relationshipId);
					break;
				default:
					break;
				}
			}
			shopPd.put("oneServiceTypeIds", oneServiceTypeIds);
			shopPd.put("twoServiceTypeIds", twoServiceTypeIds);
			shopPd.put("brandIds", brandIds);
			//处理商户联系电话
			String shopLinkTel = shopPd.getString("link_tel");
			if (!StringUtils.isEmpty(shopLinkTel)) {
				String[] linkTels = shopLinkTel.split(",");
				List<String> otherLinkTels = new ArrayList<String>();
				for (int i = 0; i < linkTels.length; i++) {
					if (i == 0) {
						shopPd.put("firstLinkTel", linkTels[0]);
					} else {
						otherLinkTels.add(i - 1, linkTels[i]);
					}
				}
				shopPd.put("otherLinkTels", otherLinkTels);
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return shopPd;
	}

	/**
	 * 根据商户id获取指定类型的关联关系
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月17日下午4:15:52
	 */
	public List<PageData> getShopRelationshipByShopIdAndType(PageData params) {
		List<PageData> pdList = null;
		try {
			pdList = (List<PageData>) dao.findForList("ShopMapper.getShopRelationShopByIdAndType", params);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return pdList;
	}

	/**
	 * 根据管理者id获取商户信息
	 * @return   
	 * @author Eric
	 * @date 2016年1月17日下午4:15:52
	 */
	public List<PageData> getShopInfoList(PageData params) {
		List<PageData> pdList = null;
		try {
			pdList = (List<PageData>) dao.findForList("ShopMapper.getShopInfoList", params);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return pdList;
	}

	/**
	 * 切换商户上下架状态
	 * @param params
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月19日下午3:47:09
	 */
	public JSONObject switchState(PageData params) {
		JSONObject result = new JSONObject();
		params.put("updated_at", DateUtil.getTime());
		PageData logPd = new PageData();
		User manager = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		logPd.put("user_id", manager.getId());
		logPd.put("username", manager.getNickname());
		logPd.put("module", "商户信息管理");
		String type = params.getString("type");
		if (!StringUtils.isEmpty(type))
			switch (type) {
			case "1":
				//基本信息上架
				logPd.put("operation", "信息上架");
				params.put("state", "1");
				break;
			case "2":
				//基本信息下架
				logPd.put("operation", "信息下架");
				params.put("state", "0");
				dao.update("ShopEmployeeMapper.clearToken", params.getString("shopId"));
				break;
			case "3"://签约信息上架
				logPd.put("operation", "签约信息_上架");
				params.put("sign_status", "1");
				break;
			case "4":
				//签约信息下架
				logPd.put("operation", "签约信息_下架");
				params.put("sign_status", "0");
				break;
			default:
				break;
			}
		logPd.put("record_id", params.getString("shopId"));
		logPd.put("method", "switchState");
		logPd.put("log_time", DateUtil.getTime());
		logPd.put("remark", params.getString("remark"));
		params.remove("remark");
		//上下架备注不更新到商户介绍里，只保存到操作记录表中
		try {
			int rowNum = (int) dao.update("ShopMapper.update", params);
			if (rowNum == 1) {
				result.put("status", 1);
				result.put("message", "");
				logPd.put("result", "成功");
			} else {
				result.put("status", -2);
				result.put("message", "数据操作异常");
				logPd.put("result", "失败");
				throw new RuntimeException();
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
			result.put("status", -2);
			result.put("message", "数据库操作异常");
			logPd.put("result", "失败");
			throw new RuntimeException();
		}
		try {
			dao.save("OperateLogMapper.insert", logPd);
		} catch (Exception e) {
			logger.error("exception-info", e);
			throw new RuntimeException();
		}
		return result;
	}

	/**
	 * 翻页获取商户交易记录
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月19日下午5:28:55
	 */
	public List<ShopBill> getTradeRecordPageable(Page page) {
		try {
			return (List<ShopBill>) dao.findForList("ShopBillMapper.shopBillListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 获取指定交易记录详情
	 * @param recordId
	 * @return 
	 * @author JHONNY
	 * @date 2016年1月20日上午11:05:27
	 */
	public PageData getTradeRecordDetail(String recordId) {
		try {
			return (PageData) dao.findForObject("ShopBillMapper.getRecordDetailById", recordId);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 获取指定id优惠券信息
	 * @param couponId
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月20日上午11:20:24
	 */
	public PageData getCouponInfoById(String couponId) {
		try {
			return (PageData) dao.findForObject("CouponInfoMapper.getCouponInfoDetailById", couponId);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 根据商户id获取商户在签约页面显示的基本信息
	 * @param shopId
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月20日下午7:03:41
	 */
	public PageData getShopRebateBaseByShopId(String shopId) {
		try {
			return (PageData) dao.findForObject("ShopMapper.getShopRebateBaseById", shopId);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 根据商户id获取商户在签约页面的返利设置信息
	 * @param shopId
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月20日下午7:10:13
	 */
	public List<PageData> getShopRebateByShopId(String shopId) {
		try {
			return (List<PageData>) dao.findForList("ShopRebateMapper.getShopRebateByShopId", shopId);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return null;
	}

	/**
	 * 保存商户签约信息
	 * @param request
	 * @param pageData   
	 * @author JHONNY
	 * @date 2016年1月23日下午4:52:50
	 */
	public JSONObject saveOrUpdateShopRebate(HttpServletRequest request) {
		JSONObject result = new JSONObject();
		User manager = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		String shopkeeperType = request.getParameter("shopkeeperType");
		//管理人方式
		String shopId = request.getParameter("shopId");
		if (StringUtils.isEmpty(shopkeeperType)) {
			shopkeeperType = "1";
		}
		PageData dbShopBasePd = null;
		String signBtnType = request.getParameter("signBtnType");
		//操作类型
		String moduleType = request.getParameter("moduleType");
		//数据来源
		try {
			dbShopBasePd = (PageData) dao.findForObject("ShopMapper.getBaseById", shopId);
			String type1 = request.getParameter("type1");
			String srId1 = request.getParameter("id1");
			PageData sr1Pd = new PageData();
			//存放普通消费配置信息
			sr1Pd.put("shop_id", shopId);

			if (type1 != null) {
				//普通消费
				String state1 = request.getParameter("state1");
				//返现模式
				String consumeType1 = request.getParameter("consume_type1");
				//使用余额
				String useBalance1 = request.getParameter("use_balance1");
				//使用优惠券
				String useCoupon1 = request.getParameter("use_coupon1");
				//使用充值卡
				String useCard1 = request.getParameter("use_card1");

				//返现比
				//最小返现比，小数
				String rebatePercent1 = request.getParameter("rebate_percent1");
				//最大返现比，小数
				String maxRebatePercent1 = request.getParameter("max_rebate_percent1");
				//最低消费额
				String minConsumeAmount1 = request.getParameter("min_consume_amount1");
				//定额返
				//最高返现额
				String maxNormAmount1 = request.getParameter("max_norm_amount1");
				//最低消费额
				String minNormConsumeAmount1 = request.getParameter("min_norm_consume_amount1");
				//擎天币
				//比例
				String pointsPercent1 = request.getParameter("points_percent1");
				//定额
				String normPoints1 = request.getParameter("norm_points1");
				//最高奖励
				String rebateMaxPoints1 = request.getParameter("rebate_max_points1");
				//最低消费额
				String pointsMinMoney1 = request.getParameter("points_min_money1");

				String strNowTime = DateUtil.getTime();
				sr1Pd.put("updated_at", strNowTime);
				sr1Pd.put("consume_type", consumeType1);
				//返现比
				if (!StringUtils.isEmpty(rebatePercent1)) {
					sr1Pd.put("rebate_percent", rebatePercent1);
				} else {
					sr1Pd.put("rebate_percent", "0.0");
				}
				if (!StringUtils.isEmpty(maxRebatePercent1)) {
					sr1Pd.put("max_rebate_percent", maxRebatePercent1);
				} else {
					sr1Pd.put("max_rebate_percent", "0.0");
				}
				if (!StringUtils.isEmpty(minConsumeAmount1)) {
					sr1Pd.put("min_consume_amount", minConsumeAmount1);
				} else {
					sr1Pd.put("min_consume_amount", "0.0");
				}
				//定额
				if (!StringUtils.isEmpty(minNormConsumeAmount1)) {
					sr1Pd.put("min_norm_consume_amount", minNormConsumeAmount1);
				} else {
					sr1Pd.put("min_norm_consume_amount", "0.0");
				}
				if (!StringUtils.isEmpty(maxNormAmount1)) {
					sr1Pd.put("max_norm_amount", maxNormAmount1);
				} else {
					sr1Pd.put("max_norm_amount", "0.0");
				}
				//擎天币
				if (!StringUtils.isEmpty(pointsPercent1)) {
					sr1Pd.put("points_percent", pointsPercent1);
				} else {
					sr1Pd.put("points_percent", "0.0");
				}
				if (!StringUtils.isEmpty(normPoints1)) {
					sr1Pd.put("norm_points", normPoints1);
				} else {
					sr1Pd.put("norm_points", "0");
				}
				if (!StringUtils.isEmpty(rebateMaxPoints1)) {
					sr1Pd.put("rebate_max_points", rebateMaxPoints1);
				} else {
					sr1Pd.put("rebate_max_points", "0");
				}
				if (!StringUtils.isEmpty(pointsMinMoney1)) {
					sr1Pd.put("points_min_money", pointsMinMoney1);
				} else {
					sr1Pd.put("points_min_money", "0");
				}
				//余额、优惠券、充值卡设置
				if (!StringUtils.isEmpty(useBalance1)) {
					sr1Pd.put("use_balance", "1");
				} else {
					sr1Pd.put("use_balance", "0");
				}
				if (!StringUtils.isEmpty(useCoupon1)) {
					sr1Pd.put("use_coupon", "1");
				} else {
					sr1Pd.put("use_coupon", "0");
				}
				if (!StringUtils.isEmpty(useCard1)) {
					sr1Pd.put("use_card", "1");
				} else {
					sr1Pd.put("use_card", "0");
				}
				sr1Pd.put("state", state1);
				if (!StringUtils.isEmpty(srId1)) {
					//修改
					sr1Pd.put("id", srId1);
					dao.update("ShopRebateMapper.update", sr1Pd);
				} else {
					//新增
					sr1Pd.put("created_at", strNowTime);
					dao.save("ShopRebateMapper.insert", sr1Pd);
				}
			} else {
				//未启用配置 
				if (!StringUtils.isEmpty(srId1)) {
					//由启用修改为禁用（state = 0）
					sr1Pd.put("id", srId1);
					sr1Pd.put("state", "0");
					dao.update("ShopRebateMapper.update", sr1Pd);
				}
			}
			String type2 = request.getParameter("type2");
			String srId2 = request.getParameter("id2");
			//存放预付消费配置信息
			PageData sr2Pd = new PageData();
			sr2Pd.put("shop_id", shopId);
			if (type2 != null) {
				//预付消费
				String state2 = request.getParameter("state2");
				//返现模式
				String consumeType2 = request.getParameter("consume_type2");
				//使用余额
				String useBalance2 = request.getParameter("use_balance2");
				//使用优惠券
				String useCoupon2 = request.getParameter("use_coupon2");
				//使用充值卡
				String useCard2 = request.getParameter("use_card2");
				//返现比
				//最小返现比，小数
				String rebatePercent2 = request.getParameter("rebate_percent2");
				//最大返现比，小数
				String maxRebatePercent2 = request.getParameter("max_rebate_percent2");
				//最低消费额
				String minConsumeAmount2 = request.getParameter("min_consume_amount2");
				//定额返
				//最高返现额
				String maxNormAmount2 = request.getParameter("max_norm_amount2");
				//最低消费额
				String minNormConsumeAmount2 = request.getParameter("min_norm_consume_amount2");
				//擎天币
				//比例
				String pointsPercent2 = request.getParameter("points_percent2");
				//定额
				String normPoints2 = request.getParameter("norm_points2");
				//最高奖励
				String rebateMaxPoints2 = request.getParameter("rebate_max_points2");
				//最低消费额
				String pointsMinMoney2 = request.getParameter("points_min_money2");

				String strNowTime = DateUtil.getTime();
				sr2Pd.put("updated_at", strNowTime);
				sr2Pd.put("consume_type", consumeType2);
				//返现比
				if (!StringUtils.isEmpty(rebatePercent2)) {
					sr2Pd.put("rebate_percent", rebatePercent2);
				} else {
					sr2Pd.put("rebate_percent", "0.0");
				}
				if (!StringUtils.isEmpty(maxRebatePercent2)) {
					sr2Pd.put("max_rebate_percent", maxRebatePercent2);
				} else {
					sr2Pd.put("max_rebate_percent", "0.0");
				}
				if (!StringUtils.isEmpty(minConsumeAmount2)) {
					sr2Pd.put("min_consume_amount", minConsumeAmount2);
				} else {
					sr2Pd.put("min_consume_amount", "0.0");
				}
				//定额
				if (!StringUtils.isEmpty(minNormConsumeAmount2)) {
					sr2Pd.put("min_norm_consume_amount", minNormConsumeAmount2);
				} else {
					sr2Pd.put("min_norm_consume_amount", "0.0");
				}
				if (!StringUtils.isEmpty(maxNormAmount2)) {
					sr2Pd.put("max_norm_amount", maxNormAmount2);
				} else {
					sr2Pd.put("max_norm_amount", "0.0");
				}
				//擎天币
				if (!StringUtils.isEmpty(pointsPercent2)) {
					sr2Pd.put("points_percent", pointsPercent2);
				} else {
					sr2Pd.put("points_percent", "0.0");
				}
				if (!StringUtils.isEmpty(normPoints2)) {
					sr2Pd.put("norm_points", normPoints2);
				} else {
					sr2Pd.put("norm_points", "0");
				}
				if (!StringUtils.isEmpty(rebateMaxPoints2)) {
					sr2Pd.put("rebate_max_points", rebateMaxPoints2);
				} else {
					sr2Pd.put("rebate_max_points", "0");
				}
				if (!StringUtils.isEmpty(pointsMinMoney2)) {
					sr2Pd.put("points_min_money", pointsMinMoney2);
				} else {
					sr2Pd.put("points_min_money", "0");
				}
				//余额、优惠券、充值卡设置
				if (!StringUtils.isEmpty(useBalance2)) {
					sr2Pd.put("use_balance", "1");
				} else {
					sr2Pd.put("use_balance", "0");
				}
				if (!StringUtils.isEmpty(useCoupon2)) {
					sr2Pd.put("use_coupon", "1");
				} else {
					sr2Pd.put("use_coupon", "0");
				}
				if (!StringUtils.isEmpty(useCard2)) {
					sr2Pd.put("use_card", "1");
				} else {
					sr2Pd.put("use_card", "0");
				}
				sr2Pd.put("state", state2);
				if (!StringUtils.isEmpty(srId2)) {
					//修改
					sr2Pd.put("id", srId2);
					dao.update("ShopRebateMapper.update", sr2Pd);
				} else {
					//新增
					sr2Pd.put("created_at", strNowTime);
					dao.save("ShopRebateMapper.insert", sr2Pd);
				}
			} else {
				//未启用配置 
				if (!StringUtils.isEmpty(srId2)) {
					//由启用修改为禁用（state = 0）
					sr2Pd.put("state", "0");
					sr2Pd.put("id", srId2);
					dao.update("ShopRebateMapper.update", sr2Pd);
				}
			}

			PageData shopInfoPd = new PageData();
			shopInfoPd.put("shopId", shopId);
			shopInfoPd.put("contract_code", request.getParameter("contract_code"));
			shopInfoPd.put("contract_begin_time", request.getParameter("contract_begin_time"));
			shopInfoPd.put("contract_end_time", request.getParameter("contract_end_time"));
			shopInfoPd.put("shopkeeper_id", request.getParameter("shopkeeper_id"));
			shopInfoPd.put("manager_mobile", request.getParameter("shopkeeper_mobile"));
			shopInfoPd.put("manager_name", request.getParameter("shopkeeper_name"));
			shopInfoPd.put("manager_idcard", request.getParameter("shopkeeper_idcard"));
			shopInfoPd.put("bank_card_name", request.getParameter("bank_card_name"));
			shopInfoPd.put("bank_name", request.getParameter("bank_name"));
			shopInfoPd.put("bank_card_code", request.getParameter("bank_card_code"));
			shopInfoPd.put("bank_card_type", request.getParameter("bank_card_type"));
			shopInfoPd.put("reg_name", request.getParameter("reg_name"));
			shopInfoPd.put("turnover", request.getParameter("turnover"));
			//shopInfoPd.put("sign_status", -6);//签约状态为“已保存”
			shopInfoPd.put("rebate_remark", request.getParameter("rebate_remark"));
			String contractImg = request.getParameter("contract_img");
			if (!StringUtils.isEmpty(contractImg)) {
				shopInfoPd.put("contract_img", contractImg);
			}
			String regImg = request.getParameter("reg_img");
			if (!StringUtils.isEmpty(regImg)) {
				shopInfoPd.put("reg_img", regImg);
			}
			PageData shopEmployeePd = new PageData();
			String strNowTime = DateUtil.getTime();
			// 保存
			if ("1".equals(shopkeeperType) && StringUtils.isEmpty(shopInfoPd.getString("shopkeeper_id"))) {
				//新建管理人
				shopEmployeePd.put("shop_id", shopId);
				//店主
				shopEmployeePd.put("is_owner", "1");
				shopEmployeePd.put("mobile", shopInfoPd.getString("manager_mobile"));
				shopEmployeePd.put("name", shopInfoPd.getString("manager_name"));
				shopEmployeePd.put("idcard", shopInfoPd.getString("manager_idcard"));
				//启用
				shopEmployeePd.put("state", "1");
				shopEmployeePd.put("created_at", strNowTime);
				shopEmployeePd.put("updated_at", strNowTime);
				String idcardImg1 = request.getParameter("idcard_img1");
				if (!StringUtils.isEmpty(idcardImg1)) {
					shopEmployeePd.put("idcard_img1", idcardImg1);
				}
				String idcardImg2 = request.getParameter("idcard_img2");
				if (!StringUtils.isEmpty(idcardImg2)) {
					shopEmployeePd.put("idcard_img2", idcardImg2);
				}
				dao.save("ShopEmployeeMapper.insert-employee", shopEmployeePd);
				//设置商户管理人id
				shopInfoPd.put("shopkeeper_id", shopEmployeePd.getString("id"));
			} else if ("1".equals(shopkeeperType) && !StringUtils.isEmpty(shopInfoPd.getString("shopkeeper_id"))) {
				//修改管理人信息
				shopEmployeePd.put("updated_at", strNowTime);
				shopEmployeePd.put("mobile", shopInfoPd.getString("manager_mobile"));
				shopEmployeePd.put("name", shopInfoPd.getString("manager_name"));
				shopEmployeePd.put("idcard", shopInfoPd.getString("manager_idcard"));
				shopEmployeePd.put("id", shopInfoPd.getString("shopkeeper_id"));
				String idcardImg1 = request.getParameter("idcard_img1");
				if (!StringUtils.isEmpty(idcardImg1)) {
					shopEmployeePd.put("idcard_img1", idcardImg1);
				}
				String idcardImg2 = request.getParameter("idcard_img2");
				if (!StringUtils.isEmpty(idcardImg2)) {
					shopEmployeePd.put("idcard_img2", idcardImg2);
				}
				dao.update("ShopEmployeeMapper.updateEmployee", shopEmployeePd);
			} else {
				//关联管理人
				//设置商户管理人id
				shopInfoPd.put("shopkeeper_id", request.getParameter("shopkeeper_id"));
			}
			if (StringUtils.isEmpty(dbShopBasePd.getString("boost_status")) || dbShopBasePd.getInteger("boost_status") == 0) {
				//推进状态
				//已签约
				shopInfoPd.put("boost_status", "1");
			}
			shopInfoPd.put("updated_at", strNowTime);
			if (dbShopBasePd.getInteger("sign_status") != null && dbShopBasePd.getInteger("sign_status") == -7) {
				shopInfoPd.put("sign_status", "-6");
				//首次保存签约信息时，记录签约人id
				//				if (!StringUtils.isEmpty("moduleType") && "2".equals(moduleType)) {
				//					//BD后台进入操作
				//					shopInfoPd.put("sign_daq_id", manager.getDaqUserId());
				//				}
				if (!StringUtils.isEmpty("moduleType") && ("0".equals(moduleType) || "1".equals(moduleType) || "4".equals(moduleType))) {
					//运营后台操作
					shopInfoPd.put("sign_daq_id", request.getParameter("signDaqId"));
				}
			}
			if (!StringUtils.isEmpty(signBtnType) && "2".equals(signBtnType)) {
				//签约信息提交审核
				//1、设置签约信息状态
				if ("-2".equals(dbShopBasePd.getString("sign_status"))) {
					//2审驳回重新提交审核时，签约状态更新为2审待审核（1审通过）即状态值为-3
					shopInfoPd.put("sign_status", "-3");
				} else {
					//-5、提交审核；
					shopInfoPd.put("sign_status", "-5");
				}
				//2、根据基本信息状态修改基本信息状态
				String dbShopState = dbShopBasePd.getString("state");
				if (!StringUtils.isEmpty(dbShopState) && Integer.valueOf(dbShopState) < -5) {
					//将基本信息一并提交审核
					shopInfoPd.put("state", "-5");
					shopInfoPd.put("base_commit_id", manager.getId());
					shopInfoPd.put("base_commit_time", DateUtil.getTime());
				}
				//3、商户签约信息提交人及提交时间
				shopInfoPd.put("sign_commit_id", manager.getId());
				shopInfoPd.put("sign_commit_time", DateUtil.getTime());
			}
			//避免修改签约信息时置空poi_type
			shopInfoPd.put("poi_type", "-1");
			dao.update("ShopMapper.update", shopInfoPd);
			result.put("status", 1);
			result.put("message", "");
		} catch (Exception e) {
			logger.error("exception-info", e);
			result.put("status", -2);
			result.put("message", "数据操作异常");
			throw new RuntimeException(e);
		}
		try {
			//设置操作日志基本信息
			PageData logPd = new PageData();
			logPd.put("user_id", manager.getId());
			logPd.put("username", manager.getNickname());
			logPd.put("module", "商户信息管理");
			logPd.put("method", "saveOrUpdateShopRebate");
			logPd.put("log_time", DateUtil.getTime());
			if (!StringUtils.isEmpty(moduleType)) {
				//0、商户库进入；1、商户信息管理（线上列表）进入；2、BD商户管理进入；3、待审核商户_BD总监
				switch (moduleType) {
				case "0":
					//运营_后台操作
					logPd.put("remark", "商户库进入进行操作");
					break;
				case "1":
					//运营_后台操作
					logPd.put("remark", "商户信息管理进入进行操作");
					break;
				case "2":
					//BD_后台操作
					logPd.put("remark", "BD商户管理进入进行操作");
					break;
				case "3":
					//待审核商户_BD总监
					logPd.put("remark", "待审核商户_BD总监进入进行操作");
					logPd.put("module", "审核操作");
					break;
				case "4":
					//商户审核
					logPd.put("remark", "商户审核进入进行操作");
					logPd.put("module", "审核操作");
					break;
				default:
					break;
				}
			} else {
				logPd.put("remark", "商户操作入口异常");
			}
			if (result.getIntValue("status") == 1) {
				logPd.put("result", "成功");
			} else {
				logPd.put("result", "失败");
			}
			if (!StringUtils.isEmpty(signBtnType)) {
				//操作按钮类型
				if (dbShopBasePd != null && dbShopBasePd.getInteger("sign_status") != null && dbShopBasePd.getInteger("sign_status") > -7) {
					logPd.put("operation", "签约信息-修改");
					logPd.put("record_id", shopId);
					dao.save("OperateLogMapper.insert", logPd);
				} else {
					logPd.put("operation", "签约信息-添加");
					logPd.put("record_id", shopId);
					dao.save("OperateLogMapper.insert", logPd);
				}
				switch (signBtnType) {
				case "1":
					//签约信息保存
					break;
				case "2":
					//签约信息提交审核
					if (dbShopBasePd != null && dbShopBasePd.getInteger("state") != null && dbShopBasePd.getInteger("state") < -5) {
						//一并提交基本信息审核
						logPd.put("operation", "基本信息-提交审核");
						logPd.put("record_id", shopId);
						dao.save("OperateLogMapper.insert", logPd);
					}
					//记录签约信息提交审核操作日志
					logPd.put("operation", "签约信息-提交审核");
					logPd.put("record_id", shopId);
					dao.save("OperateLogMapper.insert", logPd);
					break;
				default:
					break;
				}
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
			throw new RuntimeException(e);
		}
		return result;
	}

	/**
	 * 获取商户列表
	 * @return   
	 * @author Eric
	 * @date 2016年1月17日下午4:15:52
	 */
	public List<PageData> getShopListPage(Page page) {
		List<PageData> pdList = null;
		try {
			pdList = (List<PageData>) dao.findForList("ShopMapper.getShopInfoListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return pdList;
	}

	/**
	 * 校验合同编号
	 * @param contractCode
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月25日上午9:58:26
	 */
	public JSONObject checkContractCode(String contractCode) {
		JSONObject result = new JSONObject();
		try {
			PageData pd = (PageData) dao.findForObject("ShopMapper.getContractCode", contractCode);
			if (pd != null && pd.getInteger("contractCodeNum") == 0) {
				//可以使用
				result.put("status", 1);
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
	 * 校验商户名称唯一性
	 * @param shopName
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月25日下午5:14:51
	 */
	public JSONObject checkShopName(String shopName) {
		JSONObject result = new JSONObject();
		try {
			PageData pd = (PageData) dao.findForObject("ShopMapper.getShopNameNum", shopName);
			if (pd != null && pd.getInteger("shopNameNum") == 0) {
				//可以使用
				result.put("status", 1);
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
	 * 到商户审核列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月2日上午9:41:00
	 */
	public List<PageData> findShopAuthListPageable(Page page) {
		List<PageData> shopAuthList = null;
		try {
			shopAuthList = (List<PageData>) dao.findForList("ShopMapper.getAuthShopByListPage", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return shopAuthList;
	}

	/**
	 * 审核商户签约信息
	 * @param pageData
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月18日下午7:20:57
	 */
	public JSONObject authShopSign(PageData pageData) {
		JSONObject result = new JSONObject();
		User manager = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		PageData shopPd = new PageData();
		shopPd.put("shopId", pageData.getString("shopId"));
		Integer pass = pageData.getInteger("pass");
		Integer module = pageData.getInteger("module");
		if (pass != null) {
			if (pass == 1) {
				if (module == 3) {
					//一审通过
					shopPd.put("sign_status", -3);
				} else if (module == 4) {
					//二审通过
					shopPd.put("sign_status", -1);
					//核实是否存在有效daq推广记录（daq_relationship）
					PageData dbShopBasePd = (PageData) dao.findForObject("ShopMapper.getBaseById", pageData.getString("shopId"));
					if (dbShopBasePd != null) {
						PageData params = new PageData();
						params.put("type", "2");
						String[] relateIds = { pageData.getString("shopId") };
						params.put("relateIds", relateIds);
						String daqUserId = dbShopBasePd.getString("daq_user_id");
						if (StringUtils.isEmpty(daqUserId)) {
							String signDaqId = dbShopBasePd.getString("sign_daq_id");
							daqUserId = signDaqId;
							//推广人id为空，补全商户主表的daq_user_id、follow_daq_id、relevan_time
							//params.put("relevanTime", DateUtil.getTime());
						}
						params.put("daqUserId", daqUserId);
						int rowNum = (int) dao.findForObject("DaqUserMapper.getDaqShopRelationshipNum", params);
						if (rowNum < 1) {
							//不存在推广记录，则根据商户签约人id生成商户推广记录
							dao.save("DaqUserMapper.beginDaqRelationship", params);
							params.put("operate", "4");
							params.put("relevanTime", DateUtil.getTime());
							dao.update("DaqUserMapper.modifyDaqRelationship", params);
						}
					}
				}
			} else {
				if (module == 3) {
					//一审驳回
					shopPd.put("sign_status", -4);
				} else if (module == 4) {
					//二审驳回
					shopPd.put("sign_status", -2);
				}
				shopPd.put("sign_auth_remark", pageData.getString("remark"));
			}
			try {
				//避免修改签约信息时置空poi_type
				shopPd.put("poi_type", "-1");
				int rowNum = (int) dao.update("ShopMapper.update", shopPd);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "");
				} else {
					result.put("status", -2);
					result.put("message", "操作记录数异常");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据操作异常");
				throw new RuntimeException("商户签约信息审核", e);
			}
		} else {
			result.put("status", -2);
			result.put("message", "参数异常");
		}
		try {
			PageData logPd = new PageData();
			logPd.put("user_id", manager.getId());
			logPd.put("username", manager.getNickname());
			logPd.put("method", "authShopSign");
			logPd.put("log_time", DateUtil.getTime());
			logPd.put("module", "审核操作");
			logPd.put("record_id", shopPd.getString("shopId"));
			if (result.getIntValue("status") == 1) {
				logPd.put("result", "成功");
			} else {
				logPd.put("result", "失败");
			}
			String remarkInfo = null;
			if (module == 3) {
				//待审核商户_BD总监
				remarkInfo = "待审核商户_BD总监进入";
			} else if (module == 4) {
				remarkInfo = "商户审核进入";
			}
			if (pass == 1) {
				//一审通过
				if (module == 3) {
					//待审核商户_BD总监
					logPd.put("operation", "签约信息_一审通过");
					remarkInfo = remarkInfo + "_一审通过";
				} else if (module == 4) {
					logPd.put("operation", "签约信息_二审通过");
					remarkInfo = remarkInfo + "_二审通过";
				}
			} else {
				if (module == 3) {
					//待审核商户_BD总监
					logPd.put("operation", "签约信息_一审驳回");
					remarkInfo = remarkInfo + "_一审驳回";
				} else if (module == 4) {
					logPd.put("operation", "签约信息_二审驳回");
					remarkInfo = remarkInfo + "_二审驳回";
				}
				remarkInfo = remarkInfo + "_" + pageData.getString("remark");
			}
			logPd.put("remark", remarkInfo);
			dao.save("OperateLogMapper.insert", logPd);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return result;
	}

	/**
	 * 审核商户基本信息
	 * @param pageData
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月18日下午7:20:57
	 */
	public JSONObject authShopBase(PageData pageData) {
		JSONObject result = new JSONObject();
		User manager = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		PageData shopPd = new PageData();
		shopPd.put("shopId", pageData.getString("shopId"));
		Integer pass = pageData.getInteger("pass");
		Integer module = pageData.getInteger("module");
		if (pass != null) {
			if (pass == 1) {
				//一审通过
				shopPd.put("state", -1);
			} else {
				//一审驳回
				shopPd.put("state", -2);
				shopPd.put("base_auth_remark", pageData.getString("remark"));
			}
			try {
				//避免修改签约信息时置空poi_type
				shopPd.put("poi_type", "-1");
				int rowNum = (int) dao.update("ShopMapper.update", shopPd);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "");
				} else {
					result.put("status", -2);
					result.put("message", "操作记录数异常");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据操作异常");
				throw new RuntimeException("商户基本信息审核", e);
			}
		} else {
			result.put("status", -2);
			result.put("message", "参数异常");
		}
		try {
			PageData logPd = new PageData();
			logPd.put("user_id", manager.getId());
			logPd.put("username", manager.getNickname());
			logPd.put("method", "authShopBase");
			logPd.put("log_time", DateUtil.getTime());
			logPd.put("module", "审核操作");
			logPd.put("record_id", shopPd.getString("shopId"));
			if (result.getIntValue("status") == 1) {
				logPd.put("result", "成功");
			} else {
				logPd.put("result", "失败");
			}
			String remarkInfo = null;
			if (module == 3) {
				//待审核商户_BD总监
				remarkInfo = "待审核商户_BD总监进入";
			} else if (module == 4) {
				remarkInfo = "商户审核进入";
			}
			if (pass == 1) {
				//一审通过
				logPd.put("operation", "基本信息_审核通过");
				remarkInfo = remarkInfo + "_审核通过";
			} else {
				logPd.put("operation", "基本信息_审核驳回");
				remarkInfo = remarkInfo + "_审核驳回_";
			}
			remarkInfo = remarkInfo + pageData.getString("remark");
			logPd.put("remark", remarkInfo);
			dao.save("OperateLogMapper.insert", logPd);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return result;
	}

	/**
	 * 根据shopId跟新商户信息
	 * @param shopPd
	 * @return  操作影响的记录数
	 * @author JHONNY
	 * @date 2016年2月29日下午6:42:41
	 */
	public int updateShop(PageData shopPd) {
		int rowNum = 0;
		try {
			dao.update("ShopMapper.update", shopPd);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return rowNum;
	}

	/**
	 * 根据雇员信息获取商户列表
	 * @param page
	 * @return 商户列表  
	 * @author aquarius
	 * @date 2016年4月11日上午10:26:11
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findListByEmployee(Page page) {
		List<PageData> pdList = null;
		try {
			pdList = (List<PageData>) dao.findForList("ShopMapper.findListByEmployee", page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return pdList;
	}
}
