<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		
	});
	function submitForm(){
		var nameVal = $.trim($("#name").val());
		if(nameVal == "" || nameVal == undefined || nameVal == null){
			layer.tips("请输入功能名称", "#name", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		$.ajax({
		      type : "POST",
		      async : true,
		      url : "${ctx}/rightController/saveOrUpdate",
		      data : $("#form-right-save").serialize(),
		      cache : false,
		      dataType : "json",
		      beforeSend : function() {
		           // Handle the beforeSend event
		      },
		      success : function(data, textStatus) {
		          if (data.status==1) {// 处理成功
		        	  layer.msg("操作成功",{icon: 6,time:2000},function(){
		        		  //关闭后的操作
			        	  parent.location.reload();
			        	  layer_close();
		        	  });
		          } else {// 处理失败
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
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
<body>
<div class="pd-20">
	<form action="${ctx}/rightController/saveOrUpdate" method="post" class="form form-horizontal" id="form-right-save">
		<div id="tab-system" class="HuiTab">
			<div class="tabCon">
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>功能名称：</label>
					<div class="formControls col-10">
						<input type="text" id="name" name="name" placeholder="请输入功能名称" value="${right.name}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2">链接地址：</label>
					<div class="formControls col-10">
						<input type="text" id="link" name="link" placeholder="请输入链接地址" value="${right.link}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2">权限信息：</label>
					<div class="formControls col-10">
						<input type="text" id="description" name="description" placeholder="请输入权限信息" value="${right.description}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>功能状态：</label>
					<div class="formControls col-10">
						<input type="radio" id="state1" name="state" value="1" checked="checked">启用
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id="state0" name="state" value="0" <c:if test="${right.state==0}">checked="checked"</c:if>>禁用
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>功能类型：</label>
					<div class="formControls col-10">
						<input type="radio" id="type2" name="type" value="2" checked="checked">功能
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id="type1" name="type" value="1" <c:if test="${right.type==1}">checked="checked"</c:if>>菜单
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id="type0" name="type" value="0" <c:if test="${right.type==0}">checked="checked"</c:if>>包
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>排列序号：</label>
					<div class="formControls col-10">
						<input type="text" id="seqnum" name="seqnum" placeholder="请输入排列序号" value="${right.seqnum}" class="input-text">
					</div>
				</div>
			</div>
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<input type="hidden" name="id" value="${right.id}">
				<input type="hidden" name="parentId" value="${right.parentId}">
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

function icon_Select(){
	layer_show('样式选择','rightController/iconSelect',650,450);
}
</script>
</body>
</html>
