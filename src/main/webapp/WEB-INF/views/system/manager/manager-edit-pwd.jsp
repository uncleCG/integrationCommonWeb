<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
		<script type="text/javascript">
			$(function(){
				var errMsg = "${error}";
				if(errMsg != null && errMsg != '' && errMsg != undefined){
					layer.alert(errMsg);
				}
			});
			
			function submitForm(){
				var oldpasswordVal = $.trim($("#oldpwd").val());
				if(oldpasswordVal == "" || oldpasswordVal == undefined || oldpasswordVal == null){
					layer.tips("请输入旧密码", "#oldpwd", {
					    tips: [1, "#F00"],
					    time: 2000
					});
					return false;
				} 
				
				var passwordVal = $.trim($("#pwd").val());
				if(passwordVal == "" || passwordVal == undefined || passwordVal == null){
					layer.tips("请输入登录密码", "#pwd", {
					    tips: [1, "#F00"],
					    time: 2000
					});
					return false;
				}
				
				var confirmPwdVal = $.trim($("#confirmPwd").val());
				if(passwordVal != confirmPwdVal){
					layer.tips("两次密码输入不一致，请核实", "#confirmPwd", {
					    tips: [1, "#F00"],
					    time: 2000
					});
					return false;
				}
			    
				$.ajax({
				      type : "POST",
				      async : true,
				      url : "${ctx}/managerController/editUserBase",
				      data : $("#form-manager-save").serialize(),
				      cache : false,
				      dataType : "json",
				      beforeSend : function() {
				           // Handle the beforeSend event
				      },
				      success : function(data, textStatus) {
				          if (data.status==1) {// 处理成功
				        	  layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
					        	  //parent.location.reload();
					        	  //layer_close();
					        	  $("input").val("");
				        	  });
				          } else if(data.status==-1){
				        	  layer.alert(data.message,{icon: 5});
				          }else {// 处理失败
				        	  layer.msg("操作失败",{icon: 5,time:2000});
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
	</head>

<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-manager-save">
		<div id="tab-system" class="HuiTab">
			<div class="tabCon">
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>旧密码：</label>
					<div class="formControls col-10">
						<input type="password" id="oldpwd" name="oldpwd" placeholder="请输入旧密码"  class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>新密码：</label>
					<div class="formControls col-10">
						<input type="password" id="pwd" name="pwd" placeholder="请输入新密码"  class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>确认密码：</label>
					<div class="formControls col-10">
						<input type="password" id="confirmPwd" placeholder="再次输入密码"  class="input-text">
					</div>
				</div>
			</div>
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<input type="hidden" name="id" value="${userId}">
				<button onclick="submitForm();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
				<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
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

</script>
</body>
</html>
