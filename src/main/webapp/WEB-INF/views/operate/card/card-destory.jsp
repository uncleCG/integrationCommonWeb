<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>

<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>

<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-save">
		<div id="tab-system" class="HuiTab">
			<div class="row cl mt-10">
				<label class="form-label col-2">会员卡编号：</label>
				<div>
					<input type="text" name="cardCode" id="cardCode" style="width:150px" class="input-text">
				</div>
			</div>
		</div>
		<div class="row cl mt-10 clear">
			<div class="col-10 col-offset-2">
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
	
	function submitForm(){//提交表单
		var cardCodeVal = $("#cardCode").val();
		var positiveNumReg = /^[1-9]\d{5}$/;
		if(!positiveNumReg.test(cardCodeVal)){
			layer.alert("请输入正确会员卡编号");
			return false;
		}
		$.ajax({
			type:"POST",
			async:false,
			url : "${ctx}/cardController/getCardInfoByCardCode",
			data : $("#form-save").serialize(),
		    cache : false,
		    dataType : "json",
		    beforeSend : function() {
		    },
		    success : function(data, textStatus) {
		    	if(data.cardInfoPd == undefined){
		    		layer.alert("卡片不存在，请确认后重试",{icon: 5});
		    		return false;
		    	}
		    	var cardState = data.cardInfoPd.state;
		    	switch (cardState) {
				case -1:
					layer.alert("卡片已作废，请确认后重试",{icon: 5});
					break;
				case 0:
					layer.alert("卡片不存在，请确认后重试",{icon: 5});
					break;
				case 2:
					layer.alert("该卡已被领取不可作废",{icon: 5});
					break;
				case 1:
					destroyCard(data.cardInfoPd.masterId,$("#cardCode").val());
					break;
				default:
					break;
				}
		    },
		    error : function() {
				layer.alert("请求发送失败，请稍后重试",{icon: 5});
		   	},
		    complete : function() {

		    }
		});
	}
	
	function destroyCard(masterId,cardCode){
		var confirmVal = "作废后该卡将无法再被领取和使用，确认是否作废？";
		layer.confirm(confirmVal, {
            btn: ["确定","取消"] //按钮
        }, function(){//确定
        	$.ajax({
    			type:"POST",
    			async:false,
    			url : "${ctx}/cardController/cardDestory",
    			data : {
    				"masterId":masterId,
    				"cardCode":cardCode
    			},
    		    cache : false,
    		    dataType : "json",
    		    beforeSend : function() {
    		    },
    		    success : function(data, textStatus) {
    		    	if(data.status == 1){
    		    		layer.msg("操作成功",{icon: 6,time:2000},function(){
	    		    		layer_close();
    		    		});
    		    	}else{
    		    		layer.alert("操作失败，请稍后重试",{icon: 5});
    		    	}
    		    },
    		    error : function() {
    				layer.alert("请求发送失败，请稍后重试",{icon: 5});
    		   	},
    		    complete : function() {

    		    }
    		});
        }, function(){//取消
        });
	}
</script>
</body>
</html>
