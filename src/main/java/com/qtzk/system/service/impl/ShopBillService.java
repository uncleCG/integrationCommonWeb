package com.qtzk.system.service.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.ShopBill;
import com.qtzk.system.dao.DaoSupport;
import com.qtzk.system.utils.HttpRequestUtil;
import com.qtzk.system.utils.PropertiesUtil;

@Service("shopBillService")
public class ShopBillService {
	private static final Logger logger = Logger.getLogger(ShopBillService.class);

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 分页获取会员卡交易订单列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月24日下午2:43:41
	 */
	public List<PageData> getShopBillList(Page page) {
		List<PageData> list = (List<PageData>) dao.findForList("ShopBillMapper.getShopBillListPage", page);
		return list;
	}

	/**
	 * 更新订单信息
	 * @param params
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月24日下午4:04:47
	 */
	public JSONObject updateBill(PageData params) {
		JSONObject result = new JSONObject();
		Integer tradeStatus = params.getInteger("tradeStatus");
		int type = params.getInt("type");
		String billId = params.getString("id");
		String cardCode = params.getString("cardCode");
		if (tradeStatus != null) {
			switch (tradeStatus) {
			case 2:
			case 4:
				//确认订单和取消订单时，调用web接口
				String strParams = "type=" + type + "&billId=" + billId + "&cardCode=" + cardCode + "&tradeStatus=" + tradeStatus;
				String strUrl = PropertiesUtil.get("inteface_ip") + "app/shops/confirmBill";
				String strResult = HttpRequestUtil.sendPost(strUrl, strParams);
				result = JSONObject.parseObject(strResult);
				break;
			default:
				int rowNum = (int) dao.update("ShopBillMapper.update", params);
				if (rowNum == 1) {
					result.put("status", "1");
				} else {
					result.put("staus", "-2");
					result.put("message", "数据库操作记录数异常");
				}
				break;
			}
		}
		return result;
	}

	/**
	 * 获取订单详情
	 * @param params
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月24日下午5:27:15
	 */
	public PageData getBillDetail(String id) {
		PageData billDetailPd = null;
		if (StringUtils.isNotEmpty(id)) {
			billDetailPd = (PageData) dao.findForObject("ShopBillMapper.getRecordDetailById", id);
		}
		return billDetailPd;
	}

	public void handleMoreTowHourBill() {
		try {
			int tradeStatus = 0; //交易状态：1-未确认，2-未到账，3-交易完成，4-交易取消
			int hours = 2;
			PageData pd = new PageData();
			pd.put("tradeStatus", tradeStatus);
			pd.put("rebateTerminal", 3);
			logger.debug("tradeStatus=>" + tradeStatus + ",hours=>" + hours);
			List<ShopBill> list = (List<ShopBill>) dao.findForList("ShopBillMapper.getShopBillListByType8", pd);
			if (list != null && list.size() > 0) {
				Date createdAt = null;
				Date now = new Date();
				for (ShopBill sb : list) {
					createdAt = sb.getCreated_at();
					if (hours < (now.getTime() - createdAt.getTime()) / (1000 * 3600)) { //超过指定时间的订单

						String strUrl = PropertiesUtil.get("upload.freight_post") + "atlas/app/appGroupTradeResult";
						String params = "accountId=" + "" + "&tokenApp=" + "" + "&billId=" + sb.getId() + "&billCode=" + sb.getBill_code() + "&type=2";

						try {
							HttpRequestUtil.sendPost(strUrl, params);
						} catch (Exception e) {
							logger.error("exception-info", e);
						}
					}
				}
			}
		} catch (Exception e) {
		}
	}

