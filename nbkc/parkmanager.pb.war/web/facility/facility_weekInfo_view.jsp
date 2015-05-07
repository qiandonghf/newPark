<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.wiiy.commons.util.*"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>web/style/ps.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/easyslider1.7/css/slider.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/easyslider1.7/js/easySlider1.7.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		jqGridResizeRegister("orderList","feeList");
		initView();
	});
	function cc(index){
		$("#li"+index).attr("taskactive");
	}
	
	function initView(){
		var initDay = $("#initDay").val();
		tabSwitch('tasklink','taskactive','tabswitch2',initDay);
	}
</script>
</head>

<body>
<div class="basediv">
<div class="divlays">
	<input type="hidden" value="${day}" id="initDay"/>
	 <div class="psresoutces">
		<div class="psresoutcestab" >
	    	<div class="psresoutcestableft"><img src="parkmanager.pb/web/images/resarrowleft.png" onclick="location.href='<%=basePath %>facility!facilityWeekInfo.action?index=${index+1}&id=${facilityId}&year=<fmt:formatDate value="${prevWeek}" pattern="yyyy-MM-dd HH:mm:ss"/>'" width="16" height="25" /></div>
	        <div class="psresoutcestabcenter">
	        	<div class="task_qiucknav">
					<ul>
						<c:forEach items="${weekDto.dateList}" var="date" varStatus="status">
							<li  <c:if test='${status.index ne day}'>class="tasklink"</c:if><c:if test='${status.index eq day}'>class="taskactive"</c:if>  id="li${status.index}" onclick="tabSwitch('tasklink','taskactive','tabswitch2',${status.index})">
								<!-- <span class="taskactive_arrow"></span> -->
								<a href="javascript:void(0)" style="outline: none;" onclick="cc(${status.index})" <c:if test='${status.index eq day}'>id="a${status.index}"</c:if> >
									<c:if test="${status.index==0}">星期一<em class="gray">(<fmt:formatDate value="${date}" pattern="MM-dd"/>)</em></c:if>
									<c:if test="${status.index==1}">星期二<em class="gray">(<fmt:formatDate value="${date}" pattern="MM-dd"/>)</em></c:if>
									<c:if test="${status.index==2}">星期三<em class="gray">(<fmt:formatDate value="${date}" pattern="MM-dd"/>)</em></c:if>
									<c:if test="${status.index==3}">星期四<em class="gray">(<fmt:formatDate value="${date}" pattern="MM-dd"/>)</em></c:if>
									<c:if test="${status.index==4}">星期五<em class="gray">(<fmt:formatDate value="${date}" pattern="MM-dd"/>)</em></c:if>
									<c:if test="${status.index==5}">星期六<em class="gray">(<fmt:formatDate value="${date}" pattern="MM-dd"/>)</em></c:if>
									<c:if test="${status.index==6}">星期天<em class="gray">(<fmt:formatDate value="${date}" pattern="MM-dd"/>)</em></c:if>
								</a>
							</li>
		                </c:forEach>
					</ul>
				</div>
	        </div>
	        <div class="psresoutcestabright"><img src="parkmanager.pb/web/images/resarrowright.png" onclick="location.href='<%=basePath %>facility!facilityWeekInfo.action?index=${index-1}&id=${facilityId}&year=<fmt:formatDate value="${nextWeek}" pattern="yyyy-MM-dd HH:mm:ss"/>'" width="16" height="25" /></div>
	    </div>
	    
	    <c:forEach items="${weekDto.facilityDtoList}" var="facilityDto" varStatus="status">
		    <div class="psresoutceslist tabswitch2" id="arrowView">
		    	<ul>
		    		<c:forEach items="${facilityDto.facilityOrderList}" var="facilityOrder">
		        	<li><tr><td>·<a href="javascript:void(0)">${facilityOrder.customer.name}</a></td><span><td>${facilityOrder.facility.name}申请 </td><td><fmt:formatDate value="${facilityOrder.startTime}" pattern="yyyy-MM-dd HH:mm"/> — <fmt:formatDate value="${facilityOrder.endTime}" pattern="yyyy-MM-dd HH:mm"/></td></span></tr></li>
		        	</c:forEach>
		        </ul>
		    </div>
	    </c:forEach>
	    
	</div>
</div>
</div>
</body>
</html>