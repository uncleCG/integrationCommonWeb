<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户系统 <span class="c-gray en">&gt;</span> 卖家管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" onclick="to_page_sub('page-data-param')" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">

	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
		<div class="l"> 
 			手机号：
 			<input type="text" name="mobile" id="mobile" placeholder="关键词" value="${pageData.mobile}" style="width:150px" class="input-text">
 			姓名：
 			<input type="text" name="name" id="name" placeholder="关键词" value="${pageData.name}" style="width:150px" class="input-text">
			身份：
			<span class="select-box inline">
 				 <select name="is_owner" class="select" style="min-width:100px">
 					<option value="-1"<c:if test="${empty pageData.is_owner or pageData.is_owner == '-1'}" >selected="selected"</c:if>>全部身份</option>
 					<option value="0"<c:if test="${pageData.is_owner=='0'}" >selected="selected"</c:if>>员工</option>
					<option value="1"<c:if test="${pageData.is_owner=='1'}" >selected="selected"</c:if>>管理人</option>
 				</select>
 			</span>
 				状态：
			<span class="select-box inline">
 				 <select name="state" class="select" style="min-width:100px">
 					<option value="-1"<c:if test="${empty pageData.state or pageData.state == '-1'}" >selected="selected"</c:if>>全部状态</option>
 					<option value="0"<c:if test="${pageData.state=='0'}" >selected="selected"</c:if>>禁用</option>
					<option value="1"<c:if test="${pageData.state=='1'}" >selected="selected"</c:if>>启用</option>
					<option value="9"<c:if test="${pageData.state=='9'}" >selected="selected"</c:if>>解约</option>
 				</select>
 			</span>
	</div>
		<span class="l pd-10"> 
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span>
		<span class="l pd-10">
			<button name="" id="" class="btn btn-success" type="button"
					onclick="to_export_xls_sub('page-data-param','${ctx}/sellerManageController/exportSellerList?showCount=${page.showCount*page.totalPage}','卖家管理列表')">导出</button>
		</span> 
		<span class="r pd-10"> 
			<a class="btn btn-primary radius" data-title="添加员工" href="javascript:;"  onclick="showEditPage('添加卖家','${ctx}/sellerManageController/preEdit')">
				<i class="Hui-iconfont">&#xe600;</i> 添加员工
			</a>
		</span> 
	</div>
	<div class="mt-10">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="60">序号</th>
					<th width="120">手机号</th>
					<th width="80">姓名</th>
					<th width="80">身份</th>
					<th width="80">注册时间</th>
					<th width="75">状态</th>
					<th width="75">关联商户数</th>
					<th width="75">开卡数</th>
					<th width="75">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${list}" varStatus="indexId">
					<tr class="text-c">
					<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td>${m.mobile}</td>
						<td>${m.name}</td>
						<td>
							<c:if test="${m.is_owner==0}">员工</c:if>
							<c:if test="${m.is_owner==1}">管理人</c:if>	
						</td>
						<td>${m.created_at}</td>
						<td>
							<c:if test="${m.state==1}">启用</c:if>	
							<c:if test="${m.state==0}">禁用</c:if>	
							<c:if test="${m.state==9}">解约</c:if>
						</td>
						<td>
							<c:choose>
								<c:when test="${m.state==9}">0</c:when>
								<c:otherwise>
									<c:if test="${m.is_owner==0}">
										<a title="商户列表" style="color: blue;" onclick="Hui_admin_tab(this)" href="javascript:;" data-title="商户列表" _href="shopController/findListByEmployee?shopId=${m.shop_id}">${m.shopsnum}</a>
									</c:if>
									<c:if test="${m.is_owner==1}">
										<a title="商户列表" style="color: blue;" onclick="Hui_admin_tab(this)" href="javascript:;" data-title="商户列表" _href="shopController/findListByEmployee?shopkeeperId=${m.id}">${m.shopsnum}</a>
									</c:if>
								</c:otherwise>	
							</c:choose>
						</td>
						<td>${m.cardNum}</td>
						<td>
							<c:if test="${m.is_owner==1}">
								<a title="详情" href="javascript:;" onclick="showEditPage('详情','sellerManageController/getSellerInfo?id=${m.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe665;</i></a>
							</c:if>
							<c:if test="${m.is_owner==0}">	
								<a title="编辑" href="javascript:;" onclick="showEditPage('编辑','sellerManageController/preEdit?id=${m.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
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
		
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});

		$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
		
	});

	/*弹出窗口*/
	function showEditPage(title,url){
		var index = layer.open({
			type: 2,
			title: title,
			content: url
		});
		layer.full(index);
	}

</script> 
</body>
</html>