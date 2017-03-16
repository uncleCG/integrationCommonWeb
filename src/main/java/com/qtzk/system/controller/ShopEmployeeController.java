package com.qtzk.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.controller.base.BaseController;
import com.qtzk.system.service.impl.ShopEmployeeService;
import com.qtzk.system.service.impl.ShopService;
import com.qtzk.system.utils.DateUtil;
import com.qtzk.system.utils.FileUpload;
import com.qtzk.system.utils.JsonUtils;
import com.qtzk.system.utils.POIUtils;
import com.qtzk.system.utils.PathUtil;
import com.qtzk.system.utils.SerialNum;

/**
 * 卖家管理控制器
 *    
 * @author JHONNY
 * @date 2016年7月30日下午6:31:24
 */

@Controller
@RequestMapping(value = "/sellerManageController")
public class ShopEmployeeController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(ShopEmployeeController.class);

	@Resource(name = "shopEmployeeService")
	private ShopEmployeeService shopEmployeeService;

	@Resource(name = "shopService")
	private ShopService shopService;

	/**
	 * 分页获取买家列表
	 * @param page
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月30日下午6:34:48
	 */
	@RequestMapping(value = "/getSellerList")
	public String getSellerList(Page page, Model model) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> list = shopEmployeeService.getSellerList(page);
		model.addAttribute("pageData", pd);
		model.addAttribute("page", page);
		model.addAttribute("list", list);
		return "/account/seller-manage/seller-manage-list";
	}

	/**
	 * 获取卖家详情
	 * @param id
	 * @param model
	 * @return
	 * @throws Exception   
	 * @author JHONNY
	 * @date 2016年7月31日上午11:19:35
	 */
	@RequestMapping(value = "/getSellerInfo")
	public String getSellerInfo(String id, Model model) throws Exception {
		PageData shopEmployeePd = null;
		if (id != null) {//修改
			shopEmployeePd = shopEmployeeService.getById(id);
			if (shopEmployeePd.getInt("is_owner") == 1) {
				PageData pageData = new PageData();
				pageData.put("manager_id", id);
				List<PageData> list = shopService.getShopInfoList(pageData);
				model.addAttribute("list", list);
			}
		} else {
			shopEmployeePd = new PageData();
		}
		model.addAttribute("shopEmployee", shopEmployeePd);
		return "/account/seller-manage/seller-info";
	}

	/**
	 * 到信息添加、修改页
	 * @param model
	 * @param id
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月31日下午12:13:55
	 */
	@RequestMapping(value = "/preEdit")
	public String preEdit(Model model, String id) {
		PageData shopEmployeePd = null;
		if (StringUtils.isEmpty(id)) {
			//添加
			shopEmployeePd = new PageData();
		} else {
			//修改
			shopEmployeePd = shopEmployeeService.getById(id);
		}
		model.addAttribute("shopEmployee", shopEmployeePd);
		return "/account/seller-manage/seller-edit";
	}

	/**
	 * 保存员工信息
	 * @param request
	 * @param headImgFile
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月31日下午2:51:09
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public JSONObject saveOrUpdate(HttpServletRequest request, @RequestParam(value = "headImg", required = false) MultipartFile headImgFile) {
		JSONObject result = new JSONObject();
		PageData pd = new PageData();
		String id = request.getParameter("id");
		String mobile = request.getParameter("mobile");
		String name = request.getParameter("name");
		String state = request.getParameter("state");
		String shopId = request.getParameter("shopId");
		if (headImgFile != null && StringUtils.isNotEmpty(headImgFile.getOriginalFilename())) {
			//上传了头像
			String filePathType = "upload.shopImg";
			String path = PathUtil.getFilePath(filePathType);
			String fileName = SerialNum.getMoveOrderNo("");
			String fileAllName = FileUpload.fileUp(headImgFile, path, fileName);
			String fullPath = path + "/" + fileAllName;
			FileUpload.syncPost(headImgFile, fullPath, filePathType, fileName);
			pd.put("head_image", fileAllName);
		}
		if (StringUtils.isNotEmpty(mobile)) {
			pd.put("mobile", mobile);
		}
		if (StringUtils.isNotEmpty(name)) {
			pd.put("name", name);
		}
		if (StringUtils.isNotEmpty(shopId)) {
			pd.put("shop_id", shopId);
		}
		pd.put("state", state);
		int rowNum = 0;
		if (StringUtils.isEmpty(id)) {
			//新增
			pd.put("is_owner", "0");
			rowNum = shopEmployeeService.insertEmployee(pd);
		} else {
			//修改
			pd.put("id", id);
			rowNum = shopEmployeeService.updateEmployee(pd);
		}
		if (rowNum == 1) {
			result.put("status", "1");
			result.put("message", "");
		} else {
			result.put("status", "-2");
			result.put("message", "操作失败");
		}
		return result;
	}

	@RequestMapping(value = "/exportSellerList")
	public void exportSellerList(HttpServletResponse response, Page page) throws Exception {
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> list = shopEmployeeService.getSellerList(page);
		String fileName = pd.getString("fileName") + "_" + DateUtil.getDays();
		JSONArray ja = new JSONArray();

		JSONObject js = new JSONObject();
		js.put("colkey", "mobile");
		js.put("name", "手机号");
		js.put("hide", "");
		ja.add(js);

		JSONObject js2 = new JSONObject();
		js2.put("colkey", "name");
		js2.put("name", "姓名");
		js2.put("hide", "");
		ja.add(js2);

		JSONObject js3 = new JSONObject();
		js3.put("colkey", "is_owner");
		js3.put("name", "身份");
		js3.put("hide", "");
		Map<String, String> map = new HashMap<String, String>(2);
		map.put("0", "员工");
		map.put("1", "管理人");
		js3.put("mapKey", map);
		ja.add(js3);

		JSONObject js4 = new JSONObject();
		js4.put("colkey", "created_at");
		js4.put("name", "注册时间");
		js4.put("hide", "");
		ja.add(js4);

		JSONObject js5 = new JSONObject();
		js5.put("colkey", "state");
		js5.put("name", "状态");
		js5.put("hide", "");
		Map<String, String> map2 = new HashMap<String, String>(2);
		map2.put("0", "禁用");
		map2.put("1", "启用");
		map2.put("9", "解约");
		js5.put("mapKey", map2);
		ja.add(js5);

		JSONObject js6 = new JSONObject();
		js6.put("colkey", "shopsnum");
		js6.put("name", "关联商户数");
		js6.put("hide", "");
		ja.add(js6);

		JSONObject js7 = new JSONObject();
		js7.put("colkey", "cardNum");
		js7.put("name", "开卡数");
		js7.put("hide", "");
		ja.add(js7);

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
	 * 校验手机号是否可用
	 * @param phoneNum
	 * @return   status = 1 可用，否则不可用
	 * @author JHONNY
	 * @date 2016年7月31日下午4:44:07
	 */
	@RequestMapping(value = "/isMobileExist")
	@ResponseBody
	public JSONObject isMobileExist(String phoneNum) {
		if (StringUtils.isNotEmpty(phoneNum)) {
			return shopEmployeeService.checkShopkeeperMobile(phoneNum);
		} else {
			JSONObject result = new JSONObject();
			result.put("status", "-2");
			result.put("message", "待校验手机号为空");
			return result;
		}
	}

}
