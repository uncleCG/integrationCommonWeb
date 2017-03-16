package com.qtzk.system.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;

/**
 * 会员卡服务接口
 *    
 * @author JHONNY
 * @date 2016年7月25日上午11:25:50
 */
public interface CardService {

	/**
	 * 分页获取空卡录入数据列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月25日上午11:27:02
	 */
	public List<PageData> getBlankCardListPageable(Page page);

	/**
	 * 新增入库信息
	 * @param pd
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月25日下午5:10:10
	 */
	public JSONObject save(PageData pd);

	/**
	 * 根据入库批次id获取其下所有会员卡信息
	 * @param masterId
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午3:04:38
	 */
	public List<PageData> getCardDetailListByMasterId(String masterId);

	/**
	 * 会员卡入库
	 * @param pd
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午3:42:57
	 */
	public JSONObject entryWarehouse(PageData pd);

	/**
	 * 根据卡号获取会员卡信息
	 * @param cardCode
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午5:48:02
	 */
	public PageData getCardInfoByCardCode(String cardCode);

	/**
	 * 会员卡报废
	 * @param pd
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月26日下午3:42:57
	 */
	public JSONObject cardDestory(PageData pd);

	/**
	 * 分页获取已领取会员卡列表
	 * @param page
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日上午10:28:59
	 */
	public List<PageData> getReceiveCardListPage(Page page);

	/**
	 * 校验领取会员卡号段内信息
	 * @param pd
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日下午3:36:26
	 */
	public PageData cardReceiveCheck(PageData pd);

	/**
	 * 会员卡领取
	 * @param pd
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日上午11:49:32
	 */
	public JSONObject cardReceive(PageData pd);

	/**
	 * 获取可用会员卡入库批次列表
	 * @param pd
	 * @return   
	 * @author JHONNY
	 * @date 2016年7月27日下午4:16:30
	 */
	public List<PageData> getEligibleBatchList(PageData pd);

}
