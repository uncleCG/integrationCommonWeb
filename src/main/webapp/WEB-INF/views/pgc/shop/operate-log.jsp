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
	<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 信息系统 <span class="c-gray en">&gt;</span> 商户信息管理 <span class="c-gray en">&gt;</span> 操作日志</span><a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="tab-system  pd-20">
    	<table class="table table-border table-bordered table-bg table-hover table-sort">
    		<thead>
    			<tr class="text-c">
    				<th>序号</th>
    				<th>操作人</th>
    				<th>时间</th>
    				<th>事件</th>
    				<th>操作备注</th>
    				<th>状态</th>
    			</tr>
    		</thead>
    		<tbody>
    			<c:forEach items="${logList}" var="operateLog" varStatus="indexId">
	    			<tr class="text-c">
	    				<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
	    				<td>${operateLog.username}</td>
	    				<td>
	    					<fmt:formatDate value="${operateLog.log_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
	    				</td>
	    				<td>${operateLog.operation}</td>
	    				<td>${operateLog.remark}</td>
	    				<td>${operateLog.result}</td>
	    			</tr>
    			</c:forEach>
    		</tbody>
    	</table>
    	<%@ include file="../../common/page.jsp" %>
    </div>
    <%@ include file="../../common/_footer.jsp" %>
  </body>
</html>
