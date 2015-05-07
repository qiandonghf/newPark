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
Date date = (Date)request.getAttribute("date");
Integer dayNo = Integer.parseInt(DateUtil.format(date, "dd"));
Integer monthNo = Integer.parseInt(DateUtil.format(date, "MM"));
Integer yearNo = Integer.parseInt(DateUtil.format(date, "yyyy"));
String dateStr = yearNo+"-"+monthNo+"-"+dayNo; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>员工日报</title>
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
<style>
	.selectTd{
		margin-top: 12px;
	}
</style>
<script type="text/javascript" >
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
        year.value=<%=yearNo%>;
        //填充月份下拉框   
		for (var i = 1; i <= 12; i++){   
            month.options.add(new Option(i,i));   
        }   
        //选中当月   
        month.value = <%=monthNo%>;  
		//获得当月的初始化天数   
        var n = MonDays[<%=monthNo%>-1];   
        //如果为2月，天数加1   
        if (m == 2 && isLeapYear(year.options[year.selectedIndex].value))   
       		n++;   
       	//填充日期下拉框   
        createDay(n,day);
        //选中当日   
        day.value = <%=dayNo%>;   
	}
	
	function createDay(n,day){   
	 	//填充日期下拉框   
		//清空下拉框   
		clearOptions(day);   
		//几天，就写入几项   
		for(var i=1; i<=n; i++){   
		day.options.add(new Option(i,i));   
		}   
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
			createDay(n,day);   
		}
	
  	function toSubmit(form1){
  		var receiver = $("#receiver").val();
  		if(receiver==undefined){
  			showTip("请先设置报送人",2000);
  			return;
  		}
  		var names = document.getElementsByName("content");
  		var len = names.length;
  		if (len > 0) {
  			var j = 0;
  		    for (var i = 0; i < len; i++){
  		    	if(names[i].value==""){
  		    		j++;
  		    	}
  		    }   
  		    if(j==len){
  		    	showTip("请填写内容",2000);
  	  			return;
  		    }
  		 }  
  		var yearNo = $("#year").val();
  		$("#yearNo").val(yearNo);
  		var monthNo = $("#month").val();
  		$("#monthNo").val(monthNo);
  		var dayNo = $("#day").val();
  		$("#dayNo").val(dayNo);
  		$("#selectDate").val(yearNo+"-"+monthNo+"-"+dayNo);
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
  	
  	function deleteTr(obj){
  		$(obj).parent().parent().parent().parent().parent().parent().remove();
  		//$("#tr"+num).remove();
  	}
  	
</script>
</head>

<body style="background:#fff;">

<form action="<%=basePath%>workDayReport!save.action?dateStr=<%=dateStr%>" method="post"  name="form1" id="form1">
<input type="hidden" id="status" name="workDayReport.status"/>
<!--basediv-->
<div class="basediv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="4" class="layertdleftblack" style=" border-right:none; background:#cbcbcb; color:#003877;">
		<h2 style="text-align:center; padding-top:5px">员工日报</h2>
		</td>
      </tr>
      <tr>
        <td class="layertdleftblack">日期：</td>
        <td colspan="3" class="layerrightblack"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td ><label>
            	<input id="selectDate" name="selectDate" type="hidden"/>
            	<input id="yearNo" name="workDayReport.yearNo" value="<%=yearNo%>" type="hidden"/>
             	 <input id="monthNo" name="workDayReport.monthNo" value="<%=monthNo%>" type="hidden"/>
             	 <input id="weekNo" name="workDayReport.weekNo" value="${week.week}" type="hidden"/>
             	 <input id="dayNo" name="workDayReport.dayNo" value="<%=dayNo%>" type="hidden"/>
				<select id="year" name="select_year" onchange="change(this, document.form1.select_month, document.form1.select_day)">
				</select>
				</label>
				年
				<label>
					<select id="month" name="select_month"  onchange="change(document.form1.select_year, this,document.form1.select_day)">
					</select>
				</label>
				月
				<label>
					<select id="day" name="select_day">
					</select>
				</label>
				日
          </td></tr>
        </table></td>
      </tr>
	  </table>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      	<td class="layertdleftblack">致：</td>
      	<td width="35%" class="layerrightblack" >
   		<c:if test="${workReportConfigList ne null}">
		 	<c:forEach items="${workReportConfigList}" var="workReportConfig">
     		 	${workReportConfig.receiver.realName} 
     		 	<input type="hidden" id="receiver" name="workDayReport.receiver" value="${workReportConfig.receiver.realName}"/>
     		</c:forEach> 
      	</c:if>
      	<c:if test="${workReportConfigList==null}">
			<input type="hidden" id="receiver" name="workDayReport.receiver"/>      	
      	</c:if>	
		</td>
      	<td class="layertdleftblack" style=" width:70px; border-left:1px solid #c3c3c3;">汇报人：</td>
      	<td class="layerrightblack" >
			<%=OaActivator.getSessionUser(request).getRealName()%>
			<input id="reporterId" name="workDayReport.reporterId"  value="<%=OaActivator.getSessionUser(request).getId()%>"  type="hidden"/>
		</td>
      </tr>
	 </table>
	  <table  width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td class="layertdleftblack" style=" width:45px; text-align:center;">当日<br />工作</td>
      	<td >
      	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table">
      	<c:set value="0" var="t"/>
          <c:forEach items="${taskList}" var="task" varStatus="s">
          <tr id="tr${s.index+1}">
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;">工作${s.index+1}</td>
            <td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
            	<table border="0" width="100%;">
                	<tr>
                    	<td width="70%">
                    	  	<div style="border:1px solid #ddd; padding:2px;"><textarea rows="2" class="textareaauto2" name="content">${task.title}</textarea></div>
              			</td>
                    	<td>
                   			<enum:select type="com.wiiy.oa.preferences.enums.ReportStatusEnum" name="process" styleClass="selectTd"/>&nbsp;&nbsp;
                   			<span id="deleteBtn" style="cursor:pointer; color:#06c;" onclick="deleteTr(this)">- 删除工作</span>
                    	</td>
                    </tr>
                    
                </table>
            </td>
          </tr>
          <c:set value="${s.index}" var="t"/>
          </c:forEach>
           <tr id="normalTr">
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;">工作<input type="hidden" value="${s.index+1}" id="report${s.index+1}"/></td>
            <td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
            	<table border="0" width="100%;">
                	<tr>
                    	<td width="70%">
                    		<div style="border:1px solid #ddd; padding:2px;"><textarea rows="2" class="textareaauto2" name="content"></textarea></div>
                    	</td>
                    	<td>
                   			<enum:select type="com.wiiy.oa.preferences.enums.ReportStatusEnum" name="process" styleClass="selectTd"/>&nbsp;&nbsp;
                   			<span id="deleteBtn" style="cursor:pointer; color:#06c;" onclick="deleteTr(this)">- 删除工作</span>
                    	</td>
                    </tr>
                </table>
            </td>
          </tr>
          
           <tr id="addTr">
               	<td bgcolor="#f2f2f2" id="111" nowrap="nowrap" align="center" colspan="2" height="40px;">
            		<span id="addBtn" style="text-align: center;cursor:pointer; color:#06c;">+ 添加工作</span>
				</td>
          </tr>
		</table>
		</td>
      </tr>
	  </table>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="tempallbtn" value="暂存"  onclick="$('#status').val('TEMPORARY');toSubmit(form1)"/> </label>
  <label><input name="Submit" type="button" class="allbtn" value="提交" onclick="$('#status').val('REPORTED');toSubmit(form1)"/> </label>
  </div>
</form>




<script>
var tr = '<tr>'+
'<td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;">工作</td>'	+
' <td class="layerrightblack" style="padding-top:2px;padding-bottom:2px;" ><table border="0" width="100%">'+
 ' <tr> '+
   ' <td width="70%">'+
      '<div style="border:1px solid #ddd; padding:2px;"><textarea rows="2" class="textareaauto2" name="content"></textarea></div> '+
   ' </td>'+
   	'<td><enum:select type="com.wiiy.oa.preferences.enums.ReportStatusEnum" name="process" styleClass="selectTd"/>&nbsp;&nbsp;'+
   	'<span id="deleteBtn" style="cursor:pointer; color:#06c;" onclick="deleteTr(this)"> - 删除工作</span></td> '+
	   '</tr>'+
 '</table></td>'+
'</tr>';

$('#addBtn').click(function(){
	$('#addTr').before(tr);
});




</script>
</body>
</html>
