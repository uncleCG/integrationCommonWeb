<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
	String path = "";
	String base_path = "";
	final String serverName = request.getServerName();
	path = "http://" + serverName +":"+request.getServerPort() + request.getContextPath() ;
	base_path = path + "/";
%>
<c:set var="path" value="<%=path%>" />
<c:set var="ctx" value="<%=path%>" />
<c:set var="base_href" value="<%=base_path%>" />
<c:set var="ImgPath" value="http://127.0.0.1:8082/kcqb"/>
 
 