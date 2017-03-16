package com.qtzk.system.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;

/**
 * 买家服务接口
 *    
 * @author JHONNY
 * @date 2016年7月28日下午5:46:55
 */
public interface AccountService {

	/**
	 * 分页获取绑卡买家列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月28日下午5:47:10
	 */
	public List<PageData> getTieBuyerListPage(Page page);

	/**
	 * 分页获取帮卡买家的会员卡列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月29日上午11:09:27
	 */
	public List<PageData> getMyCardListPage(Page page);

	/**
	 * 维护已开通会员卡的状态、密码
	 * @param pd
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月29日上午11:49:37
	 */
	public JSONObject updateCard(PageData pd);

	/**
	 * 分页获取未绑卡买家列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月30日下午4:11:10
	 */
	public List<PageData> getNoTieBuyerListPage(Page page);
}
