<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<base href="${ base_href }">
		<!-- jsp文件头和头部 -->
		<%@ include file="../common/_top.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctx}/statics/cutImg/css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/statics/cutImg/css/default.css">
		<link href="${ctx}/statics/cutImg/assets/css/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/statics/cutImg/dist/cropper.css" rel="stylesheet">
		<link href="${ctx}/statics/cutImg/css/main.css" rel="stylesheet">
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
	</head>
<body>
<div class="pd-20">
	<div class="htmleaf-container">
	<!-- Content -->
<div class="container">
<div class="row">
  <div class="col-md-9">
	<!-- <h3 class="page-header">Demo:</h3> -->
	<div class="img-container">
	  <img src="${ctx}/statics/cutImg/assets/img/picture.jpg" alt="Picture" id="image">
	</div>
  </div>
  <div class="col-md-3">
	<!-- <h3 class="page-header">Preview:</h3> -->
	<div class="docs-preview clearfix">
	  <div class="img-preview preview-lg"></div>
	  <div class="img-preview preview-md"></div>
	  <div class="img-preview preview-sm"></div>
	  <div class="img-preview preview-xs"></div>
	</div>

	<!-- <h3 class="page-header">Data:</h3> -->
	<div class="docs-data" style="display:none;">
	  <div class="input-group">
		<label class="input-group-addon" for="dataX">X</label>
		<input class="form-control" id="dataX" type="text" placeholder="x">
		<span class="input-group-addon">px</span>
	  </div>
	  <div class="input-group">
		<label class="input-group-addon" for="dataY">Y</label>
		<input class="form-control" id="dataY" type="text" placeholder="y">
		<span class="input-group-addon">px</span>
	  </div>
	  <div class="input-group">
		<label class="input-group-addon" for="dataWidth">Width</label>
		<input class="form-control" id="dataWidth" type="text" placeholder="width">
		<span class="input-group-addon">px</span>
	  </div>
	  <div class="input-group">
		<label class="input-group-addon" for="dataHeight">Height</label>
		<input class="form-control" id="dataHeight" type="text" placeholder="height">
		<span class="input-group-addon">px</span>
	  </div>
	  <div class="input-group">
		<label class="input-group-addon" for="dataRotate">Rotate</label>
		<input class="form-control" id="dataRotate" type="text" placeholder="rotate">
		<span class="input-group-addon">deg</span>
	  </div>
	</div> 
  </div>
</div>
<div class="row" style="text-align:center;">
  <div class="col-md-9 docs-buttons">
	<!-- <h3 class="page-header">Toolbar:</h3> -->
	<div class="btn-group">
	  <!-- <button class="btn btn-primary" data-method="setDragMode" data-option="move" type="button" title="Move">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  移动
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="setDragMode" data-option="crop" type="button" title="Crop">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  裁切
		</span>
	  </button> -->
	  <button class="btn btn-primary" data-method="zoom" data-option="0.1" type="button" title="Zoom In">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  放大
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="zoom" data-option="-0.1" type="button" title="Zoom Out">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  缩小
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="rotate" data-option="-45" type="button" title="Rotate Left">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  左旋转
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="rotate" data-option="45" type="button" title="Rotate Right">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  右旋转
		</span>
	  </button>
	   <button class="btn btn-primary" data-method="reset" type="button" title="Reset">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  刷新
		</span>
	  </button>
	  <label class="btn btn-primary btn-upload" for="inputImage" title="Upload image file">
		<input class="sr-only" id="inputImage" name="imgFile" type="file" accept="image/*">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  上传
		</span>
	  </label>
	</div>

	<!-- <div class="btn-group">
	  <button class="btn btn-primary" data-method="disable" type="button" title="Disable">
		<span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;disable&quot;)">
		  <span class="icon icon-lock"></span>
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="enable" type="button" title="Enable">
		<span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;enable&quot;)">
		  <span class="icon icon-unlock"></span>
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="clear" type="button" title="Clear">
		<span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;clear&quot;)">
		  <span class="icon icon-remove"></span>
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="reset" type="button" title="Reset">
		<span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;reset&quot;)">
		  <span class="icon icon-refresh"></span>
		</span>
	  </button>
	  <label class="btn btn-primary btn-upload" for="inputImage" title="Upload image file">
		<input class="sr-only" id="inputImage" name="imgFile" type="file" accept="image/*">
		<span class="docs-tooltip" data-toggle="tooltip" title="Import image with Blob URLs">
		  <span class="icon icon-upload"></span>
		</span>
	  </label>
	  <button class="btn btn-primary" data-method="destroy" type="button" title="Destroy">
		<span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;destroy&quot;)">
		  <span class="icon icon-off"></span>
		</span>
	  </button>
	</div> 

	<div class="btn-group btn-group-crop">
	  <button class="btn btn-primary" data-method="getCroppedCanvas" type="button">
		<span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;getCroppedCanvas&quot;)">
		  Get Cropped Canvas
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="getCroppedCanvas" data-option="{ &quot;width&quot;: 160, &quot;height&quot;: 90 }" type="button">
		<span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;getCroppedCanvas&quot;, { &quot;width&quot;: 160, &quot;height&quot;: 90 })">
		  160 &times; 90
		</span>
	  </button>
	  <button class="btn btn-primary" data-method="getCroppedCanvas" data-option="{ &quot;width&quot;: 320, &quot;height&quot;: 180 }" type="button">
		<span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;getCroppedCanvas&quot;, { &quot;width&quot;: 320, &quot;height&quot;: 180 })">
		  320 &times; 180
		</span>
	  </button>
	</div>
