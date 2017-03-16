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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户系统 <span class="c-gray en">&gt;</span> 买家管理 <span class="c-gray en">&gt;</span> 未绑卡买家管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" onclick="to_page_sub('page-data-param')" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
		<div class="l"> 
			会员卡编号：
 			<input type="text" name="cardCode" id="cardCode" placeholder="支持模糊搜索" value="${page.pd.cardCode}" style="width:150px" class="input-text" />
 		</div>
		<span class="l pd-10"> 
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span> 
		<a class="btn btn-primary radius r mt-10" data-title="未绑卡买家管理" onclick="to_export_xls_sub('page-data-param','accountController/exportNoTieBuyerList?showCount=${page.showCount*page.totalPage}','未绑卡买家列表')" href="javascript:void(0);">
			&nbsp;导&nbsp;&nbsp;&nbsp;出&nbsp;
		</a>
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
					<th width="">充值总金额</th>
					<th width="">消费总金额</th>
					<th width="">卡内余额</th>
					<th width="">挂失状态</th>
					<th width="">冻结状态</th>
					<th width="">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${list}" varStatus="indexId">
					<tr class="text-c">
						<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td>${m.cardCode}</td>
						<td>${m.shopName}</td>
						<td>
							<fmt:formatDate value="${m.createdAt}" type="both"/>
						</td>
						<td>
							<fmt:formatDate value="${m.firstRechargeAt}" type="both"/>
						</td>
						<td>${m.recharge}</td>
						<td>${m.consume}</td>
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
							<c:if test="${m.isLoss == 0}">
								<a href="javascript:;" onclick="switchCardState('挂失','${ctx}/accountController/updateCard?relateId=${m.id}',1)">挂失</a>
							</c:if>
							<c:if test="${m.isLoss == 1}">
								<a href="javascript:;" onclick="switchCardState('解挂','${ctx}/accountController/updateCard?relateId=${m.id}',3)">解挂</a>
							</c:if>
							<c:if test="${m.isFreeze == 0}">
								<a href="javascript:;" onclick="switchCardState('冻结','${ctx}/accountController/updateCard?relateId=${m.id}',2)">冻结</a>
							</c:if>
							<c:if test="${m.isFreeze == 1}">
								<a href="javascript:;" onclick="switchCardState('解冻','${ctx}/accountController/updateCard?relateId=${m.id}',4)">解冻</a>
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
</script>

</body>
</html>