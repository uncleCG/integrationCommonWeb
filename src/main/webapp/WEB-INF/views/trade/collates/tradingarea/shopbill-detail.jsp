<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>

<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../../common/_top.jsp"%>
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
				<label class="form-label col-2">订单编号：</label>
				<div class="formControls col-10">
					${billDetailPd.billCode}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">订单状态：</label>
				<div class="formControls col-10">
					<c:if test="${billDetailPd.tradeStatus == 1}">待确认</c:if>	
					<c:if test="${billDetailPd.tradeStatus == 2}">未到账</c:if>	
					<c:if test="${billDetailPd.tradeStatus == 3}">交易完成</c:if>
					<c:if test="${billDetailPd.tradeStatus == 4}">交易取消</c:if>	
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">交易类型：</label>
				<div class="formControls col-10">
					<c:if test="${billDetailPd.type == 10}">消费</c:if>	
					<c:if test="${billDetailPd.type == 11}">充值</c:if>	
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">支付方式：</label>
				<div class="formControls col-10">
					<c:if test="${billDetailPd.payType == '1001'}">现金</c:if>	
					<c:if test="${billDetailPd.payType == '1003'}">微信支付</c:if>	
					<c:if test="${billDetailPd.payType == '1004'}">支付宝</c:if>	
					<c:if test="${billDetailPd.payType == '1006'}">银行卡</c:if>
					<c:if test="${billDetailPd.payType == '1007'}">会员卡</c:if>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">交易金额：</label>
				<div class="formControls col-10">
					${billDetailPd.amount} 元
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">会员卡编号：</label>
				<div class="formControls col-10">
					${billDetailPd.cardCode}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">付款人：</label>
				<div class="formControls col-10">
					${billDetailPd.payMobile}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">商户编号：</label>
				<div class="formControls col-10">
					${billDetailPd.shopCode}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">商户名称：</label>
				<div class="formControls col-10">
					${billDetailPd.shopName}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">交易终端：</label>
				<div class="formControls col-10">
					${billDetailPd.createdMobile}
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">代理商：</label>
				<div class="formControls col-10">
					${billDetailPd.createdName}+${billDetailPd.createdMobile}（${billDetailPd.shopName}）
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">创建时间：</label>
				<div class="formControls col-10">
					<fmt:formatDate value="${billDetailPd.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">交易完成时间：</label>
				<div class="formControls col-10">
					<fmt:formatDate value="${billDetailPd.tradeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-2">到账时间：</label>
				<div class="formControls col-10">
					<c:if test="${billDetailPd.type==11}">
						<fmt:formatDate value="${billDetailPd.accountTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../../../common/_footer.jsp" %>

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
