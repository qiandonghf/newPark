<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
	});
	
	function update(id){
		var url = "<%=basePath %>park!update.action";
		var data = {"park.water":$("#water"+id).val(),"park.electricity":$("#electricity"+id).val(),"park.gas":$("#gas"+id).val(),"park.id":id};
		$.post(url,data,function(data){
			showTip(data.result.msg,2000);
		});
	}
	
</script>
</head>

<body>
<div class="pm_msglist" >
   	<div class="titlebg">默认水电气单价</div>
   	<div class="basediv" style="height:395px; overflow-y:auto; overflow-x:hidden">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<c:forEach items="${parkList }" var="park">
			<tr>
				<td class="layertdleft100"><label>园区名称：</label></td>
	            <td class="layerright"><label><input type="hidden" name="id${park.id }" value="${park.id }"/>${park.name }</label></td>
			</tr>	
			<tr>
				<td class="layertdleft100"><label>水价：</label></td>
	            <td class="layerright"><label><input id="water${park.id }" name="park.water" value="<fmt:formatNumber value="${park.water}" pattern="#0.00"/>" type="text" class="input100" /> 元</label></td>
			</tr>	
			<tr>
				<td class="layertdleft100"><label>电价：</label></td>
	            <td class="layerright"><label><input id="electricity${park.id }" name="park.electricity" value="<fmt:formatNumber value="${park.electricity}" pattern="#0.00"/>" type="text" class="input100" /> 元</label></td>
			</tr>	
			<tr>
				<td class="layertdleft100"><label>气价：</label></td>
	            <td class="layerright"><label><input id="gas${park.id }" name="park.gas" value="<fmt:formatNumber value="${park.gas}" pattern="#0.00"/>" type="text" class="input100" /> 元</label></td>
			</tr>
			<tr>
				<td class="layertdleft100"><label>操作：</label></td>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_energyFeeList_update")) {%>
				<td class="layerright"><lable><img id="save${park.id }" src="<%=basePath %>web/images/pbseavebtn.gif" onclick="update($(this).attr('id').replace('save',''))"/></lable></td>
				<%} %>
			</tr>
		</c:forEach>
	</table>
</div>
</div>
</body>
</html>
