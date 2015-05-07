<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
		<style>
			table{
				table-layout:fixed;
			}
			td{
				white-space:nowrap;
				overflow:hidden;
				text-overflow:ellipsis;
			}
		</style>
	</head>

	<body>
			<div class="basediv">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">项目名称：</td>
						<td class="layerright"><span title="${result.value.gardenApply.projectName}">${result.value.gardenApply.projectName}</span></td>
					</tr>
					<tr>
						<td class="layertdleft100">备注内容：</td>
						<td class="layerright" style="padding:2px 3px;">
							<textarea style="color:#666;border:0px;height:80px;resize:none;overflow:hidden;overflow-y:auto;" 
								readonly="readonly" class="inputauto">${result.value.content}</textarea>
						</td>
					</tr>
				</table>
			</div>
			<div class="hackbox"></div>
		</div>
		<div style="height: 5px;"></div>
	</body>
</html>

