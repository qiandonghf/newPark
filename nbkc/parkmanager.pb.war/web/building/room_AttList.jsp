<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css"  href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css"  href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css"  href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<style>a{TEXT-DECORATION:none}</style>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initList("list");
	});
	function initList(list){
		$("#"+list).jqGrid({
	    	url:'<%=basePath%>roomAtt!list.action?id=<%=request.getParameter("id") %>',
			datatype: 'json',
			prmNames: {search: "search"},
			jsonReader: {root:"root",repeatitems: false},
			colModel: [
				{label:'附件或图片名',name:'name', align:"center",formatter:attName}, 
				{label:'重命名名称', name:'newName',align:"center", hidden:true}, 
				{label:'类型', name:'type.title',align:"center"}, 
			    {label:'管理',width:30, name:'manager', align:"center", sortable:false, resizable:false}
			    
			],
			height: 139,
			width: 782,
			rowNum: 0,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function attName(cellvalue, options, rowObject ){
		var src = rowObject["newName"];
		var data = "";
	  	if(!/\.(gif|jpg|jpeg|png)$/.test(cellvalue)) {
			data = "<a href=\"core/resources/"+src+"?name="+cellvalue+"\" >"+cellvalue+"</a>";
	 	}else{
	 		data = "<a href=\"javascript:void(0)\" onclick=\"imgOrattView('"+src+"');\">"+cellvalue+"</a>";
	 	}
		return data;
	}
	function imgOrattView(src){
		fbShow(src);
	}
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>roomAtt!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				$("#list").trigger("reloadGrid");
			});
		}
	}
	function deleteByIds(){
		var selectedRowIds =   
		$("#list").jqGrid("getGridParam","selarrrow"); 
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>roomAtt!delete.action?ids="+selectedRowIds,function(data){
				showTip(data.result.msg,1000);
				$("#list").trigger("reloadGrid");
			});
		}
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
</script>
</head>
<body style="background:#fff;">
	<div class="pm_msglist">
		<div class="emailtop" >
			<div class="leftemail" >
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建附近件与图片','<%=basePath %>web/building/roomAtt_add.jsp?id=<%=request.getParameter("id") %>',500,116);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
				</ul>
			</div>
		</div>
		<table id="list" class="jqGridList"><tr><td/></tr></table>
	</div>	
</body>
</html>
