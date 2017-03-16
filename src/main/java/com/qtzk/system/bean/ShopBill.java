package com.qtzk.system.bean;

import java.sql.Timestamp;
import java.util.Date;

public class ShopBill {
	private Integer id;
	private String bill_code;// '账单编号',
	private String amount;// '交易总额',
	private Integer rebate_points;// '获得的擎天',
	private String qrcode_image;// '二维码图片地址',
	private String trade_code;// '交易码',
	private String card_code;// '卡号',
	private Integer type;// '消费类型，1-消费，2-充值',
	private Timestamp trade_time;// '交易时间',
	private Date created_at;// '创建账单时间',
	private Integer created_by;// '创建账单员工ID',
	private String pay_mobile;// '付款人手机号',
	private Integer pay_by;// '付款人ID（account表accountId）',
	private String pay_name;// '付款人名字',
	private Double balance_pay;// '余额支付',
	private Double offline_pay;// '线下支付',
	private Double restore_pay;// '参返金额',
	private Integer trade_status;// '交易状态，0-待支付，1-待确认，2-已取消，3-交易完成，4-交易关闭',
	private Integer shop_id;// '商户ID',
	private Integer rebate_terminal;// '充值终端，0-未知，1-擎天重卡APP，2-商铺终端',
	private Integer rebate_way;// '充值方式，0-未知，1-线上，2-线下',
	private Double rebate_amount;//返现总额
	private Double rebate_owner_norm_amount;//车主定额返现金额
	private Double rebate_owner_amount;//车主返现总额
	private Integer owner_id;//车主ID（也是accountId）
	private Double rebate_dirver_norm_amount;//司机定额返现
	private Double rebate_driver_amount;//司机返现总额
	private Double rebate_owner_percent;//车主返现百分比
	private Double rebate_points_percent;//司机擎天币返比
	private Double rebate_driver_percent;//司机返现百分比
	private Integer rebate_model;//返利模式，0-未知，1-百分比，2-定额，3-百分比和定额
	private Integer cars_id;//车队id
	private Double coupon_pay;// 优惠券使用的金额
	private String name;//商铺名称
	private String shop_code;//商铺编号 
	private String couponType;//优惠券类型
	private String couponName;//优惠券名称

	public String getShop_code() {
		return shop_code;
	}

	public void setShop_code(String shop_code) {
		this.shop_code = shop_code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private String pay_type;//支付方式

	public String getPay_type() {
		return pay_type;
	}

	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getBill_code() {
		return bill_code;
	}

	public void setBill_code(String bill_code) {
		this.bill_code = bill_code;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public Integer getRebate_points() {
		return rebate_points;
	}

	public void setRebate_points(Integer rebate_points) {
		this.rebate_points = rebate_points;
	}

	public String getQrcode_image() {
		return qrcode_image;
	}

	public void setQrcode_image(String qrcode_image) {
		this.qrcode_image = qrcode_image;
	}

	public String getTrade_code() {
		return trade_code;
	}

	public void setTrade_code(String trade_code) {
		this.trade_code = trade_code;
	}

	public String getCard_code() {
		return card_code;
	}

	public void setCard_code(String card_code) {
		this.card_code = card_code;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Timestamp getTrade_time() {
		return trade_time;
	}

	public void setTrade_time(Timestamp trade_time) {
		this.trade_time = trade_time;
	}

	public Integer getCreated_by() {
		return created_by;
	}

	public void setCreated_by(Integer created_by) {
		this.created_by = created_by;
	}

	public String getPay_mobile() {
		return pay_mobile;
	}

	public void setPay_mobile(String pay_mobile) {
		this.pay_mobile = pay_mobile;
	}

	public Integer getPay_by() {
		return pay_by;
	}

	public void setPay_by(Integer pay_by) {
		this.pay_by = pay_by;
	}

	public String getPay_name() {
		return pay_name;
	}

	public void setPay_name(String pay_name) {
		this.pay_name = pay_name;
	}

	public Double getBalance_pay() {
		return balance_pay;
	}

	public void setBalance_pay(Double balance_pay) {
		this.balance_pay = balance_pay;
	}

	public Double getOffline_pay() {
		return offline_pay;
	}

	public void setOffline_pay(Double offline_pay) {
		this.offline_pay = offline_pay;
	}

	public Double getRestore_pay() {
		return restore_pay;
	}

	public void setRestore_pay(Double restore_pay) {
		this.restore_pay = restore_pay;
	}

	public Integer getTrade_status() {
		return trade_status;
	}

	public void setTrade_status(Integer trade_status) {
		this.trade_status = trade_status;
	}

	public Integer getShop_id() {
		return shop_id;
	}

	public void setShop_id(Integer shop_id) {
		this.shop_id = shop_id;
	}

	public Integer getRebate_terminal() {
		return rebate_terminal;
	}

	public void setRebate_terminal(Integer rebate_terminal) {
		this.rebate_terminal = rebate_terminal;
	}

	public Integer getRebate_way() {
		return rebate_way;
	}

	public void setRebate_way(Integer rebate_way) {
		this.rebate_way = rebate_way;
	}

	public Double getRebate_amount() {
		return rebate_amount;
	}

	public void setRebate_amount(Double rebate_amount) {
		this.rebate_amount = rebate_amount;
	}

	public Double getRebate_owner_norm_amount() {
		return rebate_owner_norm_amount;
	}

	public void setRebate_owner_norm_amount(Double rebate_owner_norm_amount) {
		this.rebate_owner_norm_amount = rebate_owner_norm_amount;
	}

	public Double getRebate_owner_amount() {
		return rebate_owner_amount;
	}

	public void setRebate_owner_amount(Double rebate_owner_amount) {
		this.rebate_owner_amount = rebate_owner_amount;
	}

	public Integer getOwner_id() {
		return owner_id;
	}

	public void setOwner_id(Integer owner_id) {
		this.owner_id = owner_id;
	}

	public Double getRebate_dirver_norm_amount() {
		return rebate_dirver_norm_amount;
	}

	public void setRebate_dirver_norm_amount(Double rebate_dirver_norm_amount) {
		this.rebate_dirver_norm_amount = rebate_dirver_norm_amount;
	}

	public Double getRebate_driver_amount() {
		return rebate_driver_amount;
	}

	public void setRebate_driver_amount(Double rebate_driver_amount) {
		this.rebate_driver_amount = rebate_driver_amount;
	}

	public Double getRebate_owner_percent() {
		return rebate_owner_percent;
	}

	public void setRebate_owner_percent(Double rebate_owner_percent) {
		this.rebate_owner_percent = rebate_owner_percent;
	}

	public Double getRebate_points_percent() {
		return rebate_points_percent;
	}

	public void setRebate_points_percent(Double rebate_points_percent) {
		this.rebate_points_percent = rebate_points_percent;
	}

	public Double getRebate_driver_percent() {
		return rebate_driver_percent;
	}

	public void setRebate_driver_percent(Double rebate_driver_percent) {
		this.rebate_driver_percent = rebate_driver_percent;
	}

	public Integer getRebate_model() {
		return rebate_model;
	}

	public void setRebate_model(Integer rebate_model) {
		this.rebate_model = rebate_model;
	}

	public Integer getCars_id() {
		return cars_id;
	}

	public void setCars_id(Integer cars_id) {
		this.cars_id = cars_id;
	}

	public Double getCoupon_pay() {
		return coupon_pay;
	}

	public void setCoupon_pay(Double coupon_pay) {
		this.coupon_pay = coupon_pay;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public String getCouponType() {
		return couponType;
	}

	public void setCouponType(String couponType) {
		this.couponType = couponType;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

}
