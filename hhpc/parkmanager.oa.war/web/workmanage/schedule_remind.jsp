<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.entity.Schedule"%>
<%@page import="com.wiiy.commons.util.CalendarUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	  		$("#merters").css("height",getTabContentHeight()-45);
	  });
	  
</script>

</head>

<body>
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建提醒','<%=basePath %>web/workmanage/schedule_add.jsp?promot=<%="CURRENTDAY" %>&scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>',550,313);" ><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.href='<%=basePath %>schedule!list.action'"><span><img src="core/common/images/viewdata.gif"/></span>日历</li>
			<%--<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.href='<%=basePath %>web/workmanage/schedule_month_list.jsp'"><span><img src="core/common/images/viewdata.gif"/></span>月历</li>--%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.href='<%=basePath %>schedule!remind.action?scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>'"><span><img src="core/common/images/remind.png"/></span>提醒</li>
		</ul>
	</div>
</div>
<div class="Schedule">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td valign="top" >
      <td valign="top">
	  <div id="merters" style=" overflow-x:hidden; overflow-y:auto">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  	<tr>
          <td class="day_td_gray day_detail_curr"><span></span><a href="javascript:void(0)" onclick="fbStart('新建提醒','<%=basePath %>web/workmanage/schedule_add.jsp?promot=<%="CURRENTDAY" %>&scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>',550,313);" >新建提醒...</a></td>
        </tr>
	  	<c:forEach items="${result.value}" var="schedule">
	  			<%
					Schedule schedule = (Schedule)pageContext.getAttribute("schedule");
	  				boolean promot = (new Date()).getTime()<schedule.getPromotTime().getTime();
				%>
  				<tr>
  					<td class="day_td" onclick="fbStart('编辑提醒','<%=basePath %>schedule!edit.action?id=${schedule.id}',550,337);">
		  			<c:if test="${schedule.repeatType eq 'EVERYYEAR'}">
		  				<span <c:if test="<%=promot %>">style="color:#000"</c:if>>
		  					${schedule.repeatType.title}<fmt:formatDate value="${schedule.promotTime}" pattern="M月d日"/>
		  				</span>
		  				<span <c:if test="<%=promot %>">style="color:#000"</c:if>>
		  				<fmt:formatDate value="${schedule.promotTime}" pattern="HH:mm"/>
		  				</span>
		  				<span <c:if test="<%=promot %>">style="color:#000"</c:if>>
		  					${schedule.title}
		  				</span>
		  			</c:if>
		  			<c:if test="${schedule.repeatType eq 'EVERYMONTH'}">
		  				<span style="color:#000">
		  					${schedule.repeatType.title}<fmt:formatDate value="${schedule.promotTime}" pattern="d日"/></span>
		  				<span style="color:#000">
		  				<fmt:formatDate value="${schedule.promotTime}" pattern="HH:mm"/>
		  				</span>
		  				<span style="color:#000">
		  					${schedule.title}
		  				</span>
		  			</c:if>
		  			<c:if test="${schedule.repeatType eq 'EVERYWEEK'}">
		  				<span style="color:#000">
		  					每<fmt:formatDate value="${schedule.promotTime}" pattern="E"/>
	  					</span><span style="color:#000">
		  				<fmt:formatDate value="${schedule.promotTime}" pattern="HH:mm"/>
		  				</span>
		  				<span style="color:#000">
		  					${schedule.title}
		  				</span>
		  			</c:if>
		  			<c:if test="${schedule.repeatType eq 'EVERYDAY'}">
		  				<span style="color:#000">
		  					${schedule.repeatType.title}
		  				</span><span style="color:#000">
		  				<fmt:formatDate value="${schedule.promotTime}" pattern="HH:mm"/>
		  				</span>
		  				<span style="color:#000">
		  					${schedule.title}
		  				</span>
		  			</c:if>
		  			<c:if test="${schedule.repeatType eq 'NOREPEAT'}">
		  				<span <c:if test="<%=promot %>">style="color:#000"</c:if>>
			  				<fmt:formatDate value="${schedule.promotTime}" pattern="yyyy年M月d日"/>
			  			</span><span <c:if test="<%=promot %>">style="color:#000"</c:if>>
		  				<fmt:formatDate value="${schedule.promotTime}" pattern="HH:mm"/>
		  				</span>
		  				<span <c:if test="<%=promot %>">style="color:#000"</c:if>>
		  					${schedule.title}
		  				</span>
		  			</c:if>
		  			<c:if test="${schedule.repeatType ne 'NOREPEAT'}">
		  				<em style="color:#B2B7BF; font-style: normal;">重复</em>
		  			</c:if>
		  			</td>
		  		</tr>
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
