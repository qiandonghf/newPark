<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript">
	 $(function(){
		initTip();
		initForm();
	}); 
	 function initForm(){
		$("#form1").validate({
			rules: {
				"workerNames":"required",
				"workArrange.scheduleId":"required"
			},
			messages: {
				"workerNames":"请选择员工",
				"workArrange.scheduleId":"请选择班制"
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
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	 
 	function setSelectedUsers(users){
		var ids = "";
		var names = "";
		for(var i = 0; i < users.length; i++){
			ids += users[i].id+",";
			names += users[i].name+",";
		}
		ids = deleteLastCharWhenMatching(ids,",");
		$("#ids").val(ids);
		names = deleteLastCharWhenMatching(names,",");
		$("#workerNames").val(names);
	}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>workArrange!save.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
      <td class="layertdleft100"><span class="psred">*</span>员工：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%">
            	<input id="ids" name="workerIds" type="hidden" />
            	<input id="workerNames" name="workerNames" type="text" class="inputauto"  readonly="readonly" onclick="fbStart('选择员工','<%=BaseAction.rootLocation %>/core/user!select2.action',520,400);"/>
            </td>
            <td valign="top"><img style="cursor:pointer; position:relative; left:-1px;" onclick="fbStart('选择员工','<%=BaseAction.rootLocation %>/core/user!select2.action',520,400);" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>班制：</td>
      <td><label>
        <select name="workArrange.scheduleId" class="selectauto">
        	<option value="">请选择</option>
	        <c:forEach items="${workSchedules}" var="workSchedule">
	          <option value="${workSchedule.id}">${workSchedule.name}</option>
	        </c:forEach>
        </select>
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">开始时间：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="120"><input id="startTime" name="workArrange.startTime" type="text" class="inputauto" readonly="readonly" onclick="return showCalendar('startTime','y-mm-dd');"/></td>
            <td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;position: relative;" onclick="return showCalendar('startTime','y-mm-dd');"/></td>
            <td>&nbsp;</td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">结束时间：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="120"><input id="endTime" name="workArrange.endTime" type="text" class="inputauto" readonly="readonly" onclick="return showCalendar('endTime','y-mm-dd');"/></td>
            <td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer; position: relative;; left:-1px;" onclick="return showCalendar('endTime','y-mm-dd');"/></td>
            <td>&nbsp;</td>
          </tr>
      </table></td>
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
