<%@page import="com.wiiy.oa.entity.WorkReport"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ page import="com.wiiy.oa.preferences.enums.*"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page import="com.wiiy.oa.dto.*"%>
<%@ page import="com.wiiy.commons.util.*"%>
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
<title>员工周报</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>

</head>

<body style="background:#fff;">

<input type="hidden" id="status" name="workReport.status"/>
<!--basediv-->
<c:if test="${workReport!=null }">
<div class="basediv" style="width:700px">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="4" class="layertdleftblack" style=" border-right:none; background:#cbcbcb; color:#003877;">
		<h2 style="text-align:center; padding-top:5px">员工周报</h2>
		</td>
      </tr>
      <tr>
        <td class="layertdleftblack">日期段：</td>
        <td colspan="3" class="layerrightblack"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td ><label>
              ${workReport.yearNo}年
              ${workReport.monthNo}月     
                                      第${workReport.weekNo}周
            </label>
            &nbsp;&nbsp;
            	<c:forEach items="${week.dateList}"  var="startDate" begin="0" end="0">
            		<fmt:formatDate value="${startDate}"  pattern="yyyy-MM-dd" var="startDateString"/>${startDateString}
	           	 	<input id="startTime" name="workReport.startTime" value="${startDateString}" type="hidden"/>
            	</c:forEach>
           		 &nbsp;--&nbsp;
            	<c:forEach items="${week.dateList}" var="endDate" begin="6" end="6">
            		<fmt:formatDate value="${endDate}"  pattern="yyyy-MM-dd" var="endDateString"/>${endDateString}
	           		<input id="endTime" name="workReport.endTime" value="${endDateString}" type="hidden"/>
            	</c:forEach>
            </td>
          </tr>
        </table></td>
      </tr>
	  </table>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      	<td class="layertdleftblack">致：</td>
      	<td width="35%" class="layerrightblack" >
      		 ${workReport.receiver}
      	</td>
      	<td class="layertdleftblack" style=" width:100px; border-left:1px solid #c3c3c3;">汇报人：</td>
      	<td class="layerrightblack" >
			${workReport.reporter.realName}
			<input id="id" name="workReport.id"  value="${workReport.id}"  type="hidden"/>
		</td>
      </tr>
	 </table>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      	<td class="layertdleftblack">计划编差：</td>
      	<td width="35%" class="layerrightblack" >
      		${workReport.offset.title}
      	</td>
      	<td class="layertdleftblack" style=" width:100px; border-left:1px solid #c3c3c3;">编制日期：</td>
      	<td class="layerrightblack">
			<fmt:formatDate value="${workReport.createTime}" pattern="yyyy-MM-dd"/>
		</td>
      </tr>
	 </table>
	  <table  width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td class="layertdleftblack" style=" width:45px; text-align:center;">本周<br />进度</td>
      	<td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;">已完成<br />工　作</td>
            	
			<td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
				<div style=" vertical-align:middle;  padding:5px; overflow-x:hidden; overflow-y:auto;">
				${workReport.finishWork}
				</div>
			</td>
          </tr>
		  <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;">未完成<br />工　作</td>
            <td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
				<div style=" vertical-align:middle;  padding:5px; overflow-x:hidden; overflow-y:auto;">
				${workReport.unfinishWork}
				</div>
			</td>
          </tr>
          <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center;padding:0px;">原因及<br />对　策</td>
           	<td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
				<div style=" vertical-align:middle;  padding:5px; overflow-x:hidden; overflow-y:auto;">
					${workReport.reason}
				</div>
			</td>
          </tr>
        </table></td>
      </tr>
	  </table>
      <table  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleftblack">下周计划：</td>
 
		<td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
			<div style=" vertical-align:middle;  padding:5px; overflow-x:hidden; overflow-y:auto;">
				${workReport.nextContect}
			</div>
		</td>
		
      </tr>
      <tr>
      	<td class="layertdleftblack" style=" border-right:1px solid #c3c3c3;border-bottom:none">资源需求：</td>
 
		<td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
			<div style=" vertical-align:middle;  padding:5px; overflow-x:hidden; overflow-y:auto;">
				${workReport.resourceNeeds}
			</div>
		</td>
      	</tr>
    </table>
</div>
</c:if>
<c:if test="${workReport==null }">
<%-- <div style="vertical-align: middle;text-align: center;line-height: 300px">
	<a href="javascript:vopen('<%=basePath %>workReport!addWeekReport.action','weeks',800,600);">立即新建本周周报</a>
</div> --%>
</c:if>
</body>
</html>
