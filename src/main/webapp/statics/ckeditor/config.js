/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
var locat = (window.location+'').split('/'); 
//alert(window.location);
//alert(locat[3]);
//alert(locat[3].indexOf("webTest"))
//$.each(locat,function(index,value){
//	alert("obj_" + index + " = " + value);
//})
//alert(locat[3].indexOf("qtzk")<0)

//根据项目名称分割url
if(locat[3].indexOf("gkfw")<0){
	locat =  locat[0]+'//'+locat[2];
}else{
	locat =  locat[0]+'//'+locat[2]+'/'+locat[3];
};


CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	
    //图片处理  
    config.pasteFromWordRemoveStyles = true;  
    
    //服务器上域名使用下的路径
    //config.filebrowserImageUploadUrl = "/horseticket2.2/admin/operateImage/ckUpload?type=image";  
    
    //设置图片上传URL使用本地路径
    config.filebrowserImageUploadUrl = locat+"/ckUploadController/ckUpload?type=image";  
      
    // 去掉ckeditor“保存”按钮  
    config.removePlugins = 'save'; 
    
    config.toolbar_Standard =
    	[
			['Source', '-','Undo','Redo'],
			['Find','Replace','-','SelectAll','RemoveFormat'],
			['Link', 'Unlink', 'Image', 'SpecialChar'],
			['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
			'/',
			['Bold', 'Italic','Underline'],
			['FontSize'],
			['TextColor'],
			['NumberedList','BulletedList','-','Blockquote']
		];
    config.toolbar_Chat =
    	[
			['Icon'],
			['Bold', 'Italic','Underline'],
			['FontSize'],
			['TextColor', 'Image', 'Smiley']
		];
};
