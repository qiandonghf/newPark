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
	$("#.salestax24").keyup(function(){
		changeSalestax(24,"");
	});
	$("#.salestax24t").keyup(function(){
		changeSalestax(24,"t");
	});
});
function checkForm(status){
	if(status==1){
		$("#status").val("SAVED");
	} else if(status==2){
		$("#status").val("PUB");
	}
	
	/* for(var i=0;i<33;i++){
		checkDouble($("#feeValue"+i).val());
	} */
	
	$("#form1").ajaxSubmit({
        dataType: 'json',		        
        success: function(data){
       		showTip(data.result.msg,2000);
        	if(data.result.success){
        		window.opener.reloadList();
        		setTimeout("self.close(); ", 2000);
        		/* setTimeout("getOpener().reloadList();parent.fb.end();", 2000); */
        	}
        } 
    });
}
/*
 * 数值计算（累计）
 */
function changeSalestax(valueNo,type){
	var money = 0;
	$(".salestax"+valueNo+type).each(function(){
		if($(this).val()!=null && $(this).val()!=''){
			money = money+parseFloat($(this).val());
		}
	});
	$("#feeValue"+valueNo+type).val(money.toFixed(2));
	changeFee(type);
	if(valueNo==24){
		changeFee2(type);
	}
}
function checkFeeNull(value){
	if(value!=null && value!=''){
		return parseFloat(value);
	}else{
		return 0;
	}
}
/**
 * 序号21计算
 */
function changeFee(type){
	var feeValue21 = checkFeeNull($("#feeValue1"+type).val())-checkFeeNull($("#feeValue2"+type).val())-checkFeeNull($("#feeValue3"+type).val())-checkFeeNull($("#feeValue11"+type).val())-checkFeeNull($("#feeValue14"+type).val())-checkFeeNull($("#feeValue18"+type).val())+checkFeeNull($("#feeValue20"+type).val());
	$("#feeValue21"+type).val(feeValue21.toFixed(2));
	changeFee2(type);
}
/**
 * 序号30计算
 */
function changeFee2(type){
	var feeValue30 = checkFeeNull($("#feeValue21"+type).val())+checkFeeNull($("#feeValue22"+type).val())-checkFeeNull($("#feeValue24"+type).val());
	$("#feeValue30"+type).val(feeValue30.toFixed(2));
	changeFee3(type);
}
/**
 * 序号32计算
 */
