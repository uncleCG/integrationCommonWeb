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
	<c:if test="${pd.type!=1}">
		<form action="" method="post" class="form form-horizontal" id="form-save">
			<div id="tab-system" class="HuiTab" >
				<div class="tabCon">
					<c:if test="${pd.type==0 }"><!-- 一级服务类型 -->
						<div class="row cl">
							<label class="form-label col-2"><span class="c-red">*</span>一级类型：</label>
							<div class="formControls col-10">
								<input type="text" id="name" name="name" placeholder="请输入一级类型名称" value="${pd.name}" class="input-text">
							</div>
						</div>
					</c:if>
					<c:if test="${pd.type==2 }"><!-- 二级服务类型 -->
						<div class="row cl">
							<label class="form-label col-2"><span class="c-red">*</span>二级类型：</label>
							<div class="formControls col-10">
								<input type="hidden" name="parentId" value="${pd.parentId}">
								<input type="text" id="name" name="name" placeholder="请输入二级类型名称" value="${pd.name}" class="input-text">
							</div>
						</div>
					</c:if>
				</div>
				<div class="row cl mt-10">
					<label class="form-label col-2"><span class="c-red">*</span>图标：</label>
					<div class="formControls col-10">
						<input type="file" name="logoImg" id="logoImg" style="display:none;" onchange="previewImg(this,'imgDivId')">
						<div>
							<c:if test="${empty pd.logo}">
								<div id="imgDivId" style="float: left;">
									<img src="" style="width: 160px;height: 120px;">
								</div>
								<p class="c-red" style="clear:left;">图片尺寸：104*104</p>
								<label for="logoImg" class="btn btn-primary radius ml-5" id="uploadLogoBtn" style="float: left;">上传图标</label>
							</c:if>
							<c:if test="${!empty pd.logo}">
								<div id="imgDivId" style="float: left;">
									<img alt="logo" src="${ImgPath}/atlas/statics/shopImg/${pd.logo}" style="width: 160px;height: 120px;">
								</div>
								<p class="c-red" style="clear:left;">图片尺寸：104*104</p>
								<label for="logoImg" class="btn btn-primary radius ml-5" id="uploadLogoBtn" style="float: left;">修改图标</label>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="row cl mt-10 clear">
				<div class="col-10 col-offset-2">
					<input type="hidden" name="id" value="${pd.id}">
					<input type="hidden" name="type" value="${pd.type}">
					<button onclick="submitForm();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
					<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
				</div>
			</div>
		</form>
	</c:if>
	<c:if test="${pd.type==1}">
		<form action="${ctx}/serviceTypeController/saveOrUpdateBrand" method="post" class="form form-horizontal" id="form-save">
			<div id="tab-system" class="HuiTab" style="height: <c:if test="${pd.type==0}">80</c:if><c:if test="${pd.type==1}">250</c:if><c:if test="${pd.type==2}">80</c:if>px;">
				<div class="tabCon">
					<div class="row cl">
						<label class="form-label col-2"><span class="c-red">*</span>品牌缩写：</label>
						<div class="formControls col-10">
							<input type="text" id="name" name="name" placeholder="请输入品牌缩写" value="${pd.name}" class="input-text">
						</div>
					</div>
					<div class="row cl">
						<label class="form-label col-2"><span class="c-red">*</span>品牌名称：</label>
						<div class="formControls col-10">
							<input type="text" id="full_name" name="full_name" placeholder="请输入品牌名称" value="${pd.full_name}" class="input-text">
						</div>
					</div>
					<div class="row cl">
						<label class="form-label col-2"><span class="c-red">*</span>品牌LOGO：</label>
						<div class="formControls col-10">
							<input type="file" name="logoImg" id="logoImg" style="display:none;" onchange="previewImg(this,'imgDivId')">
							<div>
								<c:if test="${empty pd.logo}">
									<div id="imgDivId" style="float: left;">
										<img src="" style="width: 160px;height: 120px;">
									</div>
									<label for="logoImg" class="btn btn-primary radius ml-5" id="uploadLogoBtn" style="float: left;">上传LOGO</label>
								</c:if>
								<c:if test="${!empty pd.logo}">
									<div id="imgDivId" style="float: left;">
										<img alt="logo" src="${ImgPath}/atlas/statics/shopImg/${pd.logo}" style="width: 160px;height: 120px;">
									</div>
									<label for="logoImg" class="btn btn-primary radius ml-5" id="uploadLogoBtn" style="float: left;">修改LOGO</label>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row cl clear">
				<div class="col-10 col-offset-2">
					<input type="hidden" name="id" value="${pd.id}">
					<input type="hidden" name="type" value="${pd.type}">
					<button onclick="submitForm();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
					<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
				</div>
			</div>
		</form>
	</c:if>
