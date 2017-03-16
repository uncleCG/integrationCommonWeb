package com.qtzk.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.qtzk.system.service.AccountService;
import com.qtzk.system.utils.DateUtil;
import com.qtzk.system.utils.JsonUtils;
import com.qtzk.system.utils.POIUtils;

/**
 * 买家管理控制器
 *   
 * @author JHONNY
 * @date 2016年7月28日下午4:57:09
 */
@Controller
@RequestMapping(value = "/accountController")
public class AccountController extends BaseController {

	@Resource(name = "accountService")
	private AccountService accountService;

	private Logger logger = LoggerFactory.getLogger(AccountController.class);

	/**
	 * 分页获取已绑卡买家列表
	 * @param model
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月29日上午11:54:06
	 */
	@RequestMapping(value = "/getTieBuyerListPage")
	public String getTieBuyerListPage(Model model, Page page) {
		model.addAttribute("page", page);
		page.setPd(this.getPageData());
		model.addAttribute("list", accountService.getTieBuyerListPage(page));
		return "/account/buyer-manage/account-tie-list";
	}

	/**
	 * 导出绑卡买家列表
	 * @param response
	 * @param page
	 * @throws Exception   
	 * @author JHONNY
	 * @date 2016年7月28日下午6:28:22
	 */
	@RequestMapping(value = "/exportTieBuyerList")
	public void exportTieBuyerList(HttpServletResponse response, Page page) throws Exception {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> list = accountService.getTieBuyerListPage(page);

		String fileName = pd.getString("fileName") + "_" + DateUtil.getDays();
		JSONArray ja = new JSONArray();

		JSONObject js = new JSONObject();
		js.put("colkey", "id");
		js.put("name", "ID");
		js.put("hide", "");
		ja.add(js);

		JSONObject js2 = new JSONObject();
		js2.put("colkey", "mobile");
		js2.put("name", "手机号");
		js2.put("hide", "");
		ja.add(js2);

		JSONObject js3 = new JSONObject();
		js3.put("colkey", "firstRechargeAt");
		js3.put("name", "个人首单充值时间");
		js3.put("hide", "");
		ja.add(js3);

		JSONObject js4 = new JSONObject();
		js4.put("colkey", "firstTieAt");
		js4.put("name", "首次帮卡时间");
		js4.put("hide", "");
		ja.add(js4);

		JSONObject js5 = new JSONObject();
		js5.put("colkey", "recharge");
		js5.put("name", "充值总金额");
		js5.put("hide", "");
		ja.add(js5);

		JSONObject js6 = new JSONObject();
		js6.put("colkey", "consume");
		js6.put("name", "消费总金额");
		js6.put("hide", "");
		ja.add(js6);

		JSONObject js7 = new JSONObject();
		js7.put("colkey", "balance");
		js7.put("name", "总余额");
		js7.put("hide", "");
		ja.add(js7);

		JSONObject js8 = new JSONObject();
		js8.put("colkey", "cardNum");
		js8.put("name", "会员卡");
		js8.put("hide", "");
		ja.add(js8);

		JSONObject js9 = new JSONObject();
		js9.put("colkey", "createdAt");
		js9.put("name", "创建时间");
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

	/**
	 * 分页获取买家已绑定的会员卡列表
	 * @param model
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月29日上午11:54:29
	 */
	@RequestMapping(value = "/getMyCardListPage")
	public String getMyCardListPage(Model model, Page page) {
		model.addAttribute("page", page);
		page.setPd(this.getPageData());
		model.addAttribute("list", accountService.getMyCardListPage(page));
		return "/account/buyer-manage/account-card-list";
	}

	/**
	 * 维护已开通会员卡的状态、密码
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月29日上午11:55:46
	 */
	@RequestMapping(value = "/updateCard")
	@ResponseBody
	public JSONObject updateCard(HttpSession session) {
		JSONObject result = null;
		PageData pd = this.getPageData();
		String smsCheckCode = pd.getString("smsCheckCode");
		String phoneNum = pd.getString("phoneNum");
		if (StringUtils.isNotEmpty(smsCheckCode)) {
			//校验短信验证码
			String sessionSMSCheckCode = (String) session.getAttribute(phoneNum);
			if (!smsCheckCode.equals(sessionSMSCheckCode)) {
				result = new JSONObject();
				result.put("status", "-1");
				result.put("message", "验证码错误");
				return result;
			} else {
				session.removeAttribute(phoneNum);
			}
		}
		return accountService.updateCard(pd);
	}

	/**
	 * 到密码修改页
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月29日下午3:12:30
	 */
	@RequestMapping(value = "/preEditPwd")
	public String preEditPwd(Model model) {
		PageData pd = this.getPageData();
		model.addAttribute("relateId", pd.getString("relateId"));
		model.addAttribute("phoneNum", pd.getString("phoneNum"));
		model.addAttribute("ope", pd.getString("ope"));
		model.addAttribute("cardCode", pd.getString("cardCode"));
		return "/account/buyer-manage/account-card-pwd";
	}

	/**
	 * 分页获取未绑卡买家列表
	 * @param model
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月30日下午4:19:16
	 */
	@RequestMapping(value = "/getNoTieBuyerListPage")
	public String getNoTieBuyerListPage(Model model, Page page) {
		model.addAttribute("page", page);
		page.setPd(this.getPageData());
		model.addAttribute("list", accountService.getNoTieBuyerListPage(page));
		return "/account/buyer-manage/account-no-tie-list";
	}

	/**
	 * 导出未绑卡买家列表
	 * @param response
	 * @param page
	 * @throws Exception   
	 * @author JHONNY
	 * @date 2016年7月30日下午4:39:49
	 */
	@RequestMapping(value = "/exportNoTieBuyerList")
	public void exportNoTieBuyerList(HttpServletResponse response, Page page) throws Exception {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> list = accountService.getNoTieBuyerListPage(page);

		String fileName = pd.getString("fileName") + "_" + DateUtil.getDays();
		JSONArray ja = new JSONArray();

		JSONObject js = new JSONObject();
		js.put("colkey", "cardCode");
		js.put("name", "会员卡编号");
		js.put("hide", "");
		ja.add(js);

		JSONObject js2 = new JSONObject();
		js2.put("colkey", "shopName");
		js2.put("name", "代理商");
		js2.put("hide", "");
		ja.add(js2);

		JSONObject js3 = new JSONObject();
		js3.put("colkey", "createdAt");
		js3.put("name", "开卡时间");
		js3.put("hide", "");
		ja.add(js3);

		JSONObject js4 = new JSONObject();
		js4.put("colkey", "firstRechargeAt");
		js4.put("name", "首单充值时间");
		js4.put("hide", "");
		ja.add(js4);

		JSONObject js5 = new JSONObject();
		js5.put("colkey", "recharge");
		js5.put("name", "充值总金额");
		js5.put("hide", "");
		ja.add(js5);

		JSONObject js6 = new JSONObject();
		js6.put("colkey", "consume");
		js6.put("name", "消费总金额");
		js6.put("hide", "");
		ja.add(js6);

		JSONObject js7 = new JSONObject();
		js7.put("colkey", "balance");
		js7.put("name", "卡内余额");
		js7.put("hide", "");
		ja.add(js7);

		JSONObject js8 = new JSONObject();
		js8.put("colkey", "isLoss");
		js8.put("name", "挂失状态");
		js8.put("hide", "");
		Map<String, String> map = new HashMap<String, String>(2);
		map.put("0", "正常");
		map.put("1", "挂失");
		js8.put("mapKey", map);
		ja.add(js8);

		JSONObject js9 = new JSONObject();
		js9.put("colkey", "isFreeze");
		js9.put("name", "冻结状态");
		js9.put("hide", "");
		Map<String, String> map2 = new HashMap<String, String>(2);
		map2.put("0", "正常");
		map2.put("1", "冻结");
		js9.put("mapKey", map2);
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
