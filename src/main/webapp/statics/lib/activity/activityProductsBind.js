var couponIdArr = new Array();
$(function(){
	//商城活动
	$("#activity_type").change(function(){
		if($("#activity_type").val() == 2){
			$("#productBtn").show();
			$("#productDiv").show();
			$("#couponBtn").hide();
			$("#couponDiv").hide();
		}else if($("#activity_type").val() == 3){
			//优惠券活动
			$("#productBtn").hide();
			$("#productDiv").hide();
			$("#couponBtn").show();
			$("#couponDiv").show();
		}else{
			$("#productBtn").hide();
			$("#productDiv").hide();
			$("#couponBtn").hide();
			$("#couponDiv").hide();
		}
	});
	
});

/**
*	弹出去重商品信息列表
*/
function popProductList(title, url) {
	var pIdsVal = $("#pIds").val();
	url = url + "?pIds=" + pIdsVal;
	if (vis != '' && vis != null){
		
		layer.confirm('确定要清空并重新选择吗？', function(index){ 
			layer_show(title, url);
			layer.close(index);
		});
	}else{
		layer_show(title, url);
	}
}


function addTr(productIdsArray, html){
	var count = productIdsArray.length;
	var productIds = productIdsArray.join(",");
	$("#pIds").val(productIds);
	if (vis != ""){
		$('#tBodyId').html(html);
	}else{
		$('#tBodyId').append(html);
	}
	vis = count;
}

function deleteTr(obj, pId) {    
	var pIds = $("#pIds").val(); 
	var newPids=pIds.replace(pId+",","");
	$("#pIds").val(newPids);
	$(obj).closest('tr').remove();
}

/**
 * 展示可关联优惠券列表 
 */
function relateCoupon(title,url){
	 var index = layer.open({
         type: 2,
         title: title,
         content: url
     });
     layer.full(index);
}

function addCouponTr(html){
	$("#couponTrId").html(html);
}

function delCouponTr(obj, couponId) {
	couponIdArr.splice($.inArray(couponId,couponIdArr),1);
	$(obj).closest('tr').remove();
}