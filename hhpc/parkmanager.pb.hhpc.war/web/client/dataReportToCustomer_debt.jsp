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
	width:84px;
	padding-right: 10px;
	text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
	initTip();
	$(".salestax15").keyup(function(){
		changeSalestax(15,'');
	});
	$(".salestax15t").keyup(function(){
		changeSalestax(15,'t');
	});
	$(".salestax29").keyup(function(){
		changeSalestax(29,'');
	});
	$(".salestax29t").keyup(function(){
		changeSalestax(29,'t');
	});
	$(".salestax41").keyup(function(){
		changeSalestax(41,'');
	});
	$(".salestax41t").keyup(function(){
		changeSalestax(41,'t');
	});
	$(".salestax46").keyup(function(){
		changeSalestax(46,'');
	});
	$(".salestax46t").keyup(function(){
		changeSalestax(46,'t');
	});
	$(".salestax52").keyup(function(){
		changeSalestax(52,'');
	});
	$(".salestax52t").keyup(function(){
		changeSalestax(52,'t');
	});
});
function checkForm(status){
	if(status==1){
		$("#status").val("SAVED");
	} else if(status==2){
		$("#status").val("PUB");
	}
	var v1 = $("#feeValue30").val();
	var v2 = $("#feeValue53").val();
	var v3 = $("#feeValue30t").val();
	var v4 = $("#feeValue53t").val();
	if(v1==v2 && v3==v4){
		$("#form1").ajaxSubmit({
	        dataType: 'json',		        
	        success: function(data){
	       		showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		window.opener.reloadList();
	        		setTimeout("self.close(); ", 2000);
	        		//setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
	        	}
	        } 
	    });
	}else{
		showTip("资产合计与负债和所有者权益(或股东权益)合计不等",2000);
	}
	
}
/*
 * 数值计算（累计）
 */
function changeSalestax(valueNo,type){
	var money = 0;
	$(".salestax"+valueNo+type).each(function(){
		money = money+checkFeeNull($(this).val());
	});
	$("#feeValue"+valueNo+type).val(money.toFixed(2));
	if(valueNo==15 || valueNo==29){
		changeSalestax(30,type);
	}
	if(valueNo==41 || valueNo==46){
		changeSalestax(47,type);
		changeSalestax(53,type);
	}
	if(valueNo==52){
		changeSalestax(53,type);
	}
	//changeFee(type);
}
function checkFeeNull(value){
	if(value!=null && value!=''){
		return parseFloat(value);
	}else{
		return 0;
	}
}
/*
 * 序号20计算
 */
