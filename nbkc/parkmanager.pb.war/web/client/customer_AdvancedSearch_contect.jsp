<%@page import="com.wiiy.crm.entity.Contect"%>
<%@page import="com.wiiy.crm.entity.Brand"%>
<%@page import="com.wiiy.crm.entity.Staffer"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.crm.entity.IncubationInfo"%>
<%@page import="com.wiiy.crm.entity.CustomerInfo"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.crm.dto.CustomerSearchResultDto"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
List<String> propertyList = (List<String>)session.getAttribute("propertys");
boolean contect_position = propertyList.contains("contect.position");
boolean contect_name = propertyList.contains("contect.name");
boolean contect_phone = propertyList.contains("contect.phone");
boolean contect_mobile = propertyList.contains("contect.mobile");
boolean contect_email = propertyList.contains("contect.email");
boolean contect_qq = propertyList.contains("contect.qq");

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
		$("#overflowAuto").height(getTabContentHeight()-60);
	});
	function jumpPage(page){
		var url = "<%=basePath%>search.action";
		url += "?page="+page;
		url += "&tab=${tab}";
		location.href=url;
	}
</script>
</head>
<body>
	<div class="pm_msglist" id="msglist">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" class="" onclick="location.href='<%=basePath%>search!export.action'"><span><img src="core/common/images/xls_min.png"></span>导出</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" class="" onclick="parent.location.href='<%=basePath%>search!before.action'"><span><img src="core/common/images/back.png"></span>返回</li>
				</ul>
			</div>
		</div>
		<div class="overflowAuto" id="overflowAuto" style="overflow-x:auto;overflow-y:auto">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1" style="white-space:nowrap; table-layout:auto;">
			<colgroup>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr class="table_titlebgcolor" style="font-weight:bold;">
					<%
						out.println("<th scope='col'>企业编号</th>");
						out.println("<th scope='col'>企业名称</th>");
						
						if(contect_position) out.println("<th scope='col'>职位</th>");
						if(contect_name) out.println("<th scope='col'>姓名</th>");
						if(contect_phone) out.println("<th scope='col'>电话</th>");
						if(contect_mobile) out.println("<th scope='col'>手机</th>");
						if(contect_email) out.println("<th scope='col'>Email</th>");
						if(contect_qq) out.println("<th scope='col'>QQ</th>");
						
					%>
				</tr>
			</thead>
			<tbody>
				<%
				Result<List<Contect>> result = (Result<List<Contect>>)request.getAttribute("result");
				List<Contect> list = result.getValue();
				if(list!=null)
				for(Contect contect : list){
					
					out.println("<tr>");
					
					out.println("<td>"+contect.getCustomer().getCode()+"</td>");
					out.println("<td>"+contect.getCustomer().getName()+"</td>");
					
					if(contect_position){if(contect!=null && contect.getPosition()!=null) out.println("<td>"+contect.getPosition()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(contect_name){if(contect!=null && contect.getName()!=null) out.println("<td>"+contect.getName()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(contect_phone){if(contect!=null && contect.getPhone()!=null) out.println("<td>"+contect.getPhone()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(contect_mobile){if(contect!=null && contect.getMobile()!=null) out.println("<td>"+contect.getMobile()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(contect_email){if(contect!=null && contect.getEmail()!=null) out.println("<td>"+contect.getEmail()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(contect_qq){if(contect!=null && contect.getQq()!=null) out.println("<td>"+contect.getQq()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					out.println("</tr>");
				}
				%>
			</tbody>    
		</table>
	</div>
	<jsp:include page="../pager.jsp" />
</div>
</body>
</html>
