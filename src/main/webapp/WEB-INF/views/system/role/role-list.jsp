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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 权限管理 <span class="c-gray en">&gt;</span> 角色管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	<shiro:hasPermission name="superman:role:add">
		<div class="cl pd-5 bg-1 bk-gray mt-3">
			<span class="r">
				<a class="btn btn-primary radius" data-title="添加角色" onclick="showEditPage('添加角色','roleController/preEdit','','270')" href="javascript:void(0);"><i class="Hui-iconfont">&#xe600;</i> 添加角色</a>
			</span>
		</div>
	</shiro:hasPermission>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="80">ID</th>
					<th width="80">角色名称</th>
					<th width="120">操作</th>
				</tr>
			</thead>
			<tbody id="tBodyId">
				<c:forEach var="m" items="${list}" varStatus="indexId">
					<tr class="text-c" id="tr${m.id}">
						<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td>${m.name }</td>
						<td class="f-14 td-manage">
							<shiro:hasPermission name="superman:role:update">
								<a style="text-decoration:none" class="ml-5" onclick="showEditPage('编辑角色','roleController/preEdit?roleId=${m.id}','','270')" href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
							</shiro:hasPermission>
							<shiro:hasPermission name="superman:role:del">
								<a style="text-decoration:none" class="ml-5" onclick="role_del(this,'${m.name}','${m.id}')" href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
							</shiro:hasPermission>
							<shiro:hasPermission name="superman:role:authorize">
								<a style="text-decoration:none" class="ml-5" onclick="showEditPage('分配权限','roleController/preAssignPermission?roleId=${m.id}','','560')" href="javascript:;" title="分配权限"><i class="Hui-iconfont">&#xe61d;</i></a>
							</shiro:hasPermission>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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
	
	function role_del(obj,roleName,roleId){
		layer.confirm("确定要删除名称为："+roleName+" 的角色吗？", {
		    btn: ["确定","取消"] //按钮
		}, function(){
			$.ajax({
			      type : "POST",
			      async : true,
			      url : "${ctx}/roleController/delById",
			      data : {
			    	  "roleId":roleId
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
			          } else if(data.status == -1){
			        	  //存在关联账户，不允许删除
			        	  layer.alert(data.message,{icon: 5});
			          }else {// 处理失败
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
		});
	}
	/*新增角色成功后，添加tr*/
	function addTr(roleId,roleName,roleDesc){
		var trNum = $("#tBodyId").children().length;
		var trHtml = "<tr class='text-c' id='tr"+roleId+"'><td>"+(trNum+1)+"</td><td>"+roleName+"</td><td class='f-14 td-manage'>";
		trHtml = trHtml + "<a style='text-decoration:none' class='ml-5' onclick=\"showEditPage(\'编辑角色\',\'roleController/preEdit?roleId="+roleId+"\',\'\',\'270\')\" href='javascript:;' title='编辑'><i class='Hui-iconfont'>&#xe6df;</i></a>";
		trHtml = trHtml + "<a style='text-decoration:none' class='ml-5' onclick=\"role_del(this,\'"+roleName+"\',\'"+roleId+"\')\" href='javascript:;' title='删除'><i class='Hui-iconfont'>&#xe6e2;</i></a>";
		trHtml = trHtml + "<a style='text-decoration:none' class='ml-5' onClick=\"article_edit(\'分配权限\',\'page/system/role/assignPre.jsp\',\'10001\')\" href='javascript:;' title='分配权限'><i class='Hui-iconfont'>&#xe61d;</i></a>";
		trHtml = trHtml +"</td>";
		$("#tBodyId").append(trHtml);
	}
	/*修改角色成功后，修改tr*/
	function updateTr(roleId,roleName){
		var trChildren = $("#tr"+roleId).children();
		trChildren.eq(1).html(roleName);
	}
</script> 
</body>
</html>