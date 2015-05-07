<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />

<link href="core/common/tree/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript">
		
		function submitSelect(){
			try{
				if(typeof(getOpener().eval("setSelectedProject")) == "function"){
					var project = {id:$(".id:checked").val(),name:$(".id:checked").parent().text()};
					getOpener().setSelectedProject(project);
				}
			} catch(e){}
			fb.end();
		}
	</script>
</head>

<body>
<form action="" method="post" name="form1" id="form1">
<div class="basediv" style="padding:5px; height:180px;OVERFLOW-Y: auto; OVERFLOW-X: auto;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="200"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<c:forEach items="${taskProjectList}" var="project">
			<tr>
				<td valign="top"><label><input type="radio" name="projectId" class="id" value="${project.id}"  <c:if test="${project.id==id}">checked="checked"</c:if>  />${project.name}</label></td>
			</tr>
			</c:forEach>
		</table></td>
	</tr>
</table>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="submitSelect()" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>

