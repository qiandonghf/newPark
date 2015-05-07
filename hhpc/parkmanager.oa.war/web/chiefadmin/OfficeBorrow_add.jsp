<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.commons.util.CalendarUtil"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

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
				"meetingRoomRent.company":"required",
				"meetingRoomRent.rentTime":"required",
				"meetingRoomRent.phone":"required",
				"meetingRoomRent.linkman":"required",
				"meetingRoomRent.reason":"required",
				"meetingRoomRent.cnt":"required"
			},
			messages: {
				"meetingRoomRent.company":"请输入借用单位",
				"meetingRoomRent.rentTime":"请选择借用时间",
				"meetingRoomRent.phone":"请输入联系电话",
				"meetingRoomRent.linkman":"请输入联系人",
				"meetingRoomRent.reason":"请输入借用事由",
				"meetingRoomRent.cnt":"请输入参会人数"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$("#rentTime").val() == processDate();
				$(form).ajaxSubmit({
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
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}

	function processDate(){
		$("#rentTime").val($("#rentTime").val()+" "+$("#sendHour").val()+":"+$("#sendMinute").val()+":00");
		return $("#rentTime").val();
	}
	
</script>
</head>

<body>
<form action="<%=basePath %>meetingRoomRent!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv" id="scrollDiv">
<div class="divlays">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>借用单位：</td>
        <td class="layerright"><input name="meetingRoomRent.company" type="text" class="inputauto"/></td>
         <td class="layertdleft100"><span class="psred">*</span>借用事由：</td>
        <td class="layerright"><input name="meetingRoomRent.reason" type="text" class="inputauto"/></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>联系电话：</td>
        <td class="layerright"><input name="meetingRoomRent.phone" type="text" class="inputauto"/></td>
	 	<td class="layertdleft100"><span class="psred">*</span>联系人：</td>
        <td class="layerright"><input name="meetingRoomRent.linkman" type="text" class="inputauto"/></td>
      </tr>
      <tr>
	 	<td class="layertdleft100"><span class="psred">*</span>参会人数：</td>
        <td class="layerright"><input name="meetingRoomRent.cnt" type="text" class="inputauto"/></td>
      </tr>
       <tr>
      		<td class="layertdleft100"><span class="psred">*</span>借用时间：</td>
      		<td class="layerright">
      			<table border="0" cellspacing="0" cellpadding="10">
					<tr>
						<td ><input id="rentTime" name="meetingRoomRent.rentTime"  type="text" class="inputauto" readonly="readonly" onclick="return showCalendar('rentTime','yy-mm-dd');"  /></td>
						<td ><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer; position: relative; left:-1px;" onclick="return showCalendar('rentTime','y-mm-dd');"/></td>
					</tr>
				</table>
      		</td>
      		<td colspan="3"><label>
				<select id="sendHour">
					<c:forEach begin="0" end="23" var="s">
						<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
					</c:forEach>
				</select>
			</label>
			时
			<label>
				<select id="sendMinute">
					<c:forEach begin="0" end="59" var="s" step="15">
						<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
					</c:forEach>
				</select>
			</label>
			分
			</td>	
      	</tr>
      <tr>
        <td class="layertdleft100">借用场所：</td>
		<td colspan="3"><span class="layerright">
	        <textarea name="meetingRoomRent.meetingRoom" rows="4" class="textareaauto"></textarea>
	    </span></td>
      </tr>
      <tr>
        <td class="layertdleft100">办公室意见：</td>
        <td colspan="3"><span class="layerright">
	        <textarea name="meetingRoomRent.approval" rows="4" class="textareaauto"></textarea>
	    </span></td>
      </tr>
     
</table>
<div class="hackbox"></div>
</div>
</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
