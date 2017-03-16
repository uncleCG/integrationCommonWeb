$(function(){
	
	//隐藏限制条件
	$(".restrictTr").hide().attr("disabled",true);
	
	//发放来源
	$("#grant_source").change(function(){
		if($("#grant_source").val() == 3){
			$("#sourceBtn").show();
			$("#shopNameSourceTextDiv").show();
		}else{
			$("#sourceBtn").hide();
			$("#shopNameSourceTextDiv").hide();
		}
	});
	
	//发放对象
	$("#grant_target").change(function() {
		var targetVal = $("#grant_target").val();
		switch (targetVal) {
		case "1":
			$("#targetOptionTr").hide();
			$("input[name='targetCheckbox']").attr("disabled", true);
			$("#showAccountsTr").hide();
			$("#accountNamesTextDiv").hide();
			$("#opt2").removeAttr("disabled");
			break;
		case "2":
			$("#targetOptionTr").show();
			$("input[name='targetCheckbox']").removeAttr("disabled");
			$("#showAccountsTr").hide();
			$("#accountNamesTextDiv").hide();
			$("#opt2").removeAttr("disabled");
			break;
		case "3":
			$("#targetOptionTr").hide();
			$("input[name='targetCheckbox']").attr("disabled", true);
			$("#showAccountsTr").show();
			$("#accountNamesTextDiv").show();
			$("#grant_way").val(1);
			$("#opt2").attr("disabled", true);
			break;
		default:
			break;
		}
	});
	
	//优惠券类型
	$("#type").change(function(){
		var typeVal = $("#type").val();
		switch (typeVal) {
		case "1":
			moneyHtmlStr = "金额";
			unitHtmlStr = "元";
			maxHighHtmlStr = "票面价值";
			$("#maxHighSpan").hide();
			$("#quota").attr("disabled", true);
			$("#rebateYes").show();
			$("#moneyHtml").html(moneyHtmlStr);
			$("#unitHtml").html(unitHtmlStr);
			$("#quota").val("");
			break;
		case "2":
			moneyHtmlStr = "折扣";
			unitHtmlStr = "折";
			maxHighHtmlStr = "最高限额";
			$("#moneyHtml").html(moneyHtmlStr);
			$("#unitHtml").html(unitHtmlStr);
			$("#maxHighHtml").html(maxHighHtmlStr);
			$("#maxHighSpan").show();
			$("#quota").removeAttr("disabled");
			$("#rebateYes").show();
			$("#quota").val(quota);
			break;
		case "3":
			$("#in_rebate2").attr("checked", true);
			$("#rebateYes").hide();
			moneyHtmlStr = "金额";
			unitHtmlStr = "元";
			maxHighHtmlStr = "票面价值";
			$("#moneyHtml").html(moneyHtmlStr);
			$("#unitHtml").html(unitHtmlStr);
			$("#maxHighHtml").html("<span style='color: red;'>*</span>" + maxHighHtmlStr);
			$("#quota").removeAttr("disabled");
			$("#maxHighSpan").show();
			$("#quota").val($.trim($("#discount").val()));
			break;
		default:
			break;
		}
	});
	
	//金额
	$("#discount").blur(function(){
		if ($("#type").val() == 3) {
			$("#quota").val($.trim($("#discount").val()));
		}
	});
	
	//是否限制使用
	$("input[name='restrict_use']").click(function(){
		$(this).iCheck('check');
		if($("input[name='restrict_use']:checked").val()==1){//限制
			$(".restrictTr").show().removeAttr("disabled");
			var useScopeVal = $("input[name='use_scope']:checked").val(); 
			if(useScopeVal==0){//不限制使用范围
				$(".scope2").hide().attr("disabled",true);	
			}else if(useScopeVal==1){//限地区、类型
				$(".scope2").show().removeAttr("disabled");
			}else if(useScopeVal==2){//指定商户，+++++++++++++++++++++++在这里弹出用户选择框
				$(".scope2").hide().attr("disabled",true);
			}
		}else{
			$(".restrictTr").hide().attr("disabled",true);
			$("#consume_min").val("0");
		}
	});
	
	//适用范围
	$("input[name='use_scope']").click(function(){
		$(this).iCheck('check');
		var useScopeVal = $("input[name='use_scope']:checked").val(); 
		if(useScopeVal==0){//不限制使用范围
			$(".scope2").hide().attr("disabled",true);
			$("#scopeBtn").hide();
			$("#shopNameScopeTextDiv").hide();
			scopeShopIdArr = new Array();
			scopeShopContractCodeArr = new Array();
			scopeShopNameArr = new Array();
			$(".addScopeTr").remove();
		}else if(useScopeVal==1){//限地区、类型
			$(".scope2").show().removeAttr("disabled");
			$("#scopeBtn").hide();
			$("#shopNameScopeTextDiv").hide();
			scopeShopIdArr = new Array();
			scopeShopContractCodeArr = new Array();
			scopeShopNameArr = new Array();
			$(".addScopeTr").remove();
		}else if(useScopeVal==2){//指定商户，弹出选择框
			$(".scope2").hide().attr("disabled",true);
			$("#scopeBtn").show();
			$("#shopNameScopeTextDiv").show();
		}
	});
	
	//初始化地址下拉列表
	_init_area();
	if(province != ""){
		var provinces = $("#s_province").children("option");
		for(var i = 0; i < provinces.length; i++){
			if($(provinces[i]).html() == province){
				$(provinces[i]).attr("selected",true);
				$("#s_province").change();
			}
		}
		var citys = $("#s_city").children("option");
		for(var i = 0; i < citys.length; i++){
			if($(citys[i]).html() == city){
				$(citys[i]).attr("selected",true);
				$("#s_city").change();
			}
		}
		var countys = $("#s_county").children("option");
		for(var i = 0; i < countys.length; i++){
			if($(countys[i]).html() == district){
				$(countys[i]).attr("selected",true);
				$("#s_county").change();
			}
		}		
	}
	
});

