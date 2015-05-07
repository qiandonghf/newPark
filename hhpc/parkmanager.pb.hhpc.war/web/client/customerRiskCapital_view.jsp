<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<script type="text/javascript">
		</script>
	<style>
		table{
			table-layout:fixed;
		}
	</style>
	</head>
	
	<body>
			<div class="basediv">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">企业：</td>
						<td class="layerright">${result.value.customer.name}</td>
						<td class="layertdleft100">日期：</td>
						<td class="layerright">
							<fmt:formatDate value="${result.value.time }" pattern="yyyy-MM-dd" />
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">金额：</td>
						<td class="layerright">
							${result.value.money }<c:if test="${not empty result.value.money }">&nbsp;万元&nbsp;${result.value.currencyType.dataValue }</c:if>
						</td>
						<td class="layertdleft100">机构名称：</td>
						<td class="layerright">${result.value.orgName }</td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td class="layerright" colspan="3"><textarea name="customerRiskCapital.memo" readonly="readonly" style="border:0px;color:#666;padding-left:0px;resize:none;height:80px;" class="inputauto">${result.value.memo }</textarea></td>
					</tr>
				</table>
			</div>
			<div class="hackbox"></div>
		</div>
		<div class="" style="height:5px;">
		</div>
	</body>
</html>

