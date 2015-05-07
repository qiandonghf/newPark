<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>jquery-easyui-1.3.2/themes/icon.css"/>
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/tools.js"></script>
