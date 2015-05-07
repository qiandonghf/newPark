<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript">
			$(function(){
				initTip();
			});
			
		</script>
	<style>
		.layerright{
		word-break:break-all;
		}
		.layertdleft100{
			white-space:nowrap;
			width:18%;
		}
	</style>
	</head>

	<body>
		<form action="" method="post" name="form1" id="form1">
		<div class="basediv">
			<div class="divlays" style="margin: 0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred"></span>开始日期：</td>
						<td width="32%" class="layerright">
							<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>
						</td>
						<td class="layertdleft100"><span class="psred"></span>维修部位：</td>
						<td width="32%" class="layerright">${result.value.repairParts}</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred"></span>结束日期：</td>
						<td class="layerright">
							<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/>
						</td>
						<td class="layertdleft100"><span class="psred"></span>维修人员：</td>
						<td class="layerright">${result.value.repairStaff}</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred"></span>维修负责人：</td>
						<td class="layerright">${result.value.head}</td>
						<td class="layertdleft100"><span class="psred"></span>制单人：</td>
						<td class="layerright">${result.value.tabulator}</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred"></span>维修内容：</td>
						<td colspan="3" class="layerright"><div style="height: 60px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.repairContent}</div></td>
					</tr>
					<tr>
						<td class="layertdleft100">更换部件：</td>
						<td colspan="3" class="layerright"><div style="height: 60px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.repairComponents}</div></td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td colspan="3" class="layerright"><div style="height: 60px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.memo}</div></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="buttondiv" style="height:auto;padding-bottom:3px;">
		</div>
		</form>
	</body>
</html>

