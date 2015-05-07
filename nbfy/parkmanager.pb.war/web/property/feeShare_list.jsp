<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

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
		initList();
	});
	
	function initList(){
		var height = getTabContentHeight()-105;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
    	url:'<%=basePath%>feeShare!list.action',
		colModel: [
			{label:'名称',name:'name', align:"center"}, 
			{label:'表类型',width:40, name:'type.title', align:"center"}, 
		    {label:'管理', width:40,name:'manager', align:"center", sortable:false, resizable:false}
		    
		],
		height: height,
		width: width,
		multiselect:false,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_feeShare")){ %>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
				content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
				<%}%>
				$(this).jqGrid('setRowData',id,{manager:content});
			}
		}
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
	}	
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function editById(id){
		fbStart('编辑','<%=basePath %>feeShare!edit.action?id='+id,350,95);
	}
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>feeShare!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				if(data.result.success){
					reloadList();
				}
			});
		}
	}
	
	function add(){
		fbStart('新建','<%=basePath %>feeShare!add.action',350,95);
	}
	
</script>
<body>
	<div class="titlebg">费用类型</div>
	<div class="emailtop">
		<div class="leftemail">
			<ul>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_feeShare")){ %>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="add();"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
			<%} %>
			</ul>
		</div>
	</div>
	<div id="container">
	  <table id="list" class="jqGridList"><tr><td/></tr></table>
	  <div id="pager"></div>
	</div>
</body>
</html>
