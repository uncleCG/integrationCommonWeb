<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<LINK rel="Bookmark" href="${ctx}/favicon.ico" >
<LINK rel="Shortcut Icon" href="${ctx}/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="${ctx}/statics/lib/html5.js"></script>
<script type="text/javascript" src="${ctx}/statics/lib/respond.min.js"></script>
<script type="text/javascript" src="${ctx}/statics/lib/PIE_IE678.js"></script>
<![endif]-->
<link href="${ctx}/statics/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/statics/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/statics/skin/default/skin.css" rel="stylesheet" type="text/css" id="skin" />
<link href="${ctx}/statics/lib/Hui-iconfont/1.0.6/iconfont.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/statics/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css">
<link href="${ctx}/statics/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/statics/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/statics/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/statics/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/statics/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
   var notice = '${notice}';
   if(notice != null && notice!=''){
	   layer.msg(notice,{icon: 6,time:2000});
   }
});
</script>

<!--[if IE 6]>
<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
