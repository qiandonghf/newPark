<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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

<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initForm();
		initUploadify("file");
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
			'fileTypeDesc'		: "所有文件",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.*",//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
		});
	}
	function onUploadSuccess(file, data, response) {
		$("#size").val($.parseJSON(data).size);
		$("#name").val($.parseJSON(data).originalName);
		$("#fileName").val($.parseJSON(data).path);
		$("#showName").append($.parseJSON(data).name);
		$("#showName").append($("<img />",{style:'padding-left:5px;',src:'core/common/images/locking.jpg',click:function(){
			deleteFile();
		}}));
	}
	function deleteFile(){
		$("#showName").empty();
		$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#fileName").val()+"-d");
		$("#fileName").val("");
	}
	function initForm(){
		$("#form1").validate({
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(trim($("#fileName").val())==""){
					showTip("请上传文档");
					return;
				}
				if(!textlength()){
					showTip("文件备注不能超过100字");
					return;
				}
				$(form).ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	
	function textlength(){
		if($("#textarea").val().length>100){
			return false;
		}
		return true;
	}
</script>
</head>

<body>
<form action="<%=basePath %>document!save.action" method="post" name="form1" id="form1">
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="layertdleft100">附件：</td>
       	<td class="layerright" height="40">
       		<input id="size" name="document.size" type="hidden" />
       		<input id="name" name="document.name" type="hidden" />
       		<input id="fileName" name="document.fileName" type="hidden"/>
       		<input id="folderId" name="document.parentId" value="${param.id }" type="hidden" />
			<table><tr>
				<td><input id="file" type="file" /></td>
				<td style="padding-left:5px;" id="showName"></td>
			</tr></table>
		</td>
    </tr>  
    <tr>
      <td class="layertdleft100">内容：</td>
      <td class="layerright"><textarea name="document.memo" style="height:80px;" class="textareaauto" id="textarea"></textarea></td>
    </tr>
    <tr>
      <td class="layertdleft100">&nbsp;</td>
      <td class="layerright"><ul>
			<li>·服务器将永久保存您的文件，永不过期 </li>
      	<li>·单个文件不能超过100M </li>
      	<li>·文件备注不能超过100字 </li>
      	</ul>      <label></label></td>
    </tr>
  </table>
</div>
	<div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value=""/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
