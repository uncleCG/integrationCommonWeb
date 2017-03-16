<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../../common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../../common/_top.jsp"%>	
		<style>
		.select-box button{
		background:#fff;
		border:0px;
		}
		a{color: blue;}
		</style>
	</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 交易系统 <span class="c-gray en">&gt;</span> 会员卡交易订单 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" onclick="to_page_sub('page-data-param')" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
		<div class="l"> 
			订单号：
 			<input type="text" name="billCode" id="billCode" placeholder="支持模糊搜索" value="${page.pd.billCode}" style="width:150px" class="input-text" />
 		</div>
 		<div class="l"> 
			会员卡编号：
 			<input type="text" name="cardCode" id="cardCode" placeholder="支持模糊搜索" value="${page.pd.cardCode}" style="width:150px" class="input-text" />
 		</div>
 		<div class="l"> 
			交易终端：
 			<input type="text" name="createdMobile" id="createdMobile" placeholder="支持模糊搜索" value="${page.pd.createdMobile}" style="width:150px" class="input-text" />
 		</div>
		<div class="clear l"> 
 			订单状态：
 			<span class="select-box inline">
 				 <select name="tradeStatus" class="select" style="min-width:100px">
 					<option value=""<c:if test="${empty page.pd.tradeStatus}" >selected="selected"</c:if>>全部状态</option>
					<option value="1"<c:if test="${page.pd.tradeStatus=='1'}" >selected="selected"</c:if>>待确认</option>
					<option value="2"<c:if test="${page.pd.tradeStatus=='2'}" >selected="selected"</c:if>>未到账</option>
					<option value="3"<c:if test="${page.pd.tradeStatus=='3'}" >selected="selected"</c:if>>交易完成</option>
					<option value="4"<c:if test="${page.pd.tradeStatus=='4'}" >selected="selected"</c:if>>交易取消</option>
 				</select>
 			</span>
		</div>
		<div class="l"> 
 			交易类型： 			
		 	<span class="select-box inline">
 				 <select name="type" id="type" class="select" style="min-width:100px">
 					<option value=""<c:if test="${empty page.pd.type}" >selected="selected"</c:if>>全部类型</option>
 					<option value="10"<c:if test="${page.pd.type=='10'}" >selected="selected"</c:if>>消费</option>
					<option value="11"<c:if test="${page.pd.type=='11'}" >selected="selected"</c:if>>充值</option>
 				</select>
 			</span>
		</div>
		<div class="l"> 
			开始时间：
			<input type="text" value="${page.pd.beginTradeTime}"  class="wdateInput" id="beginTradeTime" name="beginTradeTime" placeholder="交易开始时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd', isShowClear:true,readOnly:true})" style="width:150px;"/>
 		</div>
 		<div class="l"> 
			截止时间：
			<input type="text" value="${page.pd.endTradeTime}" class="wdateInput" id="endTradeTime" name="endTradeTime" placeholder="交易结束时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd', isShowClear:true,readOnly:true})" style="width:150px;"/>
		</div>
		<span class="l pd-10">
			<input type="hidden" name="shopId" value="${page.pd.shopId}"/>
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span> 
		<span class="r"> 
			<a class="btn btn-primary radius" data-title="导出" onclick="to_export_xls_sub('page-data-param','shopBillController/exportShopBillList?showCount=${page.showCount*page.totalPage}','会员卡交易订单')" href="javascript:void(0);">
				<i class="Hui-iconfont">&#xe600;</i> 导出记录
			</a>
		</span>
	</div>
	<div class="mt-10">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="40">序号</th>
					<th width="150">订单编号</th>
					<th width="130">会员卡号</th>
					<th width="70">订单状态</th>
					<th width="80">交易类型</th>
					<th width="200">商户名称</th>
					<th width="95">交易终端</th>
					<th width="75">支付方式</th>
					<th width="75">交易金额</th>
					<th width="150">交易完成时间</th>
					<th width="120">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${list}" varStatus="indexId">
					<tr class="text-c">
					<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td>${m.billCode}</td>
						<td>${m.cardCode}</td>
						<td>
							<c:if test="${m.tradeStatus == 1}">待确认</c:if>	
							<c:if test="${m.tradeStatus == 2}">未到账</c:if>	
							<c:if test="${m.tradeStatus == 3}">交易完成</c:if>
							<c:if test="${m.tradeStatus == 4}">交易取消</c:if>		
						</td>
						<td>
							<c:if test="${m.type == 10}">消费</c:if>	
							<c:if test="${m.type == 11}">充值</c:if>	
						</td>
						<td>${m.shopName}</td>
						<td>${m.createdMobile}</td>
						<td>
							<c:if test="${m.payType == '1001'}">现金</c:if>	
							<c:if test="${m.payType == '1003'}">微信支付</c:if>	
							<c:if test="${m.payType == '1004'}">支付宝</c:if>	
							<c:if test="${m.payType == '1006'}">银行卡</c:if>
							<c:if test="${m.payType == '1007'}">会员卡</c:if>	
						</td>
						<td>${m.amount}</td>
						<td>
							<fmt:formatDate value="${m.tradeTime}" type="both"/>
						</td>
						<td>
							<a title="详情" href="javascript:;" onclick="showEditPage('详情','shopBillController/getBillDetail?id=${m.id}','1000','','510')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe665;</i></a>
							<c:if test="${m.tradeStatus==1}">
								<a title="取消订单" href="javascript:;" onclick="switchBillState(${m.type},${m.cardCode},${m.id},4)" class="ml-5" style="text-decoration:none">取消订单</a>
								<a title="确认" href="javascript:;" onclick="switchBillState(${m.type},${m.cardCode},${m.id},2)" class="ml-5" style="text-decoration:none">确认</a>
							</c:if>
							<c:if test="${m.tradeStatus==2}">
								<a title="到账" href="javascript:;" onclick="switchBillState(${m.type},${m.cardCode},${m.id},3)" class="ml-5" style="text-decoration:none">到账</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%@ include file="../../../common/page.jsp" %>
	</div>
