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
      	<a>${category.typeName}</a>
      </c:if>
     </p>
   </h1>
   <!---左侧标题结束----> 
    
	<!---企业列表开始---->
    <div class="jisshulist">
      <c:forEach items="${platforms }" var="platform">
      <div class="jisshu">
      	<img src="core/resources/${platform.photo }" width="120" height="120" class="img" />
        <h2><a href="serviceView.action?categoryId=${platform.articleType.id }&id=${platform.id }&type=platform">${platform.name }</a>   ${platform.title }</a></h2>
        <ul>
          <li>
          	<c:if test="${fn:length(platform.content)>132 }">
          		${fn:substring(platform.content,0,131) }...
          	</c:if>
          	<c:if test="${fn:length(platform.content)<=132 }">
          		${platform.content}
          	</c:if>
          	<a href="serviceView.action?categoryId=${platform.articleType.id }&id=${platform.id }&type=platform">详细>></a>
          </li>
        </ul>
        <div class="hackbox"></div>
      </div>
      </c:forEach>
      
      <div class="hackbox"></div>
    </div>
    <!---企业列表结束---->
          
	<%-- 
	<div class="page">
		<ul>
			<li>总数：${pager.records} </li>
			<c:if test="${pager.total > 0}">
			<li><em class="pagepre"><a href="#">首页</a></em><em class="pagepre"><a href="#">上一页</a></em><em class="pagenext"><a href="#">下一页</a></em><em class="pagepre"><a href="#">尾页</a></em></li>
			<li>页次：<font color="#FF0000">${pager.page }</font>/${pager.total}</li>
			</c:if>
			<c:if test="${pager.total == 0}">
			<li><em class="pagepre"><a href="#">首页</a></em><em class="pagepre"><a href="#">上一页</a></em><em class="pagenext"><a href="#">下一页</a></em><em class="pagepre"><a href="#">尾页</a></em></li>
			<li>页次：<font color="#FF0000">0</font>/0</li>
			</c:if>
            <li><input name="yeci" type="text" /> <input name="go" type="button" value="GO" /></li>
		</ul>
	</div> --%>
    
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
