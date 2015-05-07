<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

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
	});
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"duty.company":"required",
				"duty.dutyDate":"required",
				"duty.woker":"required",
				"duty.phone":"required"
			},
			messages: {
				"duty.company":"请填写单位",
				"duty.dutyDate":"请选择值班日期",
				"duty.woker":"请填写值班人员",
				"duty.phone":"请填写联系电话"
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
<form id="form1" name="form1" method="post" action="<%=basePath %>duty!save.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
 		<tr>
	        <td class="layertdleft100" ><span class="psred">*</span>单位：</td>
	        <td class="layerright" width="180px;"><label><input name="duty.company" type="text" class="inputauto" value="三略科技有限公司"/></label></td>
	        <td class="layertdleft100"><span class="psred">*</span>值班日期：</td>
	        <td class="layerright">
				<table border="0" cellspacing="0" cellpadding="10">
				<tr>
					<td width="200"><input id="dutyDate" name="duty.dutyDate" value="<fmt:formatDate value="<%=new Date()%>" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" readonly="readonly" onclick="return showCalendar('dutyDate','y-mm-dd');"/></td>
					<td ><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer; position: relative; left:-1px;" onclick="return showCalendar('dutyDate','y-mm-dd');"/></td>
				</tr>
				</table>
			</td>
     	</tr>
     	<tr>
	        <td class="layertdleft100"><span class="psred">*</span>值班人员：</td>
	        <td class="layerright"><label><input name="duty.woker" value="${userName }" type="text" class="inputauto"/></label></td>
	        <td class="layertdleft100"><span class="psred">*</span>联系电话：</td>
			<td class="layerright"><label><input name="duty.phone" type="text" class="inputauto"/></label></td>     	
		</tr>
		<tr>
	      <td class="layertdleft100">来访情况：</td>
	      <td colspan="3"><span class="layerright">
	      	<textarea id="visitContent" name="duty.visitContent" rows="3" class="textareaauto"></textarea>
	      </span></td>
	    </tr>
		<tr>
	      <td class="layertdleft100">公共设施情况：</td>
	      <td colspan="3"><span class="layerright">
	      	<textarea id="facilitiesContent" name="duty.facilitiesContent" rows="3" class="textareaauto"></textarea>
	      </span></td>
	    </tr>
		<tr>
	      <td class="layertdleft100">消防、安全情况：</td>
	      <td colspan="3"><span class="layerright">
	      	<textarea id="safeContent" name="duty.safeContent" rows="3" class="textareaauto"></textarea>
	      </span></td>
	    </tr>
		<tr>
	      <td class="layertdleft100">门岗、消控情况：</td>
	      <td colspan="3"><span class="layerright">
	      	<textarea id="gateContent" name="duty.gateContent" rows="3" class="textareaauto"></textarea>
	      </span></td>
	    </tr>
		<tr>
	      <td class="layertdleft100">卫生情况：</td>
	      <td colspan="3"><span class="layerright">
	      	<textarea id="healthContent" name="duty.healthContent" rows="3" class="textareaauto"></textarea>
	      </span></td>
	    </tr>
		<tr>
	      <td class="layertdleft100">其他：</td>
	      <td colspan="3"><span class="layerright">
	      	<textarea id="otherContent" name="duty.otherContent" rows="3" class="textareaauto"></textarea>
	      </span></td>
	    </tr>
		<tr>
	      <td class="layertdleft100">备注：</td>
	      <td colspan="3"><span class="layerright">
	      	<textarea id="comment" name="duty.comment" rows="3" class="textareaauto"></textarea>
	      </span></td>
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
