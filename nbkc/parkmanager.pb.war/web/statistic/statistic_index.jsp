<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/">
		<title>无标题文档</title>
		<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
		<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
		<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
		<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/righth.js"></script>
		<script src="core/common/js/jquery.js"></script>
		<script src="core/common/js/jquery-ui.min.js"></script>
		<script>
			$(document).ready(function() {
				//$("#resizable").resizable();
				$("#resizable").css("height",getTabContentHeight());
				$("#pm_msglist").css("height",getTabContentHeight());
			});
		</script>
	</head>

	<body>
	</body>
</html>

