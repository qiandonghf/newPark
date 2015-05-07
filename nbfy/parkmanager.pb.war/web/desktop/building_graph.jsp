<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.core.entity.DataDict"%>
<%@page import="com.wiiy.crm.dto.StatisticGroupDto"%>
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
<div id="chartdiv11"></div>
<script language="JavaScript">					
	var chart1 = new FusionCharts("<%=BaseAction.rootLocation %>/core/common/FusionChartsFree/Charts/FCF_StackedColumn2D.swf", "ChartId", "${width-20}", "180");		   			
	var xml = "<graph yAxisMinValue='0' yAxisMaxValue='30000' showNames='1' showValues='0' baseFontSize='12' decimalPrecision='2' limitsDecimalPrecision='0' divLineDecimalPrecision='0' showAlternateHGridColor='1' alternateHGridColor='EBEDE1' divlinecolor='C4C5BD'>";
	xml += "<%
	Result<List<StatisticGroupDto>> result = (Result<List<StatisticGroupDto>>)request.getAttribute("result");
	List<StatisticGroupDto> groupList = result.getValue();
	out.print("<categories>");
	for(int i = 0; i < groupList.size(); i++){
		out.print("<category name='"+groupList.get(i).getName()+"'/>");
	}
	out.print("</categories>");
	String[] colors = new String[]{"FF3803","F4EB00","0078FF","08A900","535353"};
	List<DataDict> dataDictList = (List<DataDict>) request.getAttribute("dataDictList");
	for(int i = 0; i < dataDictList.size(); i++){
		out.print("<dataset seriesName='"+dataDictList.get(i).getDataValue()+"' color='"+colors[i]+"'>");
		int count = 0;
		for(int j = 0; j < groupList.size(); j++){
			for(int k = 0; k < groupList.get(j).getList().size(); k++){
				if(groupList.get(j).getList().get(k).getName().equals(dataDictList.get(i).getDataValue())){
					out.print("<set value='"+groupList.get(j).getList().get(k).getdValue()+"'/>");
					count++;
				}
			}
		}
		for(int j = 0; j < groupList.size()-count; j++){
			out.print("<set value='0'/>");
		}
		out.print("</dataset>");
	}
	%>";
	xml += "</graph>";
	chart1.setDataXML(xml);
	chart1.render("chartdiv11");
</script>
</body>
</html>