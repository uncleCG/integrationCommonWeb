<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>

<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
<style>
legend{margin-bottom:0px;}
</style>
<link rel="stylesheet" href="${ctx}/statics/lib/lightbox2/2.8.1/css/lightbox.css">
<body>
<div class="pt-10 pl-20 info-title">
<div class="pd-20">
<div id="tab-system">
	<div class="tabCon">
		<fieldset class="infoFieldset">
			<legend>基本信息</legend>
				<div class="row cl">
					<label class="form-label col-2">姓名：</label>
					<div class="formControls col-10 text-l">
						${shopEmployee.name}
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2"> 手机号：</label>
					<div class="formControls col-10 text-l">
							${shopEmployee.mobile}	
					</div>
				</div>
					<div class="row cl">
					<label class="form-label col-2"> 身份证号：</label>
					<div class="formControls col-10 text-l">
						${shopEmployee.idcard}
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-2">身份证照：</label>
					<div class="formControls col-10 text-l">
						<a class="example-image-link" href="${ImgPath}/atlas/statics/shopImg/${shopEmployee.idcard_img1}" data-lightbox="idcardImg-1" data-title="身份证照片-1">
							<img src="${ImgPath}/atlas/statics/shopImg/${shopEmployee.idcard_img1}" width="160px;" height="120px;" alt="身份证照片-1">
						</a>
						<a class="example-image-link" href="${ImgPath}/atlas/statics/shopImg/${shopEmployee.idcard_img2}" data-lightbox="idcardImg-2" data-title="身份证照片-2">
							<img src="${ImgPath}/atlas/statics/shopImg/${shopEmployee.idcard_img2}" width="160px;" height="120px;" alt="身份证照片-2">
						</a>
					</div>
				</div>
		
			</fieldset>	
			<fieldset class="infoFieldset">
				<legend>关联商户</legend>
				<div class="mt-10">
					<table class="table table-border table-bordered table-bg table-hover table-sort">
						<thead>
							<tr class="text-c">
								<th width="40">序号</th>
								<th width="60">商户编号</th>
								<th width="150">商户名称</th>
								<th width="65">员工</th>
								<th width="120">地理区域</th>
								<th width="75">商户状态</th>
								<th width="80">总交易量</th>
								<th width="60">总交易额</th>
								<th width="120">评价</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="m" items="${list}" varStatus="indexId">
								<tr class="text-c">
									<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
									<td>${m.code}</td>
									<td>${m.name}</td>
									<td>${m.empnums}</td>
									<td>
										${m.province}-${m.city}-${m.district}
									</td>
									<td>
										<c:if test="${m.state==1}">上架</c:if>
										<c:if test="${m.state!=1}">下架</c:if>
									</td>
									<td>${m.billnum}</td>
									<td>${m.amountnum}</td>
									<td>
										<c:choose>
											<c:when test="${m.score==null}">0</c:when>
											<c:otherwise><fmt:formatNumber value="${m.score}" pattern="#0.0#"/></c:otherwise>
										</c:choose>分-${m.numbers}条
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</fieldset>	
		</div>
	</div>
</div>
<script src="${ctx}/statics/lib/lightbox2/2.8.1/js/lightbox-plus-jquery.min.js"></script>
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
