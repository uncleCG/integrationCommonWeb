<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		
	});
	function submitForm(){
		var nameVal = $.trim($("#name").val());
		if(nameVal == "" || nameVal == undefined || nameVal == null){
			layer.tips("请输入角色名称", "#name", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		$.ajax({
		      type : "POST",
		      async : true,
		      url : "${ctx}/roleController/saveOrUpdate",
		      data : $("#form-role-save").serialize(),
		      cache : false,
		      dataType : "json",
		      beforeSend : function() {
		           // Handle the beforeSend event
		      },
		      success : function(data, textStatus) {
		          if (data.status==1) {// 处理成功
		        	  layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
			        	  //parent.location.reload();
			        	  if("${role.id}" != undefined && "${role.id}" != ""){//修改
			        		  parent.updateTr(data.role.id,data.role.name);
			        	  }else{
			        		  parent.addTr(data.role.id,data.role.name);
			        	  }
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
	<form action="" method="post" class="form form-horizontal" id="form-role-save">
		<div id="tab-system" class="HuiTab" style="height: 114px;">
			<div class="tabCon">
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>角色名称：</label>
					<div class="formControls col-10">
						<input type="text" id="name" name="name" placeholder="请输入角色名称" value="${role.name}" class="input-text">
					</div>
				</div>
			</div>
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<input type="hidden" name="id" value="${role.id}">
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
