<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=request.getScheme() + "://" + request.getServerName()
					+ ":" + request.getServerPort()%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
$(document).ready(function() {
	initTip();
	initList();
});
function initList(){
	var height = getTabContentHeight()-75;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#list").jqGrid({
    	url:'<%=basePath%>rss!listContent.action',
		colModel: [
			{label:'标题', name:'title', align:"center"}, 
		    {label:'链接', name:'url',  align:"center", index:'url'}, 
		    {label:'频道', name:'webInfo.name',width:"85",  align:"center"},
		    {label:'是否 受理', name:'hear',width:"85",  align:"center", hidden:true}, 
		    {label:'发布时间', name:'releaseDate',width:"85", align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
		    {label:'操作', name:'manager', align:"center", width:"65",resizable:false}
		],
		height: height,
		width: width,
		multiselect: true,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');	
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var selRow = $("#list").jqGrid("getRowData",id);
				var url = selRow['url'];
				var hear = selRow['hear'];
				var content = "";
				content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> &nbsp;&nbsp;&nbsp;&nbsp;";
				//if(hear == "No")
				//    content += "<img src=\"core/common/images/acceptance.png\" width=\"14\" height=\"14\" title=\"未受理\" onclick=\"hears('"+id+"','"+url+"');\"  /> &nbsp;&nbsp;&nbsp;&nbsp;";
				//else if(hear == "Yes") 
				//	content += "<img src=\"core/common/images/accept.png\" width=\"14\" height=\"14\" title=\"已受理\" onclick=\"\"  /> &nbsp;&nbsp;&nbsp;&nbsp;";
				//content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"openWindow('"+url+"'');\"  /> ";
				content += "<a href=\""+url+"\"  target=\"_blank\"  title='查看'>查看</a>";
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
function hears(id,url){	
	fbStart('添加文章','<%=basePath %>article!add.action?id='+id,780,450);
	window.open(url,"newwindow2", "height=300, width=300, top=100, left=10,toolbar=no, menubar=no, scrollbars=yes, resizable=yes, loca tion=no, status=no");
}
function doBackUp(){
	$.post("<%=basePath%>rss!doBackUp.action",function(data){
		showTip(data.result.msg,2000);
       	if(data.result.success){
       		$("#list").trigger("reloadGrid");
       	}
	});
}


function deleteById(id){
	if(confirm("确定要删吗")){
		$.post("<%=basePath%>rss!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}

function deleteByIds(){
	var ids = $("#list").jqGrid("getGridParam","selarrrow");
	if(ids!='' && confirm("确定要删吗")){
		$.post("<%=basePath%>rss!delete.action?ids="+ids,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}

function reloadList(){
	$("#list").trigger("reloadGrid");
}
function theOpenNews(cellvalue, options, rowObject){
	//alert(rowObject["url"]);
	var title = "<a href='"+rowObject['url']+"' target='_bank' >"+cellvalue+"</a>";
	return title ;
}
</script>

</head>

<body>
<form action="<%=basePath%>supplyStockIn!export.action" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
</form>
	<!--emailtop-->
	<div class="emailtop">
		<div class="leftemail">
			<ul>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''" onclick="deleteByIds()"><span><img
						src="core/common/images/emaildel.png" /></span>删除</li>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="doBackUp()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>立即抓取</li>	
			</ul>
		</div>
	</div>
	<!--//emailtop-->
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
