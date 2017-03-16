<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/statics/js/previewImage.js"></script>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>

<body>
<form action="" method="post" class="form form-horizontal" id="form-employee-save">
	<div class="pd-20">
		<div id="tab-system">
			<div class="tabCon">
				<div class="row cl">
					<label class="form-label col-2"><span class="c-red">*</span>手机号：</label>
					<div class="formControls col-5">
						<input type="text" id="mobile" name="mobile" placeholder="手机号" value="${shopEmployee.mobile}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2">姓&nbsp;&nbsp;&nbsp;名：</label>
					<div class="formControls col-5">
						<input type="text" id="name" name="name" placeholder="姓名" value="${shopEmployee.name}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2">员工照片：</label>
					<div class="formControls col-5">
						<input type="file" name="headImg" id="headImg" style="display:none;" onchange="previewImg(this,'imgDivId')">
						<div>
							<c:if test="${empty shopEmployee.head_image}">
								<div id="imgDivId" style="float: left;">
									<img src="" style="width: 160px;height: 120px;">
								</div>
								<label for="headImg" class="btn btn-primary radius ml-5" id="uploadHeadImgBtn" style="float: left;">上传照片</label>
							</c:if>
							<c:if test="${!empty shopEmployee.head_image}">
								<div id="imgDivId" style="float: left;">
									<img alt="headImg" src="${ImgPath}/atlas/statics/shopImg/${shopEmployee.head_image}" style="width: 160px;height: 120px;">
								</div>
								<label for="headImg" class="btn btn-primary radius ml-5" id="uploadHeadImgBtn" style="float: left;">修改照片</label>
							</c:if>
						</div>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2">员工状态：</label>
					<div class="formControls col-5">
						<select name="state" id="state" class="select" style="min-width:100px">
							<option value="1"<c:if test="${shopEmployee.state==1}">selected="selected"</c:if>>启用</option>
		 					<option value="0"<c:if test="${shopEmployee.state==0}">selected="selected"</c:if>>禁用</option>
							<!-- 
							<option value="9"<c:if test="${shopEmployee.state==9}">selected="selected"</c:if>>解约</option>
							 -->
		 				</select>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2">关联商户：</label>
					<div class="formControls col-5">
						<c:if test="${empty shopEmployee.id}">
							<span id="shopCodeName"></span>
						</c:if>
						<c:if test="${!empty shopEmployee.id}">
							<span id="shopCodeName">${shopEmployee.shop_code}-${shopEmployee.shop_name}</span>
						</c:if>
						<span class=""> 
							<a class="btn btn-primary radius" id="chooseShopBtn" data-title="选择商户" href="javascript:;" onclick="showShopPage('选择商户','shopController/getShopListPage','1200','900')" href="javascript:;">
								选择商户
							</a>
						</span>
					</div>
				</div>
			</div>
			<div class="row cl">
				<div class="col-10 col-offset-2">
					<input type="hidden" id="id" name="id" value="${shopEmployee.id}">
					<input type="hidden" id="shopId" name="shopId" value="${shopEmployee.shop_id}">
					<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
					<button onclick="submitForm();" class="btn btn-primary radius" type="button" id="saveBtn"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
				</div>
			</div>
		</div>
	</div>
</form>
<%@ include file="../../common/_footer.jsp" %>
<script type="text/javascript" src="${ctx}/statics/js/ajaxfileupload.js"></script>
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
});

//弹出商户列表
function showShopPage(title,url,id,w,h){
	layer_show(title,url,w,h);
}

var isOk = false;
var isCheck = false;

function checkMobile(phoneNum){
	if(isCheck){
		$.ajax({
			type:"POST",
			async:false,
			url : "${ctx}/sellerManageController/isMobileExist",
			data : {
				"phoneNum" : phoneNum
			},
		    cache : false,
		    dataType : "json",
		    beforeSend : function() {
		    },
		    success : function(data, textStatus) {
				if(data.status == 1){//合法
					isOk =  true;
				}
		    },
		    error : function() {
				layer.alert("手机号校验异常，请稍后重试",{icon: 5});
		   	},
		    complete : function() {

		    }
		});
	}else{//不用校验
		isOk = true;
	}
}

function submitForm(){
	var mobileVal = $.trim($("#mobile").val());
	var mobileReg = /^1\d{10}$/;//手机正则
	if(!mobileReg.test(mobileVal)){
		layer.tips("请填写正确的手机号", "#mobile", {
            tips: [1, "#F00"],
            time: 2000
        });
		return false;
	}else{
		var oldMobile = "${shopEmployee.mobile}";
		var idVal = "${shopEmployee.id}";
		if(idVal == "" || idVal == undefined || idVal == null){
			//添加
			isCheck = true;
		}else{
			if(oldMobile == mobileVal){
				//未修改手机号
				isCheck = false;
			}else{
				//修改了新手机号
				isCheck = true;
			}
		}
		checkMobile(mobileVal);
	}
	
	if(!isOk){
		layer.alert("手机号不可用，请重新输入",{icon: 5});
		return false;
	}
	
	var nameVal = $.trim($("#name").val());
	if(nameVal == "" || nameVal == undefined){
		layer.tips("请填写姓名", "#mobile", {
            tips: [1, "#F00"],
            time: 2000
        });
		return false;
	}
	
	var shopIdVal = $("#shopId").val();
	if(shopIdVal == "" || shopIdVal == undefined || shopIdVal == null){
		layer.tips("请选择商户", "#chooseShopBtn", {
            tips: [1, "#F00"],
            time: 2000
        });
		return false;
	}
	$("#saveBtn").prop("disabled",true);
	$.ajaxFileUpload({  
	    fileElementId: "headImg",  
	    url: "${ctx}/sellerManageController/saveOrUpdate", 
	    dataType: "json",  
	    data: {
	    	"id":"${shopEmployee.id}",
	    	"mobile":mobileVal,
	    	"name":nameVal,
	    	"state":$("#state option:selected").val(),
	    	"shopId":shopIdVal
	    },
	    beforeSend: function () {
	    },  
	    success: function (data, textStatus) {
	    	if (data.status==1) {// 处理成功
	        	  layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
		        	  parent.location.reload();
	        	  });
	          } else {// 处理失败
	        	  layer.msg("操作失败",{icon: 5,time:2000});
	        	  $("#saveBtn").prop("disabled",false);
	          }
	    },  
	    error: function () {
	    	layer.alert("请求发送失败，请稍后重试",{icon: 5}); 
	    	$("#saveBtn").prop("disabled",false);
	    },  
	    complete: function () {
	    }  
	});
}

</script>
</body>
</html>
