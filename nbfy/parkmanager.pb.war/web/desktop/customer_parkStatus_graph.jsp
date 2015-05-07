<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.dto.StatisticDto"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
</head>
<body>
<div id="chartdiv9" style="color: #EEF0E3"></div>
<script language="JavaScript">					
	var chart1 = new FusionCharts("<%=BaseAction.rootLocation %>/core/common/FusionChartsFree/Charts/FCF_Pie2D.swf", "chart1Id", "200", "200", "0", "1");		   			
	var xml = "<graph shownames='1' showvalues='0' baseFontSize='12' >";
	xml += "<%
	Result<List<StatisticDto>> result = (Result<List<StatisticDto>>)request.getAttribute("result");
	List<StatisticDto> list = result.getValue();
	String[] colors = new String[]{"A6BE50","E48801","1A95D9"};
	for(int i = 0; i < list.size(); i++){
		out.print("<set name='"+list.get(i).getName()+"' value='"+list.get(i).getAmount()+"' color='"+colors[i]+"' />");
	}
	%>";
	xml += "</graph>";
	chart1.setDataXML(xml);
	chart1.render("chartdiv9");
</script>
</body>
</html>