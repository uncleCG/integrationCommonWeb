<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="mask" class="mask">正在处理中。。。。。。</div>  
<script type="text/javascript" src="${ctx}/statics/lib/Validform/5.3.2/Validform.min.js"></script>  
<script type="text/javascript" src="${ctx}/statics/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="${ctx}/statics/lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="${ctx}/statics/lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/statics/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctx}/statics/js/H-ui.js"></script> 
<script type="text/javascript" src="${ctx}/statics/js/H-ui.admin.js"></script> 
<script>
//兼容火狐、IE8   
//显示遮罩层    
function showMask(){     
    $("#mask").css("height",$(document).height());     
    $("#mask").css("width",$(document).width());     
    $("#mask").show();     
}  
//隐藏遮罩层  
function hideMask(){     
    $("#mask").hide();     
}  
hideMask(); 
</script>