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
				手机号：<input type="text" name="mobile" placeholder="支持模糊查询" value="${pd.mobile}" style="width:160px" class="input-text">
	   		</div>
	   		<div class="l"> 
				姓名：<input type="text" name="name" placeholder="支持模糊查询" value="${pd.name}" style="width:160px" class="input-text">
	   		</div>
	   		<div class="l"> 
				身份证号：<input type="text" name="idcard" placeholder="支持模糊查询" value="${pd.idcard}" style="width:160px" class="input-text">
	   		</div>
	   		<span class="l pd-10">
				<input type="hidden" name="shopId" value="">
				<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
			</span>
			<div class="l pd-10 ml-10">
				
					<input type="hidden" name="shopId" value="">
					<button onclick="okClose();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
					<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
				
			</div>	
	   	</div>
	   	<div class="mt-20">
			<table class="table table-border table-bordered table-bg table-hover table-sort">
				<thead>
					<tr class="text-c">
						<th width="">&nbsp;</th>
						<th width="">姓名</th>
						<th width="">手机号</th>
						<th width="">身份证号</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${shopkeeperPdList}" var="shopkeeperPd">
						<tr class="text-c">
							<td><input type="radio" name="chkItem" value="${shopkeeperPd.id}" onclick="getOnCl(this)"/></td>
							<td>${shopkeeperPd.name}</td>
							<td>${shopkeeperPd.mobile}</td>
							<td>${shopkeeperPd.idcard}</td>
							<td hidden="hidden">${shopkeeperPd.idcard_img1}</td>
							<td hidden="hidden">${shopkeeperPd.idcard_img2}</td>
							<td hidden="hidden">${shopkeeperPd.shopNum}</td>
							<td hidden="hidden">${shopkeeperPd.fisrtShopName}</td>
						</tr> 
					</c:forEach>
				</tbody>
			</table>
			<%@ include file="../../common/page.jsp" %>
					
		</div>
	</div>
	<script>
		var managerId,managerName,managerMobile,managerIdcard,managerIdcardImg1,managerIdcardImg2,shopNum,firstShopName;
		$(function(){//页面重新加载后选中已选择的商户
			$("[name = chkItem]:radio").each(function () {
				if(parent.shopkeeper_id == $(this).val()){
					$(this).attr("checked", true); 
				}
			});
		});
		function okClose(){//确定
			if(managerId != undefined && managerId != ""){
				parent.showRelateShopkeeperInfo(managerId,managerName,managerMobile,managerIdcard,managerIdcardImg1,managerIdcardImg2,shopNum,firstShopName);
			}
			layer_close();
		}
		function getOnCl(obj){//赋值
			managerId = obj.value;
			var $brotherObjs = $(obj).parent().siblings();
			$brotherObjs.each(function(i){
				switch (i) {
				case 0:
					managerName=$(this).html();
					break;
				case 1:
					managerMobile=$(this).html();
					break;
				case 2:
					managerIdcard=$(this).html();
					break;
				case 3:
					managerIdcardImg1=$(this).html();
					break;
				case 4:
					managerIdcardImg2=$(this).html();
					break;
				case 5:
					shopNum=$(this).html();
					break;
				case 6:
					firstShopName=$(this).html();
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
