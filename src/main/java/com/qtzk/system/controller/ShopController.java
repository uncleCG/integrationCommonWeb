package com.qtzk.system.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.annotation.SystemLog;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.User;
import com.qtzk.system.controller.base.BaseController;
import com.qtzk.system.service.UserService;
import com.qtzk.system.service.impl.CommentDetailsService;
import com.qtzk.system.service.impl.DaqUserService;
import com.qtzk.system.service.impl.ImageDetailService;
import com.qtzk.system.service.impl.OperateLogService;
import com.qtzk.system.service.impl.ServiceTypeService;
import com.qtzk.system.service.impl.ShopEmployeeService;
import com.qtzk.system.service.impl.ShopService;
import com.qtzk.system.utils.DateUtil;

@Controller
@RequestMapping(value = "/shopController")
public class ShopController extends BaseController {
	private final Logger logger = LoggerFactory.getLogger(ShopController.class);

	@Resource(name = "shopService")
	private ShopService shopService;

	@Resource(name = "serviceTypeService")
	private ServiceTypeService serviceTypeService;

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "imageDetailService")
	private ImageDetailService imageDetailService;

	@Resource(name = "operateLogService")
	private OperateLogService operateLogService;

	@Resource(name = "commentDetailsService")
	private CommentDetailsService commentDetailsService;

	@Resource(name = "shopEmployeeService")
	private ShopEmployeeService shopEmployeeService;

	@Resource(name = "daqUserService")
	private DaqUserService daqUserService;

	/**
	 * 翻页获取列表页数据
	 * @param page
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月13日下午5:13:03
	 */
	@RequestMapping(value = "/findShopList")
	public String findByListPage(Page page, Model model) {
		PageData pd = this.getPageData();
		User manager = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		page.setPd(pd);
		model.addAttribute("shopList", shopService.findByListPage(page));
		model.addAttribute("page", page);
		model.addAttribute("pd", pd);
		model.addAttribute("manager", manager);
		model.addAttribute("oneServiceList", serviceTypeService.findAllOneServiceType());
		Integer oneService = pd.getInteger("oneService");
		if (oneService != null && oneService > 0) {
			model.addAttribute("twoServiceType", serviceTypeService.findTwoServiceByOneTypeService(oneService));
		}
		return "/pgc/shop/shop-library";
	}

	/**
	 * 根据一级服务获取二级服务
	 * @param oneService
	 * @return 
	 * @author JHONNY
	 * @date 2016年1月14日上午10:50:06
	 */
	@RequestMapping(value = "/findTwoService")
	@ResponseBody
	public JSONObject findTwoServiceByOneService(Integer oneService) {
		JSONObject result = new JSONObject();
		List<PageData> twoServiceTypeList = serviceTypeService.findTwoServiceByOneTypeService(oneService);
		if (twoServiceTypeList != null) {
			String jsonText = JSON.toJSONString(twoServiceTypeList, true);
			result.put("twoService", JSONArray.parseArray(jsonText));
			result.put("status", 1);
		} else {
			result.put("status", -2);
		}
		return result;
	}

	/**
	 * 到信息保存页
	 * @param shopId：商户id
	 * @param source：来源，0、运营后台录入；1、BD_App录入；2、BD_后台录入
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月14日上午11:39:22
	 */
	@RequestMapping(value = "/preEdit")
	public String preEdit(String shopId, Model model) {
		//获取所有一级服务列表，数据格式：List<PageData<id,name>>
		model.addAttribute("oneServiceTypeList", shopService.findAllOneServiceType());
		//获取所有二级服务列表，数据格式：List<parentId,HashMap<id,name>>
		model.addAttribute("twoServiceTypeMap", shopService.findAllTwoServiceType());
		//获取BD人员列表
		model.addAttribute("signDaqList", daqUserService.getAllFollowDaqUserList());
		PageData shopPd = null;
		if (shopId == null) {//新增
			shopPd = new PageData();
		} else {//修改
			shopPd = shopService.findShopBaseById(shopId);
			PageData shopkeeperPd = shopEmployeeService.getEmployeeSignInfoById(shopPd.getString("shopkeeper_id"));
			model.addAttribute("shopkeeperPd", shopkeeperPd);
		}
		model.addAttribute("shopPd", shopPd);
		return "/pgc/shop/shop-add";
	}

	/**
	 * 保存商户基本信息
	 * @param request
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月16日下午3:33:03
	 */
	@RequestMapping(value = "/saveOrUpdateShopBase")
	@ResponseBody
	@SystemLog(methods = "shopController/saveOrUpdateShopBase", module = "商户信息关系")
	public JSONObject saveOrUpdateShopBase(HttpServletRequest request) {
		PageData params = this.getPageData();
		return shopService.saveOrUpdateShopBase(request, params);
	}

	/**
	 * 获取商户详情
	 * @param shopId
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月17日下午2:59:58
	 */
	@RequestMapping(value = "/shopDetail")
	public String getShopDetail(String shopId, Model model) {
		getShopDetailInfo(shopId, model);
		return "/pgc/shop/shop-detail";
	}

	/**
	 * 获取商户详情，并存放到Model对象中
	 * @param shopId
	 * @param model   
	 * @author JHONNY
	 * @date 2016年2月18日下午6:02:00
	 */
	private void getShopDetailInfo(String shopId, Model model) {
		//获取商户基本信息
		PageData shopPd = shopService.findShopBaseById(shopId);
		model.addAttribute("shopPd", shopPd);
		//获取商户服务项目
		PageData twoServiceTypePd = new PageData();
		twoServiceTypePd.put("shopId", shopId);
		twoServiceTypePd.put("type", 2);
		model.addAttribute("twoServiceTypeList", shopService.getShopRelationshipByShopIdAndType(twoServiceTypePd));
		//回显商户管理人信息
		PageData shopkeeperPd = null;
		if (shopPd != null && !StringUtils.isEmpty(shopPd.getString("shopkeeper_id"))) {
			//获取商户管理者基本信息及拥有商户数和第一个商户名称
			shopkeeperPd = shopEmployeeService.getEmployeeSignInfoById(shopPd.getString("shopkeeper_id"));
		}
		model.addAttribute("shopkeeperPd", shopkeeperPd);
	}

	/**
	 * 查看操作日志
	 * @param page
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月18日下午1:51:27
	 */
	@RequestMapping(value = "/getOperateLog")
	public String getLogPageable(Page page, Model model) {
		PageData params = this.getPageData();
		//params.put("module", "商户信息管理");
		page.setPd(params);
		model.addAttribute("logList", operateLogService.getOperateLogPageableByModule(page));
		model.addAttribute("page", page);
		return "/pgc/shop/operate-log";
	}

	/**
	 * 评价列表
	 * @param page
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月18日下午1:51:27
	 */
	@RequestMapping(value = "/getCommentList")
	public String getCommentList(Page page, Model model) {
		PageData params = this.getPageData();
		params.put("type", 1);
		params.put("audit", 2);
		params.put("del_type", 0);
		page.setPd(params);
		model.addAttribute("commentList", commentDetailsService.getCommentDetailsListPageable(page));
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		return "/pgc/shop/shop-comment-list";
	}

	/**
	 * 员工列表
	 * @param page
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月18日下午9:05:28
	 */
	@RequestMapping(value = "/getEmployeeList")
	public String getEmployeeList(Page page, Model model) {
		PageData params = this.getPageData();
		page.setPd(params);
		model.addAttribute("employeeList", shopEmployeeService.getShopEmployeePageable(page));
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		return "/pgc/shop/shop-employee-list";
	}

	/**
	 * 到商户切换状态确认页
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月19日上午10:43:57
	 */
	@RequestMapping(value = "/preSwitchState")
	public String online(Model model) {
		PageData params = this.getPageData();
		Integer type = params.getInteger("type");
		if (type != null && type == 1) {
			//上架时显示下架原因
			PageData reasonPd = operateLogService.getLastestOperateLogByPd(params);
			model.addAttribute("operateLogPd", reasonPd);
		}
		model.addAttribute("params", params);
		return "/pgc/shop/shop-state-confirm";
	}

	/**
	 * 切换商户上下架状态
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月19日下午3:23:28
	 */
	@RequestMapping(value = "/switchState")
	@ResponseBody
	public JSONObject switchState() {
		return shopService.switchState(this.getPageData());
	}

	/**
	 * 获取商户交易记录
	 * @param page
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月19日下午5:27:00
	 */
	@RequestMapping(value = "/getTradeRecord")
	public String getTradeRecord(Page page, Model model) {
		PageData params = this.getPageData();
		page.setPd(params);
		model.addAttribute("recordList", shopService.getTradeRecordPageable(page));
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		return "/pgc/shop/shop-trade-record";
	}

	@RequestMapping(value = "/getRecordDetail")
	public String getTradeRecordDetail(String recordId, Model model) {
		PageData shopBillPd = shopService.getTradeRecordDetail(recordId);
		model.addAttribute("recordDetail", shopBillPd);
		if (shopBillPd != null && !StringUtils.isEmpty(shopBillPd.getString("coupon_id"))) {//使用优惠券，获取优惠券详情
			model.addAttribute("couponInfoPd", shopService.getCouponInfoById(shopBillPd.getString("coupon_id")));
		}
		return "/pgc/shop/shop-tradeRecord-detail";
	}

	/**
	 * 到签约页面
	 * @param shopId
	 * @param model
	 * @param moduleType：页面来源
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月20日下午4:23:10
	 */
	@RequestMapping(value = "/preSign")
	public String preSign(String shopId, String moduleType, Model model) {
		//获取商户的基本签约信息
		PageData shopBasePd = shopService.getShopRebateBaseByShopId(shopId);
		model.addAttribute("shopBasePd", shopBasePd);
		//回显商户管理人信息
		PageData shopkeeperPd = null;
		if (shopBasePd != null && !StringUtils.isEmpty(shopBasePd.getString("shopkeeper_id"))) {
			//获取商户管理者基本信息及拥有商户数和第一个商户名称
			shopkeeperPd = shopEmployeeService.getEmployeeSignInfoById(shopBasePd.getString("shopkeeper_id"));
		} else {//BD App 采集的商户，签约信息没有
			String shopkeeperMobile = shopBasePd.getString("manager_mobile");
			shopkeeperPd = new PageData();
			shopkeeperPd.put("mobile", shopkeeperMobile);
			shopkeeperPd.put("name", shopBasePd.getString("manager_name"));
			shopkeeperPd.put("idcard", shopBasePd.getString("manager_idcard"));
			if (!StringUtils.isEmpty(shopkeeperMobile)) {
				JSONObject mobileCheckResultJson = shopEmployeeService.checkShopkeeperMobile(shopkeeperMobile);
				int resultStatus = mobileCheckResultJson.getIntValue("status");
				switch (resultStatus) {
				case -1://管理人已存在，在商户中设置管理人的关联id
					String shopkeeperId = mobileCheckResultJson.getString("shopkeeperId");
					PageData tmpShopPd = new PageData();
					tmpShopPd.put("shopId", shopId);
					tmpShopPd.put("shopkeeper_id", shopkeeperId);
					//将已存在管理人id设置到商户表中
					tmpShopPd.put("poi_type", "-1");//避免修改签约信息时置空poi_type
					shopService.updateShop(tmpShopPd);
					//获取管理人信息
					shopkeeperPd = shopEmployeeService.getEmployeeSignInfoById(shopkeeperId);
					//设置页面展示所需值
					shopBasePd.put("shopkeeper_id", shopkeeperId);
					break;
				case 1://管理人手机号不存在，新增管理人信息
					shopkeeperPd.put("state", 1);
					shopkeeperPd.put("is_owner", 1);
					shopkeeperPd.put("created_at", DateUtil.getTime());
					shopkeeperPd.put("shop_id", shopId);
					shopkeeperPd.put("updated_at", DateUtil.getTime());
					//新增商户管理人
					shopEmployeeService.insertEmployee(shopkeeperPd);
					PageData newShopPd = new PageData();
					newShopPd.put("shopId", shopId);
					newShopPd.put("shopkeeper_id", shopkeeperPd.getString("id"));
					//将新增管理人id设置到商户表中
					newShopPd.put("poi_type", "-1");//避免修改签约信息时置空poi_type
					shopService.updateShop(newShopPd);
					//设置页面展示所需值
					shopkeeperPd.put("shop_id", shopId);//在页面上标识管理人为新建（用于修改管理人）
					shopBasePd.put("shopkeeper_id", shopkeeperPd.getString("id"));
					shopkeeperPd.put("shopNum", "1");
					shopkeeperPd.put("firstShopName", shopBasePd.getString("name"));
					break;
				case -2://异常
					break;
				default:
					break;
				}
			}
		}
		model.addAttribute("shopkeeperPd", shopkeeperPd);
		//获取商户的返利设置信息
		List<PageData> shopRebatePdList = (List<PageData>) shopService.getShopRebateByShopId(shopId);
		if (shopRebatePdList != null && !shopRebatePdList.isEmpty()) {
			for (PageData shopRebatePd : shopRebatePdList) {
				if (shopRebatePd.getInt("consume_type") == 1) {
					model.addAttribute("sr1Pd", shopRebatePd);
				} else {
					model.addAttribute("sr2Pd", shopRebatePd);
				}
			}
		}
		if (!StringUtils.isEmpty("moduleType") && ("0".equals(moduleType) || "1".equals(moduleType) || "4".equals(moduleType))) {
			//运营后台操作，获取BD人员列表
			model.addAttribute("signDaqList", daqUserService.getAllFollowDaqUserList());
		}
		model.addAttribute("shopId", shopId);
		model.addAttribute("moduleType", moduleType);
		return "/pgc/shop/shop-sign";
	}

	/**
	 * 获取待选择的商户管理人信息
	 * @param page
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月23日上午11:55:25
	 */
	@RequestMapping(value = "/chooseShopkeeper")
	public String chooseShopkeeper(Page page, Model model) {
		List<PageData> shopkeeperPdList = null;
		PageData params = this.getPageData();
		page.setPd(params);
		try {
			shopkeeperPdList = shopEmployeeService.getShopkeeperPageable(page);
		} catch (Exception e) {
			this.logger.error("exception-info", e);
		}
		model.addAttribute("page", page);
		model.addAttribute("pd", params);
		model.addAttribute("shopkeeperPdList", shopkeeperPdList);
		return "/pgc/shop/choose-shopkeeper";
	}

	/**
	 * 保存商户签约信息
	 * @param request
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月23日上午11:55:57
	 */
	@RequestMapping(value = "/saveOrUpdateShopRebate")
	@ResponseBody
	public JSONObject saveOrUpdateShopRebate(HttpServletRequest request) {
		return shopService.saveOrUpdateShopRebate(request);
	}

	/**
	 * 商户列表page
	 * @param 
	 * @param model
	 * @return   
	 * @author Eric
	 * @date 2016年1月20日下午4:23:10
	 */
	@RequestMapping(value = "/getShopListPage")
	public String getShopListPage(Model model, Page page) {
		PageData pd = this.getPageData();

		PageData pageData = new PageData();
		pageData.put("name", pd.getString("name"));
		pageData.put("code", pd.getString("code"));

		page.setPd(pageData);
		List list = shopService.getShopListPage(page);

		model.addAttribute("pageData", pageData);
		model.addAttribute("page", page);
		model.addAttribute("list", list);

		return "/account/seller-manage/shop-plist";
	}

	/**
	 * 合同编号唯一性校验
	 * @param contractCode
	 * @return  status = 1 可以使用
	 * @author JHONNY
	 * @date 2016年1月25日上午9:56:19
	 */
	@RequestMapping(value = "/checkContractCode")
	@ResponseBody
	public JSONObject checkContractCode(String contractCode) {
		return shopService.checkContractCode(contractCode);
	}

	/**
	 * 管理人手机号唯一性校验
	 * @param contractCode
	 * @return  status = 1 可以使用
	 * @author JHONNY
	 * @date 2016年1月25日上午9:56:19
	 */
	@RequestMapping(value = "/checkShopkeeperMobile")
	@ResponseBody
	public JSONObject checkShopkeeperMobile(String nowMobile) {
		return shopEmployeeService.checkShopkeeperMobile(nowMobile);
	}

	/**
	 * 商户名称唯一性校验
	 * @param contractCode
	 * @return  status = 1 可以使用
	 * @author JHONNY
	 * @date 2016年1月25日上午9:56:19
	 */
	@RequestMapping(value = "/checkShopName")
	@ResponseBody
	public JSONObject checkShopName(String shopName) {
		return shopService.checkShopName(shopName);
	}

	/**
	 * 获取待审核商户列表
	 * @param page
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月18日下午5:57:02
	 */
	@RequestMapping(value = "/authShopList")
	public String shopAuthList(Page page, Model model) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		model.addAttribute("shopAuthList", shopService.findShopAuthListPageable(page));
		model.addAttribute("page", page);
		model.addAttribute("pd", pd);
		Integer module = pd.getInteger("module");
		if (module != null && module == 4) {
			model.addAttribute("module", 4);
			return "/operate/auth/authShopList";
		} else {
			model.addAttribute("followDaqUserPdList", daqUserService.getAllFollowDaqUserList());//负责人列表
			model.addAttribute("module", 3);
			return "/operate/auth/bdAuthShopList";
		}
	}

	/**
	 * 显示待审核商户详细信息
	 * @param shopId
	 * @param moduleType：操作来源：0、运营后台进入审核；3、待审核商户_BD总监；
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月18日下午5:57:02
	 */
	@RequestMapping(value = "/preAuthShop")
	public String bdPreAuthShop(String shopId, String moduleType, Model model) {
		getShopDetailInfo(shopId, model);
		model.addAttribute("module", moduleType);//操作来源：0、运营后台进入审核；3、待审核商户_BD总监；
		return "/operate/auth/authShop";
	}

	/**
	 * 审核商户签约信息
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月18日下午7:20:37
	 */
	@RequestMapping(value = "/authShopSign")
	@ResponseBody
	public JSONObject authShopSign() {
		return shopService.authShopSign(this.getPageData());
	}

	/**
	 * 审核商户基本信息
	 * @return   
	 * @author JHONNY
	 * @date 2016年2月18日下午7:20:37
	 */
	@RequestMapping(value = "/authShopBase")
	@ResponseBody
	public JSONObject authShopBase() {
		return shopService.authShopBase(this.getPageData());
	}

	/**
	 * 从卖家管理页面进入商户列表
	 * @param page
	 * @param model
	 * @return 商户列表   
	 * @author aquarius
	 * @date 2016年4月11日上午10:26:11
	 */
	@RequestMapping(value = "/findListByEmployee")
	public String findByList(Page page, Model model) {
		PageData pd = this.getPageData();
		page.setPd(pd);
		model.addAttribute("shopList", shopService.findListByEmployee(page));
		return "/pgc/shop/employee-shop-list";
	}
}
