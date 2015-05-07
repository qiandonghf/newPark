<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String uploadPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
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
		initForm();
		initUploadify("imageUpload");
	});
	
	function initUploadify(id){
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'association','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'queueID'			: uploadify.queueID, //和存放队列的DIV的id一致 
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess,//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
			'onSelect' : function(file) {
				deleteLogo();
	        }
		});
	}
	
	function onUploadSuccess(file, data, response) {
		$("#logo").val($.parseJSON(data).path);
		$("#logoName").append($("<img />",{style:'padding-left:5px;width:50px;height:50px;',src:"core/resources/"+$.parseJSON(data).path})); 
		$("#logoName").append($("<img />",{style:'padding-left:5px;',src:'core/common/images/locking.jpg',click:function(){
			deleteLogo();}}));
	}
	
	function deleteLogo(){
		$("#logoName").empty();
		$.post("<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+$("#logo").val()+"-d");
		$("#logo").val("");
	}
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"webInfo.name":"required",
				"webInfo.url":"required",
				"webInfo.itemRegex":"required",
				"webInfo.beginFlag":"required",
				"webInfo.endFlag":"required"
			},
			messages: {
				"webInfo.name":"请输入名称",
				"webInfo.url":"请输入url地址",
				"webInfo.itemRegex":"请输入内容匹配正则",
				"webInfo.beginFlag":"请输入区域开始正则",
				"webInfo.endFlag":"请输入区域结束正则"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	

</script>
</head>

<body>
<form action="<%=basePath%>webInfo!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td width="120" class="layertdleft"><span class="psred">*</span>名称：</td>
		<td class="layerright"><input id="name" name="webInfo.name" type="text" class="inputauto" /></td>
    </tr>
    <tr>
    	<td class="layertdleft"><span class="psred">*</span>url地址：</td>
    	<td class="layerright">
    		<input name="webInfo.url" class="inputauto" type="text"/>
    		<input type="hidden" name="id" value="${id }" />
    	</td>
    </tr>
    <tr>
    	<td class="layertdleft">网址参数：</td>
    	<td class="layerright">
    		<input name="webInfo.params" style="width:50%; padding-left:2px; height:20px; line-height:20px; border:1px solid #e0e0e0;" type="text"/>(例:id:1,type:post)
    	</td>
    </tr>
    <tr>
    	<td class="layertdleft"><span class="psred">*</span>内容匹配 &nbsp;<br/>正 则：</td>
    	<td class="layerright">
    		<textarea id="memo" name="webInfo.itemRegex" class="textareaauto" style="height:40px;"></textarea>
    	</td>
    </tr>
    <tr>
    	<td class="layertdleft"><span class="psred">*</span>区域开始&nbsp;<br/>正则：</td>
    	<td class="layerright">
    		<textarea id="memo" name="webInfo.beginFlag" class="textareaauto" style="height:40px;"></textarea>
    	</td>
    </tr>
    <tr>
    <td class="layertdleft"><span class="psred">*</span>区域结束&nbsp;<br/>正则：</td>
    	<td class="layerright">
    		<textarea id="memo" name="webInfo.endFlag" class="textareaauto" style="height:40px;"></textarea>
    	</td>
    </tr>
    <tr>
    	<td class="layertdleft">标示Id&nbsp;<br/>正则：</td>
    	<td class="layerright">
    		<textarea id="memo" name="webInfo.idRegex" class="textareaauto" style="height:30px;"></textarea>
    	</td>
    </tr>
    <tr>
    	<td class="layertdleft">日期正则：</td>
    	<td class="layerright">
    		<input name="webInfo.dateRegex" class="inputauto" type="text"/>
    	</td>
    </tr>
    <tr>
    	<td class="layertdleft">日期格式：</td>
    	<td class="layerright"><input id="homePage" name="webInfo.datePattern" type="text" style="width:50%; padding-left:2px; height:20px; line-height:20px; border:1px solid #e0e0e0;" /></td>
    </tr>
    <tr>
    	<td class="layertdleft">抓取间隔：</td>
    	<td class="layerright">
    		<input id="email" name="webInfo.period" type="text" style="width:10%; padding-left:2px; height:20px; line-height:20px; border:1px solid #e0e0e0;" />小时
    	</td>
    </tr>
	</table>
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
