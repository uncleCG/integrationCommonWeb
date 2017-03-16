<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link href="${ctx}/statics/css/page.css" rel="stylesheet" type="text/css" />
<form action="#" name="pagesucks" method="POST" style="display:none;">
	<div id="page-parameter">
		<c:forEach var="parameter" items="${param}">
			<c:if test="${parameter.key != 'showCount' and parameter.key != 'currentPage'}">
				<input type="hidden" id="${parameter.key}" name="${parameter.key}" value="${parameter.value}" />
			</c:if>
		</c:forEach>
	</div>
	<input type="hidden" id="showCount" name="showCount" value="${page.showCount}" />
	<input type="hidden" id="currentPage" name="currentPage" value="${page.currentPage}" />
	<input type="submit" id="sub_page" style="display:none">
</form>

<form action="#" name="export_xls_sucks" method="POST" style="display:none;">
	<div id="export-xls-parameter">
	</div>
	<input type="hidden" id="fileName" name="fileName"/>
	<input type="submit" id="sub_export_xls" style="display:none">
</form>

<div style="text-align: center;">
	<div class="pageTab">
		<div>
			<div>
				共<label id="totalPage">${page.totalResult }</label>条
			</div>
			<div>
				<input type="hidden" value="${page.currentPage }" id="toGoPage"  placeholder="页码" />
				<!-- 
				<a onclick="toTZ();" >跳转</a>
				 -->
			</div>
			
			<div>
				<c:if test="${page.currentPage > 1}">
					<a onclick="nextPage(1)">首页</a>
					<a onclick="nextPage(${page.currentPage-1 })">上页</a>
				</c:if>
			</div>
			<div align="center" width="30%">
            	<c:set var="begin" value="${page.currentPage - 4}" />
            	<c:if test="${begin < 1}"><c:set var="begin" value="1" /></c:if>
            	
            	<c:set var="end" value="${page.currentPage + 4}" />
            	<c:if test="${end > page.totalPage}"><c:set var="end" value="${page.totalPage}" /></c:if>
            	<c:if test="${begin > 1}">...</c:if>
            	<c:forEach var="pageIndex" begin="${begin}" end="${end}">
            		<c:choose>
            			<c:when test="${pageIndex == page.currentPage}"><span style="color: red;">${pageIndex}</span></c:when>
            			<c:otherwise><a onclick="nextPage(${pageIndex})">${pageIndex}</a></c:otherwise>
            		</c:choose>
            	</c:forEach>
            	<c:if test="${end < page.totalPage}">...</c:if>
			</div>
			<div>
				<c:if test="${page.currentPage != page.totalPage }">
					<a onclick="nextPage(${page.currentPage+1 })">下页</a>
					<a onclick="nextPage(${page.totalPage})" style="margin-right:10px;">尾页</a>
				</c:if>
				
				第${page.currentPage }页
				共${page.totalPage }页
			</div>
			<div class="changeCount">
				显示条数
				<select title='显示条数'  onchange="changeCount(this.value)">
					<option value='${page.showCount }'>${page.showCount }</option>
					<option value='10'>10</option>
					<option value='20'>20</option>
					<option value='30'>30</option>
					<option value='40'>40</option>
					<option value='50'>50</option>
					<option value='60'>60</option>
					<option value='70'>70</option>
					<option value='80'>80</option>
					<option value='90'>90</option>
					<option value='100'>100</option>
				</select>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function nextPage(page) {
		showMask();
		document.pagesucks.action = window.location.pathname;
		document.getElementById("currentPage").value = (page-1);
		document.getElementById('sub_page').click();
	}
	function changeCount(value) {
		document.getElementById("showCount").value = value;
		var page = document.getElementById("currentPage").value;
		nextPage(page)
	}
	function toTZ() {
		var toPaggeVlue = document.getElementById("toGoPage").value;
		if (toPaggeVlue == '') {
			document.getElementById("toGoPage").value = 1;
			return;
		}
		if (isNaN(Number(toPaggeVlue))) {
			document.getElementById("toGoPage").value = 1;
			return;
		}
		nextPage(toPaggeVlue);
	}
	function to_page_sub(paramDivId){
		if($("#" + paramDivId).length>0){
			var html = "";
			$("#" + paramDivId + " input").each(function() {
		  		var paramName = $(this).attr("name");
		  		var paramVal = $(this).val();
		  		var paramtype = $(this).attr("type");
		  		if(paramVal != "" ){
		  			if(paramtype == 'radio'){
		  				if($(this).is(":checked")){
					  		html = html + "<input type='hidden' id='"+paramName+"' name='"+paramName+"' value='"+paramVal+"' />";
						}
		  			}else  if(paramtype == 'checkbox' ){
		  				if($(this).is(":checked")){
		  					if(paramVal == 'on'){
			  					paramVal = "1";
		  					}
		  					html = html + "<input type='hidden' id='"+paramName+"' name='"+paramName+"' value='"+paramVal+"' />";
		  				}
		  			}else{
		  				html = html + "<input type='hidden' id='"+paramName+"' name='"+paramName+"' value='"+paramVal+"' />";
		  			}
		  		}
		 	});
			$("#" + paramDivId + " select").each(function() {
				var paramName = $(this).attr("name");
		  		var paramVal = "";
		  		if($(this).attr("multiple") != undefined){
		  			paramVal = $(this).multiselect("MyValues");
		  			paramVal = myTrim(paramVal); //必须去掉中间的空格
		  		}else{
		  			paramVal = $(this).val();
		  		}
		  		if(paramVal != ""){
		  			html = html + "<input type='hidden' id='"+paramName+"' name='"+paramName+"' value='"+paramVal+"' />";
		  		}
		 	});
			$("#page-parameter").html(html);
			nextPage(1)
		}else{
			layer.msg("没有检索到ID为"+paramDivId+"的节点信息！");
		} 
	}
	
   function myTrim(str) {
          var result;
          result = str.replace(/(^\s+)|(\s+$)/g,"");
          result = result.replace(/\s/g,"");
          return result;
	}
	
	function to_export_xls_sub(paramDivId,url,fileName){
		if($("#" + paramDivId).length>0){
			var html = "";
			$("#" + paramDivId + " input").each(function() {
		  		var paramName = $(this).attr("name");
		  		var paramVal = $(this).val();
		  		var paramtype = $(this).attr("type");
		  		if(paramVal != "" ){
		  			if(paramtype == 'radio'){
		  				if($(this).is(":checked")){
					  		html = html + "<input type='hidden' id='"+paramName+"' name='"+paramName+"' value='"+paramVal+"' />";
						}
		  			}else  if(paramtype == 'checkbox' ){
		  				if($(this).is(":checked")){
		  					if(paramVal == 'on'){
			  					paramVal = "1";
		  					}
		  					html = html + "<input type='hidden' id='"+paramName+"' name='"+paramName+"' value='"+paramVal+"' />";
		  				}
		  			}else{
		  				html = html + "<input type='hidden' id='"+paramName+"' name='"+paramName+"' value='"+paramVal+"' />";
		  			}
		  		}
		 	});
			$("#" + paramDivId + " select").each(function() {
				var paramName = $(this).attr("name");
				var paramVal = "";
		  		if($(this).attr("multiple") != undefined){
		  			paramVal = $(this).multiselect("MyValues");
		  			paramVal = myTrim(paramVal); //必须去掉中间的空格
		  		}else{
		  			paramVal = $(this).val();
		  		}
		  		if(paramVal != "" ){
		  			html = html + "<input type='hidden' id='"+paramName+"' name='"+paramName+"' value='"+paramVal+"' />";
		  		}
		 	});
			$("#export-xls-parameter").html(html);
			$("#fileName").val(fileName);
			
			 
			
			document.export_xls_sucks.action = url;
			document.getElementById('sub_export_xls').click();
			
		}else{
			layer.msg("没有检索到ID为"+paramDivId+"的节点信息！");
		} 
	}
</script>