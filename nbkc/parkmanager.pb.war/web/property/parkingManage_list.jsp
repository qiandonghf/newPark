<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/jquery.treeview.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.treeview.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initList("list");
});

function initList(){
	var height = getTabContentHeight()-110;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#list").jqGrid({
    	url:'<%=basePath%>parkingManage!list.action?id='+'${param.garageId}',
		colModel: [
				{label:'车位号', name:'parkingId', align:"center"}, 
				{label:'状态', name:'status.title', align:"center"}, 
				{label:'描述', name:'description', align:"center"}, 
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
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_parkingManage_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_parkingManage_del")){%>
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
function editById(id){
	fbStart('编辑车位管理','<%=basePath %>parkingManage!edit.action?id='+id,600,165);
}

function reloadGarageList(){
	$("#list").trigger("reloadGrid");
}

function deleteById(id){
	if(confirm("确定要删吗")){
		$.post("<%=basePath%>parkingManage!delete.action?id="+id,function(data){
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
		$.post("<%=basePath%>parkingManage!delete.action?ids="+ids,function(data){
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
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" valign="top">
				<div class="apptab" id="tableid">
					<ul>
					<li class="apptabliover" ><a href="<%=basePath%>web/property/parkingManage_list.jsp?garageId=${param.garageId}">车位信息</a></li>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_parkingManage_view")){ %>
						<li class="apptabli" ><a href="<%=basePath%>parkingManage!view.action?garageId=${param.garageId}">车库视图</a></li>
					<%} %>
					</ul>
				</div>
				<div class="pm_msglist" style="display:block;" id="textname">
					<div class="emailtop">
						<div class="leftemail">
							<ul>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_parkingManage_add")){ %>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('添加车位','<%=basePath%>web/property/parkingManage_add.jsp?garageId=${param.garageId }',400,160);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
							<%} %>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_parkingManage_del")){ %>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
							<%} %>
							</ul>
						</div>
					</div>
					<table id="list" class="jqGridList"><tr><td/></tr></table>
					<div id="pager"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
