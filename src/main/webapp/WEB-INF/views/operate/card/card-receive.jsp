<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>

<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
	<style>
	#employeeDiv table{line-height:25px;}
	#employeeDiv table td{border:1px solid #cecece;}
	.td{font-size:16px;font-weight:bold;line-height:30px;}
	</style>
<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-save">
		<div id="tab-system" class="HuiTab">
			<div class="row cl mt-10">
	 			 <label class="form-label col-2">批次：</label>
	  			 <span class="select-box inline">
	 				 <select name="masterId" id="masterId" class="select" style="min-width:308px;">
	 					<option value="0" selected="selected">请选择</option>
						<c:forEach items="${masterPdList}" var="masterPd">
							<option value="${masterPd.id}">${masterPd.batchStart}-${masterPd.batchEnd}</option>
						</c:forEach>	 					
	 				</select>
	 			</span>
	 		</div>
			<div class="row cl mt-10">
				<label class="form-label col-2">领取号段：</label>
				<div>
					<input type="text" name="receiveStart" id="receiveStart" placeholder="起始编号" style="width:150px" class="input-text">
					~
					<input type="text" name="receiveEnd" id="receiveEnd" placeholder="结束编号" style="width:150px" class="input-text">
				</div>
			</div>
			<div class="row cl mt-10">
	 			 <label class="form-label col-2">跟进人：</label>
	  			 <span class="select-box inline">
	 				 <select name="daqUserId" id="daqUserId" class="select" style="min-width:308px;">
	 					<option value="0" selected="selected">请选择</option>
						<c:forEach items="${daqUserList}" var="daqUser">
							<option value="${daqUser.id}">${daqUser.name}</option>
						</c:forEach>	 					
	 				</select>
	 			</span>
	 		</div>
	 		<div class="row cl mt-10">
	 			<label class="form-label col-2">代理商：</label>
				<div>
					<button name="" id="relateEmployeeBtn" class="btn btn-primary radius" type="button" onclick="showConfirm('关联代理商','${ctx}/cardController/chooseEmployee','1200','700')">关联代理商</button>
				</div>
	 		</div>
	 		<div class="row cl mt-10" id="employeeDiv" style="display: none;">
	 			<label class="form-label col-2">&nbsp;</label>
				<div class="form-label mt-8 col-8">
					<table class="text-c" cellspacing="0" cellpadding="0">
						<thead style="background:#ddd;">
							<tr>
								<td class="td">员工姓名</td>
								<td class="td">员工手机号</td>
								<td class="td">商户编号</td>
								<td class="td">商户名称</td>
								<td class="td">地理区域</td>
							</tr>
						</thead>
						<tbody>
							<tr id="trId">
								
							</tr>
						</tbody>
					</table>
				</div>
	 		</div>
		</div>
		<div class="row cl mt-10 clear">
			<div class="col-10 col-offset-2">
				<input type="hidden" name="shopId" id="shopId"/>
				<input type="hidden" name="employeeId" id="employeeId"/>
				<input type="hidden" name="totalNum" id="totalNum"/>
				<input type="hidden" name="cancelNum" id="cancelNum"/>
				<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取&nbsp;&nbsp;&nbsp;消&nbsp;&nbsp;</button>
				<button onclick="submitForm();" class="btn btn-primary radius" type="button" id="saveBtn">&nbsp;&nbsp;提&nbsp;&nbsp;&nbsp;交&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</div>
