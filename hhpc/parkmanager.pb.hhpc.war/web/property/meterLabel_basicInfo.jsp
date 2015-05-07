<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.pb.preferences.enums.MeterKindEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.wiiy.commons.preferences.enums.TitleEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>web/style/ps.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/easyslider1.7/css/slider.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/easyslider1.7/js/easySlider1.7.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		 initTip();
	});
	
	function deleteMeterLabel(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>meterLabel!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		setTimeout("parent.fb.end();window.parent.location.reload();", 2000);
	        	}
			});
		}
	}
</script>
</head>

<body>
<div id="container">
<input id="ids" type="hidden"/>
<input id="recordIds" type="hidden"/>

	<jsp:include page="common.jsp">
			<jsp:param value="0" name="index"/>
			<jsp:param value="${result.value.id}" name="labelId"/>
			<jsp:param value="${result.value.type}" name="labelType"/>
			<jsp:param value="${result.value.checkOut}" name="checkOut"/>
	</jsp:include>
<div class="pm_msglist tabswitch" id="textname">
	<div class="emailtop">
		<div class="leftemail">
			<ul>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_meterLabel_edit")){ %>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('编辑分户表抄表','<%=basePath%>meterLabel!edit.action?id='+${result.value.id},400,360);"><span><img src="core/common/images/edit.gif" /></span>编辑</li>
			<%} %>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_meterLabel_delete")){ %>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteMeterLabel(${result.value.id})"><span><img src="core/common/images/emaildel.png" /></span>删除报表</li>
			<%} %>
			</ul>
		</div>
	</div>
				<div class="" style="padding:1px 1px 0; border-bottom:1px solid #ddd;">
				    <table width="100%" border="0" cellspacing="0" cellpadding="0">
				      <tr>
				        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
				            <tr>
				            	<td width="100" class="layertdleft100">报表名：</td>
				            	<td class="layerright">${result.value.name}</td>
				           	</tr>
				            <tr>
				            	<td class="layertdleft100">报表类型：</td>
				            	<td class="layerright">${result.value.type.title}</td>
				            </tr>
				            <tr>
				            	<td class="layertdleft100">制表日期：</td>
				            	<td class="layerright"><fmt:formatDate value="${result.value.date}" pattern="yyyy-MM-dd"/></td>
				            </tr>
				            <tr>
    							<td class="layertdleft100">抄表区间：</td>
    							<td class="layerright">
    								<table>
    									<tr>
    										<td><fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd"/></td>
	            							<td>--</td>
	            							<td><fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd"/></td>
    									</tr>
    								</table>
    							</td>
   							</tr>
				            <tr>
				            	<td class="layertdleft100">制表人：</td>
				            	<td class="layerright">${result.value.reader}</td>
				            </tr>
				            <tr>
				          	    <td class="layertdleft100">所在楼宇：</td>
				                <td class="layerright">
					                 <div style=" vertical-align:middle;height:40px;width:450px; overflow-x:hidden; overflow-y:auto;">
					                	${buildingNames}
				                	</div>	
				                </td>
				            </tr>
				            <tr>
				                <td class="layertdleft100" style="height:50px;"> 备注 </td>
				                <td class="layerright">
				                 <div style=" vertical-align:middle;height:40px; overflow-x:hidden; overflow-y:auto;">
				                	${result.value.memo}
				                	</div>
				                </td>
				            </tr>
				          </table>
				        </td>
				      </tr>
				    </table>
 				 </div>	
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
