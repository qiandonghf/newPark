<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

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
	function setSelectedUser(user){
		$("#hostId").val(user.id);
		$("#host").val(user.realName);
	}
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
</script>
</head>

<body>
<form action="" method="post" enctype="multipart/form-data" name="form1" id="form1">
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">企业名称：</td>
					<td class="layerright" colspan="3">${result.value.customer.name}</td>
				</tr>
				<tr>
					<td class="layertdleft100">帐单类型：</td>
					<td class="layerright" colspan="3">${result.value.billType.typeName}</td>
				</tr>
				<tr>
					<td class="layertdleft100">流水号：</td>
					<td class="layerright">${result.value.number}</td>
					<td class="layertdleft100">状态：</td>
					<td class="layerright">${result.value.status.title}</td>
				</tr>
				<tr>
					<td class="layertdleft100">合同编号：</td>
					<td class="layerright">${result.value.contractNo}</td>
					<td class="layertdleft100">房间编号：</td>
					<td class="layerright"><c:if test="${result.value.room ne ''}">${result.value.room.name}</c:if></td>
				</tr>
				<tr>
					<td class="layertdleft100">计划支付金额：</td>
					<td class="layerright"><fmt:formatNumber value="${result.value.totalAmount}" pattern="#0.00"/></td>
					<td class="layertdleft100">实际支付金额：</td>
					<td class="layerright"><fmt:formatNumber value="${result.value.factPayment}" pattern="#0.00"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">计划支付时间：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.planPayTime}" pattern="yyyy-MM-dd"/></td>
					<td class="layertdleft100">实际支付时间：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.payTime}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">滞纳金：</td>
					<td class="layerright"><span class="redweight">￥<fmt:formatNumber value="${result.value.penalty}" pattern="#0.00"/></span></td>
					<td class="layertdleft100">已催缴：</td>
					<td class="layerright">${result.value.urged.title}</td>
				</tr>
				<tr>
					<td class="layertdleft100">收支：</td>
					<td class="layerright">${result.value.inOut.title}</td>
					<td class="layertdleft100">是否发票：</td>
					<td class="layerright">${result.value.invoice.title}</td>
				</tr>
				<tr>
					<td class="layertdleft100">出帐日期：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.createTime}" pattern="yyyy-MM-dd"/></td>
					<td class="layertdleft100">支付方式：</td>
					<td class="layerright">${result.value.payType.title}</td>
				</tr>
				<tr>
					<td class="layertdleft100">费用起始日期：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.feeStartTime}" pattern="yyyy-MM-dd"/></td>
					<td class="layertdleft100">费用截止日期：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.feeEndTime}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">备注：</td>
					<td class="layerright" colspan="3">${result.value.memo}</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="window.print();window.opper=null;window.close()"><span><img src="core/common/images/print_btn.gif"/>打印</span></a>
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end();"><span><img src="core/common/images/closebtnicon.gif" />取消</span></a>
	</div>
</form>
</body>
</html>