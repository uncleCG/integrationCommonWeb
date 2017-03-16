<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
	<style>
		a{color: blue;}
	</style>
<body>
<div class="pd-15">
	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
		<div class="l">商户编号：<input type="text" name="code" id="code" placeholder="可模糊查询" value="${pageData.code}" style="width:160px" class="input-text" /></div>
		<div class="l">商户名称：<input type="text" name="name" id="name" placeholder="可模糊查询" value="${pageData.name}" style="width:160px" class="input-text" /></div>
		<span class="l pd-10"> 
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span> 
	</div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="30">序号</th>
					<th width="">商户编号</th>
					<th width="">商户名称</th>
					<th width="">地理区域</th>
					<th width="55">商户状态</th>
					<th width="55">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="shopPd" varStatus="indexId">
					<tr class="text-c">
						<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td title="${shopPd.code}">${shopPd.code}</td>
						<td>${shopPd.name}</td>
						<td>${shopPd.province}-${shopPd.city}-${shopPd.district}</td>
						<td>
							<c:if test="${shopPd.state==0}">下架</c:if>
							<c:if test="${shopPd.state==1}">上架</c:if>
						</td>
						<td class="f-14 td-manage">
							<a title="关联" href="javascript:;" onclick="showConfirm('关联','','220',${shopPd.id},'${shopPd.name}','${shopPd.code}')" class="ml-5" style="text-decoration:none">关联</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%@ include file="../../common/page.jsp" %>
	</div>
</div>

<%@ include file="../../common/_footer.jsp" %>
<script type="text/javascript" src="${ctx}/statics/js/area.js"></script>
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

	/*显示上下架确认操作框*/
	function showConfirm(title,w,h,id,name,code){
		var confirmStr = "确认要关联此商户吗？";
		layer.confirm(confirmStr, {
		    btn: ["确定","取消"] //按钮
		},function(){
			parent.$("#shopId").val(id);
			parent.$("#shopCodeName").html(code+"-"+name);
			layer.msg("操作成功",{icon: 6,time:1});
			layer_close();
		});
		
  	}
</script> 
</body>
</html>