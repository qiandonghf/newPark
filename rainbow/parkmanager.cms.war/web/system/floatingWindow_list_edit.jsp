<%@page import="com.wiiy.core.service.export.AppConfig.Choice"%>
<%@page import="com.wiiy.core.service.export.AppConfig.Parameter"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/demo/demo.css"/>

<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/tree/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/common/tree/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>

<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initForm();
	initUploadify("fileUpload");	
});

function initForm(){
	$("#form1").validate({
		rules: {
			"floatingWindow.name":"required",
			"floatingWindow.type":"required"
		},
		messages: {
			"floatingWindow.name":"请填写资源名称",
			"floatingWindow.type":"请选择资源类型"
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
		        		setTimeout("getOpener().reloadInitList();parent.fb.end();", 2000);
		        	}
		        } 
		    });
		}
	});
}

function initUploadify(id){
	var root = '<%=BaseAction.rootLocation %>/';
	$("#"+id).uploadify( {
		'auto'				: true, //是否自动开始 默认true
		'multi'				: false, //是否支持多文件上传 默认true
		'formData'			: {'module':'cms','directory': uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
		'uploader'			: root+"core/upload.action",
		'swf'				: uploadify.swf,//上传组件swf
		'width'				: "80",//按钮图片的长度
		'height'			: "18",//按钮图片的高度
		'buttonText'		: "图片上传",
		'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
		'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
		'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
		'fileTypeDesc'		: uploadify.images.fileTypeExts,//选择文件对话框文件类型描述信息
		'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
		'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
	});
}
function onUploadSuccess(file, data, response) {
	var suffixName = $.parseJSON(data).suffixName;
	var fileType = uploadify.images.fileTypeExts;
	if(fileType.indexOf(suffixName) != -1){
		$("#imgPath").attr("src", "core/resources/"+$.parseJSON(data).path);
	}
	$("#path").val($.parseJSON(data).path);
	$("#newName").val($.parseJSON(data).name);
	$("#oldName").val(decodeURI($.parseJSON(data).originalName));
	initHeight();
}

function startUpload(id){
	$("#"+id).uploadify("upload");
}

function removeImagery() {
	$("#newName").val("");
	$("#oldName").val("");
	$("#imgPath").attr("src", "");
}

</script>
</head>

<body>
<form action="<%=basePath %>floatingWindow!update.action" method="post" name="form1" id="form1">
<input type="hidden" name="floatingWindow.paramId" value="${result.value.paramId }" />
<input type="hidden" name="floatingWindow.id" value="${result.value.id }" />
<input id="path" type="hidden" name="floatingWindow.resourcePath" value="${result.value.resourcePath }"/>
<input id="newName" type="hidden" name="floatingWindow.newName" value="${result.value.newName }"/>
<input id="oldName" type="hidden" name="floatingWindow.oldName" value="${result.value.oldName }"/>
<!--basediv-->
<div class="basediv">
<!--divlay-->
<div class="divlays" style="margin:0px;float:left;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">是否启用：</td>
      <td class="layerright">
         <input type="radio" name="floatingWindow.enable" value="<%=BooleanEnum.YES%>" <c:if test="${result.value.enable eq 'YES' }">checked</c:if> />&nbsp;启用
     	 <input type="radio" name="floatingWindow.enable" value="<%=BooleanEnum.NO%>" <c:if test="${result.value.enable eq 'NO' }">checked</c:if> />&nbsp;禁用
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>浮窗名称：</td>
      <td><input name="floatingWindow.name" type="text" value="${result.value.name }" class="input200"  /></td>
    </tr>
    <tr>
      <td class="layertdleft100">浮窗类型：</td>
      <td class="layerright">
      	<enum:select id="type" type="com.wiiy.cms.preferences.enums.FloatingTypeEnum" checked="result.value.type" name="floatingWindow.type"/>
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">浮窗内容：</td>
      <td style="padding-top:2px;padding-bottom:2px;">
      	<textarea class="input200" name="floatingWindow.content" style="height:40px;resize:none;">${result.value.content }</textarea>
	  </td>
    </tr>
    <tr>
       <td class="layertdleft100">浮窗链接：</td>
       <td><input name="floatingWindow.url" type="text" value="${result.value.url }" class="input200"  /></td>
    </tr>
    <tr>
      <td class="layertdleft100">浮窗尺寸：</td>
      <td class="layerright">
      	<table>
      		<tr>
      			<td>宽:</td>
      			<td><input name="floatingWindow.width" type="text" class="input60" value="${result.value.width }" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
      			<td><span style="margin-left:5px;">高:</span></td>
      			<td><input name="floatingWindow.height" type="text" class="input60" value="${result.value.height }" onkeyup="value=value.replace(/[^\d]/g,'')" /></td>
      		</tr>
      	</table>
      </td>
    </tr>
  </table>
</div>
<div id="resourceList" style="margin-left:40px;float:left;">
	<table>
		<tr>
	        <td class="layerright">
	        	<table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
					<tr>
		              <td valign="top">
						<input type="file" name="upload" id="fileUpload" />
				      </td>
		            </tr>
		            <tr class="pic">
			           <td width="96"><!-- core/resources -->
			           <c:if test="${not empty result.value.resourcePath }">
			           		<img id="imgPath" src="core/resources/${result.value.resourcePath }" width="107" height="110" class="touxian"  style="margin-left:0px;"/>
			           </c:if>
			           <c:if test="${empty result.value.resourcePath }">
			           		<img id="imgPath" src= width="107" height="110" class="touxian"  style="margin-left:0px;"/>
			           </c:if>
			           </td>
			           <td width="15" align="center" valign="bottom">
			           	<img src="core/common/images/xtopico3.png" width="13" height="13" onclick="removeImagery()" />
			           </td>
				   </tr>
		          </table>
		  	</td>
		</tr>
	</table>
</div>
<div  style="float:left;">
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
