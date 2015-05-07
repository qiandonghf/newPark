<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String action = request.getParameter("action");
%>
<div class="pm_msglist" style="margin-top:2px;">
	<div class="titlebg">基本信息</div>
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">合同名称：</td>
				<td class="layerright" width="270">${result.value.name}</td>
				<td class="layertdleft100">合同编号：</td>
				<td class="layerright">${result.value.contractNo}</td>
			</tr>
			<tr>
				<td class="layertdleft100">企业名称：</td>
				<td class="layerright">${result.value.customer.name}</td>
				<td class="layertdleft100">承租用途：</td>
				<td class="layerright">${result.value.purpose}</td>
			</tr>
			<tr>
				<td class="layertdleft100">负责人：</td>
				<td class="layerright">${result.value.manager.realName}</td>
				<td class="layertdleft100">签订日期：</td>
				<td class="layerright"><fmt:formatDate value="${result.value.signDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">交付日期：</td>
				<td class="layerright"><fmt:formatDate value="${result.value.receiveDate}" pattern="yyyy-MM-dd"/></td>
				<td class="layertdleft100">合同期限：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100"><fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/><span style="padding-left:4px;padding-right:4px;">—</span><fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/></td>
							<td width="20" align="center"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">合同总额：</td>
				<td class="layerright">
					<c:if test="${result.value.totalAmount ne null}">
					<fmt:formatNumber value="${result.value.totalAmount}" pattern="#0.00"/>&nbsp;元
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	<div class="hackbox"></div>
</div>