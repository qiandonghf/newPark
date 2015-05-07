<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	if("${result.msg}"!=""){
		showTip("${result.msg}",2000);	
	}
	initForm();
	initUploadify("fileUpload");
	initUrl();
});

function initUrl(){
	var id = $("#param").val();
	if(id != undefined){
		var url = "<%=basePath%>waterMark!update.action";
		$("#form1").attr("action",url);
	}else{
		$("input[name='waterMark.opened']").eq(0).attr("checked","checked");
		$("input[name='waterMark.position']").eq(0).attr("checked","checked");
	}
}
 
function initForm(){
	$("#form1").validate({
		rules: {
			"waterMark.width":"required",
			"waterMark.height":"required"
		},
		messages: {
			"waterMark.width":"请填写宽度",
			"waterMark.height":"请填写高度"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			$(form).ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("location.reload();", 2000);
		        	}
		        } 
		    });
		}
	});
}

function cancle(){
	location.reload();
}

function initUploadify(id){
	$("#"+id).uploadify( {
		'auto'				: true, //是否自动开始 默认true
		//'multi'				: false, //是否支持多文件上传 默认true
		'formData'			: {'module':'core','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
		'uploader'			: "<%=BaseAction.rootLocation%>core/upload.action",
		'swf'				: uploadify.swf,//上传组件swf
		'width'				: "30",//按钮图片的长度
		'height'			: uploadify.height,//按钮图片的高度
		'buttonText'		: "上传",
		'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
		'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
		'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
		'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
		'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
		'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
	});
}
function onUploadSuccess(file, data, response) {
	$("#user_imagery_img").attr("src", "core/resources/"+$.parseJSON(data).path);
	$("#user_imagery").val($.parseJSON(data).path);
}

function startUpload(id){
	$("#"+id).uploadify("upload");
}

function removeImagery() {
	var userImagery = $("#user_imagery_img").attr("src");
	$("#user_imagery_img").attr("src", userImagery + "-d");
	$("#user_imagery").val("");
	$("#user_imagery_img").attr("src", "core/common/images/topxiao.gif");
}
</script>
</head>

<body style="background:#fff;">
<form name="form1" id="form1" method="post" action="<%=basePath%>waterMark!save.action" enctype="multipart/form-data">
<input id="param" name="waterMark.id" type="hidden" value="${result.value.id}"/>
<input id="user_imagery" type="hidden" name="uploadFileName" />
<div class="basediv">
<!--titlebg-->
	<div class="titlebg">图片水印</div>
    <!--//titlebg-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
	<div class="divlays">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="220" class="layertdleftauto">上传图片是否使用图片水印功能： </td>
        <td class="layerright">
	        <label>
	        	<enum:radio name="waterMark.opened" checked="result.value.opened" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
	        </label>
        </td>
      </tr>
      <tr>
        <td class="layertdleftauto">添加水印的图片大小控制：</td>
        <td><label>
	        &nbsp; 宽:<input name="waterMark.width" type="text" value="${result.value.width}" class="input60" />
	        &nbsp; 高：<input name="waterMark.height" type="text" value="${result.value.height}" class="input60" />
        </label></td>
      </tr>
      <tr>
        <td class="layertdleftauto">上传新图片：</td>
        <td>
        	<table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
				<tr>
	              <td width="96">
	              <c:if test="${result.value.img != null}">
	              <img id="user_imagery_img" src="<%=basePath%>waterMark!getImg.action" width="107" height="110" class="touxian" />
	              </c:if>
	              <c:if test="${result.value.img == null}">
	              <img id="user_imagery_img" src="core/common/images/topxiao.gif" width="107" height="110" class="touxian" />
	              </c:if>
	              </td>
	              <td width="15" align="center" valign="bottom"><img src="core/common/images/xtopico3.png" width="13" height="13" onclick="removeImagery()" /></td>
	              <td valign="top" style="padding-top:12px;">
					<input type="file" name="upload" id="fileUpload" />
			      </td>
	            </tr>
	          </table>
	  	</td>
      </tr>
      <tr>
        <td class="layertdleftauto">水印图片文字：</td>
        <td><input name="waterMark.marktext" type="text" value="${result.value.marktext}" class="input200" /></td>
      </tr>
      <tr>
        <td class="layertdleftauto">水印图片文字颜色：</td>
        <td><input name="waterMark.color" type="text" value="#FF44AA" class="input200" />
        </td>
      </tr>
      <tr>
        <td class="layertdleftauto">水印位置：</td>
        <td class="layerright">
	        <label><enum:radio name="waterMark.position" 
	        	type="com.wiiy.cms.preferences.enums.PositionEnum" 
	        	checked="result.value.position"/>
	        </label>
	    </td>
      </tr>
    </table>
	</div>
	</td>
  </tr>
</table>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="cancle();"/></label>
</div>
</form>
</body>
</html>
