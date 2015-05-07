<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>数据自检</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<link href="core/common/tree/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/tree/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(parent.window).resize(function(){
			var height = $(parent.window).height();
			$("body").css("height",height);
			$("#pageDiv").css("top",height-175);
		});
	});

	function jumpPage(page){
		var url = "<%=basePath%>dataCheck!list.action";
		url += "?page="+page;
		
		url = encodeURI(url);
		location.href=url;
	}

</script>
<style type="text/css">
	#pageDiv{
		position:absolute;
		width:100%;
		bottom:0px;
	}
</style>
</head>

<body>
<!--container-->
<div id="container">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="35" class="tdleftc"><label>
          序号
        </label></td>
        <td width="150" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">自检状态</td>
        <td width="150" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">自检日期</td>
        <td  class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">自检文件</td>
      </tr>
      <c:forEach items="${list }" var="dataCheck" varStatus="status">
	      <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
	        <td class="centertd">${status.index+1 }</td>
	        <td class="centertd">${dataCheck.status.title }</td>
	        <td class="centertd"><fmt:formatDate pattern="yyyy-MM-dd" value="${dataCheck.date }"/></td>
	        <td class="lefttd">
	        	<c:forEach items="${checkLogs }" var="log" >
	        		<c:if test="${log.parentId == dataCheck.id }">
	        			<a href="<%=basePath%>web/checkHtml/${log.name }" target="_blank">${log.name }(<span <c:if test="${log.status ne 'SUCCESS' }">style="color:red;"</c:if>>${log.status.title}</span>) &nbsp;</a>
	        		</c:if>
	        	</c:forEach>
	        </td>
	      </tr> 
      </c:forEach>
      
    </table>
</div>
<div id="pageDiv">
	<%@include file="../pager.jsp" %>
</div>
</body>
</html>
