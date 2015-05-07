<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=InitListener.webParam.getName() %></title>

<!---样式---->
	<jsp:include page="style.jsp"></jsp:include>
<!---样式结束----> 
<style>
	.but_qx{
		cursor:pointer;
	}
	.but_qd{
		cursor:pointer;
	}
	.parkinfo .left{
		text-align:right;
	}
</style>
<script type="text/javascript">
	function checkFeedBack(){
		var name = $("input[name='advicement.name']");
		var content = $("textarea[name='advicement.content']");
		//replace(/(^\s*)|(\s*$)/g, "")
		if($(name).val().replace(/(^\s*)|(\s*$)/g, "") == ''){
			alert("请输入你的姓名");
			$(name).focus();
			return;
		}
		if($(content).val().replace(/(^\s*)|(\s*$)/g, "") == ''){
			alert("请输入你的留言内容");
			$(content).focus();
			return;
		}
		save('advicement');
	}
	
	function dealAction(id){
		if(id == 'advicement'){
			$("#"+id)[0].reset(); 
		}
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
			<a>${category.parentType.typeName}</a>&nbsp;&nbsp;》
	      </c:if>
	      <c:if test="${not empty category}">
			<a>${category.typeName}</a>	      	
	      </c:if>
      </p>
    </h1>
    <!---左侧标题结束---->  
    
    <!---企业介绍具体内容开始---->
	<div class="parkinfo">
		<form action="<%=basePath %>save.action?type=advicement" id="advicement" method="post">
    	<h4>在线留言</h4>
    	<ul>
			<li class="left"><span class="psred">*</span>姓名：</li>
			<li class="right">
				<input name="advicement.name" type="text" />
			</li>
			<!-- <li class="left">昵称：</li>
			<li class="right">				
				<input name="nicheng" type="text" />
			</li> -->
			<li class="left">电话：</li>
			<li class="right">
               <input name="advicement.phone" type="text" />				
			</li>
			<li class="left">E-mail：</li>
			<li class="right">				
				<input name="advicement.email" type="text" />
			</li>
			<!-- <li class="left">留言主题：</li>
			<li class="right">				
				<input name="title" type="text" />
			</li> -->
			<li class="left"><span class="psred">*</span>留言内容：</li>
			<li class="right">
				<textarea name="advicement.content" style="resize:none;" cols="" rows=""></textarea>				
			</li>
			<li class="left"></li>
			<li class="right">
				<input name="" type=reset class="but_qx" value="清空" />
				<input name="" type="button" onclick="checkFeedBack();" class="but_qd" value="提交" />
			</li>
	    </ul>
	    </form>
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
