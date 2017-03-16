<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	function submitForm(){
		var remarkVal = $.trim($("#remark").val());
		var typeVal = $("#type").val();
		if(typeVal == 2 || typeVal == 4){//下架操作
			if(remarkVal == "" || remarkVal == undefined || remarkVal == null){
				layer.tips("请输入操作原因", "#remark", {
				    tips: [1, "#F00"],
				    time: 3000
				});
				return false;
			}
		}
		$.ajax({
		     type : "POST",
		     async : true,
		     url : "shopController/switchState",
		     data : $("#form-confrim-state").serialize(),
		     cache : false,
		     dataType : "json",
		     beforeSend : function() {
		          // Handle the beforeSend event
		     },
		     success : function(data, textStatus) {
		         if (data.status==1) {// 处理成功
		        	 layer.msg("操作成功",{icon: 6,time:2000},function(){
		        		 parent.location.reload();
			        	 layer_close();
		        	 });
		         } else {// 处理失败
		        	 layer.msg("操作失败",{icon: 5,time:2000},function(){});
		         }
		     },
		     error : function() {
		    	 layer.alert("请求发送失败，请稍后重试",{icon: 5});
		     },
		     complete : function() {

		     }
		});
	}
</script>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
	<style>
	.tabCon{display:block;}
	</style>
<body>
    <div class="pd-20">
		<form action="" id="form-confrim-state">
    	<div id="tab-system">
    		<div class="tabCon">
	    		<c:if test="${!empty operateLogPd}">
	    			<div class="row cl">
	    				<label class="form-label col-3">下架原因：</label>
	    				<div class="formControls col-9">
							${operateLogPd.remark}
						</div>
	    			</div>
	    			<div class="row cl">
	    				<label class="form-label col-3">操作人：</label>
	    				<div class="formControls col-9">
							${operateLogPd.username}
						</div>
	    			</div>
	    			<div class="row cl">
	    				<label class="form-label col-3">操作时间：</label>
	    				<div class="formControls col-9">
							<fmt:formatDate value="${operateLogPd.log_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</div>
	    			</div>
				</c:if>
    			<div class="row cl">
    				<label class="form-label col-3">
   					<c:if test="${params.type == '2' || params.type == '4'}">
    					<span class="c-red">*</span>
   					</c:if>
    				操作原因：</label>
    				<div class="formControls col-6">
						<textarea id="remark" name="remark" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" nullmsg="备注不能为空！" onKeyUp="textarealength(this,200)"></textarea>
						<p class="textarea-numberbar"><em class="textarea-length">0</em>/200</p>
					</div>
    			</div>
    		</div>
    	</div>
    	<div class="row cl mt-10 text-c">
			<input type="hidden" name="shopId" value="${params.shopId}">
			<input type="hidden" name="type" value="${params.type}" id="type">
			<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			<button onclick="submitForm();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
		</div>
	    </form>
    </div>
    <%@ include file="../../common/_footer.jsp" %>
</body>
</html>