</div>
<%@ include file="../../common/_footer.jsp" %>
<script type="text/javascript" src="${ctx}/statics/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/statics/js/previewImage.js"></script>
<script type="text/javascript">
	$(function(){
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});
		$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
		var statusVal = "${success}";
		if(statusVal != "" && statusVal != undefined && statusVal != null){
			if(statusVal==1){
				layer.msg("操作成功",{icon: 6,time:2000},function(){
					parent.location.reload();
				});
			}else{
				layer.alert("操作失败",{icon: 5,time:2000});
			}
		}
	});
	
	var isOk = false;//唯一值合法性，true：通过
	var idVal = "${pd.id}";
	var typeVal = "${pd.type}";
	var nameVal = "";
	var oldNameVal = "";
	
	function checkName(){//校验唯一值合法性
		//==================================表单校验 begin ===================================
		switch (typeVal) {
		case "1"://品牌
			nameVal = $.trim($("#full_name").val());
			oldNameVal = "${pd.full_name}";
			var brandAcronymVal = $.trim($("#name").val()); //品牌缩写
			if(brandAcronymVal == "" || brandAcronymVal == undefined || brandAcronymVal == null){
				layer.tips("请输入品牌缩写", "#name", {
				    tips: [1, "#F00"],
				    time: 2000
				});
				return false;
			}
			if(nameVal == "" || nameVal == undefined || nameVal == null){
				layer.tips("请输入品牌全称", "#full_name", {
				    tips: [1, "#F00"],
				    time: 2000
				});
				return false;
			}
			break;
		default://服务
			nameVal = $.trim($("#name").val());
			oldNameVal = "${pd.name}";
			if(nameVal == "" || nameVal == undefined || nameVal == null){
				layer.tips("请输入类型名称", "#name", {
				    tips: [1, "#F00"],
				    time: 2000
				});
				return false;
			}
			break;
		}
		var logoVal = $("#logoImg").val();
		if(idVal == "" && logoVal == ""){
			var tipContent = "请选择图标";
			if(typeVal == '1'){
				tipContent = "请选择品牌LOGO";
			}
			layer.tips(tipContent, "#uploadLogoBtn", {
			    tips: [1, "#F00"],
			    time: 2000
			});
			return false;
		}
		
	//==================================表单校验 end ===================================
		var checkFlag = false;
		if(idVal != undefined && idVal != "" && idVal != null){//修改
			if(oldNameVal != ""){
				if(oldNameVal != nameVal){
					checkFlag = true;
				}
			}
		}else{//新增
			if(nameVal != ""){//不为""
				checkFlag = true;
			}
		}
		if(checkFlag){
			$.ajax({
				type:"POST",
				async:false,
				url : "${ctx}/serviceTypeController/isExist",
				data : {
					"type" : typeVal,
					"name" : nameVal
				},
			    cache : false,
			    dataType : "json",
			    beforeSend : function() {
			    },
			    success : function(data, textStatus) {
					if(data.status == 1){//合法
						isOk =  true;
					}else{//不合法
						isOk = false;
						switch (typeVal) {
						case "1":
							$("#full_name").focus();
							layer.tips("品牌全称已存在，请更换", "#full_name", {
							    tips: [1, "#F00"],
							    time: 3000
							});
							break;
						default:
							$("#name").focus();
							layer.tips("服务名称已存在，请更换", "#name", {
							    tips: [1, "#F00"],
							    time: 3000
							});
							break;
						}
					}
			    },
			    error : function() {
					layer.alert("唯一性校验异常，请稍后重试",{icon: 5});
			   	},
			    complete : function() {

			    }
			});
		}else{//不用校验
			isOk = true;
		}
	}
	
	function submitForm(){//提交表单
		checkName();
		if(isOk){
			var urlVal = "${ctx}/serviceTypeController/saveOrUpdate";
			if(typeVal == 1){
				urlVal = "${ctx}/serviceTypeController/saveOrUpdateBrand";
			}
			var nameVal = $("#name").val();
			var fullNameVal = $("#full_name").val();
			$.ajaxFileUpload({  
			    fileElementId: "logoImg",  
			    url: urlVal,  
			    dataType: "json",  
			    //data: $("#form-save").serialize(),
			    data:{
			    	"id":"${pd.id}",
			    	"name":nameVal,
			    	"type":"${pd.type}",
			    	"parentId":"${pd.parentId}",
			    	"full_name":fullNameVal
			    },
			    beforeSend: function () {
			    },  
			    success: function (data, textStatus) {
			    	if (data.status==1) {// 处理成功
			        	  layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
				        	  parent.location.reload();
				        	  layer_close();
			        	  });
			          } else {// 处理失败
			        	  layer.msg("操作失败",{icon: 5,time:2000});
			          }
			    },  
			    error: function () {
			    	layer.alert("请求发送失败，请稍后重试",{icon: 5});  
			    },  
			    complete: function () {
			    }  
			});
		}
	}
</script>
</body>
</html>
