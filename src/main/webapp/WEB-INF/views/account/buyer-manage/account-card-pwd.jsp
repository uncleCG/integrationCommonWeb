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
				<label class="form-label col-2">验证码：</label>
				<div>
					<input type="text" name="smsCheckCode" id="smsCheckCode" style="width:150px" class="input-text">
					 <button class="btn btn-primary radius" id="msYzm" type="button">获取验证码</button>
				</div>
			</div>
			<div class="row cl mt-10">
				<label class="form-label col-2">新密码：</label>
				<div>
					<input type="text" name="pwd" id="pwd" style="width:150px" class="input-text">
				</div>
			</div>
		</div>
		<div class="row cl mt-10 clear">
			<div class="col-10 col-offset-2">
				<input type="hidden" name="relateId" value="${relateId}">
				<input type="hidden" name="phoneNum" value="${phoneNum}">
				<input type="hidden" name="ope" value="${ope}">
				<input type="hidden" name="cardCode" value="${cardCode}">
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
		$("#msYzm").click(time);
	});
	
	var wait = 60;
	var yzmBtn;
	//是否禁用获取验证码按钮：0、禁用；1、激活；
	var checkCodeErr = 1;
	function time() {
		if(wait == 60){
			yzmBtn = $("#msYzm");
		}
        if (wait == 0) {  
        	yzmBtn.prop("disabled",false);            
        	yzmBtn.html("获取验证码");  
            wait = 60;
        } else {
			if(wait == 60){
				getCheckCode("${phoneNum}");
			}
			if(checkCodeErr == 0){
				//手机号已存在等其它原因造成未成功发送验证码时重新激活发送验证码按钮
				yzmBtn.prop("disabled",false);            
	        	yzmBtn.html("获取验证码");  
	        	wait = 60;
	            checkCodeErr = 1;
	            return;
			}
			yzmBtn.prop("disabled",true);  
			yzmBtn.html("重新发送(" + wait + ")");  
            wait--;  
            setTimeout(function() {  
                time();
            },  
            1000);
        }  
    }
	
	function getCheckCode(phoneNUm) {
		$.ajax({
			type : "post",
			url : "${ctx}/sendSMSCode?phoneNum=" + phoneNUm,
			success : function(data) {
				if(data.status != "1"){
					checkCodeErr = 0;
					layer.alert(data.message);
				}
			}
		});
	}
	
	function submitForm(){//提交表单
		var smsCheckCodeVal = $("#smsCheckCode").val();
		var numReg = /^\d{6}$/;
		if(!numReg.test(smsCheckCodeVal)){
			layer.tips("请输入正确的验证码", "#smsCheckCode", {
                tips: [1, "#F00"],
                time: 2000
            });
			return false;
		}
		var pwdVal = $("#pwd").val();
		if(pwdVal == null || pwdVal == "" || pwdVal == undefined){
			layer.alert("请输入新密码");
			return false;
		}
		$.ajax({
			type:"POST",
			async:false,
			url : "${ctx}/accountController/updateCard",
			data : $("#form-save").serialize(),
		    cache : false,
		    dataType : "json",
		    beforeSend : function() {
		    },
		    success : function(data, textStatus) {
		    	if(data.status == 1){
		    		layer.msg("操作成功",{icon: 6,time:2000},function(){
		    			parent.location.reload();
		    		});
		    	}else if(data.status == -1){
		    		layer.msg("验证码错误",{icon: 5,time:2000});
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
	}
	
</script>
</body>
</html>
