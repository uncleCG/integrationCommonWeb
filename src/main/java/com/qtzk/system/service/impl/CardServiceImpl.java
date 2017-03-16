package com.qtzk.system.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.bean.User;
import com.qtzk.system.dao.DaoSupport;
import com.qtzk.system.service.CardService;
import com.qtzk.system.utils.TokenBaseInter;
import com.qtzk.system.utils.TokenToolEncrypterBase64;

/**
 * 会员卡服务接口实现
 *    
 * @author JHONNY
 * @date 2016年7月25日上午11:54:06
 */
@Service(value = "cardService")
public class CardServiceImpl implements CardService {

	private static final Logger logger = LoggerFactory.getLogger(CardServiceImpl.class);

	private static final Exception SystemException = null;

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Override
	public List<PageData> getBlankCardListPageable(Page page) {
		List<PageData> blankCardPdList = null;
		blankCardPdList = (List<PageData>) dao.findForList("CardMapper.getBlankCardListPage", page);
		return blankCardPdList;
	}

	@Override
	public JSONObject save(PageData pd) {
		JSONObject result = new JSONObject();
		User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		if (currentUser != null) {
			int startNum = pd.getInt("batch_start");
			int endNum = pd.getInt("batch_end");
			int totalNum = endNum - startNum + 1;
			pd.put("state", "0");
			pd.put("manager_id", currentUser.getId());
			pd.put("total_num", totalNum);
			pd.put("remain_num", totalNum);

			PageData check = new PageData();
			check.put("receiveStart", startNum);
			check.put("receiveEnd", endNum);
			PageData checkPd = (PageData) dao.findForObject("CardMapper.cardNewCheck", check);
			if (checkPd != null) {
				if (checkPd.getInteger("totalNum") != 0) {
					result.put("status", "-1");
					result.put("message", "操作失败，新增号段数据已存在！");
					return result;
				}
			}
			//记录主表
			int rowNum = (int) dao.save("CardMapper.saveMaster", pd);
			if (rowNum == 1) {
				TokenBaseInter base64 = new TokenToolEncrypterBase64();
				String masterId = pd.getString("id");
				//记录子表
				PageData detailParams = new PageData();
				//每次提交的记录数
				int batchSize = 300;
				PageData[] detailPdArr = null;
				if (totalNum >= batchSize) {
					detailPdArr = new PageData[batchSize];
				} else {
					detailPdArr = new PageData[totalNum];
				}
				int arrIndex = 0;
				//批量执行的次数
				int batchNum = 0;
				for (int i = 0; i < totalNum; i++) {
					PageData tmpPd = new PageData();
					tmpPd.put("master_id", masterId);
					int cardCode = startNum + i;
					String cardKey = base64.productToken(new String[] { cardCode + "" });
					tmpPd.put("card_code", cardCode);
					tmpPd.put("card_key", cardCode + "#" + cardKey);
					detailPdArr[arrIndex++] = tmpPd;
					if ((i + 1) % batchSize == 0 || (i == totalNum - 1)) {
						//执行次数 + 1
						batchNum++;
						//批量更新到数据库
						detailParams.put("detailPdArr", detailPdArr);
						rowNum = (int) dao.save("CardMapper.batchSaveDetail", detailParams);
						//数组下标重新开始计数
						arrIndex = 0;
						//剩余记录数
						int residueNum = totalNum - batchNum * batchSize;
						//判断执行结果数是否正确
						if (rowNum == batchSize || residueNum <= 0) {
							detailPdArr = null;
							//判断新建数组长度
							if (residueNum >= batchSize) {
								detailPdArr = new PageData[batchSize];
							} else {
								detailPdArr = new PageData[residueNum > 0 ? residueNum : 0];
							}
							detailParams.remove("detailParams");
							result.put("status", "1");
							result.put("message", "操作成功");
						} else {
							result.put("status", "-2");
							result.put("message", "子表记录数异常");
							break;
						}
					}
				}
			} else {
				result.put("status", "-2");
				result.put("message", "主表操作记录数异常");
			}
		} else {
			result.put("status", "-2");
			result.put("message", "操作失败，请重新登录后重试");
		}
		return result;
	}

