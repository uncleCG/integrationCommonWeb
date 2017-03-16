<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="Hui-aside">
	<input runat="server" id="divScrollValue" type="hidden" value="" />
	<div class="menu_dropdown bk_2" id="menu_tree_id">
		
		<c:forEach var="menu" items="${menuList}">
			<c:if test="${menu.type == 0}">
				<dl id="menu-${menu.id }">
					<dt><i class="Hui-iconfont">&#xe62e;</i>${menu.name }<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
					<dd>
						<ul>
							 <c:forEach var="menuChildren" items="${menu.children}">
						        <c:if test="${empty menuChildren.children}">
						        	<li><a _href="${menuChildren.link }" data-title="${menuChildren.name }" href="javascript:void(0)">${menuChildren.name }</a></li>
						        </c:if>
						        
						        <c:if test="${not empty menuChildren.children and menuChildren.type == 1}">
						        	<li><a _href="${menuChildren.link }" data-title="${menuChildren.name }" href="javascript:void(0)">${menuChildren.name }</a></li>
						        </c:if>
						        
						        <c:if test="${not empty menuChildren.children and menuChildren.type == 0}">
						        	
						        	<c:set var="menuTree" value="${menuChildren}" scope="request"/>
									<c:import url="common/_recursive.jsp"/>
										     
						        </c:if>
						        
						     </c:forEach>
						</ul>
					</dd>
				</dl>
			</c:if>
			<c:if test="${menu.type == 1}">
				<ul>
					<li><a _href="${menu.link }" data-title="${menu.name }" href="javascript:void(0)">${menu.name }</a></li>
				</ul>
			</c:if>
		</c:forEach>
		
	</div>
</aside>
<script>
$(document).ready(function() {
    
	$(".menu_dropdown dl dt").click(function(){
		alert(123);
	})	
	
});
</script>