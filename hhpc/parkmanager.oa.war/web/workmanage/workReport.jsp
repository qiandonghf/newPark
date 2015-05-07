<%@page import="com.wiiy.oa.preferences.enums.WorkReportStatusEnum"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.oa.entity.WorkReport"%>
<%@page import="com.wiiy.oa.dto.*"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ page import="com.wiiy.commons.util.*"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Integer st = 0;
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
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
<script src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript"> 
function vopen(url,name,w,h) {
	window.open(url,name,'height='+h+',width='+w+',top=100,left=150,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
}
$(document).ready(function(){
	$("#resizable").css("height",getTabContentHeight()-60);
	$("#week").css("height",getTabContentHeight()-30);
	initTip();
	<%
	Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
	boolean addDayReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_addDayReport");
	boolean editDayReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_editDayReport");
	boolean viewDayReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_viewDayReport");
	
	boolean addMonthReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_addMonthReport");
	boolean editMonthReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_editMonthReport");
	boolean viewMonthReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_viewMonthReport");
	
	boolean addWeekReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_addWeekReport");
	boolean editWeekReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_editWeekReport");
	boolean viewWeekReport = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_viewWeekReport");
	
	boolean workReportConfig = OaActivator.getHttpSessionService().isInResourceMap("oa_workReport_workReportConfig");
	%>
});

function warningWeek(){
	showTip("你已经对本周周报进行过操作",2000);
}

function warningMonth(){
	showTip("你已经对本月月报进行过操作",2000);
}

function setSelectedUsers(users){
	var ids = "";
	for(var i = 0; i < users.length; i++){
		ids += users[i].id+",";
	}
	ids = deleteLastCharWhenMatching(ids,",");
	$.post("<%=basePath%>workReportConfig!configReporter.action?ids="+ids,function(data){		
		showTip(data.result.msg,2000);
		//重新加载页面，获得workReportConfig表中的receiverId(workReportReceiverIds)
		setTimeout("location.reload();",1000);
	});
}
</script>
</head>
 
<body >
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
		<ul>
			<%if(addDayReport){%>		
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="javascript:vopen('<%=basePath %>workDayReport!addDayReport.action','days',800,600);"><span><img src="core/common/images/dayly.gif" title="写日报"/></span>写日报</li>
			<%} %>
			<%if(addWeekReport){%>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="javascript:vopen('<%=basePath %>workReport!addWeekReport.action','weeks',800,600);"><span><img src="core/common/images/weekly.png" title="写周报"/></span>写周报</li>
			<%} %>
			<%if(addMonthReport){%>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="javascript:vopen('<%=basePath %>workReport!addMonthReport.action','weeks',800,600);"><span><img src="core/common/images/month.png" title="写月报"/></span>写月报</li>
			<%} %>
			<%if(workReportConfig){%>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('设置报送人','<%=BaseAction.rootLocation %>/core/user!select2.action?ids='+'${workReportReceiverIds}',520,400);"><span><img src="core/common/images/set.png"/></span>设置报送人</li>		
			<%} %>
		</ul>
	</div>
	<!--//leftemail-->
</div>
<!--container-->
<div id="container">
 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="240" valign="top">
	   <div class="people">
	  	 <em><img src="core/common/images/dataviewleft.png" width="15" height="16" onclick="location.href='<%=basePath %>workReport!list.action?myYear=<fmt:formatDate value="${prevYear}" pattern="yyyy-MM-dd HH:mm:ss"/>'"/></em>
	  		<span>${year}年</span>
	  	 <em><img src="core/common/images/dataviewright.png"  onclick="location.href='<%=basePath %>workReport!list.action?myYear=<fmt:formatDate value="${nextYear}" pattern="yyyy-MM-dd HH:mm:ss"/>'"/></em>
	  	 <em><img src="core/common/images/dataviewleft.png" width="15" height="16" onclick="location.href='<%=basePath %>workReport!list.action?selectMonth=<fmt:formatDate value="${prevMonth}" pattern="yyyy-MM-dd HH:mm:ss"/>'"/></em>
	  		 <span>${myMonth}月</span>
	  	 <em><img src="core/common/images/dataviewright.png" width="15" height="16" onclick="location.href='<%=basePath %>workReport!list.action?selectMonth=<fmt:formatDate value="${nextMonth}" pattern="yyyy-MM-dd HH:mm:ss"/>'"/></em>
	  </div> 
	 <div class="oawork"  id="resizable">
        <!--merter_fee-->
	  	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<c:forEach items="${monthDtos}" var="monthDto">
				<tr>
				<c:set var="sVal"  value="0"/>
				<c:forEach items="${monthDto.weekList}" var="weekDto" varStatus="s">
					<c:set var="sVal"  value="${sVal+1}"/>
				</c:forEach>
					
					<td width="40" rowspan="${sVal+1}"   <c:if test="${monthDto.num==2}">class="crmcounttdlink"</c:if>  <c:if test="${monthDto.num!=2}">class="crmcounttd"</c:if>  onmouseover="$(this).find('span').css('display','block')" onmouseout="$(this).find('span').css('display','none')">
					<c:if test="${monthDto.num==2}">
						<a href="<%=basePath%>workReport!viewByMonth.action?myMonth=${monthDto.month}&curYear=${year}" target="week">${monthDto.month}月</a>
					</c:if>
					<c:if test="${monthDto.num!=2}">
						${monthDto.month}月
						<span style="display:none">
							<c:if test="${monthDto.num==0}">
								<%if(addMonthReport){%>
									&nbsp;<img onclick="javascript:vopen('<%=basePath %>workReport!addByMonth.action?myMonth=${monthDto.month}&curYear=${year}','weeks',800,600);"  src="core/common/images/workadd.png" />&nbsp;
								<%} %>
							</c:if>
							<c:if test="${monthDto.num==1}">
								<%if(editMonthReport){%>
									&nbsp;<img onclick="javascript:vopen('<%=basePath%>workReport!editByMonth.action?myMonth=${monthDto.month}&curYear=${year}','weeks',800,600);"  src="core/common/images/wrokedit.png" />
								<%} %>
							</c:if>
						</span>
					</c:if> 
					</td>
					
					
					<c:forEach items="${monthDto.weekList}" var="weekDto" varStatus="status">
						<tr>
							<td width="50"  <c:if test="${weekDto.num==2}">class="crmcounttdlink"</c:if>  <c:if test="${weekDto.num!=2}">class="crmcounttd"</c:if>  onmouseover="$(this).find('span').css('display','block')" onmouseout="$(this).find('span').css('display','none')">
								<c:if test="${weekDto.num==2}">
									<a href="<%=basePath %>workReport!viewByWeek.action?myWeek=${weekDto.week}&curYear=${year}" target="week">第${status.index+1}周</a>
								</c:if>
								<c:if test="${weekDto.num!=2}">第${status.index+1}周
									<span style="display:none">
										<c:if test="${weekDto.num==0}">
											<%if(addWeekReport){%>
												&nbsp;<img onclick="javascript:vopen('<%=basePath %>workReport!addByWeek.action?myWeek=${weekDto.week}&curYear=${year}','weeks',800,600);" src="core/common/images/workadd.png" />&nbsp;
											<%} %>
										</c:if>
										<c:if test="${weekDto.num==1}">
											<%if(editWeekReport){%>
												&nbsp;<img onclick="javascript:vopen('<%=basePath %>workReport!editByWeek.action?myWeek=${weekDto.week}&curYear=${year}','weeks',800,600);"  src="core/common/images/wrokedit.png" />
											<%} %>
										</c:if>
									</span>
								</c:if> 
							</td>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<c:forEach items="${weekDto.workDayDtoList}" var="dayDto" varStatus="status2">
													<fmt:formatDate value="${dayDto.date}" pattern="MM-dd" var="d"/>
													<fmt:formatDate value="${dayDto.date}" pattern="yyyy-MM-dd" var="d2"/>
											<tr>
												<td  <c:if test="${dayDto.num==2}">class="crmcounttdleftlink"</c:if>  <c:if test="${dayDto.num!=2}">class="crmcounttdleft"</c:if>  onmouseover="$(this).find('span').css('display','inline')" onmouseout="$(this).find('span').css('display','none')">
													<c:if test="${dayDto.num==2}">
														<a href="<%=basePath%>workDayReport!viewByDay.action?dateStr=${d2}" target="week">
														<em>周<c:if test="${status2.index==0}">一</c:if><c:if test="${status2.index==1}">二</c:if><c:if test="${status2.index==2}">三</c:if><c:if test="${status2.index==3}">四</c:if><c:if test="${status2.index==4}">五</c:if><c:if test="${status2.index==5}">六</c:if><c:if test="${status2.index==6}">日</c:if></em>
														${d}</a>
													</c:if>
													<c:if test="${dayDto.num!=2}">
														<em>周<c:if test="${status2.index==0}">一</c:if><c:if test="${status2.index==1}">二</c:if><c:if test="${status2.index==2}">三</c:if><c:if test="${status2.index==3}">四</c:if><c:if test="${status2.index==4}">五</c:if><c:if test="${status2.index==5}">六</c:if><c:if test="${status2.index==6}">日</c:if></em>
														${d}
														<span style="display:none">
															<c:if test="${dayDto.num==0}">
																<%if(addDayReport){%>
																	&nbsp;<img onclick="javascript:vopen('<%=basePath %>workDayReport!addDayReport.action?dateStr=${d2}','day',800,450);" src="core/common/images/workadd.png" />&nbsp;
																<%} %>
															</c:if>
															<c:if test="${dayDto.num==1}">
																<%if(editDayReport){%>
																	&nbsp;<img onclick="javascript:vopen('<%=basePath%>workDayReport!editDay.action?dateStr=${d2}','day',800,450);" src="core/common/images/wrokedit.png" />
																<%} %>
															</c:if>
														</span>
													</c:if>
												</td>
											</tr>
									</c:forEach>
								</table>
							</td>
						</tr>
					</c:forEach>
				</tr>
			</c:forEach> 
			
		</table>
	  </div>
 	  </td>
      <td valign="top">
      	<%if(viewDayReport){%>
	  		<iframe scrolling="auto" src="<%=basePath %>workDayReport!viewByDay.action" id="week" name="week" frameborder="0" width="100%"></iframe>
	  	<%} %>
	  </td>
    </tr>
  </table>
</div>
 <!--//container-->
</body>
</html>