function changeFee(type){
	var fee = checkFeeNull($("#feeValue18"+type).val())-checkFeeNull($("#feeValue19"+type).val());
	$("#feeValue20"+type).val(fee.toFixed(2));
	changeSalestax("29",type);
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
	int i = 243;
	int j = 303;
%>
<center>
  <br/>
  <div align=center style='width:96%'>
    <table id=t width=720 align=center>
      <tbody>
        <tr>
       		<td><table border=0 cellSpacing=0 cellPadding=0 width=720 align=center>
              <tbody>
                <tr align=right>
                  <td colSpan=4>&nbsp;</td>
                </tr>
                <tr >
                  <td style="DISPLAY: none" id=ca_1 width="25%"></td>
                  <td colSpan=4 align="center"><FONT size=4><B>企业资产负债表(${result.value.report.group.name}-${result.value.report.name})</B></FONT></td>
                  <td style="DISPLAY: none" id=ca_2 width="25%" align=right><IMG src="pages/tf/wsxt/cwgl/image/ca.gif"></td>
                </tr>
              </tbody>
            </table></td>
        </tr>
        <tr>
        	<td><table border=0 cellSpacing=0 cellPadding=0 width=720 align=center>
              <tbody>
                <tr>
                  <td align=left>编制单位:${result.value.customer.name}</td>
                  <td align=right>单位: 元</td>
                </tr>
              </tbody>
            </table></td>
        </tr>
        <tr>
          <td><table style="BORDER-COLLAPSE: collapse; table-LAYOUT: fixed" border=1 borderColor=#000000 width=720 frame=box align=center>
              <tbody>
                <tr height=25 >
                  <td width=156>资&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产</td>
                  <td width=24>行次</td>
                  <td width=94>期末余额</td>
                  <td width=94>年初余额</td>
                  <td width=140>
                    负债和所有者
                      
                    <br>
                    权益(或股东权益)                    </td>
                  <td width=24>行次</td>
                  <td width=94>期末余额</td>
                  <td width=94>年初余额</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>流动资产:</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>流动负债:</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;货币资金</td>
                  <td align="center">&nbsp;1</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield2" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;短期借款</td>
                  <td align="center">&nbsp;31</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield3" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield4" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;短期投资</td>
                  <td align="center">&nbsp;2</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield5" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield6" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;应付票据</td>
                  <td align="center">&nbsp;32</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield68" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield77" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;应收票据</td>
                  <td align="center">&nbsp;3</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield7" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield8" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;应付账款</td>
                  <td align="center">&nbsp;33</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield76" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield78" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;应收账款</td>
                  <td align="center">&nbsp;4</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield9" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield10" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;预收账款</td>
                  <td align="center">&nbsp;34</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield69" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield79" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;预付账款</td>
                  <td align="center">&nbsp;5</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield11" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield38" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;应付职工薪酬</td>
                  <td align="center">&nbsp;35</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield70" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield80" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;应收股息</td>
                  <td align="center">&nbsp;6</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield12" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield39" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;应交税费</td>
                  <td align="center">&nbsp;36</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield71" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield81" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;应收利息</td>
                  <td align="center">&nbsp;7</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield13" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield40" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;应付利息</td>
                  <td align="center">&nbsp;37</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield72" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield82" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;其他应收款</td>
                  <td align="center">&nbsp;8</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield14" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield41" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;应付利润</td>
                  <td align="center">&nbsp;38</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield73" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield83" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;存货</td>
                  <td align="center">&nbsp;9</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield15" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield42" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;其他应付款</td>
                  <td align="center">&nbsp;39</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield74" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield84" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;其中：原材料</td>
                  <td align="center">&nbsp;10</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield16" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield43" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;其他流动负债</td>
                  <td align="center">&nbsp;40</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield75" class="double salestax41" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield85" class="double salestax41t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在产品</td>
                  <td align="center">&nbsp;11</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield17" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield44" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;流动负债合计</td>
                  <td align="center">&nbsp;41</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="feeValue41" readonly="readonly" class="double salestax47" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="feeValue41t" readonly="readonly" class="double salestax47t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;库存商品</td>
                  <td align="center">&nbsp;12</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield18" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield45" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>非流动负债：</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;周转材料</td>
                  <td align="center">&nbsp;13</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield19" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield46" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;长期借款</td>
                  <td align="center">&nbsp;42</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield88" class="double salestax46" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield89" class="double salestax46t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;其他流动资产</td>
                  <td align="center">&nbsp;14</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="textfield20" class="double salestax15" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="textfield47" class="double salestax15t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;长期应付款</td>
                  <td align="center">&nbsp;43</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield90" class="double salestax46" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield94" class="double salestax46t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>流动资产合计</td>
                  <td align="center">&nbsp;15</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue15" readonly="readonly" class="double salestax30" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue15t" readonly="readonly" class="double salestax30t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;递延收益</td>
                  <td align="center">&nbsp;44</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield91" class="double salestax46" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield95" class="double salestax46t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>非流动资产：</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;&nbsp;其他非流动负债</td>
                  <td align="center">&nbsp;45</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield92" class="double salestax46" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="textfield96" class="double salestax46t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;长期债权投资</td>
                  <td align="center">&nbsp;16</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue16" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue16t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;非流动负债合计:</td>
                  <td align="center">&nbsp;46</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="feeValue46" readonly="readonly" class="double salestax47" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="feeValue46t" readonly="readonly" class="double salestax47t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;长期股权投资</td>
                  <td align="center">&nbsp;17</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue17" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue17t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;负债合计</td>
                  <td align="center">&nbsp;47</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="feeValue47" readonly="readonly" class="double salestax53" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input  type="text" id="feeValue47t" readonly="readonly" class="double salestax53t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>固定资产原价</td>
                  <td align="center">&nbsp;18</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue18" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue18t" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t');" /></td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;减:累计折旧</td>
                  <td align="center">&nbsp;19</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue19" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('');" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue19t" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'');changeFee('t');" /></td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;固定资产账面价值</td>
                  <td align="center">&nbsp;20</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue20" readonly="readonly" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue20t" readonly="readonly" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;在建工程</td>
                  <td align="center">&nbsp;21</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue21" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue21t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;工程物资</td>
                  <td align="center">&nbsp;22</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue22" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue22t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;固定资产清理</td>
                  <td align="center">&nbsp;23</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue23" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue23t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;生产性生物资产</td>
                  <td align="center">&nbsp;24</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue24" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue24t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>所有者权益(或股东权益):</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                  <td align=left>&nbsp;</td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;无形资产</td>
                  <td align="center">&nbsp;25</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue25" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue25t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;实收资本(或股本)</td>
                  <td align="center">&nbsp;48</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield100" class="double salestax52" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield101" class="double salestax52t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>开发支出</td>
                  <td align="center">&nbsp;26</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue26" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue26t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;资本公积</td>
                  <td align="center">&nbsp;49</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield102" class="double salestax52" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield107" class="double salestax52t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;长期待摊费用</td>
                  <td align="center">&nbsp;27</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue27" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue27t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;盈余公积</td>
                  <td align="center">&nbsp;50</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield103" class="double salestax52" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield108" class="double salestax52t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;其他非流动资产</td>
                  <td align="center">&nbsp;28</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue28" class="double salestax29" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue28t" class="double salestax29t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>&nbsp;&nbsp;未分配利润</td>
                  <td align="center">&nbsp;51</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield104" class="double salestax52" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="textfield109" class="double salestax52t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;非流动资产合计</td>
                  <td align="center">&nbsp;29</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue29" readonly="readonly" class="double salestax30" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input  type="text" id="feeValue29t" readonly="readonly" class="double salestax30t" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>所有者权益(或股东权益)合计</td>
                  <td align="center">&nbsp;52</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="feeValue52" readonly="readonly" class="double salestax53" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="feeValue52t" readonly="readonly" class="double salestax53t" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
                <tr height=25 align=right>
                  <td align=left>&nbsp;&nbsp;资产合计</td>
                  <td align="center">&nbsp;30</td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue30" readonly="readonly" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=i++%>"/><input type="text" id="feeValue30t" readonly="readonly" class="double" name="propertyValues" <%if(valueMap.get(i-1l)!=null && df.format(valueMap.get(i-1l).getDoubleVal())!=null){ %>value="<%=df.format(valueMap.get(i-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td align=left>负债和所有者权益(或股东权益)合计</td>
                  <td align="center">&nbsp;53</td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="feeValue53" readonly="readonly" class="double" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                  <td><input name="propertyIds" type="hidden" value="<%=j++%>"/><input type="text" id="feeValue53t" readonly="readonly" class="double" name="propertyValues" <%if(valueMap.get(j-1l)!=null && valueMap.get(j-1l).getDoubleVal()!=null){ %>value="<%=df.format(valueMap.get(j-1l).getDoubleVal()) %>"<%}%> onkeyup="value=value.replace(/[^-\d\.]/g,'')" /></td>
                </tr>
              </tbody>
            </table></td>
        </tr>
        <tr>
          <td><table border=0 cellSpacing=0 cellPadding=0 width=720 align=center>
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