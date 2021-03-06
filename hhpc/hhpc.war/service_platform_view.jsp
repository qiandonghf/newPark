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
<style>
	.servicesinfo{
		padding:10px 0px 30px 0px;
	}
	.apply{
		width:198px;
		height:43px;
		display:inline-block;
		background: url("images/but-sqsy.png");
	}
</style>
<script type="text/javascript">
	function downAttr(path,name){
		location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
	}
</script>
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
		<h3>${platform.name }
		<span class="but">
		<c:if test="${not empty platform.url}">
			<c:if test="${fn:indexOf(platform.url, 'http://') != -1}">
				<a target="_blank" class="apply" href="${platform.url }" ></a>
       		</c:if>
       		<c:if test="${fn:indexOf(platform.url, 'http://') == -1}">
				<a target="_blank" class="apply" href="http://${platform.url }" ></a>
       		</c:if>
      	</c:if>
      	<c:if test="${ empty platform.url}">
      		<a class="apply" href="javascript:;" ></a>
      	</c:if>
		</span>
		<p>${platform.title }</p>
        <p>地址：${platform.address }</p>
        <p>联系电话：${platform.phone }</p>
		</h3>
		<ul>
			<li>${platform.content }</li>
		</ul>
    </div>
    <!---企业介绍具体内容结束----> 
          
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
