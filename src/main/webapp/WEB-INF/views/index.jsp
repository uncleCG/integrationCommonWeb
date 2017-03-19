<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href } ">
		<!-- jsp文件头和头部 -->
		<%@ include file="common/_top.jsp"%> 
		<title>后台管理系统</title>
		<meta name="keywords" content="后台管理系统">
		<meta name="description" content="后台管理系统模版">
	</head>
<body>
<!-- 引用头部 -->
<%@ include file="common/_header.jsp" %>
<!-- 引用菜单 -->
 <aside class="Hui-aside">
	<input runat="server" id="divScrollValue" type="hidden" value="" />
	<div class="menu_dropdown bk_2" id="menu_tree_id">
		
	</div>
</aside>
<!--  -->
<div class="dislpayArrow"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>

<section class="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active"><span title="我的桌面" data-href="welcome.html">我的桌面</span><em></em></li>
			</ul>
		</div>
		<div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
	</div>
	<div id="iframe_box" class="Hui-article">
		<div class="show_iframe">
			<div style="display:none" class="loading"></div>
			<iframe scrolling="yes" frameborder="0" src="welcome.jsp"></iframe>
		</div>
	</div>
</section>
<!-- 引用底部JS -->
<%@ include file="common/_footer.jsp" %>

<script type="text/javascript">
//解决session过期点击菜单出错问题begin
$.ajaxSetup({  
    contentType:"application/x-www-form-urlencoded;charset=utf-8",  
    error:function(XMLHttpRequest,textStatus){  
        if(textStatus=="parsererror"){  
            window.location = "${ctx}/login.shtml";  
        }  
    }
});
//解决session过期点击菜单出错问题 end
var treeHtml = "";
function toIndex(id){
	showMask();
	$.ajax({
	      type : "POST",
	      async : false,
	      url : "${ctx}/getMenuList",
	      data : {
	    	  parentId : id
	      },
	      cache : false,
	      dataType : "json",
	      beforeSend : function() {
	           // Handle the beforeSend event
	      },
	      success : function(data, textStatus) {
	    	  var keyList = eval(data);  
	    	  treeHtml = "";
	    	 
	    	  for(var i=0;i<keyList.length;i++){ 
	    		 if(keyList[i].type == 0 ){
	    			 var iocText = "&#xe636;";
		       		  if(keyList[i].classId != null && keyList[i].classId != ""){
		       			iocText = keyList[i].classId;
		       		  }
	    			 treeHtml += "<dl id='menu-"+keyList[i].id+"'>"; 
	    			 treeHtml += "	<dt><i class='Hui-iconfont'>"+iocText+"</i>"+keyList[i].name+"<i class='Hui-iconfont menu_dropdown-arrow'>&#xe6d5;</i></dt>"; 
	    			 treeHtml += "	<dd>"; 
	    			 treeHtml += "		<ul>"; 
	    			 var menuChildren = keyList[i].children
	    			 for(var j=0;j<menuChildren.length;j++){
						//alert(menuChildren);
	    				if(menuChildren[j].children == null){
							treeHtml += "	<li><a _href='"+menuChildren[j].link+"' data-title='"+menuChildren[j].name+"' href='javascript:void(0)'>"+menuChildren[j].name+"</a></li>"; 
						}else if(menuChildren[j].children != null && menuChildren[j].type == 1 ){
							treeHtml += "	<li><a _href='"+menuChildren[j].link+"' data-title='"+menuChildren[j].name+"' href='javascript:void(0)'>"+menuChildren[j].name+"</a></li>"; 
						}else if(menuChildren[j].children != null){
							getTree(menuChildren[j])
						}
	    			 }
	    			 treeHtml += "		</ul>"; 
	    			 treeHtml += "	</dd>"; 
	    			 treeHtml += "</dl>"; 
	    		 }else if(keyList[i].type == 1){
	    			 treeHtml += "<ul>"; 
	    			 treeHtml += "	<li><a _href='"+keyList[i].link+"' data-title='"+keyList[i].name+"' href='javascript:void(0)'>"+keyList[i].name+"</a></li>"; 
	    			 treeHtml += "</ul>"; 
	    		 }
	    	  } 
	    	  
	         $("#menu_tree_id").html(treeHtml);
	         
	         $('.menu_dropdown dl dt').click(function(event){
	     		$(this).toggleClass("selected");
	        	 if($(this).next().css('display')=='none'){
	     			$(this).next().css('display','block');
	     		}else{
	     			$(this).next().css('display','none');
	     		}
	     		$(this).parent().siblings().find('dd').css('display','none');
	     		event.preventDefault();
	     	})
	     	hideMask();
	      },
	   /*    error : function() {
	    	 hideMask();
			layer.alert("请求发送失败，请稍后重试",{icon: 5});
	      }, */
	      complete : function() {
	    	hideMask();
	      }
	 });
}

function getTree(menuTree){
	var iocText = "&#xe636;";
	if(menuTree.classId != null && menuTree.classId != ""){
		iocText = menuTree.classId;
	}
	treeHtml += "<dl id='menu-"+menuTree.id+"'>"; 
	treeHtml += "	<dt><i class='Hui-iconfont'>"+iocText+"</i>"+menuTree.name+"<i class='Hui-iconfont menu_dropdown-arrow'>&#xe6d5;</i></dt>"; 
	treeHtml += "	<dd>"; 
	treeHtml += "		<ul>"; 
	var menuChildren = menuTree.children
	for(var j=0;j<menuChildren.length;j++){
		if(menuChildren[j].type == 1){
			treeHtml += "	<li><a _href='"+menuChildren[j].link+"' data-title='"+menuChildren[j].name+"' href='javascript:void(0)'>"+menuChildren[j].name+"</a></li>"; 
		}else if(menuChildren[j].children != null && menuChildren[j].type == 0){
			treeHtml += "		<li>"; 
			getTree(menuChildren[j]);
			treeHtml += "		</li>"; 
		}
	}
	treeHtml += "		</ul>"; 
	treeHtml += "	</dd>"; 
	treeHtml += "</dl>"; 
}
</script> 

<script>
$(document).ready(function() {
    $(".nav a").click(function(){
		$(this).addClass("active")
		.parent().siblings().children("a").removeClass("active");
	})
	//取值来自_header.jsp
	var menuIndex = $("#menuIndex").val();
	toIndex(menuIndex);
});
</script>
</body>
</html>