	@Override
	public List<PageData> getCardDetailListByMasterId(String masterId) {
		List<PageData> cardDetailPdList = null;
		if (StringUtils.isNotEmpty(masterId)) {
			cardDetailPdList = (List<PageData>) dao.findForList("CardMapper.getCardDetailListByMasterId", masterId);
		}
		return cardDetailPdList;
	}

	@Override
	public JSONObject entryWarehouse(PageData pd) {
		JSONObject result = new JSONObject();
		User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("userSession");
		if (currentUser != null) {
			pd.put("storage_manager_id", currentUser.getId());
			//更新主表为入库状态
			int rowNum = (int) dao.update("CardMapper.updateMaster", pd);
			if (rowNum == 1) {
				//更新从表为入库状态
				dao.update("CardMapper.updateDetail", pd);
				result.put("status", "1");
				result.put("message", "操作成功");
			} else {
				result.put("status", "-2");
				result.put("message", "主表操作记录数异常");
			}
		} else {
			result.put("status", "-2");
			result.put("message", "操作失败，请重新登录后重试");
		}
		return result;
	}

	@Override
	public PageData getCardInfoByCardCode(String cardCode) {
		PageData cardInfoPd = null;
		if (StringUtils.isNotBlank(cardCode)) {
			cardInfoPd = (PageData) dao.findForObject("CardMapper.getCardInfoByCardCode", cardCode);
		}
		return cardInfoPd;
	}

	@Override
	public JSONObject cardDestory(PageData pd) {
		JSONObject result = new JSONObject();
		//更新主表未领取库存数量减一
		pd.put("remain_num", "1");
		int rowNum = (int) dao.update("CardMapper.updateMaster", pd);
		if (rowNum == 1) {
			//更新从表为作废状态
			pd.put("state", "-1");
			rowNum = (int) dao.update("CardMapper.updateDetail", pd);
			if (rowNum == 1) {
				result.put("status", "1");
				result.put("message", "操作成功");
			} else {
				result.put("status", "-2");
				result.put("message", "从表操作记录数异常");
			}
		} else {
			result.put("status", "-2");
			result.put("message", "主表操作记录数异常");
		}
		return result;
	}

	@Override
	public List<PageData> getReceiveCardListPage(Page page) {
		List<PageData> receiveCardPdList = null;
		receiveCardPdList = (List<PageData>) dao.findForList("CardMapper.getReceiveCardListPage", page);
		return receiveCardPdList;
	}

	@Override
	public PageData cardReceiveCheck(PageData pd) {
		//校验领取号码段内的作废卡、已领取卡情况
		PageData checkPd = (PageData) dao.findForObject("CardMapper.cardReceiveCheck", pd);
		return checkPd;
	}

	@Override
	public JSONObject cardReceive(PageData pd) {
		JSONObject result = new JSONObject();
		//领取卡数量
		int totalNum = pd.getInt("totalNum");
		//1、更新master表未领取卡数量
		String masterId = pd.getString("masterId");
		PageData masterPd = new PageData();
		masterPd.put("masterId", masterId);
		masterPd.put("remain_num", totalNum);
		dao.update("CardMapper.updateMaster", masterPd);
		//2、保存领取卡信息到receive表中
		pd.put("receiveNum", totalNum);
		dao.save("CardMapper.saveCardReceive", pd);
		//3、更新detail表被领取卡的状态等信息
		dao.update("CardMapper.cardReceiveDetail", pd);
		result.put("status", "1");
		result.put("message", "操作成功");
		return result;
	}

	@Override
	public List<PageData> getEligibleBatchList(PageData pd) {
		List<PageData> eligibleBatchPdList = null;
		eligibleBatchPdList = (List<PageData>) dao.findForList("CardMapper.getEligibleBatchList", pd);
		return eligibleBatchPdList;
	}
}
