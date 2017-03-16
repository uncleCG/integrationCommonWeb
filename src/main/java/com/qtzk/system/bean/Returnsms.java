package com.qtzk.system.bean;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Returnsms{
	private String returnstatus;//返回状态值：成功返回Success 失败返回：Faild
	private String message;		//返回信息
	private int remainpoint;	//返回余额,剩余条数
	private String taskID;		//返回本次任务的序列ID
	private int successCounts;	//成功短信数：当成功后返回提交成功短信数
	public Returnsms() {
		super();
	}
	/**
	 * 返回状态值：成功返回Success 失败返回：Faild
	 * @return
	 */
	public String getReturnstatus() {
		return returnstatus;
	}
	/**
	 * 返回信息：见下表<BR>
		ok	提交成功<BR>
		用户名或密码不能为空	提交的用户名或密码为空<BR>
		发送内容包含sql注入字符	包含sql注入字符<BR>
		用户名或密码错误	表示用户名或密码错误<BR>
		短信号码不能为空	提交的被叫号码为空<BR>
		短信内容不能为空	发送内容为空<BR>
		包含非法字符：	表示检查到不允许发送的非法字符<BR>
		对不起，您当前要发送的量大于您当前余额	当支付方式为预付费是，检查到账户余额不足<BR>
		其他错误	其他数据库操作方面的错误<BR>
	 * @return
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * 返回余额,剩余条数
	 * @return
	 */
	public int getRemainpoint() {
		return remainpoint;
	}
	/**
	 * 返回本次任务的序列ID
	 * @return
	 */
	public String getTaskID() {
		return taskID;
	}
	/**
	 * 成功短信数：当成功后返回提交成功短信数
	 * @return
	 */
	public int getSuccessCounts() {
		return successCounts;
	}
	public void setReturnstatus(String returnstatus) {
		this.returnstatus = returnstatus;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setRemainpoint(int remainpoint) {
		this.remainpoint = remainpoint;
	}
	public void setTaskID(String taskID) {
		this.taskID = taskID;
	}
	public void setSuccessCounts(int successCounts) {
		this.successCounts = successCounts;
	}
	
}
