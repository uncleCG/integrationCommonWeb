package com.qtzk.system.service.impl;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.qtzk.system.bean.Page;
import com.qtzk.system.bean.PageData;
import com.qtzk.system.dao.DAO;
import com.qtzk.system.service.AccountService;
import com.qtzk.system.utils.PhoneSmsNodeUtil;

@Service(value = "accountService")
public class AccountServiceImpl implements AccountService {

	@Resource(name = "daoSupport")
	private DAO dao;

	private Logger logger = LoggerFactory.getLogger(AccountServiceImpl.class);

	@Override
	public List<PageData> getTieBuyerListPage(Page page) {
		return (List<PageData>) dao.findForList("AccountMapper.getTieBuyerListPage", page);
	}

	@Override
	public List<PageData> getMyCardListPage(Page page) {
		return (List<PageData>) dao.findForList("AccountMapper.getMyCardListPage", page);
	}

	@Override
	public JSONObject updateCard(PageData pd) {
		JSONObject result = new JSONObject();
		int rowNum = (int) dao.update("AccountMapper.updateCard", pd);
		if (rowNum == 1) {
			result.put("status", "1");
			result.put("message", "");
			String ope = pd.getString("ope");
			String phoneNum = pd.getString("phoneNum");
			if (StringUtils.isNotEmpty(phoneNum) && StringUtils.isNotEmpty(ope)) {
				String cardCode = pd.getString("cardCode");
				if (StringUtils.isNotEmpty(cardCode)) {
					int strLen = cardCode.length();
					if (strLen > 3) {
						cardCode = cardCode.substring(strLen - 3);
					}
				}
				String smsContent = null;
				switch (ope) {
				case "1":
					//挂失
					smsContent = "您的尾号为" + cardCode + "的会员卡已挂失，请您及时补办，如有疑问，请拨打400-618-9386【擎天会员卡】";
					break;
				case "2":
					//冻结
					smsContent = "您的尾号为" + cardCode + "的会员卡已冻结，如需解冻，请拨打400-618-9386【擎天会员卡】";
					break;
				case "3":
					//解挂
					smsContent = "您的尾号为" + cardCode + "的会员卡已解除挂失，已恢复正常支付使用，如有疑问，请拨打400-618-9386【擎天会员卡】";
					break;
				case "4":
					//解冻
					smsContent = "您的尾号为" + cardCode + "的会员卡解冻成功，已恢复正常支付使用，如有疑问，请拨打400-618-9386【擎天会员卡】";
					break;
				case "5":
					//设置密码
					smsContent = "您的尾号为" + cardCode + "的会员卡的密码设置成功，请牢记您的密码，如需更改，请拨打400-618-9386【擎天会员卡】";
					break;
				case "6":
					//重置密码
					smsContent = "您的尾号为" + cardCode + "的会员卡密码修改成功，请牢记您的新密码，如有疑问，请拨打400-618-9386【擎天会员卡】";
					break;
				default:
					break;
				}
				try {
					PhoneSmsNodeUtil.sendMessage(phoneNum, smsContent);
				} catch (IOException e) {
					logger.error("操作通知短信发送异常", e);
				}
			}
		} else {
			result.put("status", "-2");
			result.put("message", "操作记录数异常");
		}
		return result;
	}

	@Override
	public List<PageData> getNoTieBuyerListPage(Page page) {
		return (List<PageData>) dao.findForList("AccountMapper.getNoTieBuyerListPage", page);
	}
}
