<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/cord_icon.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script>
	//园区菜单
	var parkMenu = [[
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_garage_add")){ %>                
	{
	    text: "新建车库",
		classname: "smarty_menu_ico0",
	    func: function() {
			fbStart('新建车库信息','<%=basePath%>web/property/grage_add.jsp?id='+$(this.parentNode).attr('node-id'),300,80);
	    }
	}
	<%}%>
	],[
	   <%boolean flag=false;
	   if(PbActivator.getHttpSessionService().isInResourceMap("pb_park_edit")){flag=true; %>
	   {
	    text: "重命名",
		classname: "smarty_menu_ico1",
	    func: function() {
			fbStart('重命名','<%=basePath%>park!edit.action?id='+$(this.parentNode).attr('node-id'),300,80);
	    }
	}
    <%}%>
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_park_delete")){
			if(flag){%>,<%}%>

	   {
	    text: "删除园区",
		classname: "smarty_menu_ico2",
	    func: function() {
			if(confirm("您确定要删除")){
				$.post("<%=basePath%>park!delete.action?id="+$(this.parentNode).attr('node-id'),function(data){
					showTip(data.result.msg,1000);
					setTimeout("location.reload()", 1000);
				});
			}
	    }
	}
	<%}%>
	   ]];
	//楼宇菜单
	var buildingMenu = [[
     <%flag=false;
     if(PbActivator.getHttpSessionService().isInResourceMap("pb_garage_edit")){flag=true;%>
	                     {
	    text: "编辑车库",
		classname: "smarty_menu_ico1",
	    func: function() {
			fbStart('编辑车库信息','<%=basePath%>garage!edit.action?id='+$(this.parentNode).attr('node-id'),300,80);
	    }
	}
<%}%>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_garage_del")){
	if(flag){%>,<%}%>
	                     {
	    text: "删除车库",
		classname: "smarty_menu_ico2",
	    func: function() {
			if(confirm("您确定要删除")){
				$.post("<%=basePath%>garage!delete.action?id="+$(this.parentNode).attr('node-id'),function(data){
					showTip(data.result.msg,1000);
					setTimeout("location.reload()", 1000);
				});
			}
	    }
	}
	                     <%}%>
	                     ]];
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight());
		$("#treeviewdiv").css("height",getTabContentHeight()-55);
		refreshTree();
		var buildintId = "${param.id}";
		var parkId = "${param.parkId}";
		if(buildintId!="" && parkId!=""){
			selectBuilding(buildintId,parkId);
		}
	});
	
	function refreshTree() {
		$.ajax({
		  "url" : "<%=basePath%>garage!listGarage.action",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				animate: true,
				"data" : data.parkList,
				onClick: function(node){
					$(this).tree('toggle', node.target);
					var id = node.id;
					if($(this).tree("isLeaf",node.target)){
						$("#msglist").attr("src","<%=basePath%>web/property/parkingManage_list.jsp?garageId="+id);
					}
				},
				onLoadSuccess: function(node, data){
					var nodes = $(this).tree("getRoots");
					for( var i = 0; i < nodes.length; i++){
						var node = nodes[i];
						$(node.target).find(".tree-title").smartMenu(parkMenu,{name:'parkMenu'});
						var children = $(this).tree("getChildren",node.target);
						for( var j = 0; j < children.length; j++){
							var child = children[j];
							$(child.target).find(".tree-title").smartMenu(buildingMenu,{name:'buildingMenu'});
							
						}
					}
				}	
			});
		  }
		});
	}
	
	function selectBuilding(id,parkId){
		$("#msglist").attr("src","<%=basePath%>web/property/parkingManage_list.jsp?garageId="+id);
		refreshTree();
		setTimeout(function(){
			var tree = $('#tt');
			var group = tree.tree('find',parkId);
			tree.tree('expand',group.target);
			setTimeout(function(){
				var children = tree.tree('getChildren',group.target);
				for(var i = 0; i < children.length; i++){
					if(children[i].id == id) tree.tree('select',children[i].target);
				}
			}, 1000);
		}, 1000);
	}

	function reloadGarage(){
		frames[0].reloadGarageList();
	}
</script>
</head>

<body>
	<div id="container">
	<input type="hidden" id="buildingId" value="${param.id}"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
	        	<td width="182" valign="top">
					<div class="agency" id="resizable">
						<div class="titlebg">楼宇列表</div>
						<div class="agencybtn">
							<ul>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_park_add")){ %>
								<li><a href="javascript:void(0)" onclick="fbStart('添加园区','<%=basePath %>web/building/park_add.jsp',300,80);"><span class="icoadd"></span>添加园区</a></li>
							<%} %>
							</ul>
						</div>
						<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
						 	<ul id="tt">
	 						</ul>
			          	</div>
					</div>		
				</td>
				<td width="100%" valign="top">
					<div>
						<iframe src="parkmanager.pb/web/building/park_index.jsp" frameborder="0" id="msglist" width="100%"></iframe>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
