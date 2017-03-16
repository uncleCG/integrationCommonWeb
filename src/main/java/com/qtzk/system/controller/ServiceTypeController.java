package com.qtzk.system.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.controller.base.BaseController;
import com.qtzk.system.service.impl.ServiceTypeService;

@Controller
@RequestMapping(value = "/serviceTypeController")
public class ServiceTypeController extends BaseController {

	@Resource(name = "serviceTypeService")
	private ServiceTypeService serviceTypeService;

	/**
	 * 获取列表数据
	 * @param model
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月10日下午5:51:36
	 */
	@RequestMapping(value = "/getDataList")
	public String getDataList(Model model, Page page) {
		PageData param = this.getPageData();
		PageData pageData = new PageData();
		pageData.put("type", param.getString("type"));
		if (StringUtils.isEmpty(pageData.getString("parentId"))) {
			pageData.put("parentId", param.getString("parentId"));
		}
		page.setPd(pageData);
		List<PageData> pdList = serviceTypeService.findByListPage(page);
		model.addAttribute("pageData", pageData);
		model.addAttribute("page", page);
		model.addAttribute("pdList", pdList);
		return "/pgc/service-type/service-type-list";
	}

	/**
	 * 根据id删除对应数据
	 * @param id
	 * @param type
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月10日下午5:48:01
	 */
	@RequestMapping(value = "/delById")
	@ResponseBody
	public JSONObject delById(Integer id, Integer type) {
		return serviceTypeService.delServiceTypeById(id, type);
	}

	/**
	 * 根据id获取其详细信息
	 * @param id
	 * @param model
	 * @param parentId
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月10日下午5:50:29
	 */
	@RequestMapping(value = "/preEdit")
	public String getInfoById(Integer id, Integer type, Integer parentId, Model model) {
		PageData pd = null;
		if (id != null) {//修改
			pd = serviceTypeService.getById(id);
		} else {//新增
			pd = new PageData();
			pd.put("type", type);
		}
		if (type != null && type == 2) {//二级服务
			pd.put("parentId", parentId);
		}
		model.addAttribute("pd", pd);
		return "/pgc/service-type/service-type-add";
	}

	/**
	 * 保存信息
	 * @param request
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月10日下午5:51:18
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public JSONObject saveOrUpdate(HttpServletRequest request, @RequestParam(value = "logoImg", required = false) MultipartFile logoImg) {
		PageData pd = new PageData();
		pd.put("id", request.getParameter("id"));
		pd.put("name", request.getParameter("name"));
		pd.put("type", request.getParameter("type"));
		pd.put("parentId", request.getParameter("parentId"));
		pd.put("state", request.getParameter("state"));
		return serviceTypeService.saveOrUpdate(pd, logoImg);
	}

	/**
	 * 保存品牌信息
	 * @param request
	 * @param id
	 * @param name
	 * @param full_name
	 * @param logoImg
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月12日下午3:46:13
	 */
	@RequestMapping(value = "/saveOrUpdateBrand")
	@ResponseBody
	public JSONObject saveOrUpdateBrand(HttpServletRequest request, @RequestParam(value = "logoImg", required = false) MultipartFile logoImg, Model model) {
		PageData pd = new PageData();
		pd.put("id", request.getParameter("id"));
		pd.put("name", request.getParameter("name"));
		pd.put("full_name", request.getParameter("full_name"));
		pd.put("type", request.getParameter("type"));
		return serviceTypeService.saveOrUpdateBrand(pd, logoImg);
	}

	@RequestMapping(value = "/isExist")
	@ResponseBody
	public JSONObject isExist() {
		PageData pd = this.getPageData();
		return serviceTypeService.isExist(pd);
	}

	/**
	 * 更新服务类型基本信息（非图标信息）
	 * @return   
	 * @author JHONNY
	 * @date 2016年4月18日下午3:15:56
	 */
	@RequestMapping(value = "/updateServiceTypeBase")
	@ResponseBody
	public JSONObject updateServiceTypeBase() {
		MultipartFile logoImg = null;
		return serviceTypeService.saveOrUpdate(this.getPageData(), logoImg);
	}
}
