<%@page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@page import="com.wiiy.commons.util.StringUtil"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=InitListener.webParam.getName() %></title>
<!---样式---->
	<jsp:include page="style.jsp"></jsp:include>
<!---样式结束----> 
</head>
<body>

<!---顶部开始---->
	<jsp:include page="header.jsp"></jsp:include>
<!---顶部结束----> 
<!---导航开始---->
	<jsp:include page="navi.jsp"></jsp:include>
<!---导航结束----> 

<!---焦点图开始---->
	<jsp:include page="view_photo.jsp"></jsp:include>
<!---焦点图结束----> 

<!---主体内容开始---->
<div id="main" style="padding-top:25px;"> 
  
  <!---主体内容左侧开始---->
 	<jsp:include page="main_left.jsp">
 		<jsp:param value="${category.id }" name="currentId"/>
 	</jsp:include>
  <!---主体内容左侧结束----> 
  
  <!---主体内容右侧开始---->
  <div id="mainright2"> 
  
    	<!---左侧标题开始---->
	    <h1 class="Title5">
	      <p>
	      	      当前位置：<a href="index.action">首页</a>&nbsp;&nbsp;》
		      <c:if test="${not empty category && not empty category.parentType}"> 
		      <c:if test="${category.parentType.typeName != '网站首页' }">
				<a>${category.parentType.typeName}</a>&nbsp;&nbsp;》
			  </c:if>
		      </c:if>
		      <c:if test="${not empty category}">
		      	<a>${category.typeName}</a>
		      </c:if>
	      </p>
	    </h1>
	    <!---左侧标题结束---->     
    
        <!---企业列表开始---->
        <div class="parklist">
	        <ul>
	          <c:forEach items="${documents }" var="document" varStatus="s">
	          <c:set value="${document.name }" var="name"></c:set>
	          <%
	          String name = pageContext.getAttribute("name").toString();
	          int pos = name.lastIndexOf(".");
	          if(pos != -1 && pos < name.length()){
	        	  name = name.substring(0,pos);
	          }
	          %>
	          <li>
	          	<span><fmt:formatDate value="${document.pubTime }" pattern="yyyy-MM-dd" /></span>
	          	<em><img src="images/ico3.gif" width="8" height="5" /></em>
	          	<a href="core/resources/${document.fileName }?name=<%=name %>" title="<%=name %>"><%=name %></a>
	          </li>
	          </c:forEach>
	        </ul>
		</div> 
		<div class="hackbox"></div>
     	<!---企业列表结束----> 
     	
     	<!---分页开始----> 
     		<jsp:include page="pager.jsp"></jsp:include>
     	<!---分页结束----> 
      
		<div class="hackbox"></div>
  </div>
  <!---主体内容右侧结束---->
  
  <div class="hackbox"></div>
</div>
<!---主体内结束----> 

<!---底部开始---->
	<jsp:include page="footer.jsp"></jsp:include>
<!---底部结束---->
</body>
</html>

