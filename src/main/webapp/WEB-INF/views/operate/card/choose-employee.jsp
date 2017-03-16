<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
	<style>
	.form-label{float:left;}
	.formControls{float:left;margin-top:-10px;margin-right:30px;}
	</style>
<body>
	<div class="pd-15">
		<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
			<div class="l"> 
				商户名称：<input type="text" name="shopName" id="shopName" placeholder="支持模糊查询" value="${page.pd.shopName}" style="width:160px" class="input-text">
	   		</div>
	   		<div class="l"> 
				商户编码：<input type="text" name="shopCode" id="shopCode" placeholder="支持模糊查询" value="${page.pd.shopCode}" style="width:160px" class="input-text">
	   		</div>
	   		<span class="l pd-10">
				<input type="hidden" name="shopId" value="">
				<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
			</span>
			<div class="l pd-10 ml-10">
				<button onclick="okClose();" class="btn btn-primary radius" type="button" style="float: right;"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
				<button onclick="layer_close();" class="btn btn-default radius" type="button" style="float: right;">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
	   	</div>
	   	<div class="mt-20">
			<table class="table table-border table-bordered table-bg table-hover table-sort">
				<thead>
					<tr class="text-c">
						<th width="30">&nbsp;</th>
						<th width="">员工姓名</th>
						<th width="">员工手机号</th>
						<th width="">商户编号</th>
						<th width="">商户名称</th>
						<th width="">地理区域</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${employeePdList}" var="employeePd">
						<tr class="text-c">
							<td><input type="radio" name="chkItem" value="${employeePd.employeeId}" onclick="getOnCl(this,${employeePd.shopId})"/></td>
							<td>${employeePd.employeeName}</td> 
							<td>${employeePd.employeeMobile}</td>
							<td>${employeePd.shopCode}</td>
							<td>${employeePd.shopName}</td>
							<td>${employeePd.province}${employeePd.city}${employeePd.district}</td>
						</tr> 
					</c:forEach>
				</tbody>
			</table>
			<%@ include file="../../common/page.jsp" %>
					
		</div>
	</div>
	<script>
		var employeeId,shopId,employeeName,employeeMobile,shopCode,shopName,province;
		$(function(){
			//页面重新加载后选中已选择的商户
			/* $("[name = chkItem]:radio").each(function () {
				if(parent.employeeId == $(this).val()){
					$(this).attr("checked", true); 
				}
			}); */
		});
		function okClose(){
			//确定
			if(employeeId != undefined && employeeId != ""){
				parent.employeeId = employeeId;
				parent.shopId = shopId;
				parent.employeeName = employeeName;
				parent.employeeMobile = employeeMobile;
				parent.shopCode = shopCode;
				parent.shopName = shopName;
				parent.province = province;
				parent.showRelateEmployeeInfo();
			}
			layer_close();
		}
		function getOnCl(obj,nowShopId){//赋值
			employeeId = obj.value;
			shopId = nowShopId;
			var $brotherObjs = $(obj).parent().siblings();
			$brotherObjs.each(function(i){
				switch (i) {
				case 0:
					employeeName=$(this).html();
					break;
				case 1:
					employeeMobile=$(this).html();
					break;
				case 2:
					shopCode=$(this).html();
					break;
				case 3:
					shopName=$(this).html();
					break;
				case 4:
					province=$(this).html();
					break;
				default:
					break;
				}
			});
		}
	</script>
	<%@ include file="../../common/_footer.jsp" %>   		
  </body>
</html>
