<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		calcTotal();
	});
	function calcTotal(){
		var total = 0;
		$(".fee").each(function(){
			if($(this).val()){
				total += parseFloat($(this).val());
			}
		});
		total = Math.round(total*100)/100;
		$("#totalFee").html(total);
	}
	function toSubmit(){
		$("#form1").ajaxSubmit({
	        dataType: 'json',		        
	        success: function(data){
        		showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		setTimeout("getOpener().reloadBillPlanRentList();parent.fb.end();", 2000);
	        	}
	        } 
	    });
	}
</script>
</head>

<body>
<form action="<%=basePath %>billPlanRent!submitBillPlan.action" method="post" name="form1" id="form1">
	<input type="hidden" value="${id}" name="id"/>
	<input type="hidden" value="${feeType}" name="feeType"/>
	<input type="hidden" value="${memo}" name="memo"/>
	<c:if test="${result.success}">
	<div class="basediv" id="textname" name="textname">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="30" class="tdleftc">序号</td>
				<td width="50" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">类型</td>
				<td class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">时间段</td>
				<td width="70" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">计划付费</td>
				<td width="70" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">计划金额</td>
				<td width="90" class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">实际金额</td>
			</tr>
		</table>
		<div style="height:220px; overflow-x:hidden; overflow-y:scroll; *+padding-right:18px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<c:forEach items="${result.value}" var="billPlanRent" varStatus="s">
			<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
				<td width="30" class="centertd">${s.index+1}</td>
				<td width="50" class="centertd">${billPlanRent.feeType.title}</td>
				<td class="centertd">
					<input type="hidden" name="prices" value="${billPlanRent.price}"/>
					<input type="hidden" name="amounts" value="${billPlanRent.amount}"/>
					<fmt:formatDate value="${billPlanRent.startDate}" pattern="yyyy-MM-dd"/>
					<input type="hidden" name="startDates" value="<fmt:formatDate value="${billPlanRent.startDate}" pattern="yyyy-MM-dd"/>"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<fmt:formatDate value="${billPlanRent.endDate}" pattern="yyyy-MM-dd"/></td>
					<input type="hidden" name="endDates" value="<fmt:formatDate value="${billPlanRent.endDate}" pattern="yyyy-MM-dd"/></td>"/>
				<td width="70" class="centertd"><input type="hidden" name="planPayDates" value="<fmt:formatDate value="${billPlanRent.planPayDate}" pattern="yyyy-MM-dd"/>"/><fmt:formatDate value="${billPlanRent.planPayDate}" pattern="yyyy-MM-dd"/></td>
				<td width="70" class="centertd"><input type="hidden" name="planFees" value="<fmt:formatNumber value="${billPlanRent.planFee}" pattern="#0.##"/>"/><fmt:formatNumber value="${billPlanRent.planFee}" pattern="#0.##"/></td>
				<td width="75" class="centertd"><input value="<fmt:formatNumber value="${billPlanRent.planFee}" pattern="#0.##"/>" type="text" name="realFees" class="input60 fee" onblur="calcTotal()" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
			</tr>
			</c:forEach>
		</table>
		</div>
	</div>
	<div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr style="background:#f4f4f4;">
				<td class="centertd">&nbsp;</td>
				<td class="centertd" width="80">合计：</td>
				<td id="totalFee" class="centertd" width="75">0.00</td>
				<td class="centertd" width="15">&nbsp;</td>
			</tr>
		</table>
	</div>
	</c:if>
	<c:if test="${!result.success}">${result.msg}</c:if>
	<div class="buttondiv">
		<c:if test="${result.success}"><label><input name="Submit" type="button" class="savebtn" value="" onclick="toSubmit()"/></label></c:if>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	</div>
</form>
</body>
</html>

