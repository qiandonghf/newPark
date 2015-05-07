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
Result<LeaveRegister> result = (Result<LeaveRegister>)request.getAttribute("result");
LeaveRegister lr = result.getValue();
Date startDate = lr.getStartTime();
Integer startYear = Integer.parseInt(DateUtil.format(startDate,"yyyy"));
Integer startMonth = Integer.parseInt(DateUtil.format(startDate,"MM"));
Integer startDay = Integer.parseInt(DateUtil.format(startDate,"dd"));
Integer startHour = Integer.parseInt(DateUtil.format(startDate,"HH"));
Integer startMinute = Integer.parseInt(DateUtil.format(startDate,"mm"));
Date endDate = lr.getEndTime();
Integer endYear = Integer.parseInt(DateUtil.format(endDate,"yyyy"));
Integer endMonth = Integer.parseInt(DateUtil.format(endDate,"MM"));
Integer endDay = Integer.parseInt(DateUtil.format(endDate,"dd"));
Integer endHour = Integer.parseInt(DateUtil.format(endDate,"HH"));
Integer endMinute = Integer.parseInt(DateUtil.format(endDate,"mm"));

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
$(function(){
	initTip();
	initForm();
	initStartDate(document.form1.select_startYear,document.form1.select_startMonth,document.form1.select_startDay);
	initEndDate(document.form1.select_endYear,document.form1.select_endMonth,document.form1.select_endDay);
}); 

function initStartDate(startYear,startMonth,startDay){
  	MonDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];   
 	var y = new Date().getFullYear();   
	var m = new Date().getMonth()+1;
  	var d = new Date().getDate();   
  	for (var i = y; i < (y+3); i++){   
  		startYear.options.add(new Option(i,i));
  		$("#startYear").value=i;
	}   
  	startYear.value=<%=startYear%>;
  	for (var i = 1; i <= 12; i++){   
  		startMonth.options.add(new Option(i,i));   
	}   
	startMonth.value = <%=startMonth%>;  
	var n = MonDays[<%=startMonth%>-1];   
	if (m == 2 && isLeapYear(startYear.options[startYear.selectedIndex].value))   
  		n++;   
	createDay(n,startDay);    
    startDay.value = <%=startDay%>;  
    if(<%=startHour%><10){
    	var shour = "0"+<%=startHour%>;
    	$("#startHour").val(shour);    
    }else{
	    $("#startHour").val(<%=startHour%>);    
    }
	$("#startMinute").val(<%=startMinute%>);    
}
function initEndDate(endYear,endMonth,endDay){
  	MonDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];   
 	var y = new Date().getFullYear();   
	var m = new Date().getMonth()+1;
  	var d = new Date().getDate();   
  	for (var i = y; i < (y+3); i++){   
  		endYear.options.add(new Option(i,i));   
  		$("#endYear").value=i;
	}   
  	endYear.value=<%=endYear%>;
  	for (var i = 1; i <= 12; i++){   
  		endMonth.options.add(new Option(i,i));  
  		$("#endMonth").value=i;
	}   
  	endMonth.value = <%=endMonth%>;  
	var n = MonDays[<%=endMonth%>-1];   
	if (m == 2 && isLeapYear(endYear.options[endYear.selectedIndex].value))   
  		n++;   
	createDay(n,endDay);    
    endDay.value = <%=endDay%>;
    if(<%=endHour%><10){
    	var hour = "0"+<%=endHour%>;
    	$("#endHour").val(hour);    
    }else{
	    $("#endHour").val(<%=endHour%>);    
    }
	$("#endMinute").val(<%=endMinute%>);    
}
function isLeapYear(year){    
	//判断是否闰年   
	return( year%4==0 || (year%100 ==0 && year%400 == 0));   
}  
function createDay(n,day){   
	clearOptions(day);   
　　for(var i=1; i<=n; i++){   
　　   day.options.add(new Option(i,i));   
　　}   
}

function clearOptions(ctl){   
    for(var i=ctl.options.length-1; i>=0; i--){   
        ctl.remove(i);   
    }   
}   

