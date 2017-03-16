package com.qtzk.system.controller.base;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.service.impl.UploadImgService;

/**
 * 文件上传Controller
 *    
 * @author JHONNY
 * @date 2016年1月26日下午3:13:20
 */
@Controller
@RequestMapping(value = "/uploadImgController")
public class UploadImgController extends BaseController {
	@Resource(name = "uploadImgService")
	private UploadImgService uploadImgService;

	/**
	 * 到上传图片页
	 * @param uploadPathKey：上传图片存放路径key upload.properties
	 * @param model
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月26日上午10:56:55
	 */
	@RequestMapping(value = "/preUploadImg")
	public String preUploadImg(String uploadPathKey, Model model) {
		model.addAttribute("uploadPathKey", uploadPathKey);
		return "/common/cutImg";
	}

	/**
	 * 上传文件
	 * @param request
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月26日下午3:41:54
	 */
	@RequestMapping(value = "/uploadImg")
	@ResponseBody
	public JSONObject uploadImg(HttpServletRequest request) {
		return uploadImgService.uploadImg(request);
	}
}
