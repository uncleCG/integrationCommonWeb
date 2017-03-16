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
		</style>
		
	</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 运营中台 <span class="c-gray en">&gt;</span> 已领取卡管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" onclick="to_page_sub('page-data-param')" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
		<div class="l">
 			 批次：
  			 <span class="select-box inline">
 				 <select name="masterId" id="masterId" class="select">
 					<option value="0" selected="selected">全部批次</option>
					<c:forEach items="${masterPdList}" var="masterPd">
						<option value="${masterPd.id}"<c:if test="${page.pd.masterId == masterPd.id}">selected="selected"</c:if>>${masterPd.batchStart}-${masterPd.batchEnd}</option>
					</c:forEach>	 					
 				</select>
 			</span>
 		</div>
 		<div class="l"> 
			会员卡编号：
 			<input type="text" name="cardCode" id="cardCode" value="${page.pd.cardCode}" style="width:150px" class="input-text" />
 		</div>
 		<div class="l"> 
			代理商名称：
 			<input type="text" name="shopName" id="shopName" value="${page.pd.shopName}" style="width:150px" class="input-text" />
 		</div>
		<div class="l"> 
			领取时间：
			<input type="text" value="${page.pd.beginDate}"  class="wdateInput" id="beginDate" name="beginDate" placeholder="领取时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd', isShowClear:true,readOnly:true})" style="width:150px;"/>
 		</div>
 		<div class="l"> 
			截止时间：
			<input type="text" value="${page.pd.endDate}" class="wdateInput" id="endDate" name="endDate" placeholder="结束时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd', isShowClear:true,readOnly:true})" style="width:150px;"/>
		</div>
		<span class="l pd-10"> 
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span> 
	</div>
	<div class="mt-10">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="40"></th>
					<th width="">批次</th>
					<th width="">领取号段</th>
					<th width="">员工姓名+手机号</th>
					<th width="">所属商户名称</th>
					<th width="">领取时间</th>
					<th width="">领取数量</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${receiveCardPdList}" varStatus="indexId">
					<tr class="text-c">
					<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td>${m.batch_start}-${m.batch_end}</td>
						<td>${m.receive_start}-${m.receive_end}</td>
						<td>${m.shopEmployeeName}+${m.shopEmployeeMobile}</td>
						<td>${m.shopName}</td>
						<td>
							<fmt:formatDate value="${m.receive_at}" type="both"/>
						</td>
						<td>${m.receive_num}</td>
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
	});
</script>

</body>
</html>