	public void handleMoreSixHourBill() {
		try {
			int tradeStatus = 0; //交易状态：1-未确认，2-未到账，3-交易完成，4-交易取消
			int hours = 6;
			PageData pd = new PageData();
			pd.put("tradeStatus", tradeStatus);
			logger.debug("tradeStatus=>" + tradeStatus + ",hours=>" + hours);
			List<ShopBill> list = (List<ShopBill>) dao.findForList("ShopBillMapper.getShopBillListByTradeStatus", pd);
			if (list != null && list.size() > 0) {
				Date createdAt = null;
				Date now = new Date();
				for (ShopBill sb : list) {
					createdAt = sb.getCreated_at();
					if (hours < (now.getTime() - createdAt.getTime()) / (1000 * 3600)) { //超过指定时间的订单
						sb.setTrade_status(4); //
						dao.update("ShopBillMapper.update", sb); //更新
					}
				}
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
	}

	public void handleMore24HourBill() {
		try {
			int tradeStatus = 1; //交易状态，0-待支付，1-待确认，2-已取消，3-交易完成，4-交易关闭
			int hours = 24;
			PageData pd = new PageData();
			pd.put("tradeStatus", tradeStatus);
			pd.put("rebateTerminal", 3);
			logger.debug("tradeStatus=>" + tradeStatus + ",hours=>" + hours);
			List<ShopBill> list = (List<ShopBill>) dao.findForList("ShopBillMapper.getShopBillListByTradeStatus", pd);
			if (list != null && list.size() > 0) {
				Date createdAt = null;
				Date now = new Date();
				JSONObject json = new JSONObject();
				json.put("tradeStatus", "3");
				JSONArray ja = new JSONArray();
				JSONObject josnObj = null;
				for (ShopBill sb : list) {
					createdAt = sb.getCreated_at();
					if (hours < (now.getTime() - createdAt.getTime()) / (1000 * 3600)) { //超过指定时间的订单
						//{"tradeStatus":"3","list":[{"billCode":"","userId":""},{"billCode":"","userId":""}]}
						josnObj = new JSONObject();
						josnObj.put("billCode", sb.getBill_code() + "");
						josnObj.put("userId", sb.getCreated_by() + "");
						ja.add(josnObj);
					}
				}
				json.put("list", ja);
				//请求URL
				//正式
				String requestUrl = PropertiesUtil.get("upload.DOMAIN") + "shops/batchSaveTradeResult";
				try {
					requestPost(requestUrl, "json", json.toString());
				} catch (Exception e) {
					logger.error("Exception", e);
				}
			}
		} catch (Exception e) {
		}
	}

	/**
	 * 请求Web
	 * @param requestUrl
	 * @return
	 */
	public String requestPost(String requestUrl, String paramKey, String parameterData) {
		StringBuffer resultBuffer = null;
		try {
			requestUrl = requestUrl + "?" + paramKey + "=" + parameterData;
			logger.debug("requestUrl=>" + requestUrl);
			URL realurl = new URL(requestUrl);
			URLConnection connection = realurl.openConnection();
			HttpURLConnection httpURLConnection = (HttpURLConnection) connection;
			httpURLConnection.setDoOutput(true);
			httpURLConnection.setRequestMethod("POST");
			httpURLConnection.setRequestProperty("Accept-Charset", "utf-8");
			httpURLConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			httpURLConnection.setRequestProperty("Content-Length", String.valueOf(parameterData.length()));
			InputStream inputStream = null;
			InputStreamReader inputStreamReader = null;
			BufferedReader reader = null;
			resultBuffer = new StringBuffer();
			String tempLine = null;
			if (httpURLConnection.getResponseCode() >= 300) {
				throw new Exception("HTTP Request is not success, Response code is " + httpURLConnection.getResponseCode());
			}
			try {
				inputStream = httpURLConnection.getInputStream();
				inputStreamReader = new InputStreamReader(inputStream);
				reader = new BufferedReader(inputStreamReader);
				while ((tempLine = reader.readLine()) != null) {
					resultBuffer.append(tempLine);
				}
			} finally {
				IOUtils.closeQuietly(reader);
				IOUtils.closeQuietly(inputStreamReader);
				IOUtils.closeQuietly(inputStream);
			}
			logger.debug("response=>" + resultBuffer.toString());
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return resultBuffer.toString();
	}
}
