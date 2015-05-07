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
<style type="text/css">
	.Title4{
		padding-left:20px; 
		padding-bottom:10px;
		font-size:14px;
		font-weight:bold;
		color:#6d6d6d;
		line-height:20px;
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
 		<jsp:param value="${article.typeId }" name="currentId"/>
 	</jsp:include>
  <!---主体内容左侧结束----> 
  
  <!---主体内容右侧开始---->
  <div id="mainright2"> 
    <!---建立流程开始---->
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
   ${article.content }    
    
    <!---附件开始---->       
	<p> 附件：  </p>
     
     <c:forEach items="${article.articleAtts }" var="att">
     <c:set value="${att.newName }" var="suffix"></c:set>
     <%
     String suffix = pageContext.getAttribute("suffix").toString();
     String image = "";
     if(suffix != null){
   	  if(suffix.endsWith("jpg") || suffix.endsWith("gif")
   			  || suffix.endsWith(".png")){
   		  image = "downloadico.png";
   	  }else if(suffix.endsWith("zip") || suffix.endsWith("rar")
   			  || suffix.endsWith("7z")|| suffix.endsWith("war")){
   		  image = "downloadico.png";
   	  }else if(suffix.endsWith("doc") || suffix.endsWith("txt")
   			  || suffix.endsWith("docx")){
   		  image = "doc.gif";
   	  }else if(suffix.endsWith("ppt")){
   		  image = "ppt.png";
   	  }else if(suffix.endsWith("xls")){
   		  image = "xls.png";
   	  }else{
   		  image = "oa_icon3.gif";
   	  }
     }
     %>
     <p id="image"><img src="images/<%=image %>" width="18" height="18" /><a href="javascript:;" title="点击下载" onclick="downAttr('${att.newName }','${att.oldName }');" class="blue">${att.oldName }</a></p>
     
     </c:forEach>
    <!---附件结束----> 
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