-->
	<!-- Show the cropped image in modal -->
	<div class="modal fade docs-cropped" id="getCroppedCanvasModal" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle" role="dialog" tabindex="-1">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button class="close" data-dismiss="modal" type="button" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="getCroppedCanvasTitle">Cropped</h4>
		  </div>
		  <div class="modal-body"></div>
		  <!-- <div class="modal-footer">
			<button class="btn btn-primary" data-dismiss="modal" type="button">Close</button>
		  </div> -->
		</div>
	  </div>
	</div><!-- /.modal -->
	<!-- 
	<button class="btn btn-primary" data-method="getData" data-option="" data-target="#putData" type="button">
	  <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;getData&quot;)">
		Get Data
	  </span>
	</button>
	<button class="btn btn-primary" data-method="getImageData" data-option="" data-target="#putData" type="button">
	  <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;getImageData&quot;)">
		Get Image Data
	  </span>
	</button>
	<button class="btn btn-primary" data-method="getCanvasData" data-option="" data-target="#putData" type="button">
	  <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;getCanvasData&quot;)">
		Get Canvas Data
	  </span>
	</button>
	<button class="btn btn-primary" data-method="setCanvasData" data-target="#putData" type="button">
	  <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;setCanvasData&quot;, data)">
		Set Canvas Data
	  </span>
	</button>
	<button class="btn btn-primary" data-method="getCropBoxData" data-option="" data-target="#putData" type="button">
	  <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;getCropBoxData&quot;)">
		Get Crop Box Data
	  </span>
	</button>
	<button class="btn btn-primary" data-method="setCropBoxData" data-target="#putData" type="button">
	  <span class="docs-tooltip" data-toggle="tooltip" title="$().cropper(&quot;setCropBoxData&quot;, data)">
		Set Crop Box Data
	  </span>
	</button>
	<input class="form-control" id="putData" type="text" placeholder="Get data to here or set data with this value">
	-->
  </div><!-- /.docs-buttons -->

  <div class="col-md-3 docs-toggles">
	<!-- <h3 class="page-header">Toggles:</h3> -->
	<div class="btn-group btn-group-justified" data-toggle="buttons">
	  <label class="btn btn-primary" data-method="setAspectRatio" data-option="1.7777777777777777" title="Set Aspect Ratio">
		<input class="sr-only" id="aspestRatio1" name="aspestRatio" value="1.7777777777777777" type="radio">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  16:9
		</span>
	  </label>
	  <label class="btn btn-primary" data-method="setAspectRatio" data-option="1.3333333333333333" title="Set Aspect Ratio">
		<input class="sr-only" id="aspestRatio2" name="aspestRatio" value="1.3333333333333333" type="radio">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  4:3
		</span>
	  </label>
	  <label class="btn btn-primary" data-method="setAspectRatio" data-option="1" title="Set Aspect Ratio">
		<input class="sr-only" id="aspestRatio3" name="aspestRatio" value="1" type="radio">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  1:1
		</span>
	  </label>
	  <label class="btn btn-primary" data-method="setAspectRatio" data-option="0.6666666666666666" title="Set Aspect Ratio">
		<input class="sr-only" id="aspestRatio4" name="aspestRatio" value="0.6666666666666666" type="radio">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  2:3
		</span>
	  </label>
	  <label class="btn btn-primary active" data-method="setAspectRatio" data-option="NaN" title="Set Aspect Ratio">
		<input class="sr-only" id="aspestRatio5" name="aspestRatio" value="NaN" type="radio">
		<span class="docs-tooltip" data-toggle="tooltip" title="">
		  Free
		</span>
	  </label>
	</div> 
