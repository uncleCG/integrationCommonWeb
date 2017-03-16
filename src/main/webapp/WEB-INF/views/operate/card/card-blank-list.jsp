<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../common/_top.jsp"%>	
		<style>
		.select-box button{
		background:#fff;
		border:0px;
		}
		</style>
		
	</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 运营中台 <span class="c-gray en">&gt;</span> 空卡管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" onclick="to_page_sub('page-data-param')" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-15">
	<div class="cl pd-10 bg-1 bk-gray mt-3 page-data-param" id="page-data-param"> 
 		<div class="l"> 
			会员卡编号：
 			<input type="text" name="cardCode" id="cardCode" value="${page.pd.cardCode}" style="width:150px" class="input-text" />
 		</div>
		<div class="l"> 
			入库时间：
			<input type="text" value="${page.pd.beginDate}"  class="wdateInput" id="beginDate" name="beginDate" placeholder="入库时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd', isShowClear:true,readOnly:true})" style="width:150px;"/>
 		</div>
 		<div class="l"> 
			结束时间：
			<input type="text" value="${page.pd.endDate}" class="wdateInput" id="endDate" name="endDate" placeholder="结束时间" onClick="WdatePicker({dateFmt:'yyyy-MM-dd', isShowClear:true,readOnly:true})" style="width:150px;"/>
		</div>
		<span class="l pd-10"> 
			<button name="" id="" class="btn btn-success" type="button" onclick="to_page_sub('page-data-param')"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</span> 
	</div>
	<div style="padding: 10px 10px 0px 0px;overflow:hidden;">
		<span class="ml-5 r"> 
			<button name="" id="" class="btn btn-primary radius" type="button" onclick="showEditPage('${ctx}/cardController/preDestoryCard','会员卡作废')">作&nbsp;&nbsp;&nbsp;&nbsp;废</button>
		</span>
		<span class="ml-5 r"> 
			<button name="" id="" class="btn btn-primary radius" type="button" onclick="showEditPage('${ctx}/cardController/preReceiveCard','会员卡领取')">领&nbsp;&nbsp;&nbsp;&nbsp;取</button>
		</span>
		<span class="ml-5 r"> 
			<button name="" id="" class="btn btn-primary radius" type="button" onclick="showEditPage('${ctx}/cardController/preAdd','添加空卡')">添加空卡</button>
		</span>
	</div>
	<div class="mt-10">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="40"></th>
					<th width="">批次</th>
					<th width="">入库时间</th>
					<th width="">未领取卡数量</th>
					<th width="">状态</th>
					<th width="">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${blankCardPdList}" varStatus="indexId">
					<tr class="text-c">
					<td>${(indexId.index + 1) + (page.showCount * (page.currentPage-1))}</td>
						<td>${m.batch_start}-${m.batch_end}</td>
						<td>
							<fmt:formatDate value="${m.created_at}" type="both"/>
						</td>
						<td>${m.remain_num}</td>
						<td>
							<c:if test="${m.state==0}">未入库</c:if>
							<c:if test="${m.state==1}">已入库</c:if>
						</td>
						<td>
							<c:if test="${m.state==0}">
								<a title="导出二维码" onclick="to_export_xls_sub('page-data-param','cardController/export?masterId=${m.id}&batchName=${m.batch_start}-${m.batch_end}','二维码')" href="javascript:void(0);" class="ml-5" style="color: blue; text-decoration:none">导出二维码</a>
								<a title="入库" href="javascript:;" onclick="switchState(${m.id},'${m.batch_start}-${m.batch_end}')" class="ml-5" style="color: blue; text-decoration:none">入库</a>
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
	
	/*弹出添加、修改窗口*/
	function showEditPage(url,title){
		var index = layer.open({
			type: 2,
			title: title,
			content: url
		});
		layer.full(index);
	}
	
	function switchState(masterId,batchName){
		//确认框
		var confirmVal = "请确认 " + batchName + " 批次的卡已收到？";
		layer.confirm(confirmVal, {
            btn: ["确定","取消"] //按钮
        }, function(){//确定
            $.ajax({
                  type : "POST",
                  async : true,
                  url : "${ctx}/cardController/entryWarehouse",
                  data : {
                      "masterId":masterId,
                      "state":"1",
                      "storage_at":"update"
                  },
                  cache : false,
                  dataType : "json",
                  beforeSend : function() {
                       // Handle the beforeSend event
                  },
                  success : function(data, textStatus) {
                      if (data.status==1) {// 处理成功
                          layer.msg("操作成功",{icon: 6,time:2000},function(){//关闭后的操作
                        	 	location.reload();
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