<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href } ">
		<!-- jsp文件头和头部 -->
		<%@ include file="common/_top.jsp"%> 
		<link href="<%=path %>/statics/css/H-ui.login.css" rel="stylesheet" type="text/css" />
		<title>卡车钱宝管理系统</title>
		<meta name="keywords" content="擎天重卡,中国第一车联网、物联网,清洁能源,LNG,CNG">
		<meta name="description" content="擎天重卡网打造中国第一车联网、物联网相结合的清洁能源产业服务平台。自产品上线一月内，用户数即达万人！随着业务的扩大，未来的用户数将会成几何数不断增长，是最具朝气的平台之一。">
	</head>
<body onLoad="document.getElementById('username').focus();">
<input type="hidden" id="TenantId" name="TenantId" value="" />
<div class="header"><span>卡车钱宝管理系统</span></div>
<div class="loginWraper">
  <div id="loginform" class="loginBox">
    <form class="form form-horizontal" action="login.shtml" onsubmit="return check()" method="post">
      <div class="row cl">
        <label class="form-label col-3"><i class="Hui-iconfont">&#xe60d;</i></label>
        <div class="formControls col-8">
          <input id="username" name="nickname" type="text" placeholder="账户" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <label class="form-label col-3"><i class="Hui-iconfont">&#xe60e;</i></label>
        <div class="formControls col-8">
          <input id="password" name="password" type="password" placeholder="密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <div class="formControls col-8 col-offset-3">
          <input class="input-text size-L" type="text" id="checkcode" name="checkcode" placeholder="验证码" onblur="if(this.value==''){this.value='验证码:'}" onclick="if(this.value=='验证码:'){this.value='';}" value="" style="width:150px;">
          <img src="<%=path %>/getCheckCode"  id="createCodeIndex"  onclick="createCheckCodeIndex();"> <a id="kanbuq" href="javascript:createCheckCodeIndex();">看不清，换一张</a> </div>
      </div>
      <div class="row">
        <div class="formControls col-8 col-offset-3">
          <label for="online">
            <input type="checkbox" name="online" id="online" value=""> 使我保持登录状态
          </label>
        </div>
      </div>
      <div class="row">
        <div class="formControls col-8 col-offset-3">
          <input name="" type="submit" class="btn btn-success radius size-L" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
          <input name="" type="reset" class="btn btn-default radius size-L" value="&nbsp;重&nbsp;&nbsp;&nbsp;&nbsp;置&nbsp;">
        </div>
      </div>
    </form>
  </div>
</div>
<div class="footer">Copyright 2015  Beijing QingTianTongTu Technology Co., Ltd. </div>
<!-- 引用底部JS -->
<%@ include file="common/_footer.jsp" %>
<script>
if(window !=top){  
    top.location.href=location.href;  
} 
if ("${error}" != "") {
	//alert("${error}");
	layer.alert("${error}",{icon: 5});
};
function check(){
	var username = $("#username").val();
	var password = $("#password").val();
	var checkcode = $("#checkcode").val();
	if(username==""){
		layer.alert("请输入用户名!",{icon: 5});
        return false;
	}
	if(password==""){
		layer.alert("请输入密码!",{icon: 5});
        return false;
	}
	if(checkcode==""){
		layer.alert("请输入验证码!",{icon: 5});
        return false;
	}
	return true;
}
//首页面刷新验证码
function createCheckCodeIndex(){
	document.getElementById("createCodeIndex").src = document.getElementById("createCodeIndex").src   + "?nocache=" + new Date().getTime();  
}
</script>
</body>
</html>