<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
	});
	function checkForm(){
		if ($("#phone").val()!="") {
			if (checkPhone("phone","联系电话")==false) {
				return;
			}
		}
		if ($("#email").val()!="") {
			if (checkEmail("email","Email")==false) {
				return;
			}
		}
		if (notNull("name","姓名")) {
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
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
</script>
</head>

<body>
<form action="<%=basePath %>staffer!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
     <td class="layerright">${result.value.name}<input id="customerId" name="staffer.customerId" type="hidden" value="${result.value.id}"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>姓名：</td>
      <td class="layerright"><input name="staffer.name" type="text" class="inputauto" id="name" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">性别：</td>
      <td class="layerright">
		<enum:radio name="staffer.gender" type="com.wiiy.commons.preferences.enums.GenderEnum" defaultValue="Female" />
	  </td>
    </tr>
    <tr>
	    <td class="layertdleft100">出生年月：</td>
		<td class="layerright">
			<table width="30%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><input id="birth" name="staffer.birth" readonly="readonly" type="text" class="inputauto" onclick="showCalendar('birth');"/></td>
					<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('birth');"/></td>
				</tr>
	    	</table>
	    </td>
    </tr>
    <tr>
      <td class="layertdleft100">职位：</td>
      <td class="layerright">
      	<dd:select id="positionId" name="staffer.positionId" key="crm.0014" />
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">政治面貌：</td>
      <td class="layerright">
		<dd:select id="positionId" name="staffer.politicalId" key="crm.0029" />
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">联系电话：</td>
      <td class="layerright"><input name="staffer.phone" type="text" class="inputauto" id="phone" onkeyup="value=value.replace(/[^\d]/g,'')" /></td>
    </tr>
    
    <tr>
      <td class="layertdleft100">Email：</td>
      <td class="layerright"><input name="staffer.email" type="text" class="inputauto" id="email" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">学位：</td>
      <td class="layerright">
      	<dd:select id="degreeId" name="staffer.degreeId" key="crm.0015" />
      </td>
    </tr>
   <tr>
      <td class="layertdleft100">学历：</td>
      <td class="layerright"><input name="staffer.education" type="text" class="inputauto" id="education" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">毕业学校：</td>
      <td class="layerright"><input name="staffer.studySchool" type="text" class="inputauto" id="studySchool" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">留学国家：</td>
      <td class="layerright"><input name="staffer.abroadCountry" type="text" class="inputauto" id="abroadCountry" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">是否总经理：</td>
      <td class="layerright">
      	 <enum:radio name="staffer.manager" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否法人：</td>
      <td class="layerright">
      	 <enum:radio name="staffer.legal" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否留学员：</td>
      <td class="layerright">
      	<enum:radio name="staffer.studyAbroad" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否股东：</td>
      <td class="layerright">
      	<enum:radio name="staffer.stockHolder" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否发布网站</td>
      <td class="layerright">
      	 <enum:radio name="staffer.pub" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO"/>
      </td>
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
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm();" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
