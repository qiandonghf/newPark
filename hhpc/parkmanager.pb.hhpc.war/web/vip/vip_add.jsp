<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
		$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#logo").val()+"-d");
		$("#logo").val("");
	}
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"vip.name":"required",
				"vip.gender":"required",
				"vip.mobile":"required"
			},
			messages: {
				"vip.name":"请填写姓名",
				"vip.gender":"请选择性别",
				"vip.mobile":"请填写手机"
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
			        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	

</script>
</head>

<body>
<div>
<form action="<%=basePath%>vip!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td class="layertdleft100"><span class="psred">*</span>姓名：</td>
		<td width="35%" class="layerright"><input name="vip.name" type="text" class="inputauto" /></td>
		<td class="layertdleft100">编号：</td>
    	<td class="layerright">
    		<input id="orderId" name="vip.orderId" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/>
    	</td>
	 </tr>
	 <tr>
	 	<td class="layertdleft100">是否导师：</td>
   		<td class="layerright"><enum:radio name="vip.tutor" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
	 	<td class="layertdleft100"><span class="psred">*</span>性别：</td>
		<td class="layerright"><enum:radio name="vip.gender" type="com.wiiy.commons.preferences.enums.GenderEnum"/></td>
	 </tr>
	 <tr>
	 	<td class="layertdleft100">出生年月：</td>
		<td class="layerright"><input name="vip.birth" type="text" class="inputauto" /></td>
	 	<td class="layertdleft100">学历：</td>
		<td class="layerright"><input name="vip.education" type="text" class="inputauto" /></td>
	 </tr>
    <tr>
    	<td class="layertdleft100">联系电话：</td>
    	<td class="layerright"><input name="vip.phone" type="text" class="inputauto" /></td>
   	 	<td class="layertdleft100">职称：</td>
    	<td class="layerright"><label>
    	<input name="vip.position" type="text" class="inputauto" />
    	</label></td>
   	</tr>
   	<tr>
   		<td class="layertdleft100"><span class="psred">*</span>手机：</td>
    	<td class="layerright"><input name="vip.mobile" type="text" class="inputauto" /></td>
   		<td class="layertdleft100">email：</td>
    	<td class="layerright"><label>
    	<input name="vip.email" type="text" class="inputauto" />
    	</label></td>
    </tr>
    <tr>
    	<td class="layertdleft100">就职单位:</td>
        <td class="layerright"><label>
    	<input name="vip.nuit" type="text" class="inputauto" />
    	</label></td>
    	<td class="layertdleft100">职务：</td>
    	<td class="layerright"><label>
    	<input name="vip.job" type="text" class="inputauto" />
    	</label></td>
    </tr>
    <tr>
    	<td class="layertdleft100">单位地址：</td>
    	<td class="layerright" colspan="3">  		
    		<input name="vip.address" type="text" class="inputauto" />
    	</td>
   	</tr>
   	<tr>
   		<td class="layertdleft100">专长领域：</td>
   		<td class="layerright" colspan="3"><textarea name="vip.speciality" type="text" class="inputauto" style="height:40px;overflow-X:hidden; overflow-Y:scroll;" ></textarea></td>
   	</tr>
	</table>
	<table  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100" >照片：</td>
      <td colspan="3" class="layerright" style="padding-bottom:2px;height:50px;">
      	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td id="logoName">
				</td>
				<td>
					<img id="imageUpload" src="core/common/images/uploadbtn.png" width="47" height="22" />
					<input id="logo" type="hidden" name="vip.photo" />
				</td>
			</tr>
		</table>
	  </td>
    </tr>
    <tr>
    	<td class="layertdleft100">简介：</td>
    	<td colspan="3" class="layerright"><label>
    		<textarea name="vip.memo" class="textareaauto" style="height:100px;overflow-X:hidden; overflow-Y:scroll;"></textarea>
    	</label></td>
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
</div>
</body>
</html>
