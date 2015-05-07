<%@	page import="com.wiiy.commons.util.DateUtil"%>
<%@	page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@	page import="com.wiiy.hibernate.Result"%>
<%@	page import="com.wiiy.oa.entity.LeaveRegister"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">


</script>
</head>
<body>
<!--basediv-->
<input type="hidden" name="leaveRegister.id" value="${result.value.id}"/>
<div class="basediv" style="border:none;">
  <table width="100%"  class="oatableAdd" cellspacing="0" cellpadding="0">
  	<tr>
        <td colspan="2"  style="text-align:center; background:#e3e3e3; color:#003877; border-bottom:1px solid #c3c3c3;">
		<h2 style="text-align:center; padding-top:5px;font-size:14px;">请假单</h2>
		</td>
    </tr>
    <tr>
      <td class="layertdleftblack" width="150">姓名：</td>
      <td class="oatabletdright">
		 ${result.value.applicant}
	  </td>
    </tr>
	<tr>
	 <td class="layertdleftblack">申请日期：</td>
      <td class="oatabletdright">
      	 <fmt:formatDate value="${result.value.applyTime}" pattern="yyyy-MM-dd"/>
	  </td>
	</tr>
    <tr>
    	<td class="layertdleftblack">假别：</td>
    	<td  class="oatabletdright">
    		<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						&nbsp;${result.value.leaveType.title}
					</td>
				</tr>
				
			</table>
		</td>
    </tr>
    <tr>
    	<td class="layertdleftblack">请假时间：</td>
    	<td class="oatabletdright">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			  <td>
				<input id="startTime" name="leaveRegister.startTime" type="hidden" value='${result.value.startTime}'/>
			  	   从
					 <fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd HH:mm"/>
			 </td>
		  </tr>
		  <tr>
			 <td>
			 	   至
				   <fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
		</tr>
	</table>		
	</td>
   </tr>
   <tr>
    	<td class="layertdleftblack">请假原因：</td>
    	<td  class="oatabletdright" style="padding:2px 5px;">
			<div style=" vertical-align:middle; height:80px;width:380px;word-break:break-all; overflow-x:hidden; overflow-y:auto;">
				${result.value.memo}
			</div>
		</td>
   </tr>
</table>
</div>
<!--//basediv-->
<div style="height: 5px;"></div>
</body>
</html>
