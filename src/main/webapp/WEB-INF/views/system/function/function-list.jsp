<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
	});
</script>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
	<style type="text/css">
		.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
		.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
		.ztree li ul.level0 {padding:0; background:none;}
		.HuiTab{width:50%;border:1px solid #cecece;}
	</style>

<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 权限管理 <span class="c-gray en">&gt;</span> 功能管理<a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-article-add">
		<div id="tab-system" class="HuiTab">
			<div class="zTreeDemoBackground left">
				<ul id="treeDemo" class="ztree"></ul>
			</div>
		</div>
	</form>
</div>

<%@ include file="../../common/_footer.jsp" %>


<SCRIPT type="text/javascript">
		var setting = {
			view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},
			edit: {
				enable: true,
				editNameSelectAll: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeDrag: beforeDrag,
				beforeEditName: beforeEditName,
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onRemove: onRemove,
				onRename: onRename
			}
		};

		var zNodes =[
		];
		var ddd = null;
		<c:forEach var="right" items="${list}">
			<c:if test="${right.type == 0}">
				ddd = {id:${right.id}, pId:${right.parentId}, name:"${right.name}",type:${right.type}, open:true};
			</c:if>
			<c:if test="${right.type != 0}">
				ddd = {id:${right.id}, pId:${right.parentId}, name:"${right.name}",type:${right.type}};
			</c:if>
			zNodes.push(ddd);
		</c:forEach>
		
		var log, className = "dark";
		function beforeDrag(treeId, treeNodes) {
			return false;
		}
		
		//编辑弹出层
		function beforeEditName(treeId, treeNode) {
			/* 
			className = (className === "dark" ? "":"dark");
			showLog("[ "+getTime()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode);
			return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
			*/
			functionEdit(treeNode.name + "功能的编辑","rightController/getFuncInfoById?funcId="+treeNode.id,treeNode.id,"","560");
			return false;
		}
		
		/*
			弹出添加、修改窗口
		*/
		function functionEdit(title,url,id,w,h){
			layer_show(title,url,w,h);
		}
		
		
		//删除弹出层
		function beforeRemove(treeId, treeNode) {
			/*//选中效果
			className = (className === "dark" ? "":"dark");
			showLog("[ "+getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode); 
			return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
			*/
			if(confirm("确认删除 " + treeNode.name + " 吗？")){
				$.ajax({
					type : "POST",
				    async : true,
				    url : "${ctx}/rightController/delById",
				    data : {"funcId":treeNode.id},
				    cache : false,
				    dataType : "json",
				    beforeSend : function() {
				           // Handle the beforeSend event
				    },
				    success : function(data, textStatus) {
				         if (data.status==1) {// 处理成功
				        	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				  			zTree.removeNode(treeNode, false);//删除节点
				        	layer.msg("操作成功",{icon: 6});
				         	return true; 
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
			}
			return false;
		}
		
		function onRemove(e, treeId, treeNode) {
			showLog("[ "+getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
		}

		var newCount = 1;
		//显示增加按钮
		function addHoverDom(treeId, treeNode) {
			var treeNodeType = treeNode.type;
			if(treeNodeType == 2){
				return;
			}
			//alert("增加")
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='新增' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				//var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				//zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, type:treeNodeType+1,name:"new node" + (newCount++)});
				functionEdit(treeNode.name + "功能的添加","rightController/getFuncInfoById?parentId="+treeNode.id+"&type="+(treeNodeType+1),treeNode.id,"","560");
				return false;
			});
		};
		
		//显示修改按钮
		function showRenameBtn(treeId, treeNode) {
			//return !treeNode.isLastNode;
			return true;
		}
		
		//修改事件
		function beforeRename(treeId, treeNode, newName, isCancel) {
			className = (className === "dark" ? "":"dark");
			showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
			if (newName.length == 0) {
				alert("节点名称不能为空.");
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				setTimeout(function(){zTree.editName(treeNode)}, 10);
				return false;
			}
			return true;
		}

		function onRename(e, treeId, treeNode, isCancel) {
			showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
		}
		
		//显示删除按钮
		function showRemoveBtn(treeId, treeNode) {
			//return !treeNode.isFirstNode;
			return true;
		}
		//删除事件
		function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
		};
		
		function showLog(str) {
			if (!log) log = $("#log");
			log.append("<li class='"+className+"'>"+str+"</li>");
			if(log.children("li").length > 8) {
				log.get(0).removeChild(log.children("li")[0]);
			}
		}
		
		function getTime() {
			var now= new Date(),
			h=now.getHours(),
			m=now.getMinutes(),
			s=now.getSeconds(),
			ms=now.getMilliseconds();
			return (h+":"+m+":"+s+ " " +ms);
		}

		
		function selectAll() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
		}
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			$("#selectAll").bind("click", selectAll);
		});
	</SCRIPT>

<script type="text/javascript">
	$(function(){
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});
		$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	});
</script>
</body>
</html>
