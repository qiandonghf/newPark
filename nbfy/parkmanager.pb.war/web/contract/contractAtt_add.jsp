<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
		$(function(){
			bindTypeChange();
			initTip();
			initUploadify();
		});
		function checkForm(){
			if($("#newName").val()==''){
				showTip("请上传附件");
				return;
			}
			$("#form1").ajaxSubmit({
		        dataType: 'json',
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("getOpener().reloadContractAttList();parent.fb.end();", 2000);
		        	}
		        } 
		    });
		}
		function bindTypeChange(){
			$("#type").change(function(){
				$("#"+$(this).val()).parent().show();
				$("#"+$(this).val()).parent().siblings().hide();
			});
		}
		<%-- function initUploadify(){
			$("#file").uploadify( {
				'auto'				: true, //是否自动开始 默认true
				'multi'				: false, //是否支持多文件上传 默认true
				'formData'			: {'module':'crm','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
				'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
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
				'onUploadSuccess'	: function(file, data, response) {//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
					var file = $.parseJSON(data);
					$("#name").val(file.originalName);
					$("#newName").val(file.path);
					$("#size").val(file.size);
					$("#displayName").append(file.originalName).append($("<img />",{style:'padding-left:5px;',src:'core/common/images/locking.jpg',click:function(){
						deleteAgreementDocu();
					}}));
				},
				'onSelect' : function(file) {
					deleteAgreementDocu();
		        }
			});
		} --%>
		function initUploadify(){
			$("#PHOTO").uploadify( {
				'auto'				: true, //是否自动开始 默认true
				'multi'				: false, //是否支持多文件上传 默认true
				'formData'			: {'module':'crm','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
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
				'formData'			: {'module':'crm','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
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
		function deleteAgreementDocu(){
			$("#displayName").empty();
			$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#newName").val()+"-d");
			$("#name").val("");
			$("#newName").val("");
			$("#size").val("");
		}
		function uploadSuccess(file, data, response){
			$("#size").val($.parseJSON(data).size);
			$("#name").val($.parseJSON(data).originalName);
			$("#newName").val($.parseJSON(data).path);
			$("#showName").append($.parseJSON(data).originalName);
			$("#showName").append($("<img />",{style:'padding-left:5px;',src:'core/common/images/locking.jpg',click:function(){
				deleteFile();
			}}));
		}
		function deleteFile(){
			$("#showName").empty();
			$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#newName").val()+"-d");
			$("#newName").val("");
		}
	</script>
</head>

<body>
<form action="<%=basePath %>contractAtt!save.action" method="post" name="form1" id="form1">
	<input type="hidden" id="contractId" name="contractAtt.contractId" value="${param.id}"/>
	<input type="hidden" id="name" name="contractAtt.name"/>
	<input type="hidden" id="newName" name="contractAtt.newName"/>
	<input type="hidden" id="size" name="contractAtt.size"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">附件类型：</td>
       				<td class="layerright"><enum:select id="type" name="contractAtt.type" type="com.wiiy.pb.preferences.enums.RoomAttTypeEnum" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>附件：</td>
					<td class="layerright">
						<table  width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="90">
								<span style="display: none;"><input id="PHOTO" type="file" /></span>
								<span style="display: none;"><input id="ATTACHMENT" type="file" /></span>
								</td>
								<td style="padding-left:5px;" id="showName"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">说明：</td>
					<td class="layerright"><textarea id="memo" rows="7" class="textareaauto"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm()"/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	</div>
</form>
</body>
</html>
