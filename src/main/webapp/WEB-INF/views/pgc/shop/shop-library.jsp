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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 信息系统 <span class="c-gray en">&gt;</span> 商户信息 <span class="c-gray en">&gt;</span> 商户库</span><a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:to_page_sub('page-data-param');" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	
	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
		<div class="l">商户编号：<input type="text" name="code" id="code" placeholder="可模糊查询" value="${pd.code}" style="width:160px" class="input-text" /></div>
		<div class="l">商户名称：<input type="text" name="name" id="name" placeholder="可模糊查询" value="${pd.name}" style="width:160px" class="input-text" /></div>
		<div class="l">管理人姓名：<input type="text" name="shopkeeperName" id="shopkeeperName" placeholder="可模糊查询" value="${pd.shopkeeperName}" style="width:160px" class="input-text" /></div>
		<div class="l">管理人手机号：<input type="text" name="shopkeeperMobile" id="shopkeeperMobile" placeholder="可模糊查询" value="${pd.shopkeeperMobile}" style="width:160px" class="input-text" /></div>
 		<div class="l">
 			地理区域：
 			<span class="select-box inline">
 				<select id="s_province" name="province" class="select"></select>  
				<select id="s_city" name="city" class="select"></select>  
				<select id="s_county" name="district" class="select"></select>
 			</span>
 		</div>
 		<div class="l">
 			服务类型：
 			<span class="select-box inline">
				 <select name="oneService" class="select" style="min-width:100px" onchange="getTwoServiceType(this);">
				 	<option value="-1" selected="selected">全部状态</option>
				 	<c:forEach items="${oneServiceList}" var="tmpOneService">
				 		<option value="${tmpOneService.id}"<c:if test="${pd.oneService==tmpOneService.id}">selected="selected"</c:if>>${tmpOneService.name}</option>
				 	</c:forEach>
				 </select>
			</span>
			<span class="select-box inline">
				 <select name="twoService" class="select" style="min-width:100px" id="twoServiceSelect">
				 	<option value="-1">全部状态</option>
				 	<c:forEach items="${twoServiceType}" var="tmpTwoService">
				 		<option value="${tmpTwoService.id}"<c:if test="${pd.twoService==tmpTwoService.id}">selected="selected"</c:if>>${tmpTwoService.name}</option>
				 	</c:forEach>
				 </select>
			 </span>
		</div>
		<div class="l">
 			 上架状态：
  			 <span class="select-box inline">
 				 <select name="state" class="select" style="min-width:100px">
 					<option value="" selected="selected">全部状态</option>
					<option value="1" <c:if test="${pd.state == 1}">selected="selected"</c:if>>上架</option>
 					<option value="0" <c:if test="${pd.state == 0}">selected="selected"</c:if>>下架</option>
 				</select>
 			</span>
 		</div>
		<span class="l pd-10"> 
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span> 
		<span class="r pd-10"> 
			<a class="btn btn-primary radius" data-title="添加商户" href="javascript:;"  onclick="showEditPage('添加商户','shopController/preEdit?moduleType=0')" href="javascript:;">
				<i class="Hui-iconfont">&#xe600;</i> 添加商户
			</a>
		</span>
	</div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="66"></th>
					<th width="">商户编号</th>
					<th width="">商户名称</th>
					<th width="">地理区域</th>
					<th width="88">管理人姓名</th>
					<th width="88">管理人手机</th>
					<th width="66">商户状态</th>
					<th width="66">员工数</th>
					<th width="">订单数</th>
					<th width="">开卡数</th>
					<th width="">充值总额（元）</th>
					<th width="">消费额（元）</th>
					<th width="120">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${shopList}" var="shopPd" varStatus="indexId">
					<tr class="text-c">
						<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td title="${shopPd.code}">${shopPd.code}</td>
						<td>${shopPd.name}</td>
						<td>${shopPd.province}${shopPd.city}${shopPd.district}</td>
						<td>${shopPd.shopkeeperName}</td>
						<td>${shopPd.shopkeeperMobile}</td>
						<td>
							<c:if test="${shopPd.state == 1}">上架</c:if>
							<c:if test="${shopPd.state != 1}">下架</c:if>
						</td>
						<td>
							<a title="员工列表" onclick="Hui_admin_tab(this)" href="javascript:;" data-title="员工列表" _href="shopController/getEmployeeList?shopId=${shopPd.id}">
								<span style="color: blue;">${shopPd.employeeNum}</span>
							</a>
						</td>
						<td>
							<a title="交易记录" onclick="Hui_admin_tab(this)" href="javascript:;" data-title="交易记录" _href="shopBillController/getShopBillList?tradeStatus=3&shopId=${shopPd.id}">
								<span style="color: blue;">${shopPd.billNum}</span>				
							</a>
						</td>
						<td>${shopPd.openCardNum}</td>
						<td>${shopPd.rechargeAmount}</td>
						<td>${shopPd.consumeAmount}</td>
						<td class="f-14 td-manage">
							<a title="详情" href="javascript:;" onclick="showEditPage('商户详情','shopController/shopDetail?shopId=${shopPd.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe665;</i></a>
							<c:if test="${shopPd.state != 1}">
								<a title="编辑" href="javascript:;" onclick="showEditPage('编辑商户','shopController/preEdit?shopId=${shopPd.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
							</c:if>
							<a title="操作记录" onclick="Hui_admin_tab(this)" href="javascript:;" data-title="操作记录" _href="shopController/getOperateLog?shopId=${shopPd.id}"><i class="Hui-iconfont">&#xe667;</i></a>
							<c:if test="${shopPd.state != 1}">
								<a title="上架" href="javascript:;" onclick="showConfirm('商户信息上架确认','shopController/preSwitchState?shopId=${shopPd.id}&type=1','','300')" class="ml-5"><i class="Hui-iconfont">&#xe6dc;</i></a>
							</c:if>
							<c:if test="${shopPd.state == 1}">
								<a title="下架" href="javascript:;" onclick="showConfirm('商户信息下架确认','shopController/preSwitchState?shopId=${shopPd.id}&type=2','','220')" class="ml-5"><i class="Hui-iconfont">&#xe6de;</i></a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%@ include file="../../common/page.jsp" %>
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
	
	/*弹出添加、修改窗口*/
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