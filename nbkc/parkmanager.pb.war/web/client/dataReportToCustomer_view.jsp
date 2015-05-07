<%@page import="com.wiiy.crm.entity.DataTemplate"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.dto.DataPropertyDto"%>
<%@page import="com.wiiy.crm.entity.DataReportValue"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.crm.entity.DataReportProperty"%>
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
<title>报表查看</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<style>
body{font-size: 12px;font-family: tahoma,Helvetica, Arial, sans-serif,simsun;}
</style>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	loadReportByGroupId("${result.value.report.groupId}");
	
	function loadReportByGroupId(id){
		if(id != ''){
			var url = "<%=basePath%>dataReport!loadReport.action?id="+id;
			$.post(url,function(data){
				var monthList = $("#monthList");
				monthList.empty();
				var option = "<option value=''>----请选择----</option>";
				for(var i = 0; i < data.length; i++){
					if(data[i].templateId==1){
						var id = data[i].id;
						var name = data[i].name;
						option += "<option value='"+id+"'>"+name+"</option>";
					}
				}
				monthList.append(option);
			});
		}
	}
	
	function changeMonth(){
		var id = $("#monthList").val();
		var customerId = ${result.value.customerId};
		if(id!=null && id!=''){
			location.href = '<%=basePath%>dataReportToCustomer!view.action?reportId='+id+'&customerId='+customerId;
		}
	}
</script>
</head>

<body style="background: white;">
<center>
<div class="basediv" style='width:720px;border: 0'>
<div style="height:36px; font: bold 16px/36px ''; text-align:center;">
	<strong style="padding-left: 50px;">
		${result.value.report.group.name}-${result.value.report.name}
	</strong>
</div>
<div style="text-align:left;">
	<table border=0 width=720 align=center>
         <tbody>
           <tr>
             <td align=left>${result.value.customer.name}</td>
             <td align=right>
             	<select id="monthList" onchange="changeMonth()">
					<option value="">----请选择----</option>
				</select>
			</td>
           </tr>
         </tbody>
    </table>
</div>
<div>
	<%
		DataTemplate dataTemplate = (DataTemplate)request.getAttribute("dataTemplate");
		List<DataReportProperty> propertyList = (List<DataReportProperty>)request.getAttribute("propertyList");
		Map<Long, DataReportValue> valueMap = (Map<Long, DataReportValue>)request.getAttribute("dataReportValueMap");
		if(dataTemplate!=null){
			out.println(dataTemplate.getFormat().format(propertyList, valueMap));
		}else{%>
		<span>本月份并没有给该企业发布报表，所以没有数据显示</span>
	<%}%>
</div>
</div>
</center>
</body>
</html>
