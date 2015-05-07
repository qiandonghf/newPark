<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initUploadify("fileUpload");
	});
	function initUploadify(id){
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			//'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'crm','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
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
			'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
		});
	}
	function onUploadSuccess(file, data, response) {
		$("#imageList").append($("<td width='60'></td>").append("<img src='core/resources/"+$.parseJSON(data).path+"' width='50' height='50' class='productimg' />"));
		$("#imageList").append($("<td width='25' valign='bottom'></td>").append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
			$(this).parent().prev().remove();
			$(this).parent().remove();
			}})));
	}
	function checkForm(){
		var path;
		var pathString = "";
		if (notNull("customerName","企业名称") && notNull("name","产品名称")
				&& checkInput("technicId","技术领域") && checkInput("stageId","产品阶段")) {
			$(".productimg").each(function(){
				path = $(this).attr("src")+";";
				pathString += path;
			});
			$("#photos").val(pathString);
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
	}
	function checkInput(id,name) {
		if ($("#"+id).val()=="") {
			showTip("请选择"+name);
			return false;
		}else{
			return true;
		}
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
</script>

</head>

<body>
<form action="<%=basePath %>product!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="350"><input id="customerId" name="product.customerId" type="hidden" /><input id="customerName" type="text" class="inputauto" readonly="readonly" onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);"/></td>
          <td><img style="cursor:pointer;" src="core/common/images/outdiv.gif" style="position:relative;left:-4px;" width="20" height="22"  onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>产品名称：</td>
      <td class="layerright"><input id="name" name="product.name" type="text" class="inputauto" /></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>技术领域：</td>
      <td class="layerright">
      	<dd:select name="product.technicId" key="crm.0002" id="technicId"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>产品阶段：</td>
      <td class="layerright">
      <dd:select name="product.stageId" key="crm.0013" id="stageId"/>
      </td>
    </tr>
    
    <tr>
      <td class="layertdleft100">产品照片：</td>
      <td class="layerright">  
     	<input type="file" id="fileUpload" />
        <div id="fileQueue"></div>
     	<input  type="hidden" id="photos" name="product.photos" value=""/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">图片预览：</td>
      <td class="layerright">
      	<div style="width:370px; overflow-x:scroll; overflow-y:hidden; height:80px; margin-bottom:2px;">
      	  <table height="60" border="0" cellspacing="0" cellpadding="10">
	        <tr id="imageList"></tr>
	      </table>
	      </div>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">发布到网站：</td>
      <td class="layerright">
	      <enum:radio name="product.pub" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">产品简介：</td>
      <td class="layerright"><label>
        <textarea name="product.introduction" style="height:115px;" class="textareaauto"></textarea>
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
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
