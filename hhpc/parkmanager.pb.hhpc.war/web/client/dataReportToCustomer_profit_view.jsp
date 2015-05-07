<%@page import="java.text.DecimalFormat"%>
<%@page import="com.wiiy.crm.entity.DataTemplate"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.dto.DataPropertyDto"%>
<%@page import="com.wiiy.crm.entity.DataReportValue"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.crm.entity.DataReportProperty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>报表查看</title>
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
.double {
	background-color:#d9f6fa;
	border:0px solid #d9f6fa;
	color:#666666;
	height:25px;
	width:110px;
	padding-right: 10px;
	text-align: center;
}
</style>
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
	$("#form1").ajaxSubmit({
        dataType: 'json',		        
        success: function(data){
       		showTip(data.result.msg,2000);
        	if(data.result.success){
        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
        	}
        } 
    });
}
</script>
</head>
<body  style="background-color: white;">
<form action="<%=basePath %>dataReportToCustomer!reportProfit.action" method="post" name="form1" id="form1">
<input name="id" value="${result.value.id}" type="hidden"/>
<input id="status" type="hidden" name="status"/>
<%
	Map<Long, DataReportValue> valueMap = (Map<Long, DataReportValue>)request.getAttribute("dataReportValueMap");
	DecimalFormat df = new DecimalFormat("#.##");
	int i = 179;
%>
<center>
  <br/>
  <div align=center style='width:96%'>
    <table id=t width=720 align=center>
      <tbody>
        <tr>
          <td><table border=0 cellSpacing=0 cellPadding=0 width=640 align=center>
              <tbody>
                <tr align=right>
                  <td colSpan=4>&nbsp;</td>
                </tr>
                <tr >
                  <td style="DISPLAY: none" id=ca_1 width="25%"></td>
                  <td colSpan=4><FONT size=4><B>企业利润表(${result.value.report.group.name}-${result.value.report.name})</B></FONT></td>
                  <td style="DISPLAY: none" id=ca_2 width="25%" align=right><IMG src="pages/tf/wsxt/cwgl/image/ca.gif"></td>
                </tr>
              </tbody>
            </table></td>
        </tr>
        <tr>
          <td><table border=0 cellSpacing=0 cellPadding=0 width=640 align=center>
              <tbody>
                <tr>
                  <td align=left>编制单位:${result.value.customer.name}</td>
                  <td align=right>单位: 元</td>
                </tr>
              </tbody>
            </table></td>
        </tr>
        <tr>
          <td><table style="BORDER-COLLAPSE: collapse; table-LAYOUT: fixed" border=1 bordercolor="#666666" width=640 frame=box align=center>
              <tbody>
                <tr height=25 >
                  <td width=360>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目</td>
                  <td width=40>行&nbsp;&nbsp;次</td>
                  <td width=120>本期累计金额</td>
                  <td width=120>本月金额</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;一、营业收入</td>
                  <td align="center">&nbsp;1</td>
                  <td><label for="textfield"></label>
                    <input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="property90" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="property90" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;减:主营业务成本</td>
                  <td align="center">&nbsp;2</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield2" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;营业税金及附加</td>
                  <td align="center">&nbsp;3</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues4" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：消费税</td>
                  <td align="center">&nbsp;4</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield4" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues6" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;营业税</td>
                  <td align="center">&nbsp;5</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield5" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues5" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;城市建设维护税</td>
                  <td align="center">&nbsp;6</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield6" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues8" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;资源税</td>
                  <td align="center">&nbsp;7</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield7" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues9" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;土地增值税</td>
                  <td align="center">&nbsp;8</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield8" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield40" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;城镇土地使用税、房产税、车船税、印花税</td>
                  <td align="center">&nbsp;9</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield9" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield41" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;教育费附加、矿产资源、排污费</td>
                  <td align="center">&nbsp;10</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield10" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield42" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;销售费用</td>
                  <td align="center">&nbsp;11</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield11" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield43" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：商品维修费</td>
                  <td align="center">&nbsp;12</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield12" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield44" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;广告费和业务宣传费</td>
                  <td align="center">&nbsp;13</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield13" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield45" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;管理费用</td>
                  <td align="center">&nbsp;14</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield14" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield46" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：开办费</td>
                  <td align="center">&nbsp;15</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield15" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield47" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业务招待费</td>
                  <td align="center">&nbsp;16</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield16" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="textfield48" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;研究费用</td>
                  <td align="center">&nbsp;17</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;财务费用</td>
                  <td align="center">&nbsp;18</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：利息费用(收入以”-“号填列)</td>
                  <td align="center">&nbsp;19</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加：投资收益</td>
                  <td align="center">&nbsp;20</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;二、营业利润</td>
                  <td align="center">&nbsp;21</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加:营业外收入</td>
                  <td align="center">&nbsp;22</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：政府补助</td>
                  <td align="center">&nbsp;23</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;减:营业外支出</td>
                  <td align="center">&nbsp;24</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：坏账损失</td>
                  <td align="center">&nbsp;25</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;无法收回的长期债券投资损失</td>
                  <td align="center">&nbsp;26</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;无法收回的长期股权投资损失</td>
                  <td align="center">&nbsp;27</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;自然灾害等不可抗力因素造成的损失</td>
                  <td align="center">&nbsp;28</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;税收滞纳金</td>
                  <td align="center">&nbsp;29</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;三、利润总额(亏损总额以"-"号填列)</td>
                  <td align="center">&nbsp;30</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues0" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id=propertyValues class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;减:所得税费用</td>
                  <td align="center">&nbsp;31</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues1" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>四、净利润(净亏损以"-"号填列)</td>
                  <td align="center">&nbsp;32</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" readonly="readonly" type="text" id="propertyValues" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^\d\.]/g,'')" /></td>
                </tr>
              </tbody>
            </table></td>
        </tr>
        <tr>
          <td><table border=0 cellSpacing=0 cellPadding=0 width=640 align=center>
              <tbody>
                <tr height=25 >
                  <td width=240 align=right>填报日期: <fmt:formatDate value="${result.value.fillTime}" pattern="yyyy-MM-dd"/> </td>
                </tr>
              </tbody>
            </table></td>
        </tr>
      </tbody>
    </table>
  </div>
</center>
</form>
</body>
</html>