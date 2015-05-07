<%@page import="com.wiiy.oa.entity.WorkReport"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ page import="com.wiiy.oa.preferences.enums.*"%>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/calendar.css"/>
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	initTip();
});
	

	function toSubmit(form1){
		for (instance in CKEDITOR.instances) {
			CKEDITOR.instances[instance].updateElement();
		}
		if(isNull("offset","计划偏差")){
			showTip("请选择计划偏差",2000);
			return false;
		}
		if(isNull("finishWork","已完成工作")){
			showTip("请填写已完成工作",2000);
			return false;
		}
		if(isNull("unfinishWork","未完成工作")){
			showTip("请填写未完成工作",2000);
			return false;
		}
		if(isNull("reason","原因及对策")){
			showTip("请填写原因及对策",2000);
			return false;
		}
		if(isNull("nextContect","下月计划")){
			showTip("请填写下月计划",2000);
			return false;
		}
		if(isNull("resourceNeeds","资源需求")){
			showTip("请填写资源需求",2000);
			return false;
		}
		form1.submit();
        window.opener.location.reload(); 
        self.close(); 
	} 
	
	function loadFinishedTask(param){
  		var startTime = $("#startTime").val();//日期区间的开头
  		var endTime = $("#endTime").val();//日期区间的结尾
  		if(confirm("要加载已经完成的任务吗？")){
	  		$.post("<%=basePath%>workReport!loadTaskForWeekReport.action?taskReportParam="+param+"&myWeek=${week.week}&startTime="+startTime+"&endTime="+endTime,function(data){
	  			var tasksForReport = data.result.value;
	  			var finishedTask = tasksForReport.finishedTask;
	  			if(finishedTask!=''){
	  				CKEDITOR.instances.finishWork.setData(finishedTask); 
	  			}else{
	  				showTip("无已完成的工作可供加载",2000);
	  			}
	 	 	});
  		}
  	}
  	
  	function loadUnfinishedTask(param){
  		var startTime = $("#startTime").val();//日期区间的开头
  		var endTime = $("#endTime").val();//日期区间的结尾
  		if(confirm("要加载还未完成的任务吗？")){
	  		$.post("<%=basePath%>workReport!loadTaskForWeekReport.action?taskReportParam="+param+"&myWeek=${week.week}&startTime="+startTime+"&endTime="+endTime,function(data){
	  			var tasksForReport = data.result.value;
	  			var unfinishedTask = tasksForReport.unfinishedTask;
	  			if(unfinishedTask!=''){
	  				CKEDITOR.instances.unfinishWork.setData(unfinishedTask); 
	  			}else{
	  				showTip("无未完成的工作可供加载",2000);
	  			}
	 	 	});
  		}
  	}
</script>
</head>

<body style="background:#fff;">

<form action="<%=basePath%>workReport!update.action" method="post"  name="form1" id="form1">
<input type="hidden" id="status" name="workReport.status"/>
<!--basediv-->
<div class="basediv">

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
                &nbsp;&nbsp;
              <input id="yearNo" name="workReport.yearNo" value="${workReport.yearNo}" type="hidden"/>
              <input id="monthNo" name="workReport.monthNo" value="${month.month}" type="hidden"/>
              <input id="weekNo" name="workReport.weekNo" value="${week.week}" type="hidden"/>
            </label>
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
      	<td class="layertdleftblack"><span class="psred">*</span>致：</td>
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
      	<td class="layertdleftblack"><span class="psred">*</span>计划编差：</td>
      	<td width="35%" class="layerrightblack" >
      		<enum:select type="com.wiiy.oa.preferences.enums.WorkReportOffsetEnum" 
							     name="workReport.offset" styleClass="incubated"  checked="workReport.offset" id="offset"/>
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
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;"><span class="psred">*</span>已完成<br />工　作<br/><br/><div><img src="/parkmanager.oa/web/images/task_import.png" onclick="loadFinishedTask('finished');" onmouseover=""/></td>
            	
		<td colspan="3" class="layerright" style="padding-bottom:2px;">
			<textarea id="finishWork" name="workReport.finishWork" style="height:200px;" class="textareaauto">${workReport.finishWork}</textarea>
			<script type="text/javascript">CKEDITOR.replace( 'finishWork',{height:120});</script>
		</td>
			
          </tr>
		  <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;"><span class="psred">*</span>未完成<br />工　作<br/><br/><div><img src="/parkmanager.oa/web/images/task_import.png" onclick="loadUnfinishedTask('unfinished');" onmouseover=""/></td>
            <td colspan="3" class="layerright" style="padding-bottom:2px;">
				<textarea id="unfinishWork" name="workReport.unfinishWork" style="height:200px;" class="textareaauto">${workReport.unfinishWork}</textarea>
				<script type="text/javascript">CKEDITOR.replace( 'unfinishWork',{height:120});</script>
			</td>
          </tr>
          <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center;padding:0px;"><span class="psred">*</span>原因及<br />对　策</td>
           	<td colspan="3" class="layerright" style="padding-bottom:2px;">
				<textarea id="reason" name="workReport.reason" style="height:200px;" class="textareaauto">${workReport.reason}</textarea>
				<script type="text/javascript">CKEDITOR.replace( 'reason',{height:120});</script>
			</td>
          </tr>
        </table></td>
      </tr>
	  </table>
      <table  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleftblack"><span class="psred">*</span>下周计划：</td>
 
		<td colspan="3" class="layerright" style="padding-bottom:2px;">
			<textarea id=nextContect name="workReport.nextContect" style="height:200px;" class="textareaauto">${workReport.nextContect}</textarea>
			<script type="text/javascript">CKEDITOR.replace( 'nextContect',{height:150});</script>
		</td>
		
      </tr>
      <tr>
      	<td class="layertdleftblack" style=" border-right:1px solid #c3c3c3;border-bottom:none"><span class="psred">*</span>资源需求：</td>
 
		<td colspan="3" class="layerright" style="padding-bottom:2px;">
			<textarea id=resourceNeeds name="workReport.resourceNeeds" style="height:200px;" class="textareaauto">${workReport.resourceNeeds}</textarea>
			<script type="text/javascript">CKEDITOR.replace( 'resourceNeeds',{height:80});</script>
		</td>
      	</tr>
    </table>
</div>
<c:if test="${!flag}">
<div class="buttondiv">
  	<input name="Submit" type="submit" class="allbtn" value="暂存"  onclick="$('#status').val('TEMPORARY');toSubmit(form1)"/>
  	<input name="Submit" type="submit" class="allbtn" value="提交" onclick="$('#status').val('REPORTED');toSubmit(form1)"/> 
  </div>
</c:if>
<c:if test="${flag}">
	<script type="text/javascript">
			$(document).ready(function() {
				warning();
			});
		
			function warning(){
				showTip("你已经对本周周报进行过操作",2000);
				setTimeout("window.opener.location.reload();self.close()",2000);
			}
	</script>
</c:if>
</form>
</body>
</html>
