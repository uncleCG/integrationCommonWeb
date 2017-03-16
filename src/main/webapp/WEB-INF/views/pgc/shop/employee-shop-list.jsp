<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>
	</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 信息系统 <span class="c-gray en">&gt;</span> 商户信息 <span class="c-gray en">&gt;</span> 商户信息管理 </nav>
<div class="pd-15">
	
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="30">序号</th>
					<th width="100">商户编号</th>
					<th width="200">商户名称</th>
					<th width="100">服务类型</th>
					<th width="80">管理人姓名</th>
					<th width="80">管理人手机</th>
					<th width="30">员工</th>
					<th width="160">地理区域</th>
					<th width="50">信息状态</th>
					<th width="50">总交易量</th>
					<th width="100">总交易额</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${shopList}" var="shopPd" varStatus="indexId">
					<tr class="text-c">
						<td>${indexId.count}</td>
						<td title="${shopPd.code}">${shopPd.code}</td>
						<td title="${shopPd.name}">${shopPd.name}</td>
						<td title="${shopPd.serviceName}">${shopPd.serviceName}</td>
						<td>${shopPd.managerName}</td>
						<td>${shopPd.managerMobile}</td>
						<td>${shopPd.employeeNum}</td>
						<td title="${shopPd.province}-${shopPd.city}-${shopPd.district}">${shopPd.province}-${shopPd.city}-${shopPd.district}</td>
						<td>
							<c:if test="${shopPd.state!=1}">下架</c:if>
							<c:if test="${shopPd.state==1}">上架</c:if>
						</td>
						<td>${shopPd.billNum}</td>
						<td>
						    <span style="color: blue;">
								<c:if test="${shopPd.totalAmount != 0}">${shopPd.totalAmount}</c:if>
								<c:if test="${empty shopPd.totalAmount}">-</c:if>
							</span>
						</td>
						
						
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<%@ include file="../../common/_footer.jsp" %>
<script type="text/javascript" src="${ctx}/statics/js/area.js"></script>
<script type="text/javascript">
	$(function(){
		
		//#初始化地址下拉列表
		_init_area();
		var province = "${pd.province}";
		var city = "${pd.city}";
		var district = "${pd.district}";
		if(province != ""){
			var provinces = $("#s_province").children("option");
			for(var i = 0; i < provinces.length; i++){
				if($(provinces[i]).html() == province){
					$(provinces[i]).attr("selected",true);
					$("#s_province").change();
				}
			}
			var citys = $("#s_city").children("option");
			for(var i = 0; i < citys.length; i++){
				if($(citys[i]).html() == city){
					$(citys[i]).attr("selected",true);
					$("#s_city").change();
				}
			}
			var countys = $("#s_county").children("option");
			for(var i = 0; i < countys.length; i++){
				if($(countys[i]).html() == district){
					$(countys[i]).attr("selected",true);
					$("#s_county").change();
				}
			}
		}
		
		$(".table-sort").dataTable({
			"bPaginate": false, //翻页功能
			"bLengthChange": false, //改变每页显示数据数量
			"bFilter": false, //过滤功能
			"bSort": true, //排序功能
			"bInfo": false,//页脚信息
			"bAutoWidth": true//自动宽度
		});
	});

	/* 获取二级服务列表*/
	function getTwoServiceType(obj){
		var oneServiceTypeVal = $(obj).val();
		if(oneServiceTypeVal != undefined && oneServiceTypeVal != ""){
			$.ajax({
				  type : "POST",
			      async : true,
			      url : "shopController/findTwoService",
			      data : {
						"oneService":oneServiceTypeVal 			           
			      },
			      cache : false,
			      dataType : "json",
			      beforeSend : function() {
			           // Handle the beforeSend event
			      },
			      success : function(data, textStatus) {
			          if (data.status==1) {// 处理成功
			        	  var optionHtml = "<option value='-1'>全部状态</option>";
			        	  $.each(data.twoService,function(i,tmpTwoService){
			        		  optionHtml = optionHtml + "<option value='"+tmpTwoService.id+"'>"+tmpTwoService.name+"</option>"
			        	  });
			        	  $("#twoServiceSelect").html(optionHtml);
			          } else {// 处理失败
			        	  
			          }
			      },
			      error : function() {
			    	  layer.alert("请求发送失败，请稍后重试",{icon: 5});
			      },
			      complete : function() {
						
			      }
			});
		}
	}
	
	/*显示上下架确认操作框*/
	function showConfirm(title,url,w,h){
		layer_show(title,url,w,h);
  	}
	
	function showEditPage(title,url,
			serviceName,brandNum,province,city,district,address,link_tel,door_service,operate_state,check_status){
		if(title == '商户签约' || title == '编辑签约'){//校验基本信息是否完善，不完善不能操作签约信息
			if(serviceName == '' || serviceName == null || serviceName == undefined){
				layer.alert("服务类型信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(brandNum == '' || brandNum == null || brandNum == undefined || Number(brandNum) == 0){
				layer.alert("品牌信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(province == '' || province == null || province == undefined){
				layer.alert("地理区域信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(city == '' || city == null || city == undefined){
				layer.alert("地理区域信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(district == '' || district == null || district == undefined){
				layer.alert("地理区域信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(address == '' || address == null || address == undefined){
				layer.alert("商户地址信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(link_tel == '' || link_tel == null || link_tel == undefined){
				layer.alert("联系电话信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(door_service == '' || door_service == null || door_service == undefined){
				layer.alert("上门服务信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(operate_state == '' || operate_state == null || operate_state == undefined){
				layer.alert("运营状态信息不全，请补全后操作",{icon: 5});
				return false;
			}
			if(check_status == '' || check_status == null || check_status == undefined){
				layer.alert("信息状态信息不全，请补全后操作",{icon: 5});
				return false;
			}
		}
		var index = layer.open({
			type: 2,
			title: title,
			content: url
		});
		layer.full(index);
	}
	
	function data_del(obj,name,id,type,num){
		if(num > 0){
			switch (type) {
			case 0://一级服务
				layer.alert("对不起，请先删除所有和该类型关联的二级服务，再执行此操作",{icon: 5});
				break;
			case 1://品牌
				layer.alert("对不起，请先删除所有和该品牌关联的商户，再执行此操作",{icon: 5});
				break;
			case 2://二级服务
				layer.alert("对不起，请先删除所有和该类型关联的商户，再执行此操作",{icon: 5});
				break;
			default:
				break;
			}
			return false;
		}
		layer.confirm("确定要删除名称为："+name+" 的记录吗？", {
		    btn: ["确定","取消"] //按钮
		}, function(){
			$.ajax({
			      type : "POST",
			      async : true,
			      url : "${ctx}/serviceTypeController/delById",
			      data : {
			    	  "id":id,
			    	  "type":type
			      },
			      cache : false,
			      dataType : "json",
			      beforeSend : function() {
			           // Handle the beforeSend event
			      },
			      success : function(data, textStatus) {
			          if (data.status==1) {// 处理成功
			        	  layer.msg("操作成功",{icon: 6,time:2000},function(){/*回调函数内容*/});
			        	  $(obj).parents("tr").remove();
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
		}, function(){
			//取消操作回调函数
		});
	}
	
	
	function switchState(name,id,state){
		var confirmStr = "";
		if(state == 1){
			confirmStr = "确定要显示名称为：" + name + " 的服务吗？";
		}
		if(state == 0){
			confirmStr = "确定要屏蔽名称为：" + name + " 的服务吗？";
		}
		layer.confirm(confirmStr, {
		    btn: ["确定","取消"] //按钮
		}, function(){
			$.ajax({
			      type : "POST",
			      async : true,
			      url : "${ctx}/serviceTypeController/saveOrUpdate",
			      data : {
			    	  "id":id,
			    	  "state":state
			      },
			      cache : false,
			      dataType : "json",
			      beforeSend : function() {
			           // Handle the beforeSend event
			      },
			      success : function(data, textStatus) {
			          if (data.status==1) {// 处理成功
			        	  layer.msg("操作成功",{icon: 6,time:2000});
			        	  location.reload();
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
		}, function(){
			//取消操作回调函数
		});
	}
	
</script> 
</body>
</html>