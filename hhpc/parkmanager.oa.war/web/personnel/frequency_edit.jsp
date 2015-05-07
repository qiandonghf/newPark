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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	 $(function(){
		initTip();
		initForm();
	}); 
	 function initForm(){
		$("#form1").validate({
			rules: {
				"workClass.name":"required",
				"startTimeHour":"required",
				"startTimeMinute":"required",
				"signInStartTimeHour":"required",
				"signInStartTimeMinute":"required",
				"signInEndTimeHour":"required",
				"signInEndTimeMinute":"required",
				"endTimeHour":"required",
				"endTimeMinute":"required",
				"signOutStartTimeHour":"required",
				"signOutStartTimeMinute":"required",
				"signOutEndTimeHour":"required",
				"signOutEndTimeMinute":"required"
			},
			messages: {
				"workClass.name":"请填写班次名称",
				"startTimeHour":"请选择上班时间",
				"startTimeMinute":"请选择上班时间",
				"signInStartTimeHour":"请选择签到开始时间",
				"signInStartTimeMinute":"请选择签到开始时间",
				"signInEndTimeHour":"请选择签到结束时间",
				"signInEndTimeMinute":"请选择签到结束时间",
				"endTimeHour":"请选择下班时间",
				"endTimeMinute":"请选择下班时间",
				"signOutStartTimeHour":"请选择签退开始时间",
				"signOutStartTimeMinute":"请选择签退开始时间",
				"signOutEndTimeHour":"请选择签退结束时间",
				"signOutEndTimeMinute":"请选择签退结束时间"
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
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>workClass!update.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>班次名称：</td>
      <td>
      <input name="workClass.id" type="hidden" value="${workClass.id}"/>
      <input name="workClass.name" type="text" class="input170" value="${workClass.name}"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>上班时间：</td>
      <td class="layerright">
      <select name="startTimeHour">
      	<option value="">---</option>
      	<c:forEach begin="0" end="23" var="s">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${startTimeHour == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}
		</c:forEach>
      </select>
                    时
	  <select name="startTimeMinute">
	  	<option value="">---</option>
		<c:forEach begin="0" end="59" var="s" step="15">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${startTimeMinute == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
	  </select>
	      分 
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>签到开始时间：</td>
      <td class="layerright"><select name="signInStartTimeHour">
         <option value="">---</option>
         <c:forEach begin="0" end="23" var="s">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${signInStartTimeHour == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		 </c:forEach>
      </select>
                    时
      <select name="signInStartTimeMinute">
         <option value="">---</option>
         <c:forEach begin="0" end="59" var="s" step="15">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${signInStartTimeMinute == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
      </select> 
                    分
	</td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>签到结束时间：</td>
      <td class="layerright"><select name="signInEndTimeHour">
      	<option value="">---</option>
      	<c:forEach begin="0" end="23" var="s">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${signInEndTimeHour == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
      </select>
	      时
	  <select name="signInEndTimeMinute">
  		<option value="">---</option>
  		<c:forEach begin="0" end="59" var="s" step="15">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${signInEndTimeMinute == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
	  </select>
	     分 
	</td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>下班时间：</td>
      <td class="layerright"><select name="endTimeHour">
        <option value="">---</option>
        <c:forEach begin="0" end="23" var="s">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${endTimeHour == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
      </select>
	      时
	  <select name="endTimeMinute">
  		<option value="">---</option>
  		<c:forEach begin="0" end="59" var="s" step="15">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${endTimeMinute == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
	  </select>
                   分 
    </td>
    </tr>
    
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>签退开始时间：</td>
      <td class="layerright"><select name="signOutStartTimeHour">
        <option value="">---</option>
        <c:forEach begin="0" end="23" var="s">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${signOutStartTimeHour == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
      </select>
	      时
	  <select name="signOutStartTimeMinute">
  		<option value="">---</option>
  		<c:forEach begin="0" end="59" var="s" step="15">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${signOutStartTimeMinute == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
	  </select>
	      分
    </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>签退结束时间：</td>
      <td class="layerright"><select name="signOutEndTimeHour">
        <option value="">---</option>
        <c:forEach begin="0" end="23" var="s">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${signOutEndTimeHour == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
      </select>
	      时
	 <select name="signOutEndTimeMinute">
  		<option value="">---</option>
  		<c:forEach begin="0" end="59" var="s" step="15">
			<option value="<c:if test="${s<10}">0</c:if>${s}" <c:if test="${signOutEndTimeMinute == s}">selected="selected"</c:if>><c:if test="${s<10}">0</c:if>${s}</option>
		</c:forEach>
	 </select>
	   分 
	</td>
    </tr>
    <tr>
      <td class="layertdleft100">备注：</td>
      <td class="layerright"><label>
        <textarea name="workClass.memo" rows="5" class="textareaauto">${workClass.memo}</textarea>
      </label></td>
    </tr>
  </table>
</div>
<!--//basediv-->

<!--basediv-->
<div class="hackbox"></div>
</div>
<!--//basediv-->

<!--basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
<!--//basediv-->
</form>
</body>
</html>
