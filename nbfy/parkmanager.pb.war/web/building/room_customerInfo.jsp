<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=BaseAction.rootLocation %>/"/>
		<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
		<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
	</head>

<body style="background:#fff;">
	<div class="pm_msglist">
	<div class="basediv" style="height:182px;">
		<div class="divlays">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			  <td class="layertdleft100">企业名称：</td>
			  <td class="layerright" width="23%">${result.value.name }</td>
			  <td class="layertdleft100" >企业编号：</td>
			  <td class="layerright" width="16%">${result.value.code }</td>
			  <td class="layertdleft100">币种：</td>
			  <td class="layerright" width="16%">${result.value.customerInfo.currencyType.dataValue }</td>
			</tr>
			<tr>
			  <td class="layertdleft100">首要联系人：</td>
			  <td class="layerright">${result.value.customerInfo.legalPerson}</td>
			  <td class="layertdleft100">移动电话：</td>
			  <td class="layerright">${result.value.customerInfo.cellphone }</td>
			  <td class="layertdleft100">注册资本：</td>
			  <td class="layerright"><fmt:formatNumber value="${result.value.customerInfo.regCapital}" pattern="#0.00"/>(万元)</td>
			</tr>
			<tr>
			  <td class="layertdleft100">办公电话：</td>
			  <td class="layerright">${result.value.customerInfo.officePhone }</td>
			  <td class="layertdleft100">传真：</td>
			  <td class="layerright">${result.value.customerInfo.fax }</td>
			  <td class="layertdleft100">E-mail：</td>
			  <td class="layerright">${result.value.customerInfo.email }</td>
			</tr>
			<tr>
			  <td class="layertdleft100">注册地址：</td>
			  <td class="layerright">${result.value.customerInfo.regAddress }</td>	
			  <td class="layertdleft100">成立时间：</td>
			  <td class="layerright"><fmt:formatDate value="${result.value.customerInfo.regTime }" pattern="yyyy-MM-dd"/></td>
			  <td class="layertdleft100">营业截至时间：</td>
			  <td class="layerright"><fmt:formatDate value="${result.value.customerInfo.businessExpireDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
		  </table>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			  <td class="layertdleft100">经营范围：</td>
			  <td class="layerright" width="85%"><div style="height: 40px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">${result.value.customerInfo.businessScope }</div></td>
			</tr>
		  </table>
		  </div>
		  </div>
	</div>
</body>
</html>
