<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
List<String> propertyList = (List<String>)session.getAttribute("propertys");
boolean staffer = propertyList.contains("staffer");
boolean incubationRoute = propertyList.contains("incubationRoute");
boolean contect = propertyList.contains("contect");
boolean patent = propertyList.contains("patent");
boolean brand = propertyList.contains("brand");
boolean projectApply = propertyList.contains("projectApply");
boolean copyright = propertyList.contains("copyright");
boolean customerQualification = propertyList.contains("customerQualification");
boolean customerVentureType = propertyList.contains("customerVentureType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>

<script type="text/javascript">
	$(function(){
		$("#baseinfo").height(getTabContentHeight()-55);
	});
	function tabHander(el,url){
		$(el).siblings().removeClass("apptabliover").addClass("apptabli");
		$(el).removeClass("apptabli").addClass("apptabliover");
		$("#baseinfo").attr("src",url);
	}
</script>

</head>
<body>
<div class="titlebg">企业基本信息查询结果：</div>
	<div class="apptab" id="tableid">
        <ul>
        	<li class="apptabliover" onclick="tabHander(this,'<%=basePath%>search.action?tab=customer')">企业信息主表</li>
        	<%if(staffer) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=staffer')">企业人才实名表</li>
        	<%} %>
        	<%if(incubationRoute) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=incubationRoute')">企业孵化过程表</li>
        	<%} %>
        	<%if(customerQualification) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=customerQualification')">企业资质表</li>
        	<%} %>
        	<%if(customerVentureType) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=customerVentureType')">企业创业类型表</li>
        	<%} %>
        	<%if(contect) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=contect')">联系人表</li>
        	<%} %>
        	<%if(patent) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=patent')">专利表</li>
        	<%} %>
        	<%if(brand) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=brand')">商标表</li>
        	<%} %>
        	<%if(projectApply) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=projectApply')">项目产品表</li>
        	<%} %>
        	<%if(copyright) {%>
            <li class="apptabli" onclick="tabHander(this,'<%=basePath%>search.action?tab=copyright')">软件著作权表</li>
        	<%} %>
        </ul>
    </div>
    <iframe scrolling="no" id="baseinfo" name="baseinfo" frameborder="0" src="<%=basePath%>search.action?tab=customer" width="100%"></iframe>
</body>
</html>