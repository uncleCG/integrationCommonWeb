package com.qtzk.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.controller.base.BaseController;
import com.qtzk.system.service.impl.ShopBillService;
import com.qtzk.system.utils.DateUtil;
import com.qtzk.system.utils.JsonUtils;
import com.qtzk.system.utils.POIUtils;

/**
 * 交易记录
 */
@Controller
@RequestMapping(value = "/shopBillController")
public class ShopBillController extends BaseController {

	private final Logger logger = LoggerFactory.getLogger(ShopBillController.class);

	@Resource(name = "shopBillService")
	private ShopBillService shopBillService;

	/**
	 * 分页获取会员卡交易订单列表
	 * @param model
	 * @param page
	 * @return
	 * @throws Exception   
	 * @author JHONNY
	 * @date 2016年7月24日下午4:00:21
	 */
	@RequestMapping(value = "/getShopBillList")
	public String getShopBillList(Model model, Page page) throws Exception {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> list = shopBillService.getShopBillList(page);
		model.addAttribute("page", page);
		model.addAttribute("list", list);
		return "/trade/collates/tradingarea/shopbill-list";
	}

	/**
	 * 更新订单信息
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月24日下午4:01:35
	 */
	@RequestMapping(value = "/updateBill")
	@ResponseBody
	public JSONObject updateBill() {
		return shopBillService.updateBill(this.getPageData());
	}

	/**
	 * 获取订单详情
	 * @param model
	 * @param id
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月24日下午5:39:49
	 */
	@RequestMapping(value = "/getBillDetail")
	public String getBillDetail(Model model, String id) {
		PageData billDetailPd = shopBillService.getBillDetail(id);
		model.addAttribute("billDetailPd", billDetailPd);
		return "/trade/collates/tradingarea/shopbill-detail";
	}

	/**
	 * 会员卡交易订单导出
	 * @param response
	 * @param page
	 * @throws Exception   
	 * @author JHONNY
	 * @date 2016年7月25日上午10:16:20
	 */
	@RequestMapping(value = "/exportShopBillList")
	public void exportShopBillList(HttpServletResponse response, Page page) throws Exception {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> list = shopBillService.getShopBillList(page);

		String fileName = pd.getString("fileName") + "_" + DateUtil.getDays();
		JSONArray ja = new JSONArray();

		//订单编号
		JSONObject js = new JSONObject();
		js.put("colkey", "billCode");
		js.put("name", "订单编号");
		js.put("hide", "");
		ja.add(js);

		//会员卡号
		JSONObject js2 = new JSONObject();
		js2.put("colkey", "cardCode");
		js2.put("name", "会员卡号");
		js2.put("hide", "");
		ja.add(js2);

		//订单状态
		JSONObject js3 = new JSONObject();
		js3.put("colkey", "tradeStatus");
		js3.put("name", "交易状态");
		js3.put("hide", "");
		Map<String, String> map = new HashMap<String, String>(4);
		map.put("1", "未确认");
		map.put("2", "未到账");
		map.put("3", "交易完成");
		map.put("4", "交易取消");
		js3.put("mapKey", map);
		ja.add(js3);

		//交易类型
		JSONObject js4 = new JSONObject();
		js4.put("colkey", "type");
		js4.put("name", "交易类型");
		js4.put("hide", "");
		Map<String, String> map2 = new HashMap<String, String>(2);
		map2.put("10", "消费");
		map2.put("11", "充值");
		js4.put("mapKey", map2);
		ja.add(js4);

		//商户名称
		JSONObject js5 = new JSONObject();
		js5.put("colkey", "shopName");
		js5.put("name", "商户名称");
		js5.put("hide", "");
		ja.add(js5);

		//交易终端
		JSONObject js6 = new JSONObject();
		js6.put("colkey", "createdMobile");
		js6.put("name", "交易终端");
		js6.put("hide", "");
		ja.add(js6);

		//支付方式
		JSONObject js7 = new JSONObject();
		js7.put("colkey", "payType");
		js7.put("name", "支付方式");
		js7.put("hide", "");
		Map<String, String> map5 = new HashMap<String, String>(5);
		map5.put("1001", "现金");
		map5.put("1003", "微信支付");
		map5.put("1004", "支付宝");
		map5.put("1006", "银行卡");
		map5.put("1007", "会员卡");
		js7.put("mapKey", map5);
		ja.add(js7);

		//交易金额
		JSONObject js8 = new JSONObject();
		js8.put("colkey", "amount");
		js8.put("name", "交易金额");
		js8.put("hide", "");
		ja.add(js8);

		//交易完成时间
		JSONObject js9 = new JSONObject();
		js9.put("colkey", "tradeTime");
		js9.put("name", "交易完成时间");
		js9.put("hide", "");
		ja.add(js9);

		List<Map<String, Object>> listMap = JsonUtils.parseJSONList(ja.toString());

		List<Map<String, Object>> listBeanMap = null;
		try {
			listBeanMap = JsonUtils.parseJSONList(JsonUtils.objectToJson(list));
		} catch (Exception e) {
			this.logger.error("exception-info", e);
		}
		POIUtils.exportToExcel(response, listMap, listBeanMap, fileName);
	}
}
