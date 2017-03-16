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
<body>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 信息系统 <span class="c-gray en">&gt;</span> 商户信息管理<span class="c-gray en">&gt;</span> 员工列表</span><a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="tab-system  pd-20">
    	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param">
    		<input type="hidden" name="shopId" value="${params.shopId}">
    	</div>
    	<table class="table table-border table-bordered table-bg table-hover table-sort">
    		<thead>
    			<tr class="text-c">
    				<th width="36">序号</th>
    				<th width="120">手机号</th>
    				<th>姓名</th>
    				<th>身份</th>
    				<th>状态</th>
    				<th>开卡数</th>
    				<th>注册时间</th>
    			</tr>
    		</thead>
    		<tbody>
    			<c:forEach items="${employeeList}" var="employeePd" varStatus="indexId">
    				<tr class="text-c">
	    				<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
	    				<td>${employeePd.mobile}</td>
	    				<td>${employeePd.name}</td>
	    				<td>
	    					<c:if test="${employeePd.is_owner == 0}">员工</c:if>
	    					<c:if test="${employeePd.is_owner == 1}">管理人</c:if>
	    				</td>
	    				<td>
	    					<c:if test="${employeePd.state == 0}">禁用</c:if>
	    					<c:if test="${employeePd.state == 1}">启用</c:if>
	    					<c:if test="${employeePd.state == 2}">解约</c:if>
	    				</td>
	    				<td>${employeePd.cardNum}</td>
	    				<td>${employeePd.created_at}</td>
    				</tr>
    			</c:forEach>
    		</tbody>
    	</table>
    	<%@ include file="../../common/page.jsp" %>
    </div>
    <%@ include file="../../common/_footer.jsp" %>
  </body>
</html>
