<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
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
	var url = '<%=basePath%>billPlanFacility!listAll.action';
	<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Customer)){%>
		url = '<%=basePath%>billPlanFacility!listByCustomerId.action';
	<%}%>
	var height = getTabContentHeight()-105;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#list").jqGrid({
    	url:url,
		colModel: [
			{label:'设施名称',name:'facility.name', align:"center"}, 
			{label:'企业名称',name:'customer.name', align:"center"}, 
			{label:'开始时间', width:85,name:'startDate', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
		    {label:'结束时间', width:85,name:'endDate', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
		    {label:'金额', width:75,name:'realFee', align:"center",formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}},
		    {label:'计划付费时间', width:85,name:'planPayDate', align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
		    {label:'状态', width:50,name:'status.title', align:"center"},
		    {label:'最后付费日期', width:85,name:'lastPayDate', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
		    {label:'出账日期', width:85,name:'intoAccountDate', align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}
		],
		shrinkToFit: false,	
		height:height,
		width:width,
		pager: "#pager",
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_costList_view")){%>
				content += "<img src=\"parkmanager.pb/web/images/rmb.png\" width=\"14\" height=\"14\" title=\"费用清单\" onclick=\"viewCostById('"+id+"');\"  /> "; 
				<%}%>
				$(this).jqGrid('setRowData',id,{manager:content});
			}
		},
	}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
}

function reloadList(){
	$("#list").trigger("reloadGrid");
}

function doSearch(){
	var filters = getSearchFilters();
	search(filters);
}
function search(filters){
	$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
}

function deleteSelected(){
	var ids = $("#list").jqGrid("getGridParam","selarrrow");
	if(ids!='' && confirm("确定要删吗")){
		$.post("<%=basePath%>billPlanFacility!delete.action?ids="+ids,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}



</script>
</head>

<body>
	<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_costList_delete")){%>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
				<%} %>
				</ul>
			</div>
	</div>
	
	<div class="searchdivkf">
	  <form id="form2" name="form2" method="post" action="">
	    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
	      <tr>
	        <td width="65" align="right">设施名称： </td>
	        <td width="105">
	       	    <search:input id="name" dataType="string" field="facility.name" op="cn" inputClass="input100"/> 
	        </td>
	        <td width="70" align="right">开始时间：</td>
	        <td width="120"><table width="100%" border="0" cellspacing="2" cellpadding="0">
	          <tr>
	            <td width="105">
	            	<search:choose dataType="java.util.Date" field="startDate" op="ge">
						<input class="data inputauto" id="startDate" onclick="return showCalendar('startDate')"/>
					</search:choose>
	            </td>
	            <td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="return showCalendar('startDate')"/></td>
	          </tr>
	        </table></td>
	        <td width="70" align="right">结束时间：</td>
	       <td width="120"><table width="100%" border="0" cellspacing="2" cellpadding="0">
	          <tr>
	            <td width="105">
	            	<search:choose dataType="java.util.Date" field="endDate" op="le">
						<input class="data inputauto" id="endDate" onclick="return showCalendar('endDate')"/>
					</search:choose>
	            </td>
	            <td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="return showCalendar('endDate')"/></td>
	          </tr>
	        </table></td>
	        <td width="70" align="center"><label>
	          <input name="Submit"  class="searchbtn" value="" onclick="doSearch()"/>
	        </label></td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	    </table>
	  </form>
	</div>
	
	
	<div class="msglist" id="msglist">
		<div id="container">
			<table id="list" class="jqGridList"><tr><td/></tr></table>
			<div id="pager"></div>
		</div>
	</div>
	

	
	
	
</body>
</html>
