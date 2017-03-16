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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 权限管理 <span class="c-gray en">&gt;</span> 管理员管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:void(0);" onclick="to_page_sub('page-data-param')"
 title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	<div class="cl pd-10 bg-1 bk-gray mt-3" id="page-data-param"> 
		<div class="l" style="width:350px;">
			<!-- 
			所属港口：
			<select name="portId" style="max-width: 200px;" class="input-text">
				<option value="0">全部</option>
				<c:forEach items="${portList}" var="port">
					<option value="${port.id}" <c:if test="${page.pd.portId == port.id}">selected="selected"</c:if>>${port.name}</option>
				</c:forEach>
			</select>
			 -->
			用户名：<input type="text" name="nickname" id="nickname" placeholder="用户名" value="${pageData.nickname }" style="width:250px" class="input-text">
		</div>
		<span class="l"> 
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span>
		<shiro:hasPermission name="superman:manager:add">
			<span class="r"> 
				<a class="btn btn-primary radius" data-title="添加管理员" onclick="showEditPage('添加管理员','managerController/preEdit','','650')" href="javascript:void(0);">
					<i class="Hui-iconfont">&#xe600;</i> 添加管理员
				</a>
			</span>
		</shiro:hasPermission>
	</div>
	<div class="mt-10">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="">管理员名称</th>
					<th width="">帐号</th>
					<th width="">角色</th>
					<th width="120">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${list}" varStatus="indexId">
					<tr class="text-c">
						<td>${m.name }</td>
						<td>${m.nickname}</td>
						<td>
							<c:forEach items="${m.roleList}" var="role" varStatus="indexId">
								<c:if test="${indexId.index != 0}">,</c:if>
								${role.name}
							</c:forEach>
						</td>
						<td class="f-14 td-manage">
							<shiro:hasPermission name="superman:manager:update">
								<c:if test="${'admin'!=m.nickname}" >
									<a title="编辑" onclick="showEditPage('编辑管理员','managerController/preEdit?userId=${m.id}','','650')" href="javascript:void(0);" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
								</c:if>
							</shiro:hasPermission>
							<shiro:hasPermission name="superman:manager:del">
								<c:if test="${userSession.nickname!=m.nickname}">
									<a style="text-decoration:none" class="ml-5" onclick="manager_del(this,'${m.nickname}','${m.id}')" href="javascript:;" title="删除"> <i class="Hui-iconfont">&#xe6e2;</i></a>
								</c:if>
							</shiro:hasPermission>
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
			"bSort": false, //排序功能
			"bInfo": false,//页脚信息
			"bAutoWidth": true//自动宽度
		});
	});
	
	var daqArray = new Array();//存放已选择 DaqUser Id
	
	//用户-添加
	function manager_add(title,url,w,h){
		var index = layer.open({
			type: 2,
			title: title,
			content: url
		});
		layer.full(index);
	}
	/*用户-编辑*/
	function manager_edit(title,url,id,w,h){
		parent.layer_show(title,url,w,h);
	}
	//资讯-删除
	function manager_del(obj,id){
		layer.confirm("确认要删除吗？",function(index){
			$(obj).parents("tr").remove();
			layer.msg("已删除!",{icon: 1,time:2000});
		});
	}
	
	/*
	弹出添加、修改窗口
	*/
	function showEditPage(title,url,w,h){
		layer_show(title,url,w,h);
	}
	
	function manager_del(obj,nickname,userId){
		layer.confirm("确定要删除名称为："+nickname+" 的用户吗？", {
		    btn: ["确定","取消"] //按钮
		}, function(){
			$.ajax({
			      type : "POST",
			      async : true,
			      url : "${ctx}/managerController/delById",
			      data : {
			    	  "userId":userId
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
		});
	}
</script> 
</body>
</html>