<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		initTip();
		initUploadify("file");
		if($("#attNames").val()!=""){
			var attNames = {};
			var attSizes = {};
			var attPaths = {};
			attNames = $("#attNames").val().split(",");
			attSizes = $("#attSizes").val().split(",");
			attPaths = $("#attPaths").val().split(",");
			$.each(attNames,function(i){
				$("#attList").append($("<li></li>").append("<label></label>").append(attNames[i]));
			});
		}
	});
	
	function initUploadify(id){
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'oa','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: 102400,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: "Word文件",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.doc",//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
		});
	}
	
	function onUploadSuccess(file, data, response){
		$("#newName").val($.parseJSON(data).path);
		$("#attList").append($("<li></li>").append("<label></label>").append($.parseJSON(data).originalName).append("<input type='hidden' value='"+$.parseJSON(data).size+"' class='size' /><input type='hidden' value='"+$.parseJSON(data).originalName+"' class='attName' /><input type='hidden' value='"+$.parseJSON(data).path+"' class='attPath' />").append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
			$.post("core/resources/"+$.parseJSON(data).path+"-d");
			$(this).parent().remove();
		}})));
	}
	

</script>
</head>

<body style="padding-bottom: 5px;">
<input name="meeting.id" value="${result.value.id }" type="hidden"/>
<input id="attNames" type="hidden" value="${attNames }"/>
<input id="attSizes" type="hidden" value="${attSizes }"/>
<input id="attPaths" type="hidden" value="${attPaths }"/>
<div class="basediv">
<div class="divlays" style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
 		<tr>
	        <td class="layertdleft100" >会议主题：</td>
	        <td class="layerright"><label>${result.value.title }</label></td>
     	</tr>
     	<tr>
    	    <td class="layertdleft100">会议时间：</td>
	        <td class="layerright"><fmt:formatDate value="${result.value.meetingTime}" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<td class="layertdleft100" >会议类型：</td>
			<td class="layerright">${result.value.meetingType.dataValue}</td>
		</tr>
   		
	  	<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
		    <tr>
		    <td class="layertdleft100">附件：</td>
		    <td class="layerright">
		      <table border="0" cellspacing="0" cellpadding="0" style="white-space:nowrap;">
		      	<tr><td style="padding-left:5px;width:300px;">
		      		<div id="attList" style="overflow-x:hidden;overflow-y: auto; ">
			      	</div>
			      	</td>
			      </tr>
		      </table>
		     </td>
		    </tr>
   		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		      <td class="layertdleft100">备注：</td>
		      <td colspan="3">
		      	<div style="height: 90px;overflow-y: auto; overflow-x: hidden;">${result.value.content }</div>
		      </td>
		    </tr>
	   </table>
  </table>
</div>
</div>
</body>
</html>
