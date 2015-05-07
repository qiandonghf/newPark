<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />

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
		initForm();
		initUploadify();
	});
	function initUploadify(){
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
			'fileTypeDesc'		: "支持格式:jpg/gif/jpeg/png/bmp/tif/txt/doc/zip/rar/pdf",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.jpg;*.gif;*.jpeg;*.png;*.bmp;*.tif;*.txt;*.doc;*.zip;*.rar;*.pdf;",//可上传上的文件类型
			'onUploadSuccess'	: uploadSuccess
		});
	}
	function uploadSuccess(file, data, response){
		var file = $.parseJSON(data);
		var postData = {"contractRecordAtt.contractRecordId":$("#contractRecordId").val(),"contractRecordAtt.name":file.originalName,"contractRecordAtt.newName":file.path,"contractRecordAtt.size":file.size};
		$.post("<%=basePath%>contractRecordAtt!save.action",postData,function(callbackData){
			var id = callbackData.result.value.id;
			$("#attList").append($("<li></li>",{id:"li"+id}).append($("<label></label>").append(file.originalName).append("<input type='hidden' class='att' value='"+file.path+"'/>")).append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
				deleteAtt(id);
			}})));
		});
	}
	function deleteAtt(id){
		$.post("<%=basePath %>contractRecordAtt!delete.action?id="+id,function(data){
			$("#li"+id).remove();
		});			
	}
	function initForm(){
		$("#form1").validate({
			rules: {
				"contractRecord.partya":"required",
				"contractRecord.partyb":"required",
				"contractRecord.contractName":"required"
			},
			messages: {
				"contractRecord.partya":"请输入甲方",
				"contractRecord.partyb":"请输入乙方",
				"contractRecord.contractName":"请输入合同名称"
				
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(notNull("start","开始日期") && notNull("end","结束日期")){
					if($("#end").val()<$("#start").val()){
						showTip("合同开始日期不能大于合同结束日期",5000);
						return;
					}else{
						$("#duration").val($("#start").val()+"至"+$("#end").val());
					}
				}else{
					showTip("合同期限不能为空",5000);
					return;
				}
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
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
	
</script>
</head>

<body>
<form action="<%=basePath %>contractRecord!update.action" method="post" name="form1" id="form1">
<input id="contractRecordId" name="contractRecord.id" value="${result.value.id }" type="hidden" />
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>甲方：</td>
      <td class="layerright"><input name="contractRecord.partya" type="text" class="inputauto" value="${result.value.partya }"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>乙方：</td>
      <td class="layerright"><input name="contractRecord.partyb" type="text" class="inputauto" value="${result.value.partyb }"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>合同名称：</td>
      <td class="layerright"><input name="contractRecord.contractName" type="text" class="inputauto" value="${result.value.contractName }"/></td>
    </tr>
    <tr>
		<td class="layertdleft100">合同期限：</td>
		<td class="layerright">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><input name="start" readonly="readonly" type="text" class="inputauto" id="start"  onclick="return showCalendar('start');" value="<fmt:formatDate value="${start}" pattern="yyyy-MM-dd"/>"/></td>
					<td width="25"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('start');" /></td>
					<td>至</td>
					<td><input name="end" readonly="readonly" type="text" class="inputauto" id="end" onclick="return showCalendar('end');" value="<fmt:formatDate value="${end}" pattern="yyyy-MM-dd"/>" /></td>
					<td width="25"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('end');" /><input type="hidden" id="duration" name="contractRecord.duration" /> </td>
					
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="layertdleft100">签约时间：</td>
		<td class="layerright">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><input name="contractRecord.signingDate" readonly="readonly" type="text" class="inputauto" id="signingDate" onclick="return showCalendar('signingDate');" value="<fmt:formatDate value="${result.value.signingDate}" pattern="yyyy-MM-dd"/>"/></td>
					<td width="25"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('signingDate');" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
      <td class="layertdleft100">合同性质：</td>
      <td class="layerright"><enum:select type="com.wiiy.oa.preferences.enums.ContractCharacterEnum" name="contractRecord.contractCharacter" checked="result.value.contractCharacter" /></td>
    </tr>
	<tr>
      <td class="layertdleft100">金额：</td>
      <td class="layerright"><input name="contractRecord.money" type="text" class="inputauto" value="${result.value.money }" /></td>
    </tr>
    <tr>
		<td class="layertdleft100">附件：</td>
		<td class="layerright">
			<table><tr><td><input id="file" type="file" /><input id="agreementDocu" name="incubationInfo.agreementDocu" type="hidden" /></td><td style="padding-left:5px;" id="agreementDocuName"></td></tr></table>
		</td>
	</tr>
	<tr>
		<td class="layertdleft100">附件列表：</td>
		<td class="layerright">
			<table border=0 cellspacing=0 cellpadding=0 width="70%"><tr><td style="padding-left:5px;">
				<div id="attList" style="height: 100px;overflow-x:hidden;overflow-y: auto; ">
				<c:forEach items="${result.value.atts}" var="att">
				<li id="li${att.id}"><label>${att.name}<input type="hidden" value="${att.newName}" class="att"/></label><img src="core/common/images/locking.jpg" onclick="deleteAtt(${att.id})"/></li>
			</c:forEach></div>
			</td></tr></table>
		</td>
	</tr>
  </table>
</div>
	<div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
