<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initForm();
	});
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"vehicleManagement.licenseTag":"required",
				"vehicleManagement.name":"required",
				"vehicleManagement.phone":{
					required:true,
					mobileOrPhone:true
				}
			},
			messages: {
				"vehicleManagement.licenseTag":"请填写牌照",
				"vehicleManagement.name":"请填写车主姓名",
				"vehicleManagement.phone":{
					required:"请填写联系方式",
					mobileOrPhone:"请正确填写联系方式"
				}
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
<form id="form1" name="form1" method="post" action="<%=basePath%>vehicleManagement!update.action">
<input type="hidden" name="vehicleManagement.id" value="${result.value.id }"/>
<div class="basediv">
	<div class="titlebg">车辆管理信息</div>
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	 <tr>
      <td class="layertdleft100"><span class="redweight">*</span>牌照：</td>
      <td><input name="vehicleManagement.licenseTag" value="${result.value.licenseTag }" type="text" class="input170" /></td>
      <td class="layertdleft100"><span class="redweight">*</span>车主姓名：</td>
      <td><input name="vehicleManagement.name" value="${result.value.name }"  type="text" class="input170" /></td>
      </tr>
    <tr>
  	 <tr>
      <td class="layertdleft100">所在单位：</td>
      <td><input name="vehicleManagement.unit" value="${result.value.unit }"  type="text" class="input170" /></td>
      <td class="layertdleft100"><span class="redweight">*</span>联系电话：</td>
      <td><input name="vehicleManagement.phone" value="${result.value.phone }"  type="text" class="input170" /></td>
      </tr>
    <tr>
    <tr>
      <td class="layertdleft100">缴费情况：</td>
      <td colspan="3" class="layerright"><label>
        <textarea name="vehicleManagement.payment" style="height:40px;" class="textareaauto">${result.value.payment }</textarea>
      </label></td>
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
