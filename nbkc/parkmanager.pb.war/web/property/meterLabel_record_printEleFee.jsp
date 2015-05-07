<%@page import="com.wiiy.pb.entity.MeterLabelRecord"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>报表打印</title><link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="parkmanager.pb/web/style/print.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#overflowAuto').css('height',getTabContentHeight());
	});
	function exportData(){
		$("#exportDataFrame").attr("src", "<%=basePath%>meterLabelRecord!export.action?lableType=${lableType}&labelId=${labelId}");
	}
</script>
</head>

<body>
<iframe id="exportDataFrame" src="about:blank" style="display:none" width="0px" height="0px"></iframe>
<div class="overflowAuto" id="overflowAuto">
	<div style="width:820px; padding:10px 0 5px; margin:0 auto;">
	<h2 style="text-align:center; font-size:2em;">浙江大学科技园宁波发展有限公司电费结算单</h2>
	<div style="overflow:hidden; zoom:1; padding:10px 0;">
	<span style="float:right;font-size:12px;">制表人：<%=PbActivator.getSessionUser(request).getRealName() %></span>
	<span style=" font-size:12px;">结算期：<u><fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd"/></u>&nbsp;至&nbsp;<u><fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd"/></u></span>
	</div>
</div>
	<!--//tabletitle-->
<table border="1" cellpadding="0" cellspacing="0" class="table" align="center">
	<tr>
        	<td width="40" rowspan="2" align="center">序号</td>
        	<td width="70" rowspan="2" align="center">表名</td>
        	<td width="80" rowspan="2" align="center">企业名称</td>
		    <td width="70" rowspan="2" align="center">上月抄表数</td>
		    <td width="70" rowspan="2" align="center">本月抄表数</td>
		    <td width="80" rowspan="2" align="center">倍率</td>
		    <td width="80" rowspan="2" align="center">实用度数</td>
		    <td width="80" rowspan="2" align="center">损耗</td>
		    <td width="80" rowspan="2" align="center">合计度数</td>
		    <td width="80" rowspan="2" align="center">单价</td>
		    <td width="80" rowspan="2" align="center">金额</td>
		    <td width="120" colspan="2" align="center">基本电费</td>
		    <td width="80" rowspan="2" align="center">合计金额</td>
		    <td width="60" rowspan="2" align="center">用户单位签字</td>
		    </tr>
		    
		    <tr>
      			<td width="50" align="center">装机容量</td>
      			<td width="50">合计</td>
      		</tr>
      		<c:forEach items="${result.value.labelRecords}" var="list" varStatus="status">
	      		<tr>
       				<td height="25">${status.index+1}</td>
        			<c:forEach items="${result.value.meters }" var="meter">
        			<c:if test="${meter.orderNo==list.meterOrderNo }"><td>${meter.name}</td></c:if>
        			</c:forEach>
        			<td>${list.customerName}</td>
        			<td>${list.preReading}</td>
        			<td>${list.curReading}</td>
       				<td>${list.meterFactor}</td>
			        <td>${list.syAmount}</td>
			        <td>&nbsp;</td>
			       	<td>${list.totalAmount}</td>
			       	<td>${list.price}</td>
			       	<td>${list.bill}</td>
			       	<c:forEach items="${result.value.meters }" var="meter">
        			<c:if test="${meter.orderNo==list.meterOrderNo }">
        			<td>${meter.capacity}</td>
			        <td>${meter.capacityBill}</td>
			        </c:if>
        			</c:forEach>
			        <td>${list.totalBill}</td>
			        <td>&nbsp;</td>
	      			</tr>
      			</c:forEach>
    	</table>
    	<div class="tablefooter"><span></span></div>
		<div class="buttondiv" style="width:850px;text-align:left; height:29px; width:100%; text-align:center;">
		  	<label>
		   <input name="Submit" type="button" class="allbtn"  value="打印" onclick="window.print();window.opper=null;window.close()"/>
		  	</label>
		</div>
</div>
</body>
</html>

