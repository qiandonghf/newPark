<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.pb.preferences.enums.RoomStatusEnum"%>
<%@page import="com.wiiy.crm.dto.StatisticGroupDto"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.pb.dto.BuildingPandectDto"%>
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
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			initTip();
			//$("#resizable").resizable();
			$("#resizable").css("height",getTabContentHeight());
			var h = $(".titlebg").height();
			$("#container").css("height",getTabContentHeight()-h);
			$("#pm_msglist").css("height",getTabContentHeight()-h);
		});
		
		function detail(id){
			addTab(parent,'置空单元','<%=basePath%>web/building/building_roomIdle_list.jsp?id='+id);
		}
		
	</script>
</head>

<body>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
        	<td width="182" valign="top">
				<div class="agency" id="resizable">
					<div class="titlebg">统计类型</div>
					<jsp:include page="building_statistic_left.jsp">
							<jsp:param value="1" name="index"/>
					</jsp:include>
				</div>		
			</td>
			<td width="100%" valign="top">
			<div id="container" style="OVERFLOW-Y: auto; OVERFLOW-X: auto; WIDTH: 100%; HEIGHT: 100%">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td width="100%" valign="top">
						<div class="titlebg">出租率统计</div>
						<div class="" id="pm_msglist" style="border-top:none;">
							<table width="100%" border="0" cellspacing="0" cellpadding="10">
								<tr>
									<td align="center">
										<div id="chartdiv10"></div>
										<script language="JavaScript">					
										var chart1 = new FusionCharts("<%=BaseAction.rootLocation %>/core/common/FusionChartsFree/Charts/FCF_StackedColumn2D.swf", "ChartId", "700", "180");		   			
										var xml = "<graph yAxisMinValue='0' yAxisMaxValue='30000' shownames='1' showvalues='0' baseFontSize='12' decimalPrecision='2' limitsDecimalPrecision='0' divLineDecimalPrecision='0' showAlternateHGridColor='1' alternateHGridColor='EBEDE1' divlinecolor='C4C5BD'>";
										xml += "<%
										Result<List<StatisticGroupDto>> result = (Result<List<StatisticGroupDto>>)request.getAttribute("result");
										List<StatisticGroupDto> groupList = result.getValue();
										out.print("<categories>");
										for(int i = 0; i < groupList.size(); i++){
											out.print("<category name='"+groupList.get(i).getName()+"'/>");
										}
										out.print("</categories>");
										String[] colors = new String[]{"08A900","9932CC","FF8C00","D30000"};
										for(RoomStatusEnum status : RoomStatusEnum.values()){
											out.print("<dataset seriesName='"+status.getTitle()+"' color='"+colors[status.ordinal()]+"'>");
											int count = 0;
											for(int j = 0; j < groupList.size(); j++){
												for(int k = 0; k < groupList.get(j).getList().size(); k++){
													if(groupList.get(j).getList().get(k).getName().equals(status.getTitle())){
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
										chart1.render("chartdiv10");
										</script>
										
									</td>
								</tr>
								<tr>
									<td align="center">
										<div class="pm_msglist" style="width:800px;">
											<table width="100%" border="0" cellspacing="0" cellpadding="10">
												<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'" style="width: 800px;">
													<td class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">楼宇</td>
													<td class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">可出租面积</td>
													<td class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">已出租面积</td>
													<td class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">出租率</td>
													<td class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">查看空闲房间</td>
												</tr>
												<c:forEach items="${buildingPandectList}" var="dto">
												<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
													<td class="centertd">${dto.buildingName}</td>
													<c:if test="${dto.rentArea==null}">
														<td class="centertd">0</td>
													</c:if>
													<c:if test="${dto.rentArea!=null}">
														<td class="centertd">${dto.rentArea}</td>
													</c:if>
													<c:if test="${dto.rentedArea==null}">
														<td class="centertd">0</td>
													</c:if>
													<c:if test="${dto.rentedArea!=null}">
														<td class="centertd">${dto.rentedArea}</td>
													</c:if>
													<td class="centertd">${dto.occupancy}</td>
													<td class="centertd"><a href="javascript:void(0)" onclick="detail(${dto.id})">明细</a></td>
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
			</td>
		</tr>
	</table>
</div>
</body>
</html>
