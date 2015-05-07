<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.oa.preferences.enums.*"%>
<%@ page import="com.wiiy.oa.dto.*"%>
<%@ page import="com.wiiy.commons.util.*"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page import="com.wiiy.oa.entity.UserSign"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
	$("#container").css("height",getTabContentHeight());
	$(".emailtop").width($(".oacount").width());
});
 
 function vopen(url,name,w,h) {
 	window.open(url,name,'height='+h+',width='+w+',top=100,left=150,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
 }
</script>
</head>
<body>
<!--container-->
<div id="container" style="overflow:auto;">
<div class="emailtop"></div>
  <table border="0"  cellspacing="0" cellpadding="0" class="oacount">
    <tr>
    	<td colspan="73" align="center" class="workcountth"><em style="position:relative; top:3px; padding-right:5px;">
	    	<img src="core/common/images/dataviewleft.png" width="15" height="16" onclick="location.href='<%=basePath %>userSign!viewSignInfo.action?myYearMonth=<fmt:formatDate value="${preYearMonth}" pattern="yyyy-MM-dd HH:mm:ss"/>'"/>
	    		</em>
		    		${year}年${month}月
	    		<em style="position:relative; top:3px; padding-left:5px;">
	    	<img src="core/common/images/dataviewright.png" onclick="location.href='<%=basePath %>userSign!viewSignInfo.action?myYearMonth=<fmt:formatDate value="${nextYearMonth}" pattern="yyyy-MM-dd HH:mm:ss"/>'"/>
    	</em></td>
   	</tr>
    <tr>
	  <td width="65" class="workcountth">&nbsp;</td>
	  	<c:forEach items="${monthDtoList}" var="monthDto">
	  		  <c:if test="${monthDto.month eq month}">
				  <c:forEach items="${monthDto.dayDtoList}" var="dayDto">
		      			<td class="workcountth">${dayDto.daySign}号</td>
		      	  </c:forEach>
	      	  </c:if>
	  	</c:forEach>
       	<td width="100%" class="workcountth">汇总</td>
    </tr>
    <tr>
	 <td width="65" class="workcounttd">&nbsp;</td>
 		<c:forEach items="${monthDtoList}" var="monthDto">
		  <c:if test="${monthDto.month eq month}">
	  		<c:forEach items="${monthDto.dayDtoList}" var="dayDto">
		      <td valign="top">
		      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
			       <td width="40" class="workcounttd">签到</td>
		           <td width="40" class="workcounttd">签退</td>
		        </tr>
		      </table>
		      </td>
     	 </c:forEach>
        </c:if>
      </c:forEach>
      <td valign="top">
      	 <table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
          		<td width="60" class="workcounttd">正常签到</td>
          		<td width="60" class="workcounttd">正常签退</td>
          		<td width="60" class="workcounttd">迟到次数</td>
          		<td width="60" class="workcounttd">早退次数</td>
          	</tr>
      	</table>
      </td>
      
    </tr>
    <c:forEach items="${signCountDtoList}" var="signCountDto">
	    <tr>
	      <td class="workcounttd">
		      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		          <td width="64">${signCountDto.username}</td>
		        </tr>
		      </table>
	      </td>
	      
	      <c:forEach items="${signCountDto.monthDtoList}" var="monthDto">
	      	  <c:forEach items="${monthDto.dayDtoList}" var="dayDto">
		      <td valign="top">
		      <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
		        <tr>
		        
		          <td width="40" class="workcounttd">
          			<%
          				DayDto dayDto = (DayDto)pageContext.getAttribute("dayDto");
	          			int normalSignInNum = dayDto.getNormalSignInNum();//签到情况正常数
						int lateSignInNum = dayDto.getLateSignInNum();//签到情况迟到数
						int normalSignOutNum = dayDto.getNormalSignOutNum();//签退情况正常数
						int leaveEarlyNum = dayDto.getLeaveEarlyNum();//签退情况早退数
          			%>
          			<%if(normalSignInNum==0&&lateSignInNum==0){%>
          				&nbsp;
          			<%}%>
          			<%if(normalSignInNum>0){%>
          				<%for(int i=0;i<normalSignInNum;i++){%>
          					<img src="parkmanager.oa/web/images/greentips.png" width="8" height="8" /> 
          				<%}%>
          			<%}%>
          			<%if(lateSignInNum>0){%>
          				<%for(int i=0;i<lateSignInNum;i++){%>
          					<img src="parkmanager.oa/web/images/redtips.png" width="8" height="8" /> 
          				<%}%>
          			<%}%>
		          </td>
		          
		          <td width="40" class="workcounttd">
		          	<%if(normalSignOutNum==0&&leaveEarlyNum==0){%>
		          		&nbsp;
          			<%}%>
		          	<%if(normalSignOutNum>0){%>
          				<%for(int i=0;i<normalSignOutNum;i++){%>
          					<img src="parkmanager.oa/web/images/greentips.png" width="8" height="8" /> 
          				<%}%>
          			<%}%>
          			<%if(leaveEarlyNum>0){%>
          				<%for(int i=0;i<leaveEarlyNum;i++){%>
          					<img src="parkmanager.oa/web/images/redtips.png" width="8" height="8" /> 
          				<%}%>
          			<%}%>
		          </td>
		        </tr>
		      </table>
		      </td>
		      </c:forEach>
		    <td valign="top">
		      	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		          <tr>
		          	<td width="60" class="workcounttd">${monthDto.normalSignInNumPerMonth}</td>
		          	<td width="60" class="workcounttd">${monthDto.normalSignOutNumPerMonth}</td>
		          	<td width="60" class="workcounttd">${monthDto.lateSignInNumPerMonth}</td>
		          	<td width="60" class="workcounttd">${monthDto.leaveEarlyNumPerMonth}</td>
		          </tr>
		      	</table>
	       </td>
	     </c:forEach>
	    </tr>
    </c:forEach>
  </table>
</div>
 <!--//container-->
</body>
</html>
