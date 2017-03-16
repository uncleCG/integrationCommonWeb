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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 信息系统 <span class="c-gray en">&gt;</span> 商户信息 <span class="c-gray en">&gt;</span><c:if test="${pageData.type==0}">服务类型管理</c:if><c:if test="${pageData.type==1}">品牌管理</c:if><c:if test="${pageData.type==2}">二级服务管理</c:if> <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	<div class="cl pd-5 bg-1 bk-gray mt-3">
		<span class="r"> 
			<c:if test="${pageData.type==0}"><!-- 一级类型 -->
				<a class="btn btn-primary radius" data-title="添加一级类型" onclick="showEditPage('添加一级类型','serviceTypeController/preEdit?type=0','','450')" href="javascript:void(0);"><i class="Hui-iconfont">&#xe600;</i> 添加一级类型</a>
			</c:if>
			<c:if test="${pageData.type==2}"><!-- 二级类型 -->
				<a class="btn btn-primary radius" data-title="添加二级类型" onclick="showEditPage('添加二级类型','serviceTypeController/preEdit?type=2&parentId=${pageData.parentId}','','450')" href="javascript:void(0);"><i class="Hui-iconfont">&#xe600;</i> 添加二级类型</a>
			</c:if>
			<c:if test="${pageData.type==1}"><!-- 品牌 -->
				<a class="btn btn-primary radius" data-title="添加品牌" onclick="showEditPage('添加品牌','serviceTypeController/preEdit?type=1','','450')" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加品牌</a>
			</c:if>
		</span>
	</div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="80"></th>
					<c:if test="${pageData.type==0}">
						<th width="120">一级类型</th>
						<th width="80">APP端显示</th>
						<th width="80">二级类型</th>
						<th width="80">商户数量</th>
						<!-- 
						<th width="80">签约商户</th>
						<th width="80">普通商户</th>
						 -->
					</c:if>
					<c:if test="${pageData.type==2}">
						<th width="120">二级类型</th>
						<th width="80">APP端显示</th>
						<th width="80">商户数量</th>
						<!-- 
						<th width="80">签约商户</th>
						<th width="80">普通商户</th>
						 -->
					</c:if>
					<c:if test="${pageData.type==1}"><!-- 品牌 -->
						<th width="80">品牌缩写</th>
						<th width="120">品牌全称</th>
						<th width="80">商户数量</th>
					</c:if>
					<th width="120">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${pdList}" varStatus="indexId">
					<tr class="text-c" id="tr${m.id}">
						<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<c:if test="${pageData.type==0}"><!-- 一级服务 -->
							<td width="120">${m.name}</td>
							<td width="80">
								<c:if test="${m.state==1}">显示</c:if>
								<c:if test="${m.state!=1}">屏蔽</c:if>
							</td>
							<td width="80">${m.secServiceTypeNum}</td>
							<td width="80">${m.signShopNum+m.commonShopNum}</td>
							<!-- 
							<td width="80">${m.signShopNum}</td>
							<td width="80">${m.commonShopNum}</td>
							 -->
							<td>
								<a style="text-decoration:none" class="ml-5" onclick="showEditPage('修改','serviceTypeController/preEdit?id=${m.id}&type=${m.type}','','450')" href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
								<a style="text-decoration:none" class="ml-5" onclick="data_del(this,'${m.name}','${m.id}',${m.type},${m.secServiceTypeNum})" href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
								<a style="text-decoration:none" class="ml-5" onclick="Hui_admin_tab(this)" href="javascript:;" data-title="二级服务管理" _href="serviceTypeController/getDataList?type=2&parentId=${m.id}"><i class="Hui-iconfont">&#xe61d;</i></a>
								<c:if test="${m.state!=1}">
									<a style="text-decoration:none" class="ml-5" href="javascript:;" title="显示" onclick="switchState('${m.name}',${m.id},1,1);">显示</a>
								</c:if>
								<c:if test="${m.state==1}">
									<a style="text-decoration:none" class="ml-5" href="javascript:;" title="屏蔽" onclick="switchState('${m.name}',${m.id},0,1);">屏蔽</a>
								</c:if>
							</td>
						</c:if>
						<c:if test="${pageData.type==2}"><!-- 二级服务 -->
							<td width="120">${m.name}</td>
							<td width="80">
								<c:if test="${m.state==1}">显示</c:if>
								<c:if test="${m.state!=1}">屏蔽</c:if>
							</td>
							<td width="80">${m.signShopNum+m.commonShopNum}</td>
							<!-- 
							<td width="80">${m.signShopNum}</td>
							<td width="80">${m.commonShopNum}</td>
							 -->
							<td>
								<a style="text-decoration:none" class="ml-5" onclick="showEditPage('修改','serviceTypeController/preEdit?id=${m.id}&type=${m.type}','','450')" href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
								<a style="text-decoration:none" class="ml-5" onclick="data_del(this,'${m.name}','${m.id}',${m.type},${m.signShopNum+m.commonShopNum})" href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
								<c:if test="${m.state!=1}">
									<a style="text-decoration:none" class="ml-5" href="javascript:;" title="显示" onclick="switchState('${m.name}',${m.id},1,2);">显示</a>
								</c:if>
								<c:if test="${m.state==1}">
									<a style="text-decoration:none" class="ml-5" href="javascript:;" title="屏蔽" onclick="switchState('${m.name}',${m.id},0,2);">屏蔽</a>
								</c:if>
							</td>
						</c:if>
						<c:if test="${pageData.type==1}"><!-- 品牌 -->
							<td width="80">${m.name}</td>
							<td width="120">${m.full_name}</td>
							<td width="80">${m.signShopNum+m.commonShopNum}</td>
							<td width="80">
								<a style="text-decoration:none" class="ml-5" data-title="编辑品牌" onclick="showEditPage('编辑品牌','serviceTypeController/preEdit?type=1&id=${m.id}','','470')" href="javascript:;" ><i class="Hui-iconfont">&#xe6df;</i></a>
							</td>
						</c:if>
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

	/*
	弹出添加、修改窗口
	*/
	function showEditPage(title,url,w,h){
		layer_show(title,url,w,h);
	}
	
	function data_del(obj,name,id,type,num){
		if(num > 0){
			switch (type) {
			case 0://一级服务
				layer.alert("对不起，请先删除所有和该类型关联的二级服务，再执行此操作",{icon: 5});
				break;
			case 1://品牌
				layer.alert("对不起，请先删除所有和该品牌关联的商户，再执行此操作",{icon: 5});
				break;
			case 2://二级服务
				layer.alert("对不起，请先删除所有和该类型关联的商户，再执行此操作",{icon: 5});
				break;
			default:
				break;
			}
			return false;
		}
		layer.confirm("确定要删除名称为："+name+" 的记录吗？", {
		    btn: ["确定","取消"] //按钮
		}, function(){
			$.ajax({
			      type : "POST",
			      async : true,
			      url : "${ctx}/serviceTypeController/delById",
			      data : {
			    	  "id":id,
			    	  "type":type
			      },
			      cache : false,
			      dataType : "json",
			      beforeSend : function() {
			           // Handle the beforeSend event
			      },
			      success : function(data, textStatus) {
			          if (data.status==1) {// 处理成功
			        	  layer.msg("操作成功",{icon: 6,time:2000});
			        	  $(obj).parents("tr").remove();
			          } else {// 处理失败
			        	  layer.msg("操作失败",{icon: 5});
			          }
			      },
			      error : function() {
					layer.alert("请求发送失败，请稍后重试",{icon: 5});
			      },
			      complete : function() {

			      }
			 });
		}, function(){
			//取消操作回调函数
		});
	}
	
	/**
	 * name：服务类型名称；
	 * id：服务类型id
	 * state：目的状态；0、屏蔽；1、显示；
	 * type：服务类型级别：1、一级；2、二级；
	*/
	function switchState(name,id,state,type){
		var confirmStr = "";
		if(state == 1){
			confirmStr = "确定要显示名称为：" + name + " 的服务吗？";
		}
		if(state == 0){
			confirmStr = "确定要屏蔽名称为：" + name + " 的服务吗？";
		}
		layer.confirm(confirmStr, {
		    btn: ["确定","取消"] //按钮
		}, function(){
			$.ajax({
			      type : "POST",
			      async : true,
			      url : "${ctx}/serviceTypeController/updateServiceTypeBase",
			      data : {
			    	  "id":id,
			    	  "state":state,
			    	  "type":type
			      },
			      cache : false,
			      dataType : "json",
			      beforeSend : function() {
			           // Handle the beforeSend event
			      },
			      success : function(data, textStatus) {
			          if (data.status==1) {// 处理成功
			        	  layer.msg("操作成功",{icon: 6,time:2000},function(){
				        	  location.reload();
			        	  });
			          } else {// 处理失败
			        	  layer.msg("操作失败",{icon: 5});
			          }
			      },
			      error : function() {
					layer.alert("请求发送失败，请稍后重试",{icon: 5});
			      },
			      complete : function() {

			      }
			 });
		}, function(){
			//取消操作回调函数
		});
	}
	
</script> 
</body>
</html>