<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.dto.DayDto"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script>
	  $(document).ready(function() {
		 	//$("#resizable").resizable();
	  		$("#resizable").css("height",getTabContentHeight());
	  		$("#merters").css("height",getTabContentHeight()-30);
	  });
	<%
		Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
		boolean add = OaActivator.getHttpSessionService().isInResourceMap("oa_manager_addManager");
		boolean edit = OaActivator.getHttpSessionService().isInResourceMap("oa_manager_edit");
		boolean delete = OaActivator.getHttpSessionService().isInResourceMap("oa_manager_del");
		boolean view = OaActivator.getHttpSessionService().isInResourceMap("oa_manager_view");
		boolean calendar = OaActivator.getHttpSessionService().isInResourceMap("oa_manager_calendar");
		boolean remind = OaActivator.getHttpSessionService().isInResourceMap("oa_manager_remind");
	%>
</script>

</head>

<body>
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<%if(add){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建日程','<%=basePath %>web/workmanage/schedule_add.jsp?scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>',550,313);" ><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
			<%} %>
			<%if(calendar){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.href='<%=basePath %>schedule!list.action'"><span><img src="core/common/images/viewdata.gif"/></span>日历</li>
			<%} %>
			<%if(remind){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.href='<%=basePath %>schedule!remind.action?scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>'"><span><img src="core/common/images/remind.png"/></span>提醒</li>
			<%} %>
		</ul>
	</div>
</div>
<div class="Schedule">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="300" valign="top" >
	  	<div class="leftdiv" id="resizable">
	  			<div class="day_info">
					<div class="day_num"><fmt:formatDate value="${scheduledDay}" pattern="d"/></div>
					<div><fmt:formatDate value="${scheduledDay }" pattern="yyyy年MM月dd日 E"/></div>
				</div>
				<div class="day_calendar">
					<div class="day_calendar_subject">
					<span class="dayleft" onmouseover="this.className='dayleftover'" onmouseout="this.className='dayleft'" onclick="location.href='<%=basePath %>schedule!list.action?monthAction=prev&scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>'"></span>
					<span class="dayright" onmouseover="this.className='dayrightover'" onmouseout="this.className='dayright'" onclick="location.href='<%=basePath %>schedule!list.action?monthAction=next&scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>'"></span>
						<fmt:formatDate value="${scheduledDay }" pattern="yyyy年M月"/>
					</div>
					<table width="100%" class="daytable" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="dayth">一</td>
							<td class="dayth">二</td>
							<td class="dayth">三</td>
							<td class="dayth">四</td>
							<td class="dayth">五</td>
							<td class="dayth">六</td>
							<td class="dayth">日</td>
						</tr>
						<c:forEach begin="0" end="5" var="s">
						<tr>
							<c:forEach items="${result.value}" begin="${s*7}" end="${s*7+6}" var="date">
								<td class="daytd<c:if test="${date.checkedDay eq true && date.nowDate eq true}">_blue</c:if><c:if test="${date.checkedDay eq true && date.nowDate eq false}">_blue</c:if><c:if test="${date.checkedDay eq false && date.nowDate eq true}">_graybg</c:if><c:if test="${date.schedules ne null}">_active</c:if><c:if test="${date.thisMonth eq false}"> daytdgray</c:if>">
								<a href="javascript:void(0)" onclick="location.href='<%=basePath %>schedule!list.action?scheduledDay=<fmt:formatDate value="${date.date}" pattern="yyyy-MM-dd"/>'">${date.day}</a>
								</td>
							</c:forEach>
						</tr>
				  		</c:forEach>
					</table>
				</div>
		</div>
		</td>
      <td valign="top">
	  <div id="merters" style=" overflow-x:hidden; overflow-y:auto">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  	<c:forEach items="${result.value}" var="dayDto">
	  		<c:if test="${dayDto.thisWeek}">
	  			<c:if test="${dayDto.schedules ne null && dayDto.checkedDay eq false}">
		  			<tr>
			  			<td class="day_title"><fmt:formatDate value="${dayDto.date}" pattern="yyyy年MM月dd E"/></td>
			  		</tr>
	  			</c:if>
	  			<c:if test="${dayDto.schedules eq null && dayDto.checkedDay eq true}">
		  			<tr>
			  			<td class="day_title day_detail_curr"><fmt:formatDate value="${dayDto.date}" pattern="yyyy年MM月dd E"/></td>
			  		</tr>
	  			</c:if>
	  			<c:if test="${dayDto.schedules ne null && dayDto.checkedDay eq true}">
		  			<tr>
			  			<td class="day_title day_detail_curr"><fmt:formatDate value="${dayDto.date}" pattern="yyyy年MM月dd E"/></td>
			  		</tr>
	  			</c:if>
		  		<c:forEach items="${dayDto.schedules}" var="schedule">
		  			<tr>
			  			<c:if test="${schedule.wholeDay eq 'YES'}">
			  				<td class="day_td<c:if test="${dayDto.checkedDay eq true}">_yellow day_detail_curr</c:if>" onclick="fbStart('编辑日程','<%=basePath %>schedule!edit.action?id=${schedule.id}',550,337);"><span>
			  				<c:if test="${schedule.repeatType ne 'NOREPEAT'}">${schedule.repeatType.title}</c:if>
			  				<c:if test="${schedule.repeatType eq 'NOREPEAT'}">全天</c:if>
			  				
			  				</span>${schedule.title}</td>
			  			</c:if>
			  			<c:if test="${schedule.wholeDay eq 'NO'}">
			  				<td class="day_td<c:if test="${dayDto.checkedDay eq true}">_yellow day_detail_curr</c:if>" onclick="fbStart('编辑日程','<%=basePath %>schedule!edit.action?id=${schedule.id}',550,337);"><span>
			  					<c:if test="${schedule.repeatType ne 'NOREPEAT'}">${schedule.repeatType.title}</c:if>
			  					<fmt:formatDate value="${schedule.startTime }" pattern="HH:mm"/>
			  					<c:if test="${schedule.endTime ne null}">- <fmt:formatDate value="${schedule.endTime }" pattern="HH:mm"/></c:if>
			  				</span>${schedule.title}</td>
			  			</c:if>
			  			<c:if test="${schedule.wholeDay eq null}">
			  				<c:if test="${schedule.repeatType ne 'NOREPEAT'}">${schedule.repeatType.title}</c:if>
			  				<td class="day_td<c:if test="${dayDto.checkedDay eq true}">_yellow day_detail_curr</c:if>" onclick="fbStart('编辑日程','<%=basePath %>schedule!edit.action?id=${schedule.id}',550,337);"><span><fmt:formatDate value="${schedule.startTime }" pattern="HH:mm"/></span>${schedule.title}</td>
			  			</c:if>
			  		</tr>
		  		</c:forEach>
	  			<c:if test="${dayDto.checkedDay eq true}">
			  		<tr>
			  			<%if(add){%>
			          		<td class="day_td_gray day_detail_curr"><a href="javascript:void(0)" onclick="fbStart('新建日程','<%=basePath %>web/workmanage/schedule_add.jsp?scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>',550,313);" >新建日程...</a></td>
			        	<%} %>
			        </tr>
		  		</c:if>
	  		</c:if>
	  	</c:forEach>
      </table>
	  </div>
	  </td>
    </tr>
  </table>
  <blockquote>&nbsp;</blockquote>
</div>
</body>
</html>
