<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctx}/statics/lib/mutiselect/multiselectSrc/jquery.multiselect.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/statics/lib/mutiselect/assets/style.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/statics/lib/mutiselect/assets/prettify.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/statics/lib/mutiselect/assets/jquery-ui.css" />
		
		<script type="text/javascript" src="${ctx}/statics/lib/mutiselect/ui/jquery.ui.core.js"></script>
		<script type="text/javascript" src="${ctx}/statics/lib/mutiselect/ui/jquery.ui.widget.js"></script>
		<script type="text/javascript" src="${ctx}/statics/lib/mutiselect/assets/prettify.js"></script>
		<script type="text/javascript" src="${ctx}/statics/lib/mutiselect/multiselectSrc/jquery.multiselect.js"></script>
		<script type="text/javascript">
			$(function(){
				
			});
			function submitForm(){
				$("#subBtn").prop("disabled",true);
				var nameVal = $.trim($("#nickname").val());
				if(nameVal == "" || nameVal == undefined || nameVal == null){
					layer.tips("请输入帐号（邮箱格式）", "#nickname", {
					    tips: [1, "#F00"],
					    time: 2000
					});
					$("#subBtn").prop("disabled",false);
					return false;
				}
			    if(nameVal != "" && nameVal != undefined && nameVal != null){
			    	var emailReg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
			    	if(!emailReg.test(nameVal)){
			    		layer.tips("请填写正确的帐号（邮箱格式）", "#nickname", {
						    tips: [1, "#F00"],
						    time: 2000
						});
			    		$("#subBtn").prop("disabled",false);
						return false;
			    	}
			    }
				var passwordVal = $.trim($("#pwd").val());
				if(passwordVal == "" || passwordVal == undefined || passwordVal == null){
					layer.tips("请输入登录密码", "#pwd", {
					    tips: [1, "#F00"],
					    time: 2000
					});
					$("#subBtn").prop("disabled",false);
					return false;
				}
				var confirmPwdVal = $.trim($("#confirmPwd").val());
				if(passwordVal != confirmPwdVal){
					layer.tips("两次密码输入不一致，请核实", "#confirmPwd", {
					    tips: [1, "#F00"],
					    time: 2000
					});
					$("#subBtn").prop("disabled",false);
					return false;
				}
				
				var roleIdVal = $("#roleId").val();
				if(roleIdVal == 0 || roleIdVal == undefined){
					layer.tips("请分配角色", "#roleId", {
					    tips: [1, "#F00"],
					    time: 2000
					});
					$("#subBtn").prop("disabled",false);
					return false;
				}
				
				var realnameVal = $.trim($("#name").val());
				if(realnameVal == "" || realnameVal == undefined || realnameVal == null){
					layer.tips("请填写真实姓名", "#name", {
					    tips: [1, "#F00"],
					    time: 2000
					});
					$("#subBtn").prop("disabled",false);
					return false;
				}
				
			    var mobileVal = $("#mobile").val();
			    if(mobileVal != "" && mobileVal != undefined && mobileVal != null){
			    	//var mobileReg = /^0\d{2,3}-?\d{7,8}$/;//如01088888888,010-88888888,0955-7777777
			    	var mobileReg = /^1\d{10}$/;
			    	if(!mobileReg.test(mobileVal)){
			    		layer.tips("请填写正确的联系电话", "#mobile", {
						    tips: [1, "#F00"],
						    time: 2000
						});
			    		$("#subBtn").prop("disabled",false);
						return false;
			    	}
			    }
			    
				$.ajax({
				      type : "POST",
				      async : true,
				      url : "${ctx}/managerController/saveOrUpdate",
				      data : $("#form-manager-save").serialize(),
				      cache : false,
				      dataType : "json",
				      beforeSend : function() {
				           // Handle the beforeSend event
				      },
				      success : function(data, textStatus) {
				          if (data.status==1) {// 处理成功
				        	  layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
					        	  parent.location.reload();
					        	  layer_close();
				        	  });
				          } else {// 处理失败
				        	  layer.msg("操作失败",{icon: 5,time:2000});
				          }
				      },
				      error : function() {
						layer.alert("请求发送失败，请稍后重试",{icon: 5});
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
					<label class="form-label col-2"><span class="c-red">*</span>帐号：</label>
					<div class="formControls col-10">
						<input type="text" id="nickname" name="nickname" placeholder="请输入帐号（邮箱格式）" value="${manager.nickname}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>登录密码：</label>
					<div class="formControls col-10">
						<input type="password" id="pwd" name="pwd" placeholder="请输入登录密码" value="${manager.pwd}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>确认密码：</label>
					<div class="formControls col-10">
						<input type="password" id="confirmPwd" placeholder="再次输入密码" value="${manager.pwd}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>分配角色：</label>
					<div class="formControls col-10">
						<span class="select-box inline">
							<select name="roleIds" id="roleId" class="select" style="min-width:100px">
								<c:forEach items="${roleList}" var="role">
									<option value="${role.id}" <c:forEach items="${manager.roleList}" var="myRole"><c:if test="${myRole.id == role.id}">selected="selected"</c:if></c:forEach>>
										${role.name}
									</option>
								</c:forEach>
							</select>
			 			</span>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>真实姓名：</label>
					<div class="formControls col-10">
						<input type="text" id="name" name="name" placeholder="请输入真实姓名" value="${manager.name}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>用户状态：</label>
					<div class="formControls col-10">
						<input type="radio" id="state1" name="state" value="1" checked="checked">&nbsp;<label for="state1">启用</label>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id="state0" name="state" value="0" <c:if test="${!empty manager.state && manager.state != 1}">checked="checked"</c:if>>&nbsp;<label for="state0">禁用</label>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2">手机号：</label>
					<div class="formControls col-10">
						<input type="text" id="mobile" name="mobile" placeholder="请输入手机号" value="${manager.mobile}" class="input-text">
					</div>
				</div>
				<!-- 
				<div class="row cl">
					<label class="form-label col-2">电子邮箱：</label>
					<div class="formControls col-10">
						<input type="text" id="email" name="email" placeholder="请输入电子邮件" value="${manager.email}" class="input-text">
					</div>
				</div>
				 -->
			</div>
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<input type="hidden" name="id" value="${manager.id}">
				<button onclick="submitForm();" class="btn btn-primary radius" type="button" id="subBtn"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
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
	
	/* $("#roleId").multiselect({
		noneSelectedText: "请选择",
        checkAllText: "全选",
        uncheckAllText: "全不选",
        selectedList:4
    });
    $("#roleId").multiselect("refresh"); */
});

</script>
</body>
</html>
