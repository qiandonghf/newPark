<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
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
		initDate(document.form1.select_year,document.form1.select_month,document.form1.select_day);
		initDate(document.form1.select_year1,document.form1.select_month1,document.form1.select_day1);
	}); 
	 function initForm(){
		$("#form1").validate({
			rules: {
				"outRegister.reason":"required"
			},
			messages: {
				"outRegister.reason":"请填写外出事由"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(assignmentDate()==false){
					return;
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
　　      for (var i = y; i < (y+3); i++){   
　　          year.options.add(new Option(i,i));   
        }   
        //选中今年   
        year.value=y;
        
        //填充月份下拉框   
　　      for (var i = 1; i <= 12; i++){   
            month.options.add(new Option(i,i));   
        }   
        //选中当月   
        month.value = m;  
		//获得当月的初始化天数   
        var n = MonDays[m-1];   
        //如果为2月，天数加1   
        if (m == 2 && isLeapYear(year.options[year.selectedIndex].value))   
          		n++;   
        	//填充日期下拉框   
            createDay(n,day);    
            //选中当日   
            day.value = new Date().getDate();   
		
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
    　　     createDay(n,day)   
　　 }
	  	
  	function assignmentDate(){
		var month = $("#month").val();
		var day = $("#day").val();
		var month1 = $("#month1").val();
		var day1 = $("#day1").val();
		if(month<10){
			month = "0"+month;
		}
		if(day<10){
			day = "0"+day;
		}
		if(month1<10){
			month1 = "0"+month1;
		}
		if(day1<10){
			day1 = "0"+day1;
		}
		$("#startTime").val($("#year").val()+"-"+month+"-"+day+" "+$("#startHour").val()+":00"+":00");
		$("#endTime").val($("#year1").val()+"-"+month1+"-"+day1+" "+$("#endHour").val()+":00"+":00");
		if($("#endTime").val()<=$("#startTime").val()){
			showTip("结束时间不能小于开始时间");
			return false;
		}
	}
</script>
</head>

<body>
	<form id="form1" name="form1" method="post" action="<%=basePath %>outRegister!save.action">
	<!--basediv-->
	<div class="basediv">
		<!--titlebg-->
		<!--//titlebg-->
	    <!--divlay-->
	<div class="divlays" style="margin:0px;">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td class="layertdleft"><span class="psred">*</span>开始时间：
	      	<input id="startTime" name="outRegister.startTime" type="hidden" value="<fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
	      </td>
	      <td class="layerright">
	       	<select id="year" name="select_year" onchange="change(this, document.form1.select_month, document.form1.select_day)">
			</select>
			年
			<select id="month" name="select_month"  onchange="change(document.form1.select_year, this,document.form1.select_day)">
			</select>
			月
			<select id="day" name="select_day">
			</select>
			日 
			<select id="startHour">
				<c:forEach begin="0" end="23" var="s">
					<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
				</c:forEach>
			</select>
			时
		  </td>
		</tr>
	   	<tr>
	      <td class="layertdleft"><span class="psred">*</span>结束时间：
	      	<input id="endTime" name="outRegister.endTime" type="hidden" value="<fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
	      </td>
	       <td class="layerright">
	        <select id="year1" name="select_year1" onchange="change(this, document.form1.select_month1, document.form1.select_day1)">
			</select>
			年
			<select id="month1" name="select_month1"  onchange="change(document.form1.select_year1, this,document.form1.select_day1)">
			</select>
			月
			<select id="day1" name="select_day1">
			</select>
			日 
			<select id="endHour">
				<c:forEach begin="0" end="23" var="s">
					<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
				</c:forEach>
			</select>
			时
			</td>
		    </tr>
			<tr>
		      <td class="layertdleft"><span class="psred">*</span>外出事由：</td>
		      <td><label>
		        <textarea name="outRegister.reason"  style="width:300px;height:80px;" class="textarea"></textarea>
		      </label></td>
		    </tr>
		  </table>
		</div>
		<!--//divlay-->
		<div class="hackbox"></div>
	  </div>
		<!--//basediv-->
		<!--basediv-->
		<!--//basediv-->
	  <div class="buttondiv">
		  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
		  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	  </div>
	</form>
</body>
</html>
