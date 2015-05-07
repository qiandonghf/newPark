<%@page import="com.wiiy.commons.util.CalendarUtil"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ page import="com.wiiy.oa.preferences.enums.*"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page import="com.wiiy.commons.*"%>
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
<title>员工月报</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" >
	var finishedTask = "";
	var unfinishedTask = "";
	$(document).ready(function() {
		initTip();
		initDate(document.form1.select_year,document.form1.select_month,document.form1.select_day);
	});
	function initDate(year,month,day){
		//每个月的初始天数   
		MonDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];   
		//当前的年份   
		var y = new Date().getFullYear();   
		//当前的月份   
		var m = new Date().getMonth()+1; //javascript月份为0-11   
		//但前的天份   
		var d = new Date().getDate();   
		//以今年为准，向后2年，填充年份下拉框   
		for (var i = y-2; i < (y+3); i++){   
			year.options.add(new Option(i,i));   
        }   
        //选中今年   
        year.value=${month.year};
        //填充月份下拉框   
		for (var i = 1; i <= 12; i++){   
            month.options.add(new Option(i,i));   
        }   
        //选中当月   
        month.value = ${month.month};  
		//获得当月的初始化天数   
        var n = MonDays[m-1];   
        //如果为2月，天数加1   
        if (m == 2 && isLeapYear(year.options[year.selectedIndex].value))   
          		n++;   
        	//填充日期下拉框   
	}
	
  	function clearOptions(ctl){   
  		//删除下拉框中的所有选项   
        for(var i=ctl.options.length-1; i>=0; i--){   
			ctl.remove(i);   
		}   
	}   
  	function isLeapYear(year){    
  		//判断是否闰年   
		return( year%4==0 || (year%100 ==0 && year%400 == 0));   
	}   
	
  	function change(year,month,day){   
		var y = year.options[year.selectedIndex].value;   
		var m = month.options[month.selectedIndex].value;   
		var n = MonDays[m - 1];   
		if ( m ==2 && isLeapYear(y)){   
			n++;   
		}
		clearContent();
	}
  	
  	/*
  		将完成工作和未完成工作的内容清空
  		保留用户输入的内容
  	*/
  	function clearContent(){
  		var finishTxt = CKEDITOR.instances.finishWork.getData();
		var unfinishTxt = CKEDITOR.instances.unfinishWork.getData();
		CKEDITOR.instances.finishWork.setData(finishTxt.replace(finishedTask,""));
		CKEDITOR.instances.unfinishWork.setData(unfinishTxt.replace(unfinishedTask,"")); 
		finishedTask = '';
		unfinishedTask = '';
  	}
  	
  	function toSubmit(form1){
		for (instance in CKEDITOR.instances) {
			CKEDITOR.instances[instance].updateElement();
		}
		if(isNull("receiver","报送人")){
			showTip("请先设置报送人",2000);
			return false;
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
		var yearNo = $("#year").val();
  		$("#yearNo").val(yearNo);
  		var monthNo = $("#month").val();
  		$("#monthNo").val(monthNo);
  		$(form1).ajaxSubmit({ 
	     	dataType: 'json',
	     	success: function(data){
        	showTip(data.result.msg,2000);
	        if(data.result.success){
	        	setTimeout(function(){
	        		window.opener.location.reload(); 
	        		self.close(); 
				},2000);
	        }
	     } 
	  });
	} 
  	
  	//获取指定月的最后一天
  	function getLastDay(year,month){
  		//每个月的初始天数   
		var MonDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  		var day = MonDays[month-1];
		if (MonDays == 2 && isLeapYear(year))   
			day++;   
		return day;
  	}
  	
  	function loadFinishedTask(param){
  		var year = $("#year").val();
  		var month = $("#month").val();
  		var startTime = year+"-"+month+"-1";//日期区间的开头
  		var endTime = year+"-"+month+"-"+getLastDay(year,month);//日期区间的结尾
  		if(confirm("要加载已经完成的任务吗？")){
	  		$.post("<%=basePath%>workReport!loadTaskForMonthReport.action?taskReportParam="+param+"&myMonth=${month.month}&startTime="+startTime+"&endTime="+endTime,function(data){
	  			var tasksForReport = data.result.value;	
	  			/* var finishedTask = tasksForReport.finishedTask;
  				if(finishedTask !=''){
  					CKEDITOR.instances.finishWork.setData(finishedTask); 
  				}else{
	  				showTip("无已完成的工作可供加载",2000);
	  			}  */			
	  			if(finishedTask !='' &&
	  					finishedTask == tasksForReport.finishedTask){
	  				showTip("已完成的工作已加载,勿重复加载",2000);
	  			}else{
	  				if(finishedTask !=''){
	  					CKEDITOR.instances.finishWork.setData(
	  							CKEDITOR.instances.finishWork.getData().replace(finishedTask,""));
	  				}
	  				finishedTask = tasksForReport.finishedTask;
	  				if(finishedTask !=''){
	  					CKEDITOR.instances.finishWork.setData(
	  							finishedTask+CKEDITOR.instances.finishWork.getData()); 
	  				}else{
		  				showTip("无已完成的工作可供加载",2000);
		  			}
	  			}
	 	 	});
  		}
  	}
  	
  	function loadUnfinishedTask(param){
  		var year = $("#year").val();
  		var month = $("#month").val();
  		var startTime = year+"-"+month+"-1";//日期区间的开头
  		var endTime = year+"-"+month+"-"+getLastDay(year,month);//日期区间的结尾
  		if(confirm("要加载还未完成的任务吗？")){
  			$.post("<%=basePath%>workReport!loadTaskForMonthReport.action?taskReportParam="+param+"&myMonth=${month.month}&startTime="+startTime+"&endTime="+endTime,function(data){
	  			var tasksForReport = data.result.value;
	  			/* unfinishedTask = tasksForReport.unfinishedTask;
	  			if(unfinishedTask!=''){
	  				CKEDITOR.instances.unfinishWork.setData(unfinishedTask); 
	  			}else{
	  				showTip("无未完成的工作可供加载",2000);
	  			} */
	  			if(unfinishedTask != '' && 
	  					unfinishedTask == tasksForReport.unfinishedTask){
	  				showTip("未完成的工作已加载,勿重复加载",2000);
	  			}else{
	  				if(unfinishedTask !=''){
	  					CKEDITOR.instances.unfinishWork.setData(
	  							CKEDITOR.instances.unfinishWork.getData().replace(unfinishedTask,""));
	  				}
	  				unfinishedTask = tasksForReport.unfinishedTask;
	  				if(unfinishedTask !=''){
	  					CKEDITOR.instances.unfinishWork.setData(
	  							unfinishedTask+CKEDITOR.instances.unfinishWork.getData()); 
	  				}else{
		  				showTip("无未完成的工作可供加载",2000);
		  			}
	  			}
	 	 	});
  		}
  	}
</script>
</head>

<body style="background:#fff;">

<form action="<%=basePath%>workReport!save.action"  method="post"  name="form1" id="form1">
<input type="hidden" id="status" name="workReport.status"/>
<!--basediv-->
<div class="basediv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="4" class="layertdleftblack" style=" border-right:none; background:#cbcbcb; color:#003877;">
		<h2 style="text-align:center; padding-top:5px">员工月报</h2>
			<input id="type" name="workReport.type" value="<%=WorkReportEnum.MONTH%>" type="hidden"/>
			<input id="reporterId" name="workReport.reporterId" value="<%=OaActivator.getSessionUser(request).getId()%>" type="hidden"/>
		</td>
      </tr>
      <tr>
        <td class="layertdleftblack">日期段：</td>
        <td colspan="3" class="layerrightblack"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td ><label>
            	<select id="year" name="select_year" onchange="change(this, document.form1.select_month, document.form1.select_day)">
				</select>
				</label>
				年
				<label>
					<select id="month" name="select_month"  onchange="change(document.form1.select_year, this,document.form1.select_day)">
					</select>
				</label>
				月
                &nbsp;&nbsp;
              <input id="yearNo" name="workReport.yearNo" value="${month.year}" type="hidden"/>
              <input id="monthNo" name="workReport.monthNo" value="${month.month}" type="hidden"/>
            </td>
          </tr>
        </table></td>
      </tr>
	  </table>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      	<td class="layertdleftblack"><span class="psred">*</span>致：</td>
      	<td width="35%" class="layerrightblack" >
      		 <c:forEach items="${workReportConfigList}" var="workReportConfig">
      		 	${workReportConfig.receiver.realName} 
      		 	<input type="hidden" id="receiver" name="workReport.receiver" value="${workReportConfig.receiver.realName}"/>
      		</c:forEach> 
      	</td>
      	<td class="layertdleftblack" style=" width:100px; border-left:1px solid #c3c3c3;">汇报人：</td>
      	<td class="layerrightblack" >
			<%=OaActivator.getSessionUser(request).getRealName()%>
			<input id="reporter" name="workReport.reporter"  value="<%=OaActivator.getSessionUser(request)%>"  type="hidden"/>
		</td>
      </tr>
	 </table>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      		<td class="layertdleftblack"><span class="psred">*</span>计划编差：</td>
      	<td width="35%" class="layerrightblack" >
      		<enum:select type="com.wiiy.oa.preferences.enums.WorkReportOffsetEnum" 
							     name="workReport.offset" styleClass="incubated" id="offset"/>
      	</td>
      	<td class="layertdleftblack" style=" width:100px; border-left:1px solid #c3c3c3;">编制日期：</td>
      	<td class="layerrightblack">
 		<%= DateUtil.format(new Date(),"yyyy-MM-dd")%>
		<input id="createTime" name="workReport.createTime"  value="<%= DateUtil.format(new Date())%>" type="hidden"/>
      
		</td>
      </tr>
	 </table>
	  <table  width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td class="layertdleftblack" style=" width:45px; text-align:center;">本月<br />进度</td>
      	<td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;"><span class="psred">*</span>已完成<br />工　作<br/><br/><div><img src="/parkmanager.oa/web/images/task_import.png" onclick="loadFinishedTask('finished');" onmouseover=""/></td>
            	
		<td colspan="3" class="layerright" style="padding-bottom:2px;">
			<textarea id="finishWork" name="workReport.finishWork" style="height:200px;" class="textareaauto"></textarea>
			<script type="text/javascript">CKEDITOR.replace( 'finishWork',{height:120});</script>
		</td>
          </tr>
		  <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;"><span class="psred">*</span>未完成<br />工　作<br/><br/><div><img src="/parkmanager.oa/web/images/task_import.png" onclick="loadUnfinishedTask('unfinished');" onmouseover=""/></td>
            <td colspan="3" class="layerright" style="padding-bottom:2px;">
				<textarea id="unfinishWork" name="workReport.unfinishWork" style="height:200px;" class="textareaauto"></textarea>
				<script type="text/javascript">CKEDITOR.replace( 'unfinishWork',{height:120});</script>
			</td>
          </tr>
          <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center;padding:0px;"><span class="psred">*</span>原因及<br />对　策</td>
           	<td colspan="3" class="layerright" style="padding-bottom:2px;">
				<textarea id="reason" name="workReport.reason" style="height:200px;" class="textareaauto"></textarea>
				<script type="text/javascript">CKEDITOR.replace( 'reason',{height:120});</script>
			</td>
          </tr>
        </table></td>
      </tr>
	  </table>
      <table  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleftblack"><span class="psred">*</span>下月计划：</td>
 
		<td colspan="3" class="layerright" style="padding-bottom:2px;">
			<textarea id=nextContect name="workReport.nextContect" style="height:200px;" class="textareaauto"></textarea>
			<script type="text/javascript">CKEDITOR.replace( 'nextContect',{height:150});</script>
		</td>
		
      </tr>
      <tr>
      	<td class="layertdleftblack" style=" border-right:1px solid #c3c3c3;border-bottom:none"><span class="psred">*</span>资源需求：</td>
 
		<td colspan="3" class="layerright" style="padding-bottom:2px;">
			<textarea id=resourceNeeds name="workReport.resourceNeeds" style="height:200px;" class="textareaauto"></textarea>
			<script type="text/javascript">CKEDITOR.replace( 'resourceNeeds',{height:80});</script>
		</td>
      	</tr>
    </table>
</div>
<div class="buttondiv">
  	<input name="button1" type="button" class="tempallbtn" value="暂存"  onclick="$('#status').val('TEMPORARY');toSubmit(form1)"/>
  	<input name="button2" type="button" class="allbtn" value="提交" onclick="$('#status').val('REPORTED');toSubmit(form1)"/> 
  </div>
</form>
</body>
</html>
