function submitForm() {
			
    var couponNameVal = $("#coupon_name").val();
	if(couponNameVal == "" || couponNameVal == undefined || couponNameVal == null){
		layer.tips("请填写优惠券名称！", "#coupon_name", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	if(couponNameVal.length > 50){
		layer.tips("字符不能超过50", "#coupon_name", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	
	
	syncCheckCouponName();//校验优惠券名称唯一性
	if(!couponNameOk){
		 return false;
	} 
	
	if($("#grant_source").val() == 3){
		if($(shopIdsSource).val().length < 1){
			layer.tips("请关联发放商户", "#grant_source", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
	}
	
	var targetVal = $("#grant_target").val();
	switch (targetVal) {
	case "2":
		if($("input[name='targetCheckbox']:checked").length < 1){
			layer.tips("请选择限定身份", "#grant_target", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;			
		}
		break;
	case "3":
		if($("#accountIds").val().length < 1){
			layer.tips("请关联限定用户", "#grant_target", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		break;
	default:
		break;
	}
	
	var couponType = $("#type").val();//优惠券类型
	var discountVal = $.trim($("#discount").val());
	var quotaVal = $.trim($("#quota").val());
	var numReg = /^\d+$/;
	switch (couponType) {
	case "1":
		if(discountVal == ""){
			layer.tips("请填写金额信息", "#discount", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}else if (!numReg.test(discountVal)){
			layer.tips("请核对金额信息", "#discount", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		break;
	case "2":
		if(discountVal == ""){
			layer.tips("请填写折扣信息（0~100）", "#discount", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}else if (!numReg.test(discountVal)){
			layer.tips("请核对折扣信息（0~100）", "#discount", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}else if (Number(discountVal) > 100 || Number(discountVal) < 0){
			layer.tips("请核对折扣信息（0~100）", "#discount", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		if(quotaVal == ""){
			$("#quota").val(0);
		}else if (quotaVal != "" && !numReg.test(quotaVal)){
			layer.tips("请核对最高限额", "#quota", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		break;
	case "3":
		if(discountVal == ""){
			layer.tips("请填写金额信息", "#discount", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}else if (!numReg.test(discountVal)){
			layer.tips("请核对金额信息", "#discount", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		if(quotaVal == ""){
			layer.tips("请填写票面价值", "#quota", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}else if (!numReg.test(quotaVal)){
			layer.tips("请核对票面价值", "#quota", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		break;
	default:
		break;
	}
	
	var grantMaxVal = $.trim($("#grant_max").val());
	if(grantMaxVal == ""){
		layer.tips("请填写发放总数", "#grant_max", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}else if (!numReg.test(grantMaxVal)){
		layer.tips("请核对发放总数", "#grant_max", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	var eachMaxVal = $.trim($("#each_max").val());
	if(eachMaxVal == ""){W
		layer.tips("请填写每人限领", "#each_max", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}else if (!numReg.test(eachMaxVal)){
		layer.tips("请核对每人限领", "#each_max", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}else if(Number(eachMaxVal) == 0){
		layer.tips("请核对每人限领（>0）", "#each_max", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	if($("#grant_way").val() == 1){
		if(Number(eachMaxVal) > 0){
			if(Number(grantMaxVal) % Number(eachMaxVal) != 0){
				layer.tips("发放总数和每人限领必须整除，请调整", "#grant_way", {
				    tips: [1, "#F00"],
				    time: 2000
				});
				return false;
			}
		}
	}
	var putBeginTimeVal = $("#putBeginTime").val();
	if(putBeginTimeVal == ""){
		layer.tips("请填写投放期开始时间", "#putBeginTime", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	var putEndTimeVal = $("#putEndTime").val();
	if(putEndTimeVal == ""){
		layer.tips("请填写投放期结束时间", "#putEndTime", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	if(putEndTimeVal <= putBeginTimeVal){
		layer.tips("投放期结束时间必须大于投放期起始时间", "#putEndTime", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	var validBeginTimeVal = $("#validBeginTime").val();
	if(validBeginTimeVal == ""){
		layer.tips("请填写使用有效期开始时间", "#validBeginTime", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	var validEndTimeVal = $("#validEndTime").val();
	if(validEndTimeVal == ""){
		layer.tips("请填写使用有效期结束时间", "#validEndTime", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}

	if(validBeginTimeVal <= putBeginTimeVal){
		layer.tips("使用有效期起始时间必须大于投放期起始时间，请调整", "#validEndTime", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	if(validEndTimeVal <= validBeginTimeVal){
		layer.tips("使用有效期结束时间必须大于使用有效期起始时间", "#validEndTime", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	
	if(validEndTimeVal <= validBeginTimeVal){
		layer.tips("使用有效期结束时间必须大于使用有效期起始时间", "#validEndTime", {
		    tips: [1, "#F00"],
		    time: 2000
		});
		return false;
	}
	
	if($("input[name='restrict_use']:checked").val()==1){//限制
		var cousumeMin = $("#consume_min").val();
		if(cousumeMin == ""){
			$("#consume_min").val(0);
		}else if (!numReg.test(cousumeMin)){
			layer.tips("请核对最低消费", "#consume_min", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		var useScopeVal = $("input[name='use_scope']:checked").val(); 
		if(useScopeVal==1){//限地区、类型
			var provinctVal = $("#s_province").val();
			var shopType = $("#shop_type").val();
			if("省份" == provinctVal && shopType == -1){
				layer.tips("请选择地理区域或者商户类型", "#s_province", {
				    tips: [1, "#F00"],
				    time: 2000
				});
				return false;
			}
		}else if(useScopeVal==2){//指定商户，+++++++++++++++++++++++在这里弹出用户选择框
			if($("#shopIdsScope").val().length < 1){
				layer.tips("请关联指定商户", "#shop_type", {
				    tips: [1, "#F00"],
				    time: 2000
				});
				return false;
			}
		}
	}
	
	layer.confirm("确定提交？", {
	    btn: ["确定","取消"] //按钮
	},function(){
		$("#form-couponInfo-save").submit();
		$("#form-couponInfo-save").attr("disabled",true);
	});
}

/*校验优惠券名称唯一性*/
function syncCheckCouponName(){
	var checkFlag = false;
	var couponName = $.trim($("#coupon_name").val());
	if($("#id").val() != ""){//修改
		if(oldCouponName != couponName){//修改了优惠券名称
			checkFlag = true;
		}
	}else{//新增
		checkFlag = true;
	}
	if(checkFlag){
		$.ajax({
			type:"POST",
			async:false,
			url : "operate/capitalOperation/couponInfo/checkCouponName",
			data : {
				"couponName" : couponName
			},
		    cache : false,
		    dataType : "json",
		    beforeSend : function() {
		  	 $("#coupon_name").val(couponName);
		    },
		    success : function(data, textStatus) {
				if(data.status != 1){//不合法
					couponNameOk = false;
					$("#coupon_name").focus();
					if(data.status == -2){
						//alert("优惠券校验异常【"+data.message+"】")
						layer.msg("优惠券校验异常",{icon: 5,time:2000});
					}else{
						layer.msg("优惠券名称已存在，请修正",{icon: 5,time:2000});
					}
				}else{//合法
					couponNameOk =  true;
				}
		    },
		    error : function() {
				layer.msg("优惠券名称校验异常，请稍候重试",{icon: 5,time:2000});
		   	},
		    complete : function() {

		    }
		});
	}else{//不用校验
		couponNameOk = true;
	}
}