<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
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
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight()-28);
		$("#msglist").css("height",getTabContentHeight()-28);
		$("#treeviewdiv").css("height",getTabContentHeight()-82);
		initList();
		jqGridResizeRegister("list");
	});
	
	function initList(){
		var height = getTabContentHeight()-105;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>propertyFix!list.action',
			colModel: [
					{label:'状态', width:'80' ,name:'status.title', align:"center"}, 
					{label:'报修类型', width:'100' ,name:'type.dataValue', align:"center"}, 
					{label:'报修日期',width:110 , name:'reportTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
					{label:'报修方式',width:'105' , name:'method.dataValue', align:"center", hidden:true}, 
				    {label:'报修人', width:'100',name:'reporter', align:"center", hidden:true}, 
				    {label:'报修部门', width:'100' ,name:'orgName', align:"center", hidden:true},
				    {label:'报修地点', name:'reportAddr', align:"center"},
				    {label:'处理状态', name:'status', align:"center", hidden:true},
				    {label:'报修原因', width:'110' ,name:'reportReason', align:"center",formatter:count},
				    {label:'接待人员', name:'receiver', align:"center", hidden:true},
				    {label:'是否处理', name:'finished', align:"center", hidden:true},
				    {label:'报修单号', name:'oddNo', align:"center", hidden:true},
				    {label:'联系电话', name:'phone', align:"center", hidden:true},
				    {label:'完工日期', name:'finishTime', align:"center", hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				    {label:'维修人员', name:'maintainer', align:"center", hidden:true},
				    {label:'人工费用', name:'laborCosts', align:"center", hidden:true},
				    {label:'维修难度', name:'difficulty.title', align:"center", hidden:true},
				    {label:'满意程度', name:'satisficing.title', align:"center", hidden:true},
				    {label:'材料费用', name:'materialCosts', align:"center", hidden:true},
				    {label:'维修结果', name:'result', align:"center", hidden:true},
				    {label:'整改意见', name:'rectification', align:"center", hidden:true},
				    {label:'备注', name:'meno', align:"center", hidden:true},
				    {label:'管理', width:'110' ,name:'manager', align:"center",sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_propertyFix_hangIn")){%>
					content += "<img src=\"core/common/images/dj.png\" width=\"14\" height=\"14\" title=\"递交\" onclick=\"handIn('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_propertyFix_handle")){%>
					content += "<img src=\"core/common/images/cl.png\" width=\"14\" height=\"14\" title=\"处理\" onclick=\"handle('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_propertyFix_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_propertyFix_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_propertyFix_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
		    caption : "列选择",
		    title : "选择要显示的列",
		    onClickButton : function(){
		        $(this).jqGrid('columnChooser');
		    }
		});
	}
	function count(cellvalue,options,rowObject){
	   var reportReason = rowObject["reportReason"];
	   var cellvalue = reportReason;
	   if(reportReason.length > 15){
		   cellvalue = reportReason.substring(0,14)+"......";
	   }
	   return cellvalue;
	}
	
	
	function checkStatus(cellvalue,options,rowObject){
		var status = "";
		var cellvalue = "";
		status = rowObject["finished"];
		var fixStatus = rowObject["status"];
		if(status.title!='是'){
			cellvalue = "未处理";
		}else{
			cellvalue = fixStatus.title;
		}
		status = "";
		return cellvalue;
	}
	function viewById(id){
		fbStart('查看物业报修单','<%=basePath %>propertyFix!view.action?id='+id,800,231);
	}
	
	function editById(id){
		fbStart('编辑物业报修单','<%=basePath %>propertyFix!edit.action?id='+id,800,250);
	}
	
	function handIn(id){
		if(confirm("是否现在递交物业公司处理？")){
			$.post("<%=basePath%>propertyFix!hangIn.action?id="+id,function(data){
	        	if(data.result.success){
					showTip("递交成功",2000);
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function handle(id){
		fbStart('处理物业报修单','<%=basePath %>propertyFix!handle.action?id='+id,800,460);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>propertyFix!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>propertyFix!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function setSelectedOrg(selectedOrg) {
	    $("#orgName").val(selectedOrg.name);
	    $("#orgId").val(selectedOrg.id);
	}
	
	function doSearch(){
		var filters = getSearchFilters();
		search(filters);
	}
	
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
		$("#startTime1").val("");
		$("#startTime2").val("");
		$("#typeId").val("");
		$("#orgName").val("");
	}
	
	
</script>

</head>

<body>
<!--emailtop-->
<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_propertyFix_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建物业报修单','<%=basePath %>propertyFix!add.action',800,250);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_propertyFix_delete")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
				<%} %>
				</ul>
			</div>
		</div>
<!--//emailtop-->
<!--search-->
<div class="searchdiv">
    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
      <tr>
       <td width="65" align="right">报修日期：</td>
         <td width="230">
	        <table width="100%" border="0" cellspacing="0" cellpadding="10">
	          <tr>
	            <td width="90">
	            	<search:choose dataType="java.util.Date" field="reportTime" op="ge">
	            		<input id="startTime1" class="data inputauto" onclick="return showCalendar('startTime1')"/>
	            	</search:choose>
	            </td>
	            <td width="20">
	            	<img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('startTime1');" />
	            </td>
	            <td>--</td>
	            <td width="90">
	            	<search:choose dataType="java.util.Date" field="reportTime" op="le">
	            		<input id="startTime2" class="data inputauto" onclick="return showCalendar('startTime2')"/>
	            	</search:choose>
	            </td>
	            <td width="20">
	            	<img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('startTime2');" />
	            </td>
	          </tr>
	        </table>
	    </td>
	    
	    
        <td width="70" align="right">报修类型：</td>
        <td width="105">
        	<search:choose dataType="string" field="typeId" op="eq">
      			<dd:select id="typeId" styleClass="data" key="pb.0010"/>
      		</search:choose>
       	</td>
        <td width="70" align="center"><label>
          <input name="Submit" type="button" class="searchbtn" value="" onclick="doSearch();"/>
        </label></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
</div>
<!--//search-->
<!--container-->
<div class="msglist" id="msglist">
	<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
	</div>
</div>
<!--//container-->
</body>
</html>