function changeFee3(type){
	var feeValue32 = checkFeeNull($("#feeValue30"+type).val())-checkFeeNull($("#feeValue31"+type).val());
	$("#feeValue32"+type).val(feeValue32.toFixed(2));
}
</script>
</head>
<body style="background-color: white;">
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
                  <td colSpan=4 align="center"><FONT size=4><B>企业利润表(${result.value.report.group.name}-${result.value.report.name})</B></FONT></td>
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
                <tr height=25>
                  <td width=360>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目</td>
                  <td width=40>行&nbsp;&nbsp;次</td>
                  <td width=120>本期累计金额</td>
                  <td width=120>本月金额</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;一、营业收入</td>
                  <td align="center">&nbsp;1</td>
                  <td ><label for="textfield"></label>
                    <input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue1" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('');" /></td>
                  <td ><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue1t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;减:主营业务成本</td>
                  <td align="center">&nbsp;2</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue2" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue2t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;营业税金及附加</td>
                  <td align="center">&nbsp;3</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input id="feeValue3" name="propertyValues" type="text"  class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input id="feeValue3t" name="propertyValues" type="text"  class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：消费税</td>
                  <td align="center">&nbsp;4</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue4" class="double salestax3" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue4t" class="double salestax3t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;营业税</td>
                  <td align="center">&nbsp;5</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue5" class="double salestax3"<%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue5t" class="double salestax3t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;城市建设维护税</td>
                  <td align="center">&nbsp;6</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue6" class="double salestax3" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue6t" class="double salestax3t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;资源税</td>
                  <td align="center">&nbsp;7</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue7" class="double salestax3" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue7t" class="double salestax3t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;土地增值税</td>
                  <td align="center">&nbsp;8</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue8" class="double salestax3" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue8t" class="double salestax3t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;城镇土地使用税、房产税、车船税、印花税</td>
                  <td align="center">&nbsp;9</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue9" class="double salestax3" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue9t" class="double salestax3t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;教育费附加、矿产资源、排污费</td>
                  <td align="center">&nbsp;10</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue10" class="double salestax3" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue10t" class="double salestax3t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;销售费用</td>
                  <td align="center">&nbsp;11</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input id="feeValue11" name="propertyValues" type="text"  id="textfield11" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input id="feeValue11t" name="propertyValues" type="text"  id="textfield43" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：商品维修费</td>
                  <td align="center">&nbsp;12</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue12" class="double salestax11" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue12t" class="double salestax11t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;广告费和业务宣传费</td>
                  <td align="center">&nbsp;13</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue13" class="double salestax11" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue13t" class="double salestax11t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;管理费用</td>
                  <td align="center">&nbsp;14</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input id="feeValue14"  name="propertyValues" type="text" id="feeValue14" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input id="feeValue14t"  name="propertyValues" type="text" id="feeValue14t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：开办费</td>
                  <td align="center">&nbsp;15</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue15" class="double salestax14" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue15t" class="double salestax14t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right> 
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业务招待费</td>
                  <td align="center">&nbsp;16</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue16" class="double salestax14" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue16t" class="double salestax14t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;研究费用</td>
                  <td align="center">&nbsp;17</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue17t" class="double salestax14" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue17t" class="double salestax14t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;财务费用</td>
                  <td align="center">&nbsp;18</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue18" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue18t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：利息费用(收入以”-“号填列)</td>
                  <td align="center">&nbsp;19</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue19" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue19t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加：投资收益</td>
                  <td align="center">&nbsp;20</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue20" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue20t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t');" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;二、营业利润</td>
                  <td align="center">&nbsp;21</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue21" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee2('')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue21t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee2('t')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加:营业外收入</td>
                  <td align="center">&nbsp;22</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue22" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee2('')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue22t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee2('t')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：政府补助</td>
                  <td align="center">&nbsp;23</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue23" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue23t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;减:营业外支出</td>
                  <td align="center">&nbsp;24</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue24" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee2('')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue24t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee2('t')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：坏账损失</td>
                  <td align="center">&nbsp;25</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue25" class="double salestax24" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue25t" class="double salestax24t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;无法收回的长期债券投资损失</td>
                  <td align="center">&nbsp;26</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue26" class="double salestax24" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue26t" class="double salestax24t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;无法收回的长期股权投资损失</td>
                  <td align="center">&nbsp;27</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue27" class="double salestax24" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue27t" class="double salestax24t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;自然灾害等不可抗力因素造成的损失</td>
                  <td align="center">&nbsp;28</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue28" class="double salestax24" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue28t" class="double salestax24t" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;税收滞纳金</td>
                  <td align="center">&nbsp;29</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue29" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue29t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;三、利润总额(亏损总额以"-"号填列)</td>
                  <td align="center">&nbsp;30</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue30" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee3('')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue30t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee3('t')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;减:所得税费用</td>
                  <td align="center">&nbsp;31</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue31" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee3('')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue31t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee3('t')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>四、净利润(净亏损以"-"号填列)</td>
                  <td align="center">&nbsp;32</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue32" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input name="propertyValues" type="text" id="feeValue32t" class="double" <%if(valueMap.get(i-1l)!=null && valueMap.get(i-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
              </tbody>
            </table></td>
        </tr>
        <tr>
          <td><table border=0 cellSpacing=0 cellPadding=0 width=640 align=center>
              <tbody>
                <tr height=25 >
                  <td width=240 align=right>填报日期: <c:if test="${result.value.fillTime ne null }"><fmt:formatDate value="${result.value.fillTime}" pattern="yyyy-MM-dd"/></c:if><c:if test="${result.value.fillTime eq null }"><fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd"/></c:if>  </td>
                </tr>
              </tbody>
            </table></td>
        </tr>
      </tbody>
    </table>
  </div>
</center>
<div class="buttondiv">
	<a href="javascript:void(0)" title="" onclick="checkForm(1)" class="btn_bg"><span><img src="core/common/images/savetemp_icon.gif">暂存</span></a>
	<a href="javascript:void(0)" title="" onclick="checkForm(2)" class="btn_bg"><span><img src="core/common/images/savebtnicon.gif">保存并上报</span></a>
	<a href="javascript:void(0)" title="" onclick="self.close();" class="btn_bg"><span><img src="core/common/images/closebtnicon.gif">取消</span></a>
</div>
</form>
</body>
</html>