<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.wiiy.oa.entity.Schedule"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</head>
<body>
<div>
	<ul class="list_sy_1">
		<c:forEach items="${schedules}" var="schedule">
			<%
				Schedule s = (Schedule)pageContext.getAttribute("schedule");
				String memo = "";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar = Calendar.getInstance();
				String now = sdf.format(calendar.getTime());
				calendar.add(Calendar.DATE, 1);
				String tomo = sdf.format(calendar.getTime());
				String startDate = sdf.format(s.getStartTime());
				if(startDate.equals(now)){
					memo = "今天";
				}else if(startDate.equals(tomo)){
					memo = "明天";
				}else{
					memo ="后天";
				}
			%>
			<li><a href="javascript:void(0);" onclick="fbStart('日程管理','<%=BaseAction.rootLocation %>/parkmanager.oa/schedule!view.action?id=${schedule.id }','500','275')" title="">${schedule.title }</a>&nbsp;<%=memo %></li>
		</c:forEach>
	</ul>
</div>
</body>
</html>