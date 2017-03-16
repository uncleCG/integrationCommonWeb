package com.qtzk.system.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Right;
import com.qtzk.system.service.RightService;

@Controller
@RequestMapping(value = "/rightController")
public class RightController {

	@Resource(name = "rightService")
	private RightService rightService;

	@RequestMapping(value = "/getAllRight")
	public String getAllRight(Model model) throws Exception {
		List<Right> list = rightService.getAllRight();
		model.addAttribute("list", list);
		return "/system/function/function-list";
	}

	/**
	 * 根据id获取权限的详细信息
	 * @param funcId
	 * @param model
	 * @return
	 * @author JHONNY
	 */
	@RequestMapping(value = "/getFuncInfoById")
	public String getFuncInfoById(Integer funcId, Integer parentId, Integer type, Model model) {
		Right right = null;
		if (funcId != null) {//修改
			right = rightService.getRightById(funcId);
		} else {//新增
			right = new Right();
			right.setType(type);
			right.setParentId(parentId);
		}
		model.addAttribute("right", right);
		return "/system/function/function-add";
	}

	/**
	 * 保存权限的信息
	 * @param right
	 * @return
	 * @author JHONNY
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public JSONObject saveOrUpdate(Right right) {
		return rightService.saveOrUpdateRight(right);
	}

	/**
	 * 根据id删除指定功能
	 * @param funcId
	 * @return
	 * @author JHONNY
	 */
	@RequestMapping(value = "/delById")
	@ResponseBody
	public JSONObject delFuncById(Integer funcId) {
		return rightService.delRightById(funcId);
	}

	/**
	 * 样式选择页面
	 * @param model
	 * @return
	 * @author aquarius
	 * @date 2016年4月12日 上午11:00:12 
	 * @throws Exception
	 */
	@RequestMapping(value = "/iconSelect")
	public String iconSelect(Model model) throws Exception {
		return "/system/function/icon-select";
	}

}
