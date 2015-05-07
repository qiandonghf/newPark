<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initForm();
	initUrl();
});

function initUrl(){
	var id = $("#param").val();
	if(id != undefined){
		var url = "<%=basePath%>contactInfo!update.action";
		$("#form1").attr("action",url);
	}
}

function initForm(){
	$("#form1").validate({
		rules: {
			"contactInfo.name":"required",
			"contactInfo.contact":"required",
			"contactInfo.phone":"required"
		},
		messages: {
			"contactInfo.name":"请填写公司名称",
			"contactInfo.contact":"请填写联系人",
			"contactInfo.phone":"请填写电话"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			$(form).ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("location.reload();", 2000);
		        	}
		        } 
		    });
		}
	});
}
</script>
</head>

<body style="background:#fff;">
<form id="form1" name="form1" method="post" action="<%=basePath%>contactInfo!save.action">
<input id="param" name="contactInfo.id" type="hidden" value="${result.value.id}"/>
<div class="basediv">
<!--titlebg-->
	<div class="titlebg">联系方式</div>
    <!--//titlebg-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
	<div class="divlays">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="200" class="layertdleftauto">公司名称：</td>
        <td><label>
          <input name="contactInfo.name" type="text" class="input200" value="${result.value.name}"/>
        </label></td>
        </tr>
      <tr>
        <td class="layertdleftauto">联系人：</td>
        <td><input name="contactInfo.contact" type="text" class="input200" value="${result.value.contact}"/></td>
      </tr>
      <tr>
        <td class="layertdleftauto">电话：</td>
        <td><input name="contactInfo.phone" type="text" class="input200" value="${result.value.phone}"/></td>
        </tr>
      <tr>
        <td class="layertdleftauto">传真：</td>
        <td><input name="contactInfo.fax" type="text" class="input200" value="${result.value.fax}"/></td>
      </tr>
      <tr>
        <td class="layertdleftauto">E-mail：</td>
        <td><input name="contactInfo.email" type="text" class="input200" value="${result.value.email}"/></td>
      </tr>
      <tr>
        <td class="layertdleftauto">地址：</td>
        <td><textarea name="contactInfo.address" class="textarea248">${result.value.address}</textarea></td>
      </tr>
    </table>
	</div>
	</td>
  </tr>
</table>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="location.reload();"/></label>
  </div>
</form>
</body>
</html>
