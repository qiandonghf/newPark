<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.oa.entity.WorkReport"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ page import="com.wiiy.oa.preferences.enums.*"%>
<%@ page import="com.wiiy.oa.dto.*"%>
<%@ page import="com.wiiy.commons.util.*"%>
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
 $(document).ready(function(){
	$("#container").css("height",getTabContentHeight());
	$(".emailtop").css("width",$(".oacount").width());
	<%
	Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
	boolean dayReport = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_viewDayReportCollectList");
	boolean weekReport = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_viewWeekReportList");
	boolean monthReport = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_viewMonthReportList");
	%>
});
 
 function vopen(url,name,w,h) {
 	window.open(url,name,'height='+h+',width='+w+',top=100,left=150,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
 }
 
 function exportDate(){
	 fbStart('导出','<%=basePath %>workReport!selectPersonReport.action',380,240);
 }
</script>
</head>
<body>

<!--container-->
<div id="container" style="overflow:auto;">
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<%if(dayReport){%>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="location.href='<%=basePath %>workDayReport!dayCountList.action'"><span><img src="core/common/images/daylycount.gif" /></span>日报</li>
			<%} %>
			<%if(weekReport){%>
			<li style="background-color:#D2E6FF" onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="location.href='<%=basePath %>workReport!workCountList.action'"><span><img src="core/common/images/weeklycount.png" /></span>周报</li>
			<%} %>
			<%if(monthReport){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" 	onclick="location.href='<%=basePath %>workReport!workMonthCountList.action'"><span><img src="core/common/images/monthcount.png" /></span>月报</li>
			<%} %>
			<!-- <li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li> -->
		</ul>
	</div>
</div>

  <table border="0" width="1800" cellspacing="0" cellpadding="0" class="oacount">
      <tr>
    	<td colspan="13" align="center" class="workcountth">
    		<em style="position:relative; top:3px; padding-right:5px;">
    			<img src="core/common/images/dataviewleft.png" width="15" height="16" onclick="location.href='<%=basePath %>workReport!workCountList.action?myYear=<fmt:formatDate value="${prevYear}" pattern="yyyy-MM-dd HH:mm:ss"/>'"/>
    		</em>${year}年<em style="position:relative; top:3px; padding-left:5px;">
    			<img src="core/common/images/dataviewright.png" onclick="location.href='<%=basePath %>workReport!workCountList.action?myYear=<fmt:formatDate value="${nextYear}" pattern="yyyy-MM-dd HH:mm:ss"/>'"/>
    		</em>
    	</td>
      </tr>
    <tr>
	 <td width="65" class="workcountth">&nbsp;</td>
		<c:forEach items="${monthDtoList}" var="monthDto">
	      <td width="180" class="workcountth">${monthDto.month}月</td>
   		</c:forEach>
    </tr>
    <tr>
   	<td width="65" class="workcounttd">&nbsp;</td>
      <c:forEach items="${monthDtoList}" var="monthDto">
      <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
      	<c:forEach items="${monthDto.weekList}" var="weekDto">
          <td width="30" class="workcounttd">${weekDto.week}周</td>
	      </c:forEach>
        </tr>
      </table></td>
      </c:forEach>
    </tr>
    
    <c:forEach items="${workCountDtoList}" var="workCountDto">
    <tr>
      <td class="workcounttd"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="64">${workCountDto.username}</td>
        </tr>
      </table></td>
      <c:forEach items="${workCountDto.monthDtoList}" var="monthDto">
      <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<c:forEach items="${monthDto.weekList}" var="weekDto">
        	 <%	
        		WeekDto weekDto = (WeekDto)pageContext.getAttribute("weekDto");
		 		Integer sum = weekDto.getNum();
		 		if(sum == 2){
		 	%>
		 		<td class="workcounttd"><img src="core/common/images/rightgreen.png" width="7" height="7" onclick="javascript:vopen('<%=basePath %>workReport!viewByWeek.action?myWeek=${weekDto.week}&curYear=${year}&id=${workCountDto.id}','weeks',800,600);"/></td>
		 	<%}else if(sum == 1){ %>
		 		<td class="workcounttd"><a onclick="javascript:vopen('<%=basePath %>workReport!viewByWeek.action?myWeek=${weekDto.week}&curYear=${year}&id=${workCountDto.id}','weeks',800,600);">${day}+</a>   </td>
		 	<%}else if(sum == 0){ %>
	   			<td class="workcounttd">&nbsp;</td>
	   		<%} %>  
          	</c:forEach>
        </tr>
      </table></td>
      </c:forEach>
    </tr>
    </c:forEach>
  </table>
</div>
 <!--//container-->
</body>

</html>
