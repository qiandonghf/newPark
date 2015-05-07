<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
				"agency.name":"required"
			},
			messages: {
				"agency.name":"请填写单位名称"
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
<form action="<%=basePath%>agency!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td class="layertdleft100"><span class="psred">*</span>单位名称：</td>
		<td width="35%" class="layerright">
			<input name="agency.name" type="text" class="inputauto" />
		</td>
		<td class="layertdleft100">编号：</td>
    	<td class="layerright">
    		<input id="orderId" name="agency.orderId" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/>
    	</td>
    </tr>
     <tr>
		<td class="layertdleft100">发布到网站：</td>
		<td width="35%" class="layerright">
			<enum:radio name="agency.pub" type="com.wiiy.commons.preferences.enums.BooleanEnum" />
		</td>
		<td class="layertdleft100">网址：</td>
    	<td class="layerright">
    		<input id="orderId" name="agency.homePage" type="text" class="inputauto"/>
    	</td>
    </tr>
     <tr>
    	<td class="layertdleft100">负责人：</td>
    	<td class="layerright"><input id="charger" name="agency.charger" type="text" class="inputauto" /></td>
    	<td class="layertdleft100">职务：</td>
    	<td class="layerright"><input id="position" name="agency.position" type="text" class="inputauto" /></td>
    </tr>
    <tr>
    	<td class="layertdleft100">负责人手机：</td>
    	<td class="layerright"><input id="mobile" name="agency.mobile" type="text" class="inputauto" /></td>
    	<td class="layertdleft100">负责人电话：</td>
    	<td class="layerright"><input id="phone" name="agency.phone" type="text" class="inputauto" /></td>
    </tr>
    <tr>
    	<td class="layertdleft100">联系人：</td>
    	<td class="layerright"><input id="contact" name="agency.contact" type="text" class="inputauto" /></td>
    	<td class="layertdleft100">职务：</td>
    	<td class="layerright"><input id="cposition" name="agency.cposition" type="text" class="inputauto" /></td>
    </tr>
    <tr>
    	<td class="layertdleft100">联系人手机：</td>
    	<td class="layerright"><input id="mobile" name="agency.contractMobile" type="text" class="inputauto" /></td>
    	<td class="layertdleft100">联系人电话：</td>
    	<td class="layerright"><input id="phone" name="agency.contractPhone" type="text" class="inputauto" /></td>
    </tr>
    <tr>
    	<td class="layertdleft100">Email：</td>
    	<td class="layerright">
    		<input id="email" name="agency.email" type="text" class="inputauto" />
    	</td>
    	<td class="layertdleft100">机构类型：</td>
    	<td class="layerright">
    		<enum:select type="com.wiiy.crm.preferences.enums.AgencyEnum" name="agency.agencyType" />
    	</td>
    </tr>
   <!--  <tr>
    	<td class="layertdleft100">网址：</td>
    	<td class="layerright">
    		<input name="agency.homePage" type="text" class="inputauto" />
    	</td>
    	<td class="layertdleft100"><span class="psred">*</span>邮编：</td>
		<td>
			<input name="agency.zipcode" type="text" class="input60" />
		</td>
    	</tr>
	</table>
	<table  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">通讯地址：</td>
      <td colspan="3" class="layerright">
      	<input style="width:469px;" name="agency.address" type="text" class="inputauto" />
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">LOGO：</td>
      <td colspan="3" class="layerright" style="padding-bottom:2px;height:50px;">
      	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td id="logoName">
				</td>
				<td>
					<img id="imageUpload" src="core/common/images/uploadbtn.png" width="47" height="22" />
					<input id="logo" type="hidden" name="agency.logo" />
				</td>
			</tr>
		</table></td>
    </tr> -->
    
    <tr>
    	<td class="layertdleft100">简介：</td>
    	<td colspan="3" class="layerright"><label>
    		<textarea name="agency.memo" class="textareaauto" style="height:100px;"></textarea>
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
</body>
</html>
