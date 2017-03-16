<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>	
		<style>
		.select-box button{
		background:#fff;
		border:0px;
		}
		a{color: blue;}
		</style>
		
	</head>
<body>
<div class="pd-15">
	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
		<div class="l"> 
			手机号：${page.pd.accountMobile}
 		</div>
	</div>
	<div class="mt-10">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="30"></th>
					<th width="">会员卡编号</th>
					<th width="">代理商</th>
					<th width="">开卡时间</th>
					<th width="">首单充值时间</th>
					<th width="">卡内余额</th>
					<th width="">挂失状态</th>
					<th width="">冻结状态</th>
					<th width="">异常操作备注</th>
					<th width="">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${list}" varStatus="indexId">
					<tr class="text-c">
						<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td>${m.cardCode}</td>
						<td>${m.shopName}</td>
						<td><fmt:formatDate value="${m.createdAt}" type="both"/></td>
						<td><fmt:formatDate value="${m.firstRechargeAt}" type="both"/></td>
						<td>${m.balance}</td>
						<td>
							<c:if test="${m.isLoss == 0}">正常</c:if>
							<c:if test="${m.isLoss == 1}">挂失</c:if>
						</td>
						<td>
							<c:if test="${m.isFreeze == 0}">正常</c:if>
							<c:if test="${m.isFreeze == 1}">冻结</c:if>
						</td>	
						<td>
							${m.remark}
						</td>
						<td>
							<c:if test="${m.isLoss == 0}">
								<a href="javascript:;" onclick="switchCardState('挂失','${ctx}/accountController/updateCard?relateId=${m.id}&ope=1&cardCode=${m.cardCode}&phoneNum=${page.pd.accountMobile}',1)">挂失</a>
							</c:if>
							<c:if test="${m.isLoss == 1}">
								<a href="javascript:;" onclick="switchCardState('解挂','${ctx}/accountController/updateCard?relateId=${m.id}&ope=3&cardCode=${m.cardCode}&phoneNum=${page.pd.accountMobile}',3)">解挂</a>
							</c:if>
							<c:if test="${m.isFreeze == 0}">
								<a href="javascript:;" onclick="switchCardState('冻结','${ctx}/accountController/updateCard?relateId=${m.id}&ope=2&cardCode=${m.cardCode}&phoneNum=${page.pd.accountMobile}',2)">冻结</a>
							</c:if>
							<c:if test="${m.isFreeze == 1}">
								<a href="javascript:;" onclick="switchCardState('解冻','${ctx}/accountController/updateCard?relateId=${m.id}&ope=4&cardCode=${m.cardCode}&phoneNum=${page.pd.accountMobile}',4)">解冻</a>
							</c:if>
							<c:if test="${m.isLoss == 0 && m.isFreeze == 0 && m.isPwd == 0}">
								<a href="javascript:;" onclick="editPwd('设置密码','${ctx}/accountController/preEditPwd?relateId=${m.id}&phoneNum=${page.pd.accountMobile}&ope=5&cardCode=${m.cardCode}')">设置密码</a>
							</c:if>
							<c:if test="${m.isLoss == 0 && m.isFreeze == 0 && m.isPwd == 1}">
								<a href="javascript:;" onclick="editPwd('重置密码','${ctx}/accountController/preEditPwd?relateId=${m.id}&phoneNum=${page.pd.accountMobile}&ope=6&cardCode=${m.cardCode}')">重置密码</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%@ include file="../../common/page.jsp" %>
	</div>
</div>

<%@ include file="../../common/_footer.jsp" %>
<script type="text/javascript">
	$(function(){
		$(".table-sort").dataTable({
			"bPaginate": false, //翻页功能
			"bLengthChange": false, //改变每页显示数据数量
			"bFilter": false, //过滤功能
			"bSort": true, //排序功能
			"bInfo": false,//页脚信息
			"bAutoWidth": true//自动宽度
		});
		layer.config({
		    extend: 'extend/layer.ext.js'
		});
	});
	
	function switchCardState(title,url,type){
		var tipText = "";
		var isLoss = "";
		var isFreeze = "";
		switch (type) {
		case 1:
			tipText = "挂失";
			isLoss = "1";
			break;
		case 2:
			tipText = "冻结";
			isFreeze = "1";
			break;
		case 3:
			tipText = "解挂";
			isLoss = "0";
			break;
		case 4:
			tipText = "解冻";
			isFreeze = "0";
			break;
		default:
			break;
		}
		layer.prompt({
		    title: "<span class='c-red'>*</span>请输入"+tipText+"原因（<span class='c-red'>必填项</span>）",
		    formType: 2 //prompt风格，支持0-2
		}, function(remarkInfo){
			 $.ajax({
		        type:"POST",
		        async:false,
		        url : url,
		        data :{
		        	"isLoss":isLoss,
		        	"isFreeze":isFreeze,
		        	"remark":remarkInfo
		        },
		        cache : false,
		        dataType : "json",
		        beforeSend : function() {
		        },
		        success : function(data, textStatus) {
		            if(data.status == 1){//成功
		            	layer.msg("操作成功",{icon: 6,time:2000},function(){
		            		location.reload();
		            	});
		            }else{//
		            	layer.alert("操作失败",{icon: 5});
		            }
		        },
		        error : function() {
		        	layer.alert("请求发送失败，请稍候重试");
		        },
		        complete : function() {
		        }
		    });
		});
	}
	
	function editPwd(title,url){
		layer_show(title,url,'800','600');
	}
	
</script>

</body>
</html>