</div>

<%@ include file="../../../common/_footer.jsp" %>
<script type="text/javascript">
	$(function(){
		
		$(".table-sort").dataTable({
			"bPaginate": false, //翻页功能
			"bLengthChange": false, //改变每页显示数据数量
			"bFilter": false, //过滤功能
			"bSort": true, //排序功能
			"bInfo": false,//页脚信息
			"bAutoWidth": true//自动宽度
		});

	});
	
	/*
	弹出添加、修改窗口
	*/
	function showEditPage(title,url){
		var index = layer.open({
			type: 2,
			title: title,
			content: url
		});
		layer.full(index);
	}
	
	function switchBillState(typeVal,cardCodeVal,billId,operate){
		//确认框
		var confirmVal = "";
		var billStatus = "";
		switch (operate) {
		case 2:
			confirmVal = "是否要确认订单？";
			billStatus = "2";
			break;
		case 3:
			confirmVal = "确认该订单已到账？";
			billStatus = "3";
			break;
		case 4:
			confirmVal = "是否要取消订单？";
			billStatus = "4";
			break;

		default:
			break;
		}
		layer.confirm(confirmVal, {
            btn: ["确定","取消"] //按钮
        }, function(){//确定
            $.ajax({
                  type : "POST",
                  async : true,
                  url : "${ctx}/shopBillController/updateBill",
                  data : {
                      "id":billId,
                      "tradeStatus":billStatus,
                      "type":typeVal,
                      "cardCode":cardCodeVal
                  },
                  cache : false,
                  dataType : "json",
                  beforeSend : function() {
                       // Handle the beforeSend event
                  },
                  success : function(data, textStatus) {
                      if (data.status==1) {// 处理成功
                          layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
                        	  location.reload();;
                          });
                      } else {// 处理失败
                          layer.msg("操作失败",{icon: 5,time:2000});
                      }
                  },
                  error : function() {
                    layer.alert("请求发送失败，请稍后重试",{icon: 5});
                  },
                  complete : function() {

                  }
             });
        }, function(){//取消
        });
	}
</script>

</body>
</html>