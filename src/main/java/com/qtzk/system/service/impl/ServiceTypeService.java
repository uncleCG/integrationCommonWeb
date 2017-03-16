package com.qtzk.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.dao.DaoSupport;
import com.qtzk.system.utils.FileUpload;
import com.qtzk.system.utils.PathUtil;
import com.qtzk.system.utils.SerialNum;

@Service("serviceTypeService")
public class ServiceTypeService {

	private static final Logger logger = LoggerFactory.getLogger(ServiceTypeService.class);
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 根据id获取其详细信息
	 * @param id
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月10日下午5:23:35
	 */
	public PageData getById(Integer id) {
		PageData manager = null;
		if (id != null) {
			try {
				manager = (PageData) this.dao.findForObject("ServiceTypeMapper.getById", id);
			} catch (Exception e) {
				logger.error("exception-info", e);
			}
		}
		return manager;
	}

	/**
	 * 保存
	 * @param pd
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月10日下午5:29:08
	 */
	public JSONObject saveOrUpdate(PageData pd, MultipartFile logoImg) {
		JSONObject result = new JSONObject();
		String type = pd.getString("type");
		try {
			if (logoImg != null && !StringUtils.isEmpty(logoImg.getOriginalFilename())) {//修改了 LOGO
				String filePathType = "upload.shopImg";
				String path = PathUtil.getFilePath(filePathType);
				String fileName = SerialNum.getMoveOrderNo("");
				String fileAllName = FileUpload.fileUp(logoImg, path, fileName);
				String fullPath = path + "/" + fileAllName;
				FileUpload.syncPost(logoImg, fullPath, filePathType, fileName);
				pd.put("logo", fileAllName);
			}
			if (!StringUtils.isEmpty(pd.getString("id"))) {//修改
				if (StringUtils.isNotEmpty(type) && "1".equals(type) && StringUtils.isNotEmpty(pd.getString("state")) && "0".equals(pd.getString("state"))) {
					//如果一级进行屏蔽操作，则屏蔽一级下所有二级
					pd.put("parentId", pd.getString("id"));
				}
				int rowNum = (int) dao.update("ServiceTypeMapper.update", pd);
				if (rowNum > 0) {
					result.put("status", 1);
					result.put("message", "操作成功");
				} else {
					result.put("status", -2);
					result.put("message", "执行结果异常，请稍候重试");
				}
			} else {//增加
				boolean secServiceFlag = !StringUtils.isEmpty(type) && "2".equals(type);//是否是二级服务的标记，是=true，否=false
				if (secServiceFlag) {//二级服务
					pd.put("state", 1);
				} else {
					pd.put("state", 0);//新增数据状态为屏蔽
				}
				int rowNum = (int) dao.save("ServiceTypeMapper.insert", pd);
				if (rowNum == 1) {
					if (secServiceFlag) {//二级服务
						PageData relationshipParam = new PageData();
						relationshipParam.put("serviceTypeId", pd.getString("parentId"));
						relationshipParam.put("serviceBrandId", pd.getString("id"));
						relationshipParam.put("type", 2);
						dao.save("ServiceTypeMapper.saveRelationShip", relationshipParam);//维护一二级服务类型关联关系
					}
					result.put("status", 1);
				} else {
					result.put("status", -2);
					result.put("message", "执行结果异常，请稍候重试");
				}
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
			result.put("status", -2);
			result.put("message", "数据操作异常，请稍候重试");
		}
		return result;
	}

	/**
	 * 分页获取数据
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月10日下午5:32:37
	 */
	public List<PageData> findByListPage(Page page) {
		List<PageData> pdList = null;
		PageData param = page.getPd();
		try {
			String mapperSqlId = "ServiceTypeMapper.findByListPage";
			if (param != null) {
				String type = param.getString("type");
				if (!StringUtils.isEmpty(type)) {
					if ("2".equals(type)) {//二级服务
						mapperSqlId = "ServiceTypeMapper.findSecServiceByListPage";
					}
				}
			}
			pdList = (List<PageData>) dao.findForList(mapperSqlId, page);
		} catch (Exception e) {
			logger.error("exception-info", e);
		}
		return pdList;
	}

	/**
	 * 根据id删除数据
	 * @param managerId
	 * @param type
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月7日下午4:57:48
	 */
	public JSONObject delServiceTypeById(Integer id, Integer type) {
		JSONObject result = new JSONObject();
		if (id != null) {
			try {
				int rowNum = (int) dao.delete("ServiceTypeMapper.delById", id);
				if (rowNum == 1) {
					if (type != null && type == 2) {//删除二级服务时，删除其关联关系
						dao.delete("ServiceTypeMapper.delRelatioshipByServiceId", id);
					}
					result.put("status", 1);
					result.put("message", "操作成功");
				} else {
					result.put("status", "-2");
					result.put("message", "执行结果异常，请稍候重试");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据操作异常，请稍候重试");
			}
		} else {
			result.put("status", -2);
			result.put("message", "参数异常");
		}
		return result;
	}

	/**
	 * 获取所有上架状态的一级服务类型
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月11日下午3:55:50
	 */
	public List<PageData> findAllOneServiceType() {
		try {
			return (List<PageData>) dao.findForList("ServiceTypeMapper.findAllOneService", null);
		} catch (Exception e) {
			logger.error("exception-info", e);
			return null;
		}
	}

	/**
	 * 根据一级服务获取二级服务列表
	 * @param oneService
	 * @return 
	 * @author JHONNY
	 * @date 2016年1月14日上午10:33:12
	 */
	public List<PageData> findTwoServiceByOneTypeService(Integer oneService) {
		try {
			return (List<PageData>) dao.findForList("ServiceTypeMapper.findAllByOneService", oneService);
		} catch (Exception e) {
			logger.error("exception-info", e);
			return null;
		}
	}

	/**
	 * 判断指定字符串是否存在
	 * @param param 带校验字符串
	 * @param type 字符串类型，品牌 = 1，其它=非空
	 * @return 不存在返回status=1，否则返回status=-2
	 * @author JHONNY
	 * @date 2016年1月12日上午11:44:03
	 */
	public JSONObject isExist(PageData pd) {
		JSONObject result = new JSONObject();
		try {
			PageData dbPd = (PageData) dao.findForObject("ServiceTypeMapper.findIsExist", pd);
			if (dbPd != null && dbPd.getInt("rowNum") > 0) {//存在
				result.put("status", -2);
			} else {
				result.put("status", 1);
			}
		} catch (Exception e) {
			logger.error("exception-info", e);
			result.put("status", -2);
		}
		return result;
	}

	/**
	 * 保存品牌信息
	 * @param pd
	 * @param logoImg
	 * @return   
	 * @author JHONNY
	 * @date 2016年1月12日下午3:25:26
	 */
	public JSONObject saveOrUpdateBrand(PageData pd, MultipartFile logoImg) {
		JSONObject result = new JSONObject();
		String id = pd.getString("id");
		if (logoImg != null && !StringUtils.isEmpty(logoImg.getOriginalFilename())) {//修改了 LOGO
			String filePathType = "upload.shopImg";
			String path = PathUtil.getFilePath(filePathType);
			String fileName = SerialNum.getMoveOrderNo("");
			String fileAllName = FileUpload.fileUp(logoImg, path, fileName);
			String fullPath = path + "/" + fileAllName;
			FileUpload.syncPost(logoImg, fullPath, filePathType, fileName);
			pd.put("logo", fileAllName);
		}
		if (!StringUtils.isEmpty(id)) {//修改
			try {
				int rowNum = (int) dao.update("ServiceTypeMapper.update", pd);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "");
				} else {
					result.put("status", -2);
					result.put("message", "数据操作异常，请稍后重试");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据库操作异常，请稍后重试");
			}
		} else {//新增
			pd.put("state", "1");
			try {
				int rowNum = (int) dao.save("ServiceTypeMapper.insert", pd);
				if (rowNum == 1) {
					result.put("status", 1);
					result.put("message", "");
				} else {
					result.put("status", -2);
					result.put("message", "数据操作异常，请稍后重试");
				}
			} catch (Exception e) {
				logger.error("exception-info", e);
				result.put("status", -2);
				result.put("message", "数据库操作异常，请稍后重试");
			}
		}
		result.put("pd", pd);
		return result;
	}
}
