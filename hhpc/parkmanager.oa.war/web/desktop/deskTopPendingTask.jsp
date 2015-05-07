<%@page import="com.wiiy.oa.dto.TaskDto"%>
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
	<ul class="list_sy_2">
	<c:forEach items="${taskDtoList}" var="dto">
	<%
			TaskDto taskDto = (TaskDto)pageContext.getAttribute("dto");
			Integer day = taskDto.getDay();
			String memo = "";
			if(day>1){
				memo = day+"天后到期";
			}else if(day==0){
				memo = "今天到期";
			}else if(day<0){
				day = -day;
				memo = "已逾期"+day+"天";
			}else if(day==1){
				memo = "明天到期";
			}
			String priorityName = taskDto.getPriorityName();
		%>
      <li <c:if test="${dto.taskStatus == -1}">class="sign_01"</c:if><c:if test="${dto.taskStatus == 1}">class="sign_02"</c:if> <c:if test="${dto.taskStatus == 0}">class="sign_03"</c:if>>
      <a href="javascript:void(0);" onclick="fbStart('查看工作任务','<%=BaseAction.rootLocation %>/parkmanager.oa/task!view.action?id=${dto.id}',650,400)" title="${dto.title}">${dto.title}</a>&nbsp;<span class="cor_999 margin_left_10"><%=memo%></span>&nbsp;<span class="cor_999 margin_left_10"><img src="core/common/images/bai${dto.progress}_min.png" /></span></li>
    </c:forEach>
    </ul>
	 <ul style="white-space: nowrap;" class="explain_list">
    	<li style="padding-left:10px;"><img src="core/common/images/sign_01.gif" />待签收</li>
        <li style="padding-left:10px;"><img src="core/common/images/sign_02.gif" />我派出</li>
        <li style="padding-left:10px;"><img src="core/common/images/sign_03.gif" />我代办</li>
    </ul>
</div>
</body>
</html>