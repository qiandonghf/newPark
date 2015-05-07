<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
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
	$(document).ready(function() {
		initTip();
		initForm();
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"roomMonitor.title":"required"
			},
			messages: {
				"roomMonitor.title":"请输入跟进标题"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				var item = $(":checked")
				var len=item.length;
				if(len>0){
					if($(":radio:checked").val()==2){
		 				$("#sms").val("<%=BooleanEnum.NO %>");
		 				$("#email").val("<%=BooleanEnum.NO %>");
		 			}
				}
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		if('${param.type}'==1){
			        			setTimeout("getOpener().frames[0].reloadList();",2000);
			        		}
			        		setTimeout("fb.end();",2000);
			        	}
			        } 
			    });
			}
		});
	}
	function checkradio(){ 
		var item = $(":checked");
		var len=item.length; 
		if(len>0){ 
		 	if($(":radio:checked").val()==2){
		 		$("#promotType").css({display:"none"});
		 	}else{
		 		$("#promotType").css({display:"block"});
		 	}
		} 
	} 
</script>
</head>

<body>
<form action="<%=basePath %>roomMonitor!update.action" method="post" name="form1" id="form1">
<input name="roomMonitor.roomId" value="${param.id}" type="hidden"/>
<input type="hidden" name="roomMonitor.id" value="${result.value.id }"/>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>跟进标题：</td>
      <td class="layerright"><input name="roomMonitor.title" type="text" class="inputauto" value="${result.value.title }"/></td>
      </tr>
    <tr>
      <td class="layertdleft100">提醒日期：</td>
      <td class="layerright"><table width="145" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="120"><input id="promotTime" name="roomMonitor.promotTime" readonly="readonly" value="<fmt:formatDate value="${result.value.promotTime}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('promotTime');"/></td>
          <td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('promotTime');"/></td>
          <td></td>	
        </tr>
      </table></td>
    </tr>
    <td class="layertdleft100">是否提醒：</td>
      <td class="layerright"><label>
        <input type="radio" name="ch" value="1" onclick="checkradio()" <c:if test="${result.value.sms eq 'NO' && result.value.email eq 'NO'}">checked="checked"</c:if> />
      是
      <input type="radio" name="ch" value="2" onclick="checkradio()" <c:if test="${result.value.sms eq 'YES' || result.value.email eq 'YES'}">checked="checked"</c:if>/>
      否
      </label></td>
    </tr>
    
    <tr id="promotType">
        <td class="layertdleft100">提醒方式：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          	<tr>
				<td width=20><label><input id="sms" value="<%=BooleanEnum.YES %>" type="checkbox" name="roomMonitor.sms" <c:if test="${result.value.sms eq 'YES'}">checked="checked"</c:if>></label></td>
				<td width=30>短信 </td>
				<%-- <td width=20><input id="defaultEmail" value="<%=BooleanEnum.YES %>" type="checkbox" name="roomMonitor.defaultEmail"></td>
				<td width=50>内部邮件</td> --%>
				<td width=20><input id="email" value="<%=BooleanEnum.YES %>" type="checkbox" name="roomMonitor.email" <c:if test="${result.value.email eq 'YES'}">checked="checked"</c:if>></td>
				<td>邮件</td>
				<td>&nbsp;</td>
			</tr>
        </table></td>
      </tr>
      
      <td class="layertdleft100">跟进内容：</td>
      <td class="layerright"><textarea name="roomMonitor.memo" rows="8" class="textareaauto">${result.value.memo }</textarea></td>
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
