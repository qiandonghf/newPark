<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
 <%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initList("list");
	});
	function initList(list){
		var height = getTabContentHeight()-75;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#"+list).jqGrid({
	    	url:'<%=basePath%>smsTemplate!list.action',
			colModel: [
				{label:'模板名称', name:'name',width:220,align:"center"}, 
				{label:'模板内容', name:'content', align:"center",width:320}, 
		    	{label:'管理', name:'manager', width:50,align:"center", sortable:false, resizable:false}			    
			],
			shrinkToFit: false,
			height: height,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%
					Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
					boolean add = OaActivator.getHttpSessionService().isInResourceMap("oa_smsTemplate_add");
					boolean edit = OaActivator.getHttpSessionService().isInResourceMap("oa_smsTemplate_edit");
					boolean delete = OaActivator.getHttpSessionService().isInResourceMap("oa_smsTemplate_del");
					boolean view = OaActivator.getHttpSessionService().isInResourceMap("oa_smsTemplate_view");
					%>
					<%if(view){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%} %>
					<%if(edit){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					<%} %>
					<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%} %>
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
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function viewById(id){
		fbStart('查看短信模板','<%=basePath%>smsTemplate!view.action?id='+id,500,205);
	}
	function editById(id){
		fbStart('编辑短信模板信息','<%=basePath%>smsTemplate!edit.action?id='+id,500,235);
	}
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>smsTemplate!delete.action?id="+id,function(data){
				if(data.result!=null){
					showTip(data.result.msg,1000);
					$("#list").trigger("reloadGrid");
				}else{
					showTip("没有权限");
				}
			});
		}
	}
	function deleteByIds(){
		var selectedRowIds =   
		$("#list").jqGrid("getGridParam","selarrrow"); 
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>smsTemplate!delete.action?ids="+selectedRowIds,function(data){
				if(data.result!=null){
					showTip(data.result.msg,1000);
					$("#list").trigger("reloadGrid");
				}else{
					showTip("没有权限");
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
			<%if(add){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''"onclick="fbStart('新建短信模板','<%=basePath %>web/communication/sms_template_add.jsp',500,288);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
			<%} %>
			<%if(delete){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
			<%} %>
		</ul>
	</div>
	<!--//leftemail-->
</div>
<div id="container">
	<div class="msglist" id="msglist">
	  <table id="list" class="jqGridList"><tr><td/></tr></table>
	  <div id="pager"></div>
	</div>
</div>
</body>
</html>
