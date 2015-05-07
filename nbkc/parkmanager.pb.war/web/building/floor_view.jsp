<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.pb.entity.Room"%>
<%@ page import="com.wiiy.pb.preferences.enums.RoomStatusEnum"%>
<%@page import="com.wiiy.pb.entity.Building"%>
<%@page import="com.wiiy.pb.entity.Floor"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="java.security.KeyStore.Builder"%>
<%@page import="com.wiiy.pb.dto.BuildingDto"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
double minPx = 45d;
double maxPx = 112d;
Result<BuildingDto> result = (Result<BuildingDto>)request.getAttribute("result");
Building building = result.getValue().getBuilding();
double min = 50d;
if(building.getMinArea()!=null) min = building.getMinArea();
double max = 3000d;
if(building.getMaxArea()!=null) max = building.getMaxArea();
double rate = (maxPx-minPx)/(max-min);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery.treeview.css"/>

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	$(function(){
		$("#pm_msglist").height(getTabContentHeight()-60);
	});
	function roomView(id){
		fbStart('查看房间信息','<%=basePath%>room!info.action?id='+id,800,510);
	}
</script>
</head>
<body>

<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" valign="top">
				<div class="titlebg">楼层信息</div>
				<div class="apptab" id="tableid">
					<ul>
						<li class="apptabli"><a href="<%=basePath%>building!view.action?id=${result.value.building.id}">基本信息</a></li>
						<li class="apptabliover" ><a href="<%=basePath%>floor!floorView.action?id=${result.value.building.id}">楼层视图</a></li>
						<li class="apptabli" ><a href="<%=basePath%>room!listByBuildingId.action?id=${result.value.building.id}">房间信息</a></li>
					</ul>
				</div>
				<div class="pm_msglist" id="pm_msglist" style="overflow-y: auto;">
					<div class="emailtop">
						<div class="leftemail">
							<ul>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_building_editFloorView")){%>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('编辑楼层','<%=basePath%>floor!listByBuildingId.action?id=${result.value.building.id}',800,450);"><span><img src="core/common/images/edit.gif"/></span>编辑</li>
							<%} %>
							</ul>
						</div>
					</div>
					<div id="displaylayer">
						<div class="parkico">
							<ul>
								<li><span><img src="core/common/images/parkico1.gif" width="12" height="12" /></span>空闲</li>
								<li><span><img src="core/common/images/parkico4.gif" width="12" height="12" /></span>预定</li>
								<li><span><img src="core/common/images/parkico3.gif" width="12" height="12" /></span>装修</li>
								<li><span><img src="core/common/images/parkico5.gif" width="12" height="12" /></span>使用</li>
							</ul>
						</div>
						<div class="parklist">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<c:forEach items="${result.value.floorDtoList}" var="floorDto">
								<tr>
									<td width="50" class="parkname">${floorDto.floor.name}</td>
									<td class="parkroom">
										<c:forEach items="${floorDto.roomList}" var="room">
										<%
											Room room = (Room)pageContext.getAttribute("room");
											Double width = 0d;
											if(room.getBuildingArea()==null || room.getBuildingArea().intValue()<min)
												width = minPx*2.6;
											else if(room.getBuildingArea().intValue()>max )
												width = 150d;
											else if( building.getMinArea()==null || building.getMaxArea()==null)
												width = minPx*2.6;
											else {
												double area = room.getBuildingArea().doubleValue();
												width = (minPx+(area-min)*rate)*1.3;
											}
										%>
										<div onclick="roomView(${room.id})"
											class="<%if(room.getStatus().equals(RoomStatusEnum.IDLE)){ if(room.getBuildingArea().intValue()<max){out.print("vacancy");}else{out.print("vacancy_overflow");}}
												else if(room.getStatus().equals(RoomStatusEnum.USING)){ if(room.getBuildingArea().intValue()<max){out.print("apply");}else{out.print("apply_overflow");}}
												else if(room.getStatus().equals(RoomStatusEnum.BOOK)){ if(room.getBuildingArea().intValue()<max){out.print("preordain");}else{out.print("preordain_overflow");}}
												else if(room.getStatus().equals(RoomStatusEnum.FITMENT)){ if(room.getBuildingArea().intValue()<max){out.print("busy");}else{out.print("busy_overflow");}}%>" 
											style="cursor:pointer; width:<%=width %>px;"
										>
											<c:if test="${fn:length(room.name)<5 }">${room.name}</c:if>
											<c:if test="${fn:length(room.name)>5 }">${fn:substring(room.name,0,5)}...</c:if>
										</div>
										</c:forEach>
										&nbsp;
									</td>
								</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<div class="hackbox"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
