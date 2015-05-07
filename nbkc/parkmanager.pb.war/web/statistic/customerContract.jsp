<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.dto.StatisticDto"%>
<%@page import="com.wiiy.crm.dto.StatisticGroupDto"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(
		function() {
			initTip();
			$('#overflowAuto').height($(window).height() - 84).width($(window).width() - 184);
			$("#resizable").css("height", getTabContentHeight());
			$("#msglist").css("height", getTabContentHeight() - 50);
			initList();
		});
	
</script>
</head>
<body>
	<!--container-->
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="182" valign="top"><div class="agency" id="resizable">
						<div class="titlebg">统计类型</div>
						<jsp:include page="bill_form_list_left.jsp">
							<jsp:param value="5" name="index" />
						</jsp:include>
					</div></td>
				<td width="100%" valign="top">
					<!--titlebg-->
					<div class="titlebg">分户明细表:</div>
					<!--//titlebg-->
					<div class="emailtop">
						<!--打印-->
						<div class="leftemail">
							<ul>
								<li onclick="location.href='<%=basePath%>statistic!exportContract.action'" onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/print_btn.gif"></span>打印</li>
							</ul>
						</div>
						<!--//打印-->
					</div>
					<div class="overflowAuto" id="overflowAuto">
						<!--[if lte ie 8]> <div style="+zoom:1"><![endif]-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1" style="white-space: nowrap; table-layout: fixed;">
							<thead>
								<tr>
									<th width="60" rowspan="2">序号</th>
									<th width="100" rowspan="2">档案号</th>
									<th width="80" rowspan="2">房号</th>
									<th width="150" rowspan="2">企业名称</th>
									<th width="90" rowspan="2">建筑面积(m2)</th>
									<th width="140" colspan="2">执行标准</th>
									<th width="120" rowspan="2">应收租金(元/年)</th>
									<th width="120" rowspan="2">应收能源费(元/年)</th>
									<th width="520" colspan="4">第一次缴费(实收金额)</th>
									<th width="520" colspan="4">第二次缴费(实收金额)</th>
									<th width="100" rowspan="2">已收押金(元)</th>
									<th width="100" rowspan="2" style="white-space: pre-wrap;">减免金额</th>
									<th width="140" rowspan="2">合同期限</th>
									<th width="80" rowspan="2">联系人</th>
									<th width="80" rowspan="2">联系电话</th>
									<th width="120" rowspan="2">入驻时间</th>
									<th width="220" rowspan="2">备注</th>
								</tr>
								<tr>
									<th width="70">房源</th>
									<th width="70">能源</th>
									<th width="170">期限</th>
									<th width="140">租金(元/半年)</th>
									<th width="140">能源费(元/半年)</th>
									<th width="90">网络费</th>
									<th width="170">期限</th>
									<th width="140">租金(元/半年)</th>
									<th width="140">能源费(元/半年)</th>
									<th width="90">网络费</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${result.value}" var="dto" varStatus="s">
								<tr>
									<td class="centertd">${s.index+1}</td>
									<td class="centertd">${dto.contract.contractNo}</td>
									<td class="centertd">${dto.rooms}</td>
									<td style="white-space: normal;">${dto.contract.customerName}</td>
									<td>${dto.area}</td>
									<td>${dto.rentPrice}</td>
									<td><fmt:formatNumber value="${dto.rentPrice}" pattern="#0.00"/></td>
									<td><fmt:formatNumber value="${dto.energyPrice}" pattern="#0.00"/></td>
									<td><fmt:formatNumber value="${dto.energyTotal}" pattern="#0.00"/></td>
									<td>${dto.firstHalfYearTime}</td>
									<td><fmt:formatNumber value="${dto.firstHalfYearMoneyRent}" pattern="#0.00"/></td>
									<td><fmt:formatNumber value="${dto.firstHalfYearMoneyEnergy}" pattern="#0.00"/></td>
									<td><fmt:formatNumber value="${dto.firstHalfYearMoneyNet}" pattern="#0.00"/></td>
									<td>${dto.secondHalfYearTime}</td>
									<td><fmt:formatNumber value="${dto.secondHalfYearMoneyRent}" pattern="#0.00"/></td>
									<td><fmt:formatNumber value="${dto.secondHalfYearMoneyEnergy}" pattern="#0.00"/></td>
									<td><fmt:formatNumber value="${dto.secondHalfYearMoneyNet}" pattern="#0.00"/></td>
									<td><fmt:formatNumber value="${dto.deposit}" pattern="#0.00"/></td>
									<td>${dto.contract.policy}</td>
									<td><fmt:formatDate value="${dto.contract.startDate}" pattern="yyyy-MM-dd"/>-<fmt:formatDate value="${dto.contract.endDate}" pattern="yyyy-MM-dd"/></td>
									<td>${dto.manager}</td>
									<td>${dto.managerPhone}</td>
									<td><fmt:formatDate value="${dto.contract.receiveDate}" pattern="yyyy-MM-dd"/></td>
									<td style="white-space: normal;"></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<!--[if lte ie 8]> </div><![endif]-->
					</div>
					<jsp:include page="../pager.jsp" />
				</td>
			</tr>
		</table>
	</div>
	<!--//container-->
</body>
</html>
