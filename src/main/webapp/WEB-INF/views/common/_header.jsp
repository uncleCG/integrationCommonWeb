<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header class="Hui-header cl"> 
	<a class="Hui-logo l" title="管理系统" href="">后台管理系统</a> <a class="Hui-logo-m l" href="" title="QT.admin">QT</a> <span class="Hui-subtitle l">V1.0</span>
    <!--我要添加子菜单：开始-->
    <nav class="main_cld_nav cl nav" id="Hui-nav">
    	<ul>
        	<li class="current">Menu</li>
        	
        	<c:forEach var="menu" items="${menuList}"  varStatus="indexId">
        		<c:if test="${indexId.index == 0}">
        			<li>
	        			<a href="javascript:;" class='active' onclick="toIndex(${menu.id})">
	        				<i class="Hui-iconfont">&#xe625;</i>
	        				${menu.name}
	        			</a>
        			</li>
        			<input type="hidden" name="menuIndex" id="menuIndex" value="${menu.id}">
        		</c:if>
        		<c:if test="${indexId.index != 0}">
        			<li>
	        			<a href="javascript:;"  onclick="toIndex(${menu.id})">
	        				<i class="Hui-iconfont">&#xe625;</i>
	        				${menu.name}
	        			</a>
        			</li>
        		</c:if>
        	</c:forEach>
        </ul>
    </nav>
    <form action="" method="post" id="toIndex">
    	<input type="hidden" name="parentId" id="parentId" value="0"/>
    	<input type="submit" id="sub_index" style="display:none">
    </form>
    <!--我要添加子菜单：结束-->
    
	<ul class="Hui-userbar">
		<li>
			<c:forEach items="${manager.roleList}" var="role" varStatus="indexId">
				<c:if test="${indexId.index != 0}">,</c:if>
				${role.name}				
			</c:forEach>
		</li>
		<li class="dropDown dropDown_hover"><a href="#" class="dropDown_A">${manager.nickname} <i class="Hui-iconfont">&#xe6d5;</i></a>
			<ul class="dropDown-menu radius box-shadow">
				<li><a onclick="showEditPage('修改密码','managerController/preEditPwd?userId=${manager.id}','','650')" href="javascript:void(0);">修改密码</a></li>
				<li><a href="#">切换账户</a></li>
				<li><a href="logout">退出</a></li>
			</ul>
		</li>
		<!-- <li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li> -->
		<li id="Hui-skin" class="dropDown right dropDown_hover"><a href="javascript:;" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
			<ul class="dropDown-menu radius box-shadow">
				<li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
				<!-- 
				<li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
				<li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
				<li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
				<li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
				<li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
				-->
			</ul>
		</li>
	</ul>
	<a href="javascript:;" class="Hui-nav-toggle Hui-iconfont" aria-hidden="false">&#xe667;</a> 
</header>
<script>
function showEditPage(title,url,w,h){
	layer_show(title,url,w,h);
}
</script>