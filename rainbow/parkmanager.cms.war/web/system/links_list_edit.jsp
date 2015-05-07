<%@page import="com.wiiy.cms.preferences.enums.LinksTypeEnum"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
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
	$("#type").children().eq(0).remove();
	$("#type").change(typeChange);
	$("#photo").hide();
	initTip();
	initForm();
	typeChange();
});

function typeChange (){
	var text = $("#type").val();
	var type;
	var directory = "links";
	var fun = "onUploadSuccess";
	$(".pic").hide();
	if(text == 'PHOTO'){
		$(".pic").show();
		name = "上传图片";
		type = uploadify.images.fileTypeExts;
	}
	initUploadify("fileUpload",type,directory,name);
	if(text != '<%=LinksTypeEnum.WORDS %>')
		$("#resourceList").show();
	else
		$("#resourceList").hide();
}

function initUploadify(id,type,directory,name){
	var root = '<%=BaseAction.rootLocation %>/';
	$("#"+id).uploadify( {
		'auto'				: true, //是否自动开始 默认true
		'multi'				: false, //是否支持多文件上传 默认true
		'formData'			: {'module':'cms','directory':directory},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
		'uploader'			: root+"core/upload.action",
		'swf'				: uploadify.swf,//上传组件swf
		'width'				: "80",//按钮图片的长度
		'height'			: "18",//按钮图片的高度
		'buttonText'		: name,
		'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
		'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
		'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
		'fileTypeDesc'		: type,//选择文件对话框文件类型描述信息
		'fileTypeExts'		: type,//可上传上的文件类型
		'onUploadSuccess'	: function(file, data, response){
				onUploadSuccess(file, data, response,true);
		}
	});
}

function onUploadSuccess(file, data, response) {
	showTip("文件读取成功!",2000);
	var data = $.parseJSON(data);
	var path = data.path;
	var oldName = data.originalName;
	$("#user_imagery_img").attr("src", "core/resources/"+path);
	$(".pic").show();
	$(".sourceName").text(oldName);
	$("#photo").val(path);
	$("#oldName").val(oldName);
}

function removeImagery() {
	$("#photo").val("");
	$("#oldName").val("");
	$("#user_imagery_img").attr("src", "");
}

function initForm(){
	$("#form1").validate({
		rules: {
			"links.linkURL":"required",
			"links.displayOrder":"required"
		},
		messages: {
			"links.linkURL":"请填写链接地址",
			"links.displayOrder":"请填写排列顺序"
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
		        		setTimeout("getOpener().reloadInitList('links','links');parent.fb.end();", 2000);
		        	}
		        } 
		    });
		}
	});
}

</script>
</head>

<body>
<form action="<%=basePath %>links!update.action" method="post" name="form1" id="form1">
<input type="hidden" name="links.id" value="${result.value.id }" />
<input id="oldName" type="hidden" name="links.oldName" value="${result.value.oldName }"/>
<input id="photo" type="hidden" name="links.photo" value="${result.value.photo }"/>
<!--basediv-->
<div class="basediv">
<!--divlay-->
<div class="divlays" style="margin:0px;">
  <table border="0" cellspacing="0" cellpadding="0" style="float:left;">
    <tr>
      <td class="layertdleft100">是否启用链接：</td>
      <td class="layerright">
         <input type="radio" name="links.display" value="<%=BooleanEnum.YES%>" <c:if test="${result.value.display eq 'YES'}">checked="checked"</c:if> />&nbsp;启用
     	 <input type="radio" name="links.display" value="<%=BooleanEnum.NO%>" <c:if test="${result.value.display eq 'NO'}">checked="checked"</c:if>/>&nbsp;禁用
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">链接名称：</td>
      <td><input name="links.linkName" type="text" class="input200" value="${result.value.linkName }" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">链接类型：</td>
      <td class="layerright"><enum:select id="type" checked="result.value.type" name="links.type" type="com.wiiy.cms.preferences.enums.LinksTypeEnum"></enum:select></td>
    </tr>
    <tr>
      <td class="layertdleft100">链接地址：</td>
      <td><input name="links.linkURL" type="text" class="input200" value="${result.value.linkURL }" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">排列顺序：</td>
      <td><label>
      <input name="links.displayOrder" type="text" class="input60" id="displayOrder"  value="${result.value.displayOrder }" />
      </label></td>
    </tr>
  </table>
  <div id="resourceList" style="float:left;">
		<table>
			<tr>
				<td class="layertdleft100" width="80">图片名称：</td>
				<td class="layerright">
		        	<span style="margin-left:0px;" class="sourceName">${result.value.oldName}</span>
			  	</td>
			</tr>
			<tr>
		        <td class="layerright" colspan="2">
		        	<table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
			              <td valign="top">
							<input type="file" name="upload" id="fileUpload" />
					      </td>
			            </tr>
			            <tr class="pic">
				           <td width="92"><!-- core/resources -->
				            <c:if test="${not empty result.value.photo }">
			           			<img id="user_imagery_img" src="core/resources/${result.value.photo }" width="90" height="34" class="touxian"  style="margin-left:0px;"/>
				           </c:if>
				           <c:if test="${empty result.value.photo }">
				           		<img id="user_imagery_img" src="" width="90" height="34" class="touxian"  style="margin-left:0px;"/>
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