function change(year,month,day){   
   	 var y = year.options[year.selectedIndex].value;   
     var m = month.options[month.selectedIndex].value;   
     var n = MonDays[m - 1];   
     if ( m ==2 && isLeapYear(y)){   
         n++;   
     }   
     createDay(n,day)   
}

 function initForm(){
	$("#form1").validate({
		rules: {
			"leaveRegister.leaveType":"required",
			"leaveRegister.applicant":"required"
		},
		messages: {
			"leaveRegister.leaveType":"请选择假别",
			"leaveRegister.applicant":"请填写申请人"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			var startMonth = $("#startMonth").val();
			var endMonth = $("#endMonth").val();
			var startDay = $("#startDay").val();
			var endDay = $("#endDay").val();
			if(startMonth<10){
				startMonth = "0"+startMonth;
			}
			if(endMonth<10){
				endMonth = "0"+endMonth;
			}
			if(startDay<10){
				startDay = "0"+startDay;
			}
			if(endDay<10){
				endDay = "0"+endDay;
			}
			$("#startTime").val($("#startYear").val()+"-"+startMonth+"-"+startDay+" "+$("#startHour").val()+":"+$("#startMinute").val()+":00");
			$("#endTime").val($("#endYear").val()+"-"+endMonth+"-"+endDay+" "+$("#endHour").val()+":"+$("#endMinute").val()+":00");
			if($("#endTime").val()<=$("#startTime").val()){
				showTip("请假结束时间必须大于请假开始时间");
				return false;
			}
			$(form).ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){			        		
		        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
		        	}
		        } 
		    });
		}
	});
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="<%=basePath %>leaveRegister!update.action">
<!--basediv-->
<input type="hidden" name="leaveRegister.id" value="${result.value.id}"/>
<div class="basediv" style="border:none;">
  <table width="100%"  class="oatableAdd" cellspacing="0" cellpadding="0">
  	<tr>
        <td colspan="2"  style=" border-right:none; text-align:center; background:#e3e3e3; color:#003877; border-bottom:1px solid #c3c3c3;">
		<h2 style="text-align:center; padding-top:5px;font-size:14px;">请假单</h2>
		</td>
    </tr>
    <tr>
      <td class="layertdleftblack"><span class="psred">*</span>申请人：</td>
      <td width="150" class="oatabletdright">
	  	 <input  name="leaveRegister.applicant" value="${result.value.applicant}"/>
	  </td>
    </tr>
	<tr>
	 <td class="layertdleftblack">申请日期：</td>
      <td class="oatabletdright">
	  	 <input type="hidden" name="leaveRegister.applyTime" value="${result.value.applyTime}"/>
      	 <fmt:formatDate value="${result.value.applyTime}" pattern="yyyy-MM-dd"/>
	  </td>
	</tr>
    <tr>
    	<td class="layertdleftblack"><span class="psred">*</span>假别：</td>
    	<td  class="oatabletdright">
    		<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<c:forEach items="${enumList}" var="leaveType" begin="0" end="3">
							<input type="radio" name="leaveRegister.leaveType" value="${leaveType}" <c:if test="${leaveType eq result.value.leaveType}">checked="checked"</c:if>/>&nbsp;${leaveType.title}
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td>
						<c:forEach items="${enumList}" var="leaveType" begin="4" end="7">
							<input type="radio" name="leaveRegister.leaveType" value="${leaveType}" <c:if test="${leaveType eq result.value.leaveType}">checked="checked"</c:if>/>&nbsp;${leaveType.title}
						</c:forEach>
					</td>
				</tr>
			</table>
		</td>
    </tr>
    <tr>
    	<td class="layertdleftblack"><span class="psred">*</span>请假时间：</td>
    	<td class="oatabletdright">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			  <td>
				<input id="startTime" name="leaveRegister.startTime" type="hidden" value='${result.value.startTime}'/>
			  	   从
					<select id="startYear" name="select_startYear" onchange="change(this, document.form1.select_startMonth, document.form1.select_startDay)">
					</select>
				   年
					<select id="startMonth" name="select_startMonth"  onchange="change(document.form1.select_startYear, this,document.form1.select_startDay)">
					</select>
				   月
					<select id="startDay" name="select_startDay">
					</select>
				  日 
					<select id="startHour">
						<c:forEach begin="0" end="23" var="s">
							<option value="<c:if test="${s<10}">0</c:if>${s}">
								<c:if test="${s<10}">0</c:if>${s}
							</option>
						</c:forEach>
					</select>
				  时
					<select id="startMinute">
						<c:forEach begin="0" end="59" var="s" step="15">
							<option value="<c:if test="${s<10}">0</c:if>${s}">
								<c:if test="${s<10}">0</c:if>${s}
							</option>
						</c:forEach>
					</select>
				分
			 </td>
		  </tr>
		  <tr>
			 <td>
			 <input id="endTime" name="leaveRegister.endTime" type="hidden" value='<fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>'/>
			 	   至
				   <select id="endYear" name="select_endYear" onchange="change(this, document.form1.select_endMonth, document.form1.select_endDay)">
					</select>
				   年
					<select id="endMonth" name="select_endMonth"  onchange="change(document.form1.select_endYear, this,document.form1.select_endDay)">
					</select>
				   月
					<select id="endDay" name="select_endDay">
					</select>
				  日 
					<select id="endHour">
						<c:forEach begin="0" end="23" var="s">
							<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
						</c:forEach>
					</select>
				  时
					<select id="endMinute">
						<c:forEach begin="0" end="59" var="s" step="15">
							<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
						</c:forEach>
					</select>
				分
			</td>
		</tr>
	</table>		
	</td>
   </tr>
   <tr>
    	<td class="layertdleftblack">请假原因：</td>
    	<td  class="oatabletdright" style="padding:2px 5px;">
			<label>
			<textarea name="leaveRegister.memo" class="textareaauto" style="width:400px; height:40px;">${result.value.memo}</textarea>
			</label>		
		</td>
   </tr>
</table>
</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
</div>
</form>
</body>
</html>
