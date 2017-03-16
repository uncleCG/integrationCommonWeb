<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-assign-permission">
		<div id="tab-system" class="HuiTab">
			<div class="zTreeDemoBackground left">
				<ul id="treeDemo" class="ztree"></ul>
			</div>	
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<button onClick="submitForm();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
				<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</div>

<%@ include file="../../common/_footer.jsp" %>


<script type="text/javascript">
	var setting = {
		view: {
			dblClickExpand: false,
			showLine: false,
			selectedMulti: false
		},
		data: {
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: ""
			}
		},
		check: {
			enable: true
		},
		callback: {
			beforeClick: function(treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				zTree.checkNode(treeNode, null, true, false);//控制复选框
				if (treeNode.isParent) {
					zTree.expandNode(treeNode);
					return false;
				} else {
					//demoIframe.attr("src",treeNode.file + ".html");
					return true;
				}
			}
		}
	};
	
	var zNodes =[];
 	var ddd = null;
	<c:forEach var="right" items="${rightList}">
		var checkFlag = false;
		var openFlag = false;
		<c:forEach var="roleRight" items="${roleRightList}">
			if(${roleRight.rightId==right.id}){
				checkFlag = true;
				openFlag = true;
			}
		</c:forEach>
		ddd = {id:${right.id}, pId:${right.parentId}, name:"${right.name}",type:${right.type}, checked:checkFlag, open:openFlag};
		zNodes.push(ddd);
	</c:forEach>
			
	var code;
			
	function showCode(str) {
		if (!code) code = $("#code");
		code.empty();
		code.append("<li>"+str+"</li>");
	}
			
	$(document).ready(function(){
		var t = $("#treeDemo");
		t = $.fn.zTree.init(t, setting, zNodes);
	});
</script>

<script type="text/javascript">
	$(function(){
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});
		$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	});
	
	function submitForm(){
		var rightIds = new Array(); //定义数组，记录选中的id
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		var checkedNodes = zTree.getCheckedNodes(true);
		$.each(checkedNodes,function(i,checkNode){
			if(checkNode.parentId != 0){//去除根目录
				rightIds.push(checkNode.id);
			}
		});
		$.ajax({
		      type : "POST",
		      async : true,
		      url : "${ctx}/roleController/assignPermission",
		      data : {
		    	  roleId:"${roleId}",
		    	  rightIds:rightIds.toString()
		      },
		      cache : false,
		      dataType : "json",
		      beforeSend : function() {
		           // Handle the beforeSend event
		      },
		      success : function(data, textStatus) {
		          if (data.status==1) {// 处理成功
		        	  layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
		        	  });
		          } else {// 处理失败
		        	  layer.msg(data.message,{icon: 5,time:2000});
		          }
		      },
		      error : function() {
				layer.alert("请求发送失败，请稍后重试",{icon: 5});
		      },
		      complete : function() {
		    	  rightIds = new Array();//清空数组
		      }
		 });
	}
</script>
</body>
</html>
