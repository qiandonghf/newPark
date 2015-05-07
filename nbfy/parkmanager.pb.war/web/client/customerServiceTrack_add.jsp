<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
$(function(){
	initTip();
	initForm();
});
function initForm(){
	$("#form1").validate({
		rules: {
			"customerServiceTrack.userName":"required",
			"customerServiceTrack.handleTime":"required"
		},
		messages: {
			"customerServiceTrack.userName":"请选择处理人",
			"customerServiceTrack.handleTime":"请选择处理时间"
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
		        		setTimeout("getOpener().frames[0].reloadList();parent.fb.end();", 2000);
		        	}
		        } 
		    });
		}
	});
}

	function setSelectedUser(user){
		$("#userId").val(user.id);
		$("#userName").val(user.name);
	}

</script>
</head>

<body>
<form action="<%=basePath %>customerServiceTrack!save.action" method="post" name="form1" id="form1">
<input type="hidden" name="customerServiceTrack.serviceId" value="${param.serviceId }"/>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>处理人：</td>
      	 	<td class="layerright" style="width:250px;">
				<table border="0" cellspacing="0" cellpadding="0" width="50%">
					<tr>
						<td width=""><input id="userId" name="customerServiceTrack.userId" type="hidden" /><input id="userName" name="customerServiceTrack.userName" type="text" class="inputauto" readonly="readonly" /></td>
						<td width="21" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择处理人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);" style="cursor:pointer"/></td>
					</tr>
				</table>
			</td>
        </tr>
      <tr>
      	<td class="layertdleft100"><span class="psred">*</span>处理时间：</td>
      		<td class="layerright">
				<table width="50%" border="0" cellspacing="0" cellpadding="0">
					<tr>
			          <td><input name="customerServiceTrack.handleTime" readonly="readonly" type="text" class="inputauto" id="handleTime" onclick="return showCalendar('handleTime');" /></td>
			          <td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('handleTime');" /></td>
			        </tr>
				</table>
			</td>
      	</tr>
        
      <tr>
      	<td class="layertdleft100">内容：</td>
      	<td ><span class="layerright" style="padding-top:4px;">
      	  <textarea name="customerServiceTrack.content"  class="textareaauto"  style="height:50px; width:95%;"></textarea>
      	</span></td>
      	</tr>
    </table>
	</div>
</div>
    <div class="buttondiv">
		<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end()"/></label>
	</div>
</body>
</form>
</html>
