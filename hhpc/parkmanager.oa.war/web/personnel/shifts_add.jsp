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
				"workSchedule.name":"required",
				"workSchedule.isDefault":"required",
				"day7Class":"required",
				"day1Class":"required",
				"day2Class":"required",
				"day3Class":"required",
				"day4Class":"required",
				"day5Class":"required",
				"day6Class":"required"
			},
			messages: {
				"workSchedule.name":"请填写班制名称",
				"workSchedule.isDefault":"请选择是否缺省",
				"day7Class":"请安排周日班次",
				"day1Class":"请安排周一班次",
				"day2Class":"请安排周二班次",
				"day3Class":"请安排周三班次",
				"day4Class":"请安排周四班次",
				"day5Class":"请安排周五班次",
				"day6Class":"请安排周六班次"
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
	function setSelectedWorkClass(workClassArray,trueId,falseId){
		var strIds = ""; 
		var strName = "";
		for(var i=0;i<workClassArray.length;i++){
			var workClass = workClassArray[i];
			if(i==workClassArray.length-1){//最后一个不要添加","和"/"，为了美观
				strIds+=workClass.id;
				strName+=workClass.name;
				$("#"+trueId).val(strIds);
				$("#"+falseId).val(strName);
				return;
			}
			strIds+=workClass.id+",";
			strName+=workClass.name+"/";
		};
		$("#"+trueId).val(strIds);
		$("#"+falseId).val(strName);
	}
	function setRest(workClass,trueId,falseId){
		var strIds=workClass.id;
		var strName=workClass.name;
		$("#"+trueId).val(strIds);
		$("#"+falseId).val(strName);
	}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>workSchedule!save.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="layertitle">基本信息</div>
	<!--//titlebg-->
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>班制名称：</td>
        <td class="layerright"><label>
          <input name="workSchedule.name" type="text" class="inputauto" />
        </label></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>是否缺省：</td>
        <td class="layerright"><label>
        	<enum:radio name="workSchedule.isDefault" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
        </label></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>周日：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150">
            	<input type="hidden" name="workSchedule.day7" id="day7"/>
            	<input name="day7Class" type="text" class="inputauto" id="showOnly7" readonly="readonly"/>
            </td>
            <td valign="top"><img style="cursor:pointer; position:relative; left:-1px;" onclick="fbStart('选择班次','<%=basePath%>web/personnel/shifts_selected.jsp?trueId=day7&falseId=showOnly7',520,400);"src="core/common/images/outdiv.gif" width="20" height="22" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>周一：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150">
            	<input name="workSchedule.day1" type="hidden" id="day1" />
            	<input name="day1Class" type="text" class="inputauto" id="showOnly1" readonly="readonly"/>
            </td>
            <td valign="top"><img style="cursor:pointer; position:relative; left:-1px;" onclick="fbStart('选择班次','<%=basePath%>web/personnel/shifts_selected.jsp?trueId=day1&falseId=showOnly1',520,400);"src="core/common/images/outdiv.gif" width="20" height="22" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>周二：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150">
	            <input name="workSchedule.day2" type="hidden"  id="day2" />
	            <input name="day2Class" type="text" class="inputauto" id="showOnly2" readonly="readonly"/>
            </td>
            <td valign="top"><img style="cursor:pointer; position:relative; left:-1px;" onclick="fbStart('选择班次','<%=basePath%>web/personnel/shifts_selected.jsp?trueId=day2&falseId=showOnly2',520,400);"src="core/common/images/outdiv.gif" width="20" height="22" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>周三：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150">
            <input name="workSchedule.day3" type="hidden" id="day3" />
            <input name="day3Class" type="text" class="inputauto" id="showOnly3" readonly="readonly"/>
            </td>
            <td valign="top"><img style="cursor:pointer; position:relative; left:-1px;" onclick="fbStart('选择班次','<%=basePath%>web/personnel/shifts_selected.jsp?trueId=day3&falseId=showOnly3',520,400);"src="core/common/images/outdiv.gif" width="20" height="22" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>周四：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150">
            	<input name="workSchedule.day4" type="hidden" id="day4" />
            	<input name="day4Class" type="text" class="inputauto" id="showOnly4" readonly="readonly"/>
            </td>
            <td valign="top"><img style="cursor:pointer; position:relative; left:-1px;" onclick="fbStart('选择班次','<%=basePath%>web/personnel/shifts_selected.jsp?trueId=day4&falseId=showOnly4',520,400);"src="core/common/images/outdiv.gif" width="20" height="22" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>周五：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150">
            	<input name="workSchedule.day5" type="hidden" id="day5" />
            	<input name="day5Class" type="text" class="inputauto" id="showOnly5" readonly="readonly"/>
            </td>
            <td valign="top"><img style="cursor:pointer; position:relative; left:-1px;" onclick="fbStart('选择班次','<%=basePath%>web/personnel/shifts_selected.jsp?trueId=day5&falseId=showOnly5',520,400);"src="core/common/images/outdiv.gif" width="20" height="22" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>周六：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150">
            	<input name="workSchedule.day6" type="hidden" id="day6" />
            	<input name="day6Class" type="text" class="inputauto" id="showOnly6" readonly="readonly"/>
            </td>
            <td valign="top"><img style="cursor:pointer; position:relative; left:-1px;" onclick="fbStart('选择班制','<%=basePath%>web/personnel/shifts_selected.jsp?trueId=day6&falseId=showOnly6',520,400);"src="core/common/images/outdiv.gif" width="20" height="22" /></td>
          </tr>
        </table></td>
      </tr>
    </table>
    <!--//divlay-->
<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv--><!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