<%@ include file="../../common/_footer.jsp" %>
<script type="text/javascript">
	$(function(){
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});
		$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	});
	
	/*显示关联代理商操作框*/
	function showConfirm(title,url,w,h){
		//layer_show(title,url,w,h);
		var index = layer.open({
			type: 2,
			title: title,
			content: url
		});
		layer.full(index);
	}
	
	var employeeId,shopId,employeeName,employeeMobile,shopCode,shopName,province;
	
	function showRelateEmployeeInfo(){
		var htmlCotent = "<td>"+employeeName+"</td><td>"+employeeMobile+"</td><td>"+shopCode+"</td><td>"+shopName+"</td><td>"+province+"</td>"
		$("#trId").html(htmlCotent);
		$("#employeeDiv").show();
		$("#shopId").val(shopId);
		$("#employeeId").val(employeeId);
	}
	
	function submitForm(){//提交表单
		var masterId = $("#masterId option:selected").val();
		if(masterId == 0){
			layer.tips("请选择批次", "#masterId", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}	
		var masterText = $("#masterId option:selected").text();		
		var receiveStartVal = $("#receiveStart").val();
		var receiveEndVal = $("#receiveEnd").val();
		var positiveNumReg = /^[1-9]\d{5}$/;
		if(!positiveNumReg.test(receiveStartVal)){
			layer.tips("请输入正确的领取号段", "#receiveStart", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		var batchArr = masterText.split("-");
		var batchStart = batchArr[0];
		var batchEnd = batchArr[1];
		if(receiveStartVal < batchStart){
			layer.tips("领取号段于"+batchStart+"起", "#receiveStart", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		if(receiveStartVal > batchEnd){
			layer.tips("领取号段于"+batchEnd+"止", "#receiveStart", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		if(!positiveNumReg.test(receiveEndVal)){
			layer.tips("请输入正确的领取号段", "#receiveEnd", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		if(receiveEndVal < batchStart){
			layer.tips("领取号段于"+batchStart+"起", "#receiveEnd", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		if(receiveEndVal > batchEnd){
			layer.tips("领取号段于"+batchEnd+"止", "#receiveEnd", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		if(receiveEndVal < receiveStartVal){
			layer.tips("结束号段不能小于开始号段", "#receiveEnd", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		var daqUserIdVal = $("#daqUserId option:selected").val();
		if(daqUserIdVal == 0){
			layer.tips("请选择跟进人", "#daqUserId", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		if(shopId == undefined || employeeId == undefined){
			layer.tips("请关联代理商", "#relateEmployeeBtn", {
                tips: [1, "#F00"],
                time: 3000
            });
			return false;
		}
		$("#saveBtn").prop("disabled",true);
		
		$.ajax({
			type:"POST",
			async:false,
			url : "${ctx}/cardController/cardReceiveCheck",
			data : {
				"masterId":masterId,
				"receiveStart":receiveStartVal,
				"receiveEnd":receiveEndVal
			},
		    cache : false,
		    dataType : "json",
		    beforeSend : function() {
		    },
		    success : function(data, textStatus) {
				//号码段内作废数量
				var cancelNumVal = data.checkPd.cancelNum;
				//号码段内已被领取数量
				var receiveNumVal = data.checkPd.receiveNum;
		    	//号码段内总数量
				var totalNumVal = data.checkPd.totalNum - cancelNumVal;
				if(receiveNumVal > 0){
					layer.alert(receiveStartVal + "-"+ receiveEndVal +"中有"+receiveNumVal+"张已被领取，请核对后重试",{icon: 5});
					$("#saveBtn").prop("disabled",false);
					return false;
				}
				$("#totalNum").val(totalNumVal);
				$("#cancelNum").val(cancelNumVal);
				var confirmVal = "";
				if(cancelNumVal > 0){
					confirmVal = "本次领取的卡会员卡共"+totalNumVal+"张，号段中包含作废卡"+cancelNumVal+"张";
				}else{
					confirmVal = "本次领取的卡会员卡共"+totalNumVal+"张";
				}
				confirmReceiveSend(confirmVal);
		    },
		    error : function() {
				layer.alert("请求发送失败，请稍后重试",{icon: 5});
				$("#saveBtn").prop("disabled",false);
		   	},
		    complete : function() {

		    }
		});
	}
	
	function confirmReceiveSend(confirmVal){
		layer.confirm(confirmVal, {
            btn: ["确定领取","取消"] //按钮
        }, function(){//确定
        	$.ajax({
    			type:"POST",
    			async:false,
    			url : "${ctx}/cardController/cardReceive",
    			data : $("#form-save").serialize(),
    		    cache : false,
    		    dataType : "json",
    		    beforeSend : function() {
    		    },
    		    success : function(data, textStatus) {
    		    	if(data.status == 1){
    		    		layer.msg("操作成功",{icon: 6,time:2000},function(){
	    		    		layer_close();
    		    		});
    		    	}
    		    },
    		    error : function() {
    				layer.alert("请求发送失败，请稍后重试",{icon: 5});
    		   	},
    		    complete : function() {
    		    	$("#saveBtn").prop("disabled",false);
    		    }
    		});
        }, function(){//取消
        	$("#saveBtn").prop("disabled",false);
        });
	}
</script>
</body>
</html>
