<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initForm();
	});

	function initForm(){
		$("#form1").validate({
			rules:{
				"sealApply.applicant":"required",
				"sealApply.applyTime":"required",
				"sealApply.name":"required",
				"sealApply.cnt":"number",
				"sealApply.content":"required"
			},
			messages: {
				"sealApply.applicant":"请填写姓名",
				"sealApply.applyTime":"请选择申请日期",
				"sealApply.name":"请填写用印名称",
				"sealApply.cnt":"请正确填写用印数量",
				"sealApply.content":"请填写申请内容"
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
<form id="form1" name="form1" method="post" action="<%=basePath%>sealApply!update.action">
<input type="hidden" value="${result.value.id}" name="sealApply.id"/>
<div class="basediv" style="border:none;">
  <table width="100%"  class="oatableAdd" cellspacing="0" cellpadding="0">
  	<tr>
        <td colspan="2"  style=" border-right:none; text-align:center; background:#e3e3e3; color:#003877; border-bottom:1px solid #c3c3c3;">
		<h2 style="text-align:center; padding-top:5px;font-size:14px;">用印申请</h2>		</td>
    </tr>
    <tr>
      <td class="layertdleftblack"><span class="psred">*</span>姓名：</td>
      <td width="150" class="oatabletdright" style="padding:2px 5px;">
      	 <input type="text" name="sealApply.applicant" class="inputauto" style="width:150px;" value="${result.value.applicant}"/>
      </td>
    </tr>
	<tr>
		 <td class="layertdleftblack"><span class="psred">*</span>申请日期：</td>
	     <td class="oatabletdright" style="padding:2px 5px;">
	     	<table width="50%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><input id="regTime" name="sealApply.applyTime" value="<fmt:formatDate value="${result.value.applyTime}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="showCalendar('regTime');"/></td>
					<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('regTime');"/></td>
				</tr>
			</table>
	     </td>
	</tr>
    <tr>
    	<td class="layertdleftblack">申请项目：</td>
    	<td  class="oatabletdright" style="padding:2px 5px;">
    		<input type="text" name="sealApply.project" value="${result.value.project}" class="inputauto" />
    	</td>
    </tr>
    <tr>
    	<td class="layertdleftblack"><span class="psred">*</span>用印名称：</td>
    	<td class="oatabletdright" style="padding:2px 5px;">
    		<input type="text" name="sealApply.name" value="${result.value.name}" class="inputauto" style="width:150px;" />
    	</td>
    </tr>
   	<tr>
   		<td class="layertdleftblack">用印数量：</td>
   		<td  class="oatabletdright" style="padding:2px 5px;">
   			<input type="text" name="sealApply.cnt" value="${result.value.cnt}" class="inputauto" style="width:150px;" />
   		</td>
   	</tr>
   	<tr>
    	<td class="layertdleftblack"><span class="psred">*</span>申请内容：</td>
    	<td  class="oatabletdright" style="padding:2px 5px;">
			<textarea name="sealApply.content" class="textareaauto" style="width:400px; height:80px;">${result.value.content}</textarea>
		</td>
    </tr>
  </table>
</div>
<!--//basediv-->
<div class="buttondiv">
	  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
	  <label><input name="Submit" type="submit" class="" value="保存并送审" /></label>
	  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();" /></label>
</div>
</form>
</body>
</html>