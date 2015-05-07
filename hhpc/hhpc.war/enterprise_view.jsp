<%@page import="com.wiiy.web.dto.BaseDto"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
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
 		<jsp:param value="${category.id}" name="currentId"/>
 	</jsp:include>
  <!---主体内容左侧结束----> 
  
  <!---主体内容右侧开始---->
  <div id="mainright2"> 
    <!---左侧标题开始---->
    <h1 class="Title5">
      <p>
      	      当前位置：<a href="/">首页</a>&nbsp;&nbsp;》
	      <c:if test="${not empty category && not empty category.parentType}"> 
	      	<c:if test="${category.parentType.typeName != '网站首页' }">
				<c:if test="${category.kind=='SINGLE'}">
					<a href="javascript:;">${category.parentType.typeName}</a>&nbsp;&nbsp;》
				</c:if>
				<c:if test="${category.kind=='LIST'}">
					<a href="javascript:;">${category.parentType.typeName}</a>&nbsp;&nbsp;》
				</c:if>
			</c:if>
	      </c:if>
	      <c:if test="${not empty category}">
			<c:if test="${category.kind=='SINGLE'}">
				<a href="javascript:;">${category.typeName}</a>
			</c:if>
			<c:if test="${category.kind=='LIST'}">
		      	<c:if test="${not empty category.url}">
					<c:if test="${not empty category.url}">
      				<c:if test="${fn:indexOf(category.url, '?') != -1}">
						<a href="${category.url}&id=${category.id}">${category.typeName}</a>
	         		</c:if>
	         		<c:if test="${fn:indexOf(category.url, '?') == -1}">
						<a href="${category.url}?id=${category.id}">${category.typeName}</a>
	         		</c:if>
				</c:if>
				</c:if>
				<c:if test="${empty category.url}">
					<a href="list.action?id=${category.id}">${category.typeName}</a>
				</c:if>		      	
			</c:if>	
	      </c:if>
      </p>
    </h1>
    <!---左侧标题结束---->  
    
    <!---服务平台具体内容开始---->
    <div class="parkinfo">
		<c:if test="${not empty baseDto.logo }">
			<img src="core/resources/${baseDto.logo }" style="float:left;max-width: 100px;margin-right: 5px;" height="70px;"/>
		</c:if>
		<c:if test="${not empty baseDto.logo }">
			<img src="/images/db_logo.gif" style="float:left;max-width: 100px;margin-right: 5px;" height="70px;"/>
		</c:if>
		<h3>${baseDto.name }
			<span>
			<c:if test="${not empty baseDto.url}">
				<c:if test="${fn:indexOf(baseDto.url, 'http://') != -1}">
					|&nbsp;<a href="${category.url}">${baseDto.url }</a>
	       		</c:if>
	       		<c:if test="${fn:indexOf(baseDto.url, 'http://') == -1}">
					|&nbsp;<a href="http://${baseDto.url}">${baseDto.url }</a>
	       		</c:if>
       		</c:if>
			</span>
			<p>联系电话：${baseDto.phone}</p>
			<p>地址：${baseDto.address}</p>
			<c:if test="${not empty products }"><p>企业产品：<c:forEach items="${products }" var="product"><a href="#">${product.name }</a> </c:forEach> </p></c:if>
		</h3>
		<ul>
	        <li>
	          <c:if test="${not empty baseDto.photo }">
	          <c:set value="${baseDto.photo }" var="p"></c:set>
			  <%
				String photo = pageContext.getAttribute("p").toString();
				int pos = -1;
				if(photo != null && (pos=photo.lastIndexOf(".")) != -1){
					 photo = photo.substring(0,pos)+"335-240"+photo.substring(pos);
				}
			  %>
	          <p><img src="core/resources/<%=photo %>" alt="${baseDto.oldName }" /></p>
	          </c:if>
	          <p>${baseDto.content }</p>
	          <br />
	        </li>
		</ul>
    </div>
    <!---服务平台具体内容结束----> 
    
    <c:if test="${not empty dtoMap }">
    	<%
    	HashMap<Integer,BaseDto> map = (HashMap<Integer,BaseDto>)request.getAttribute("dtoMap");
    	BaseDto lastDto = map.get(1);
    	BaseDto nextDto = map.get(2);
    	%>
	    <!---nextpage---->
	    <div class="nextpage">
	      <c:set var="t" value="企业"></c:set>
	      <c:if test="${category.id eq '28' }">
	      <c:set var="t" value="项目"></c:set>
	      </c:if>
	      <p><span>上一${t }：
	      	  <%if(lastDto != null){ %>
	      	  <% String content = lastDto.getName();
		      	if(content.length() > 21){
		    		content = content.substring(0,20);
		    		content += "...";
		        }
		       %>
		      <a title="<%=lastDto.getName() %>" href="enterpriseView.action?type=<%=lastDto.getType() %>&categoryId=<%=lastDto.getCategory().getId() %>&id=<%=lastDto.getId() %>&pos=<%=lastDto.getRecord() %>"><%=content %></a>
		      <%}else{%>
		      <a href="javascript:;">没有了</a>
		       <%}%>
	      </span>下一${t }：
	          <%if(nextDto != null){ %>
	          <% String content = nextDto.getName();
		      	if(content.length() > 21){
		    		content = content.substring(0,20);
		    		content += "...";
		        }
		       %>
		      <a title="<%=nextDto.getName() %>" href="enterpriseView.action?type=<%=nextDto.getType() %>&categoryId=<%=nextDto.getCategory().getId() %>&id=<%=nextDto.getId() %>&pos=<%=nextDto.getRecord() %>"><%=content %></a>
	      	  <%} else{%>
		      <a href="javascript:;">没有了</a>
		       <%}%>
	      </p>
	    </div>
	    <!---nextpage---->
    </c:if>
    
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