<!-- 
	<div class="dropdown dropup docs-options">
	  <button class="btn btn-primary btn-block dropdown-toggle" id="toggleOptions" type="button" data-toggle="dropdown" aria-expanded="true">
		Toggle Options
		<span class="caret"></span>
	  </button>
	  <ul class="dropdown-menu" role="menu" aria-labelledby="toggleOptions">
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="strict" checked>
			strict
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="responsive" checked>
			responsive
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="checkImageOrigin" checked>
			checkImageOrigin
		  </label>
		</li>

		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="modal" checked>
			modal
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="guides" checked>
			guides
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="highlight" checked>
			highlight
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="background" checked>
			background
		  </label>
		</li>

		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="autoCrop" checked>
			autoCrop
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="dragCrop" checked>
			dragCrop
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="movable" checked>
			movable
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="resizable" checked>
			resizable
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="rotatable" checked>
			rotatable
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="zoomable" checked>
			zoomable
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="touchDragZoom" checked>
			touchDragZoom
		  </label>
		</li>
		<li role="presentation">
		  <label class="checkbox-inline">
			<input type="checkbox" name="option" value="mouseWheelZoom" checked>
			mouseWheelZoom
		  </label>
		</li>
	  </ul>
	</div> -->
	<!-- /.dropdown -->
  </div><!-- /.docs-toggles -->
</div>
</div>
<!-- Alert -->
	<form action="" method="post" class="form form-horizontal" id="form-service-type-save">
		<div id="tab-system"  style="height: px;">
			<div class="tabCon">
				
			</div>
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<button onclick="uploadFile('${ctx}/uploadImgController/uploadImg','${uploadPathKey}');" id="saveBtn" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
				<button onclick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</div>
<%@ include file="../common/_footer.jsp" %>

<script src="${ctx}/statics/cutImg/assets/js/bootstrap.min.js"></script>
<script src="${ctx}/statics/cutImg/dist/cropper.js"></script>
<script src="${ctx}/statics/cutImg/js/main.js"></script>
<script src="${ctx}/statics/js/ajaxfileupload.js"></script>
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	
});

/**
 * uploadUrl：上传URL
 * uploadPathKey：在upload.properties文件中配置上传目录对应的key值
 */
function uploadFile(uploadUrl, uploadPathKey) {
	$("#saveBtn").attr("disabled","disabled");
	//获取选择区域对象
	var croppedCanvas = $("#image").cropper("getCroppedCanvas");
	//获取图像的数据链接
	var data = croppedCanvas.toDataURL();
	//alert(data);
	
	var xVal = $.trim($("#dataX").val());
	var yVal = $.trim($("#dataY").val());
	var widthVal = $.trim($("#dataWidth").val());
	var heightVal = $.trim($("#dataHeight").val());
	if(isNaN(xVal)){
		layer.tips("请核实X值", "#dataX", {
            tips: [1, "#F00"],
            time: 2000
        });
		return false;
	}
	if(isNaN(xVal)){
		layer.tips("请核实Y值", "#dataY", {
            tips: [1, "#F00"],
            time: 2000
        });
		return false;
	}
	if(isNaN(xVal)){
		layer.tips("请核实Width值", "#dataWidth", {
            tips: [1, "#F00"],
            time: 2000
        });
		return false;
	}
	if(isNaN(xVal)){
		layer.tips("请核实Height值", "#dataHeight", {
            tips: [1, "#F00"],
            time: 2000
        });
		return false;
	}
	
	$.ajax({
	      type : "POST",
	      async : false,
	      url : uploadUrl,
	      data : {
				"uploadPathKey":uploadPathKey,
				"image":data.toString()
		  },
	      cache : false,
	      dataType : "json",
	      beforeSend : function() {
	      },
		  success : function(data, status){
			switch (data.status) {
			case 1://成功
				layer.msg("上传成功",{icon: 6,time:2000},function(){//关闭后的操作
		        	parent.ajaxModifyImgCallBack(data.imageName);
		        	layer_close();
        	    });
				break;
			case -1://文件太大
				layer.msg("上传失败，图片大小大于 1M",{icon: 5,time:2000},function(){//关闭后的操作
					$("#saveBtn").removeAttr("disabled");
        	    });
				break;
			default:
				break;
			}
		  },
	 	  error : function(data, status, e){
			layer.alert("请求发送失败，请稍后重试",{icon: 5});
		  },
		  complete : function() {
			  
	      }
	});
}

</script>
</body>
</html>
