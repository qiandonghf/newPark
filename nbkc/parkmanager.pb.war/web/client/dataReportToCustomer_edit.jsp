<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.crm.entity.DataTemplate"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.dto.DataPropertyDto"%>
<%@page import="com.wiiy.crm.entity.DataReportValue"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.crm.entity.DataReportProperty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>数据填报</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<style>
body{font-size: 12px;font-family: tahoma,Helvetica, Arial, sans-serif,simsun;}
</style>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
	});
	function checkForm(status){
		if(status==1){
			$("#status").val("SAVED");
		} else if(status==2){
			$("#status").val("PUB");
		}
		var validate = true;
		$(".int").each(function(){
			if($(this).val()!='' && !checkIntValue($(this).val())){
				validate = false;
				showTip($(this).parent().prev().text()+"只能为整数",3000);
				return;
			}
		});
		$(".double").each(function(){
			if($(this).val()!='' && !checkDoubleValue($(this).val())){
				validate = false;
				showTip($(this).parent().prev().text()+"只能为小数",3000);
				return;
			}
		});
		if(validate){
			$("#form1").ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
						window.opener.reloadList();
						<%if(PbActivator.getSessionUser().getAdmin()!=BooleanEnum.YES){%>
							setTimeout("updateCustomerInfo();", 2000);
						<%}else{%>
							setTimeout("self.close(); ", 2000);
						<%}%>
		        	}
		        } 
		    });
		}
	}
	
	function updateCustomerInfo(){
		var id = $("#customerId").val();
		if(confirm("基本信息需要修改吗？")){
			window.opener.openCustomerInfo(id);
		}
		setTimeout("self.close();");
	}
	
	function loadReportByGroupId(id){
		if(id != ''){
			var url = "<%=basePath%>dataReport!loadReport.action?id="+id;
			$.post(url,function(data){
				var monthList = $("#monthList");
				monthList.empty();
				var option = "<option value=''>----请选择----</option>";
				for(var i = 0; i < data.length; i++){
					if(data[i].templateId==1){
						var id = data[i].id;
						var name = data[i].name;
						option += "<option value='"+id+"'>"+name+"</option>";
					}
				}
				monthList.append(option);
			});
		}
	}
	
	function toLead(){
		var id = $("#couId").val();
		var falgs = "yes";
		location = "<%=basePath%>dataReportToCustomer!edit.action?id="+id+"&type="+falgs;	
	}
	
	loadReportByGroupId("${result.value.report.groupId}");
	
	function changeMonth(){
		var id = $("#monthList").val();
		var customerId = ${result.value.customerId};
		if(id!=null && id!=''){
			location.href = '<%=basePath%>dataReportToCustomer!edit.action?reportId='+id+'&customerId='+customerId;
		}
	}
</script>
<style>
.borderTable {
	BACKGROUND-COLOR: #ffffff;
	COLOR: #000000;
	border-top: 1px solid #000000;
	border-right: 2px solid #000000;
	border-bottom: 2px solid #000000;
	border-left: 1px solid #000000;
}
.borderCell {
	BACKGROUND-COLOR: #ffffff;
	COLOR: #000000;
	line-height: 18px;
	border-top: 1px solid #000000;
	border-right: 0px solid #000000;
	border-bottom: 0px solid #000000;
	border-left: 1px solid #000000;
}
.borderCellLine {
	BACKGROUND-COLOR: #ffffff;
	COLOR: #000000;
	line-height: 18px;
	border-top: 0px solid #000000;
	border-right: 0px solid #000000;
	border-bottom: 1px solid #000000;
	border-left: 0px solid #000000;
}
.doubleLineHead {
	line-height: 30px;
}
.underLine {
	text-decoration: underline;
}
body, td, div, p, span {
	font-size: 9pt;
}

</style>
</head>

<body style="background-color: white;">
<%-- <div style="height:36px; font: bold 16px/36px ''; text-align:center;">${result.value.customer.name}<strong style="padding-left: 50px;">${result.value.report.group.name}-${result.value.report.name}</strong></div> --%>
<form action="<%=basePath %>dataReportToCustomer!report.action" method="post" name="form1" id="form1">
<input id="couId" name="id" value="${result.value.id}" type="hidden"/>
<input id="customerId" name="customerId" value="${result.value.customerId}" type="hidden"/>
<input id="status" type="hidden" name="status"/>
<center>
<div class="basediv" style='width:720px;border: 0'>
	<div style="height:36px; font: bold 16px/36px ''; text-align:center;">
	<strong style="padding-left: 50px;">
		${result.value.report.group.name}-${result.value.report.name}
	</strong>
	<!-- <table width="100%">
		<tr>
			<td>
				<span id="monthList">
					&nbsp;
				</span>
			</td>
		</tr>
	</table> -->
</div>
<div>
	<table border=0 width=720 align=center>
         <tbody>
           <tr>
             <td align=left>${result.value.customer.name}</td>
             <td align=right>
             	<select id="monthList" onchange="changeMonth()">
					<option value="">----请选择----</option>
				</select>
				<a href="javascript:void(0)" title="" onclick="toLead()" class="btn_bg" >
					<span>导入上一期数据</span>
				</a>
			</td>
           </tr>
         </tbody>
    </table>
</div>
<div class="divlays">
	<%
		DataTemplate dataTemplate = (DataTemplate)request.getAttribute("dataTemplate");
		List<DataReportProperty> propertyList = (List<DataReportProperty>)request.getAttribute("propertyList");
		Map<Long, DataReportValue> valueMap = (Map<Long, DataReportValue>)request.getAttribute("dataReportValueMap");
		if(dataTemplate!=null){
			out.println(dataTemplate.getFormat().format(propertyList, valueMap));
		}else{%>
			<span>本月份并没有给该企业发布报表，所以没有数据显示</span>
		<%}%>
</div>
</div>
</center>
<div class="buttondiv">
	<a href="javascript:void(0)" title="" onclick="checkForm(1)" class="btn_bg"><span><img src="core/common/images/savetemp_icon.gif"/>暂存</span></a>
	<a href="javascript:void(0)" title="" onclick="checkForm(2)" class="btn_bg"><span><img src="core/common/images/savebtnicon.gif"/>保存并上报</span></a>
	<a href="javascript:void(0)" title="" onclick="self.close();" class="btn_bg"><span><img src="core/common/images/closebtnicon.gif"/>取消</span></a>
</div>
</form>
</body>
</html>
