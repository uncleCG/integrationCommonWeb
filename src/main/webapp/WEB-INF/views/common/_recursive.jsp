<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<dl id="menu-${menuTree.id }">
	<dt><i class="Hui-iconfont">&#xe62e;</i>${menuTree.name }<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
	<dd>
		<ul>
			  <c:forEach var="menuChildren" items="${menuTree.children}">
		        
		        <c:if test="${menuChildren.type == 1}">
		        	<li><a _href="${menuChildren.link }" data-title="${menuChildren.name }" href="javascript:void(0)">${menuChildren.name }</a></li>
		        </c:if>
		        
		        <c:if test="${menuChildren.type == 0}">
			        <c:if test="${not empty menuChildren.children}">
						     <li>
							     <c:set var="menuTree" value="${menuChildren}" scope="request"/>
							     <c:import url="common/_recursive.jsp"/>
						     </li>
			        </c:if>
		        </c:if>
		     </c:forEach>
		</ul>
	</dd>
</dl>
