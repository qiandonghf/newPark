<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/printC_table.css"/>

<style>       
@media print{     
    div.buttondiv{display:none;}   
}   
</style>

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>

<script type="text/javascript">
	$(function(){
		initTip();
	});
	function pay(){
		if(confirm('确认结算?')){
			$.post("<%=basePath%>bill!pay.action",{ids:$("#ids").val(),payTime:$("#payTime").val()},function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					setTimeout("getOpener().reloadList();parent.fb.end()", 2000);
				}
			});
		}
	}
</script>
</head>

<body style="background:#eee; padding:0; margin:4px;">
<input type="hidden" value="${ids}" id="ids"/>
<input type="hidden" value="${payTime}" id="payTime"/>
<div class="basediv">
	<div class="companydivlist" style="height:400px; overflow-y:auto; overflow-x:hidden; margin:0; padding:0;">
		<table class="" border="0" cellpadding="0" cellspacing="1" style="background:#C3C3C3; width:100%;">
			<tr>
				<td style="background:#fff; padding:4px;">
				<div style="height:30px; font: bold 14px/30px ''; text-align:center;"><strong>退款通知单</strong></div>
				
				<ul class="table_list">
				<c:forEach items="${result.value}" var="dto">
				<li>
				<div><span class="flLt">${dto.customerName}</span><span class="flRt">单位：元 </span></div>
				    <table border="1" bordercolor="#ccc" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse">
				    	<tr>
				        	<th width="100">费用类型</th>
				            <th width="150">计费时间</th>
				            <!-- <th width="80">数量</th>
				            <th>单价</th> -->
				            <th width="90">出帐日期</th>
				            <th width="100">金额</th>
				        </tr>
				        <c:forEach items="${dto.billList}" var="bill">
					        <tr>
					           <td align="center">${bill.billType.typeName}</td>
					           <td align="center"><fmt:formatDate value="${bill.feeStartTime}" pattern="yyyy-MM-dd"/> – <fmt:formatDate value="${bill.feeEndTime}" pattern="yyyy-MM-dd"/></td>
					           <%-- <td align="center"><fmt:formatNumber value="${bill.amount}" pattern="#.##"/></td>
					           <td align="center">${bill.price}</td> --%>
					           <td align="center"><fmt:formatDate value="${bill.checkoutTime}" pattern="yyyy-MM-dd"/></td>
					           <td align="right"><fmt:formatNumber value="${bill.factPayment}" pattern="#0.00"/></td>
					        </tr>
				        </c:forEach>
				        <tr>
				        	<td colspan="3" align="right">合计：</td>
				           <td align="right"><fmt:formatNumber value="${dto.total}" pattern="#0.00"/></td>
				        </tr>
				    </table>
				</li>
				</c:forEach>
				</ul>
					<div class="clear" style="padding-right: 150px;"><span class="flRt">结算日期：${payTime}</span></div>
				</td>
			</tr>
		</table>
	</div>
    <div class="buttondiv" style="margin-top:4px;">
		<label><input name="Submit" type="button" class="psviewbtn" value="" onclick="window.print();window.opper=null;window.close()" /></label>
	</div>
</div>
</body>
</html>
