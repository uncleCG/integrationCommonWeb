
/**
 * @param imgFile 上传文件
 * @param imgDivId 包含显示图片<img> 标签的<div> id
 * @param imgWidth 宽，不指定则默认160px;
 * @param imgHeight 高，不指定则默认120px;
 */
function previewImg(imgFile, imgDivId, imgWidth, imgHeight) {
	var pattern = /(\.*.jpg$)|(\.*.png$)|(\.*.jpeg$)|(\.*.gif$)|(\.*.bmp$)/;
	if (!pattern.test(imgFile.value.toLowerCase())) {
		alert("仅支持jpg/jpeg/png/gif/bmp格式的图片！");
		imgFile.focus();
	} else {
		if (imgWidth == '' || imgWidth == undefined || imgWidth == null) {
			imgWidth = "160px;";
		}
		if (imgHeight == '' || imgHeight == undefined || imgHeight == null) {
			imgHeight = "120px;";
		}
		var path;
		if (document.all)// IE
		{	
			imgFile.select();
			path = document.selection.createRange().text;
			document.getElementById(imgDivId).innerHTML = "";
			document.getElementById(imgDivId).style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\""
					+ path + "\")";// 使用滤镜效果
		} else// FF
		{
			path = URL.createObjectURL(imgFile.files[0]);
			var innerHtml = "<img src=\"" + path + "\" style=\"width:"+imgWidth+" height:"+imgHeight+"\"/>";
			document.getElementById(imgDivId).innerHTML = innerHtml;
		}
	}
}


var maxsize = 2*1024*1024;// 2M
var errMsg = "上传的文件大小不能超过2M！";  
var tipMsg = "您的浏览器暂不支持计算上传文件的大小，请确保上传文件不要超过2M，建议使用Chrome、FireFox 等浏览器。";  
var  browserCfg = {};  
var ua = window.navigator.userAgent;
if (ua.indexOf("MSIE")>=1){  
    browserCfg.ie = true;  
}else if(ua.indexOf("Firefox")>=1){  
    browserCfg.firefox = true;  
}else if(ua.indexOf("Chrome")>=1){  
    browserCfg.chrome = true;  
}
/**
 * 检查上传文件大小
 * 
 * @param fileObj
 *            上传文件
 * @param imgDivId
 *            包含显示图片<img> 标签的<div> id
 * @param imgWidth
 *            宽，不指定则默认160px;
 * @param imgHeight
 *            高，不指定则默认120px;
 */
function checkFile(fileObj,imgDivId, imgWidth, imgHeight){
	var uploadFileSize = -1;
	try{
		uploadFileSize = fileObj.files[0].size;
		if(uploadFileSize == -1){  
            alert(tipMsg);
            return false;
        }else if(uploadFileSize > maxsize){  
            alert(errMsg);  
            return false;
        }else{
        	previewImg(fileObj,imgDivId, imgWidth, imgHeight);
        }
	}catch(e){
		if(uploadFileSize == -1){
			alert(tipMsg);
		}else{
			alert(e);
		}
		return false;
	}
}