package com.qtzk.system.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
import com.qtzk.system.service.CardService;
import com.qtzk.system.service.impl.DaqUserService;
import com.qtzk.system.service.impl.ShopEmployeeService;
import com.qtzk.system.utils.DateUtil;
import com.qtzk.system.utils.JsonUtils;
import com.qtzk.system.utils.POIUtils;

@Controller
@RequestMapping(value = "/cardController")
public class CardController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(CardController.class);

	@Resource(name = "cardService")
	private CardService cardService;
	@Resource(name = "daqUserService")
	private DaqUserService daqUserService;
	@Resource(name = "shopEmployeeService")
	private ShopEmployeeService shopEmployeeService;

	/**
	 * 翻页获取空白会员卡录入列表
	 * @param model
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月25日上午11:24:09
	 */
	@RequestMapping(value = "/getBlankCardList")
	public String getBlankCardList(Model model, Page page) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> blankCardPdList = cardService.getBlankCardListPageable(page);
		model.addAttribute("page", page);
		model.addAttribute("blankCardPdList", blankCardPdList);
		return "/operate/card/card-blank-list";
	}

	/**
	 * 到添加页
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月25日下午5:07:47
	 */
	@RequestMapping(value = "/preAdd")
	public String preAdd() {
		return "/operate/card/card-add";
	}

	/**
	 * 新增会员卡
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月25日下午5:08:50
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public JSONObject save() {
		return cardService.save(this.getPageData());
	}

	/**
	 * 导出
	 * @param response
	 * @throws Exception   
	 * @author JHONNY
	 * @date 2016年7月26日下午2:58:22
	 */
	@RequestMapping(value = "/export")
	public void exportShopBillList(HttpServletResponse response) {
		PageData pd = this.getPageData();
		List<PageData> list = cardService.getCardDetailListByMasterId(pd.getString("masterId"));
		String fileName = pd.getString("batchName") + pd.getString("fileName") + "_" + DateUtil.getDays();

		JSONArray ja = new JSONArray();
		//会员卡记录id
		JSONObject js = new JSONObject();
		js.put("colkey", "id");
		js.put("name", "ID");
		js.put("hide", "");
		ja.add(js);

		//会员卡号
		JSONObject js2 = new JSONObject();
		js2.put("colkey", "card_code");
		js2.put("name", "code");
		js2.put("hide", "");
		ja.add(js2);

		//会员卡key
		JSONObject js3 = new JSONObject();
		js3.put("colkey", "card_key");
		js3.put("name", "key");
		js3.put("hide", "");
		ja.add(js3);

		List<Map<String, Object>> listMap = JsonUtils.parseJSONList(ja.toString());

		List<Map<String, Object>> listBeanMap = null;
		try {
			listBeanMap = JsonUtils.parseJSONList(JsonUtils.objectToJson(list));
		} catch (Exception e) {
			this.logger.error("exception-info", e);
		}
		POIUtils.exportToExcel(response, listMap, listBeanMap, fileName);
	}

	/**
	 * 会员卡入库
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午4:49:15
	 */
	@RequestMapping(value = "/entryWarehouse")
	@ResponseBody
	public JSONObject entryWarehouse() {
		return cardService.entryWarehouse(this.getPageData());
	}

	/**
	 * 到会员卡作废页
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午4:51:33
	 */
	@RequestMapping(value = "/preDestoryCard")
	public String preDestoryCard() {
		return "/operate/card/card-destory";
	}

	/**
	 * 校验待报废会员卡信息
	 * @param cardCode
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午5:47:06
	 */
	@RequestMapping(value = "/getCardInfoByCardCode")
	@ResponseBody
	public JSONObject getCardInfoByCardCode(String cardCode) {
		JSONObject result = new JSONObject();
		PageData cardInfoPd = cardService.getCardInfoByCardCode(cardCode);
		result.put("cardInfoPd", cardInfoPd);
		return result;
	}

	/**
	 * 会员卡报废
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午4:49:15
	 */
	@RequestMapping(value = "/cardDestory")
	@ResponseBody
	public JSONObject cardDestory() {
		return cardService.cardDestory(this.getPageData());
	}

	/**
	 * 到会员卡领取页
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午4:51:33
	 */
	@RequestMapping(value = "/preReceiveCard")
	public String preReceiveCard(Model model) {
		//1、获取可用会员卡入库批次列表
		PageData pd = new PageData();
		pd.put("remain_num", "0");
		model.addAttribute("masterPdList", cardService.getEligibleBatchList(pd));
		//2、获取跟进人列表
		model.addAttribute("daqUserList", daqUserService.getAllFollowDaqUserList());
		return "/operate/card/card-receive";
	}

	/**
	 * 到员工选择页
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日下午5:19:55
	 */
	@RequestMapping(value = "/chooseEmployee")
	public String chooseEmployee(Model model, Page page) {
		List<PageData> employeePdList = null;
		PageData pd = this.getPageData();
		page.setPd(pd);
		if (StringUtils.isNotEmpty(pd.getString("shopName")) || StringUtils.isNotEmpty(pd.getString("shopCode"))) {
			employeePdList = shopEmployeeService.getEmployeeListPage(page);
		}
		model.addAttribute("employeePdList", employeePdList);
		model.addAttribute("page", page);
		return "/operate/card/choose-employee";
	}

	/**
	 * 校验待领取会员卡号段合法性
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日下午3:42:47
	 */
	@RequestMapping(value = "/cardReceiveCheck")
	@ResponseBody
	public JSONObject cardReceiveCheck() {
		JSONObject result = new JSONObject();
		PageData checkPd = cardService.cardReceiveCheck(this.getPageData());
		result.put("checkPd", checkPd);
		return result;
	}

	/**
	 * 领取会员卡
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日下午4:08:32
	 */
	@RequestMapping(value = "/cardReceive")
	@ResponseBody
	public JSONObject cardReceive() {
		return cardService.cardReceive(getPageData());
	}

	/**
	 * 获取已领取会员卡列表
	 * @param model
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日上午10:36:18
	 */
	@RequestMapping(value = "/getReceiveCardList")
	public String getReceiveCardList(Model model, Page page) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> receiveCardPdList = cardService.getReceiveCardListPage(page);
		model.addAttribute("page", page);
		model.addAttribute("receiveCardPdList", receiveCardPdList);
		//1、获取会员卡入库批次列表
		model.addAttribute("masterPdList", cardService.getEligibleBatchList(null));
		return "/operate/card/card-receive-list";
	}

}
