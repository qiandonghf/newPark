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
				"realName":"required",
				"signTime":"required",
				"userSign.workClassId":"required",
				"userSign.signType":"required",
				"userSign.reason":"required"
			},
			messages: {
				"realName":"请选择登记人",
				"signTime":"请填写登记时间",
				"userSign.workClassId":"请选择班次",
				"userSign.signType":"请选择补签标识",
				"userSign.reason":"请填写原因"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$("#trueSignTime").val($("#signTime").val()+" "+$("#signHour").val()+":"+$("#signMinute").val()+":00");
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
	 
	function setSelectedUser(user){
		$("#username").val(user.realName);
		$("#userId").val(user.id);
	}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>userSign!save.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>登记人：</td>
      <td class="layerright"><table  border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="120">
					<input id="userId" name="userSign.userId" type="hidden" />
					<input id="username" name="realName" class="inputauto" readonly="readonly" onclick="fbStart('选择登记人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);"/>
				</td>
				<td width="20" align="center">
					<img style="cursor:pointer;" onclick="fbStart('选择登记人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);" src="core/common/images/outdiv.gif" width="20" height="22" />
				</td>
				<td align="center">&nbsp;</td>
			</tr>
		</table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>登记时间：</td>
      <td class="layerright" width="400">
		<table border="0" cellspacing="0" cellpadding="10">
		<tr>
			<td width="120">
				<input id="signTime" name="signTime" type="text" class="inputauto" readonly="readonly" onclick="return showCalendar('signTime','y-mm-dd');"/>
				<input id="trueSignTime" name="userSign.signTime" type="hidden" value="test"/>
			</td>
			<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;relative; left:-1px;" onclick="return showCalendar('signTime','y-mm-dd');"/></td>
			<td style="padding-left: 4px;">
				<select id="signHour">
				<c:forEach begin="0" end="23" var="s">
					<option value="<c:if test="${s<10}">0</c:if>${s}">${s}</option>
				</c:forEach>
				</select>&nbsp;时
				<select id="signMinute">
					<c:forEach begin="0" end="59" var="s" step="1">
						<option value="<c:if test="${s<10}">0</c:if>${s}">${s}</option>
					</c:forEach>
				</select>&nbsp;分
			</td>
		</tr>
		</table>
	 </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>班次：</td>
      <td width="100" class="layerright"><select name="userSign.workClassId">
        	<option value="">--选择班次--</option>
         	<c:forEach items="${workClassList}" var="workClass">
         		<option value="${workClass.id}">${workClass.name}</option>      	
        	</c:forEach>              
      </select></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>补签标识：</td>
      <td class="layerright"><enum:radio name="userSign.signType" type="com.wiiy.oa.preferences.enums.SignTypeEnum"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>迟到或早退原因：</td>
      <td><textarea name="userSign.reason" rows="4" class="textareaauto"></textarea></td>
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
