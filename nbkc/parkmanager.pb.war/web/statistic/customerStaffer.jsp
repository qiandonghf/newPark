<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.dto.StatisticDto"%>
<%@page import="com.wiiy.crm.dto.StatisticGroupDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
		<script type="text/javascript" src="core/common/FusionChartsFree/Code/DOM/js/FusionChartsDOM.js"></script>
		<script src="core/common/js/jquery.js"></script>
		<script src="core/common/js/jquery-ui.min.js"></script>
		<script>
			$(document).ready(function() {
				//$("#resizable").resizable();
				$("#resizable").css("height",getTabContentHeight());
				$("#pm_msglist").css("height",getTabContentHeight()-30);
			});
		</script>
	</head>

	<body>
		<div id="container">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="182" valign="top">
						<div class="agency" id="resizable" >
							<div class="titlebg">统计分类</div>
							<jsp:include page="statistic_left.jsp">
								<jsp:param value="8" name="index"/>
							</jsp:include>
						</div>
					</td>
					<td width="100%" valign="top">
						<div class="titlebg">企业从业人员情况表</div>
						<div class="pm_msglist" id="pm_msglist" style="overflow-y:auto; overflow-x:hidden;border:0px solid;">
							<table width="100%" border="0" cellspacing="0" cellpadding="10">
								<tr>
									<td style="padding-bottom:10px; padding-top:10px;">
										<div id="chart1div"></div>
										<script language="JavaScript">					
											var chart1 = new FusionCharts("<%=BaseAction.rootLocation %>/core/common/FusionChartsFree/Charts/FCF_Column2D.swf", "chart1Id", "600", "400", "0", "1");		   			
											var xml = "<graph decimalPrecision='0' showNames='1' showValues='0' baseFontSize='12'><%
											Result<List<StatisticDto>> result = (Result<List<StatisticDto>>)request.getAttribute("result");
											List<StatisticDto> list = result.getValue();
											String[] colors = new String[]{"C4E647","FFA600","F56908","F8F605","FBCE03","0490E5","0FCD11","D80DE5","005E9B","A5BD4F","FE0000","659303","F0A5B1","1A4EEC"};
											for(int i = 0; i < list.size(); i++){
												out.print("<set name='"+list.get(i).getName()+"' value='"+list.get(i).getiValue()+"' color='"+colors[i%colors.length]+"' />");
											}
											%></graph>";
											chart1.setDataXML(xml);
											chart1.render("chart1div");
										</script>
									</td>
								</tr>
								<tr>
									<td>
										<div style="width:400px; margin-left:42px; margin-bottom:30px;">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" class="crmtable">
												<tr onmouseout="this.style.background='#fff'" onmouseover="this.style.background='#f4f4f4'">
													<td class="tdcenter" width="20%">年度</td>
													<td width="35%" class="tdcenter">企业数</td>
													<td width="35%" class="tdcenter">从业人员数</td>
												</tr>
												<c:forEach items="${result.value}" var="dto">
												<tr onmouseout="this.style.background='#fff'" onmouseover="this.style.background='#f4f4f4'">
													<td class="crmcounttd">${dto.name}</td>
													<td class="crmcounttd">${dto.amount}</td>
													<td class="crmcounttd">${dto.iValue}</td>
												</tr>
												</c:forEach>
											</table>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
