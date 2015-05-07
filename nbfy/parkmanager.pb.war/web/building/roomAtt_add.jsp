<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		bindTypeChange();
		initTip();
		initForm();
		initUploadify();
	});
	function bindTypeChange(){
		$("#type").change(function(){
			$("#"+$(this).val()).parent().show();
			$("#"+$(this).val()).parent().siblings().hide();
		});
	}
	function initUploadify(){
		$("#PHOTO").uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'pb','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: '<%=uploadPath %>core/upload.action',//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: uploadSuccess,
			'onSelect' : function(file) {
				deleteFile();
	        }
		});
		$("#ATTACHMENT").uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'pb','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: '<%=uploadPath %>core/upload.action',//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.attachments.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.attachments.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: uploadSuccess,
			'onSelect' : function(file) {
				deleteFile();
	        }
		});
	}
	function uploadSuccess(file, data, response){
		$("#size").val($.parseJSON(data).size);
		$("#name").val($.parseJSON(data).originalName);
		$("#newName").val($.parseJSON(data).path);
		$("#showName").append($.parseJSON(data).name);
		$("#showName").append($("<img />",{style:'padding-left:5px;',src:'core/common/images/locking.jpg',click:function(){
			deleteFile();
		}}));
	}
	function deleteFile(){
		$("#showName").empty();
		$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#newName").val()+"-d");
		$("#newName").val("");
	}
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"roomAtt.newName":"required",
				"roomAtt.type":"required"
			},
			messages: {
				"roomAtt.newName":"请选择附件",
				"roomAtt.type":"请选择附件类型"
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
			        		setTimeout("getOpener().frames[0].reloadList();fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
</script>

</head>

<body>
<form action="<%=basePath %>roomAtt!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlays-->
<div class="divlays" style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
      	<td class="layertdleft100">附件类型：</td>
       	<td class="layerright">
			<enum:select id="type" name="roomAtt.type" type="com.wiiy.pb.preferences.enums.RoomAttTypeEnum" />
	  	</td>
      </tr>	
      <tr>
        <td class="layertdleft100">附件名称：</td>
       	<td class="layerright" height="40">
       		<input  type="hidden" name="roomAtt.roomId" value="${param.id}"/>
       		
       		<input id="size" name="roomAtt.size" type="hidden" />
       		<input id="name" name="roomAtt.name" type="hidden" />
       		<input id="newName" name="roomAtt.newName" type="hidden" />
       		
			<table><tr>
				<td><span style="display: none;"><input id="PHOTO" type="file" /></span><span style="display: none;"><input id="ATTACHMENT" type="file" /></span></td>
				<td style="padding-left:5px;" id="showName"></td>
			</tr></table>
		</td>
      </tr>
    </table>
	</div>
	<!--//divlays-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value=""/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
