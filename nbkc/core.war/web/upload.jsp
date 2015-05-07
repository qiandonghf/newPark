<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=BaseAction.rootLocation%>"/>
		<title>文件上传</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				initUploadify("fileUpload");
			});
			function initUploadify(id){
				$("#"+id).uploadify( {
					'auto'				: true, //是否自动开始 默认true
					'multi'				: false, //是否支持多文件上传 默认true
					'formData'			: {'module':'core','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
					'uploader'			: uploadify.uploader,//文件服务器路径
					'swf'				: uploadify.swf,//上传组件swf
					'width'				: uploadify.width,//按钮图片的长度
					'height'			: uploadify.height,//按钮图片的高度
					'buttonText'		: uploadify.buttonText, //按钮上的文字
					'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
					'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
					'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
					'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
					'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
					'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
				});
			}
			function onUploadSuccess(file, data, response) {
				//$.parseJSON(data).path//将data转成json对象 此对象为 com.wiiy.core.dto.UploadResult;
			}
			function startUpload(id){
				$("#"+id).uploadify("upload");
			}
		</script>
	</head>

	<body>
		<center>
			<div>
				<input type="file" id="fileUpload" />
			</div>
			<input type="button" value="开始上传" onclick="startUpload('fileUpload')"/>
		</center>
	</body>
</html>

