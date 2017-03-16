<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>

<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>

<body>
<div class="pd-20">
	<form action="" method="post" class="form form-horizontal" id="form-save">
		<div id="tab-system" class="HuiTab">
			<div class="row cl mt-10">
				<label class="form-label col-2">会员卡编号：</label>
				<div>
					<input type="text" name="batch_start" id="batch_start" placeholder="起始编号" style="width:150px" class="input-text">
					~
					<input type="text" name="batch_end" id="batch_end" placeholder="结束编号" style="width:150px" class="input-text">
				</div>
			</div>
		</div>
		<div class="row cl mt-10 clear">
			<div class="col-10 col-offset-2">
				<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取&nbsp;&nbsp;&nbsp;消&nbsp;&nbsp;</button>
				<button onclick="submitForm();" class="btn btn-primary radius" type="button" id="saveBtn">&nbsp;&nbsp;提&nbsp;&nbsp;&nbsp;交&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</div>
<%@ include file="../../common/_footer.jsp" %>
<script type="text/javascript">
	$(function(){
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});
		$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	});
	
	function submitForm(){//提交表单
		var batchStartVal = $("#batch_start").val();
		var batchEndVal = $("#batch_end").val();
		//正整数
		var positiveNumReg = /^[1-9]\d{5}$/;
		if(!positiveNumReg.test(batchStartVal)){
			layer.alert("请输入正确的起始编号（非0开头的6位数字）");
			return false;
		}
		if(!positiveNumReg.test(batchEndVal)){
			layer.alert("请输入正确的结束编号（非0开头的6位数字）");
			return false;
		}
		if(batchEndVal < batchStartVal){
			layer.alert("结束编号不能小于开始编号");
			return false;
		}
		$("#saveBtn").prop("disabled",true);
		$.ajax({
			type:"POST",
			async:false,
			url : "${ctx}/cardController/save",
			data : $("#form-save").serialize(),
		    cache : false,
		    dataType : "json",
		    beforeSend : function() {
		    },
		    success : function(data, textStatus) {
				if(data.status == 1){//成功
					layer.msg("操作成功",{icon: 6,time:2000},function(){
						parent.location.reload();
                    });
				}else if(data.status == -1){
					$("#saveBtn").prop("disabled",false);
					layer.msg("操作失败，新增号段数据已存在！",{icon: 5});
				}else{//失败
					$("#saveBtn").prop("disabled",false);
					layer.msg("很遗憾，提交失败，请稍后重试",{icon: 5});
				}
		    },
		    error : function() {
				$("#saveBtn").prop("disabled",false);
				layer.alert("请求发送失败，请稍后重试",{icon: 5});
		   	},
		    complete : function() {

		    }
		});
	}
</script>
</body>
</html>
