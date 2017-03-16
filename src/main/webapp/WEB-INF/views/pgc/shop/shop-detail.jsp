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
		legend{
			width: auto; 
		    margin-bottom: 0px; 
		    font-size: 21px; 
		    line-height: auto; 
		    border: 0; 
		    border-bottom: 0px;
		}
		table td{
			padding:10px 0px;
		}
</style>
<body>
<div class="pd-20">
	<div id="tab-system">
		<div class="tabCon">
			<div class="row cl">
				<label class="form-label col-2">商户编号：</label>
				<div class="formControls col-10">
					${shopPd.code}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">商户名称：</label>
				<div class="formControls col-10">
					${shopPd.name}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">地理区域：</label>
				<div class="formControls col-10">
					${shopPd.province}－${shopPd.city}－${shopPd.district}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">商户地址：</label>
				<div class="formControls col-10">
					${shopPd.address}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">经度：</label>
				<div class="formControls col-10">
					${shopPd.longitude}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">纬度：</label>
				<div class="formControls col-10">
					${shopPd.latitude}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">联系人：</label>
				<div class="formControls col-10">
					${shopPd.linkman}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">联系电话：</label>
				<div class="formControls col-10">
					${shopPd.link_tel}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">服务类型：</label>
				<div class="formControls col-10">
					<c:forEach items="${twoServiceTypeList}" var="twoServiceTypePd" varStatus="indexId">
						<c:if test="${indexId.index != 0}">,</c:if>
						${twoServiceTypePd.name}
					</c:forEach>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">开户名：</label>
				<div class="formControls col-10">
					${shopPd.bank_card_name}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">开户行：</label>
				<div class="formControls col-10">
					${shopPd.bank_name}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">账号：</label>
				<div class="formControls col-10">
					${shopPd.bank_card_code}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">账户性质：</label>
				<div class="formControls col-10">
					<c:if test="${shopPd.bank_card_type == 1}">对公账户</c:if>
					<c:if test="${shopPd.bank_card_type == 2}">对私，法定代表人</c:if>
					<c:if test="${shopPd.bank_card_type == 3}">对私，非法定代表人</c:if>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">营业执照注册名称：</label>
				<div class="formControls col-10">
					${shopPd.reg_name}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">营业执照照片：</label>
				<div class="formControls col-10">
					<img src="${ImgPath}/atlas/statics/shopImg/${shopPd.reg_img}" width="160" height="120" id="regImg"/>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">管理人姓名：</label>
				<div class="formControls col-10">
					${shopkeeperPd.name}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">管理人手机号：</label>
				<div class="formControls col-10">
					${shopkeeperPd.mobile}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">管理人身份证号：</label>
				<div class="formControls col-10">
					${shopkeeperPd.idcard}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">管理人身份证照片：</label>
				<div class="formControls col-10">
					<img src="${ImgPath}/atlas/statics/shopImg/${shopkeeperPd.idcard_img1}" width="160" height="120" id="idcardImg1"/>
					<img src="${ImgPath}/atlas/statics/shopImg/${shopkeeperPd.idcard_img2}" width="160" height="120" id="idcardImg2"/>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">商户返利：</label>
				<div class="formControls col-10">
					<fmt:formatNumber type="percent" value="${shopPd.total_rebate_percent}"/>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">充值需确认到账限额：</label>
				<div class="formControls col-10">
					${shopPd.confirm_money}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">合同照片：</label>
				<div class="formControls col-10">
					<img src="${ImgPath}/atlas/statics/shopImg/${shopPd.contract_img}" width="160" height="120" id="contractImg"/>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">合同有效期：</label>
				<div class="formControls col-10">
					${shopPd.contract_begin_time}
					<c:if test="${!empty shopPd.contract_begin_time && !empty shopPd.contract_end_time }">
						~ 
					</c:if>
					${shopPd.contract_end_time}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">录入时间：</label>
				<div class="formControls col-10">
					<fmt:formatDate value="${shopPd.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</div>
			</div>
		</div>
	</div>
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
