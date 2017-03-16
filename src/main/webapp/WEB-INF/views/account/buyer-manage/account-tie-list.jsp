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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户系统 <span class="c-gray en">&gt;</span> 买家管理 <span class="c-gray en">&gt;</span> 绑卡买家管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" onclick="to_page_sub('page-data-param')" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
		<div class="l"> 
			手机号：
 			<input type="text" name="mobile" id="mobile" placeholder="支持模糊搜索" value="${page.pd.mobile}" style="width:150px" class="input-text" />
 		</div>
		<span class="l pd-10"> 
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span> 
		<a class="btn btn-primary radius r mt-10" data-title="绑卡买家管理" onclick="to_export_xls_sub('page-data-param','accountController/exportTieBuyerList?showCount=${page.showCount*page.totalPage}','绑卡买家列表')" href="javascript:void(0);">
			&nbsp;导&nbsp;&nbsp;&nbsp;出&nbsp;
		</a>
	</div>
	<div class="mt-10">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="">ID</th>
					<th width="">手机号</th>
					<th width="">个人首单充值时间</th>
					<th width="">首次绑卡时间</th>
					<th width="">充值总金额</th>
					<th width="">消费总金额</th>
					<th width="">总余额</th>
					<th width="">会员卡</th>
					<th width="">创建时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${list}" varStatus="indexId">
					<tr class="text-c">
						<td>${m.id}</td>
						<td>${m.mobile}</td>
						<td>
							<fmt:formatDate value="${m.firstRechargeAt}" type="both"/>
						</td>
						<td>
							<fmt:formatDate value="${m.firstTieAt}" type="both"/>
						</td>
						<td>${m.recharge}</td>
						<td>${m.consume}</td>
						<td>${m.balance}</td>
						<td>
							<a title="我的会员卡" href="javascript:;" onclick="showEditPage('我的会员卡','${ctx}/accountController/getMyCardListPage?accountId=${m.id}&accountMobile=${m.mobile}');" class="ml-5" style="text-decoration:none;color: blue;">
								${m.cardNum}
							</a>
						</td>
						<td>
							<fmt:formatDate value="${m.createdAt}" type="both"/>
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
	});
	
	/*弹出添加、修改窗口*/
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