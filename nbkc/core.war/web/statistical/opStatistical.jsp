<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initList();
	});
	function initList(){
		var height = getTabContentHeight()-77;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>operationLog!opList.action',
			colModel: [
				{label:'用户', name:'creator', align:"center",width:110}, 
				{label:'部门', name:'orgName', align:"center",width:90}, 
			    {label:'操作IP', name:'ip', align:"center",width:90}, 
			    {label:'操作时间', name:'createTime', align:"center",width:130, formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i:s', newformat: 'Y-m-d H:i:s'}},
			    {label:'内容', name:'msg', align:"center"}, 
			],
			shrinkToFit: false,
			height: height,
			width: width
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
		    caption : "列选择",
		    title : "选择要显示的列",
		    onClickButton : function(){
		        $(this).jqGrid('columnChooser');
		    }
		});
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
</script>
</head>

<body>
<div id="container">
	<div class="searchdiv">
	<form id="form2" name="form2" method="post" action="">
		<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40" align="right">用户： </td>
				<td width="120"><search:input dataType="string" field="creator" op="cn" inputClass="inputauto"/></td>
				<td width="50" align="right">部门： </td>
				<td width="155">
					<search:choose dataType="long" field="orgId" op="eq">
						<select class="data" style="width:150px; height:20px; line-height:20px;">
							<option value="">----请选择----</option>
							<c:forEach items="${result.value}" var="org">
								<option value="${org.id}">${org.name}</option>
							</c:forEach>
						</select>
					</search:choose>
        		</td>
				<td width="40" align="right">日期：</td>
				<td width="220">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<search:choose dataType="java.util.Date" field="createTime" op="ge">
								<input id="start" name="start" type="text" class="inputauto data" onclick="return showCalendar('start')"/>
								</search:choose>
							</td>
							<td width="20" ><img style="cursor:pointer;position: relative; left:-1px;" src="core/common/images/timeico.gif"  onclick="return showCalendar('start')" width="20" height="22" /></td>
							<td width="20"align="center">至</td>
							<td>
								<search:choose dataType="java.util.Date" field="createTime" op="le">
								<input id="end" name="end" type="text" class="inputauto data" onclick="return showCalendar('end')"/>
								</search:choose>
							</td>
							<td width="20" align="center"><img style="cursor:pointer;relative; left:-1px;" onclick="return showCalendar('end')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
							<td width="6"></td>
						</tr>
					</table>
				</td>
				<td width="75" align="center"><input name="" type="button" class="searchbtn" onclick="doSearch()"/></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
	</form>
	</div>
    <table id="list"><tr><td></td></tr></table>
    <div id="pager"></div>
</div>
</body>
</html>
