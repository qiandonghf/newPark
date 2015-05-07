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

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script>
	//园区菜单
	var groupMenu = [[
	     <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReport_add")){%>             
	 {
	    text: "新建报表",
		classname: "smarty_menu_ico0",
	    func: function() {
			fbStart('新建报表','<%=basePath%>dataReport!add.action?id='+$(this).find('input').val(),500,170);
	    }
	}
	 <%}%>
	 ],[
	    <%boolean flag=false;
	    if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportGroup_edit")){
	    	flag=true;%>	
	    
	    {
	    text: "编辑分组",
		classname: "smarty_menu_ico1",
	    func: function() {
			fbStart('编辑分组','<%=basePath%>dataReportGroup!edit.action?id='+$(this).find('input').val(),300,80);
	    }
	}
	<%}%>
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportGroup_delete")){
		if(flag){%>,<%}%>
	
	    {
	    text: "删除分组",
		classname: "smarty_menu_ico2",
	    func: function() {
			if(confirm("您确定要删除")){
				$.post("<%=basePath%>dataReportGroup!delete.action?id="+$(this).find('input').val(),function(data){
					showTip(data.result.msg,1000);
					setTimeout("location.reload()", 1000);
				});
			}
	    }
	}
	    <%}%>
	    ]];
	//楼宇菜单
	var dataReportMenu = [[
	 <%flag=false;
	 if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReport_edit")){
		 flag=true;%>
	 
	                       {
	    text: "编辑报表",
		classname: "smarty_menu_ico1",
	    func: function() {
			fbStart('编辑报表','<%=basePath%>dataReport!edit.action?id='+$(this).find('input').val(),500,190);
	    }
	}
		<%}%>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReport_delete")){
			if(flag){%>,<%}%>
	                       {
	    text: "删除报表",
		classname: "smarty_menu_ico2",
	    func: function() {
			if(confirm("您确定要删除")){
				$.post("<%=basePath%>dataReport!delete.action?id="+$(this).find('input').val(),function(data){
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
		$("#treeviewdiv").css("height",getTabContentHeight()-53);
		initTree();
		$(".folder").smartMenu(groupMenu,{name:'groupMenu'});
	});
	function initTree(){
		$("#browser").tree({
			animate: true,
			url: "<%=basePath%>dataReport!loadGroup.action",
			onBeforeExpand: function(node){
				$("#browser").tree("options").url="<%=basePath%>dataReport!loadReportByGroupId.action";
			},
			onClick: function(node){
				$(this).tree('toggle', node.target);
				if($(this).tree("isLeaf",node.target)){
					$("#msglist").attr("src","<%=basePath%>dataReport!view.action?id="+node.id);
				}
			},
			onLoadSuccess: function(node, data){
				var nodes = $(this).tree("getRoots");
				for( var i = 0; i < nodes.length; i++){
					var node = nodes[i];
					if(!$(this).tree("isLeaf",node.target)){
						$(node.target).find(".tree-title").smartMenu(groupMenu,{name:'groupMenu'});
						var children = $(this).tree("getChildren",node.target);
						for( var j = 0; j < children.length; j++){
							var child = children[j];
							$(child.target).find(".tree-title").smartMenu(dataReportMenu,{name:'dataReportMenu'});
						}
					}
				}
			}
		});
	}
	function loadDataReportByGroupId(groupId){
		if($("#groupLi"+groupId).hasClass("expandable")){
			$.post("<%=basePath%>dataReport!loadDataReportByGroupId.action?id="+groupId,function(data){
				if(data.result.success){
					$("#groupUl"+groupId).empty();
					for(var i = 0; i < data.result.value.length; i++){
						var building = data.result.value[i];
						var span = $("<span class=\"file\"></span>").append(building.name).append($("<input />",{type:"hidden",value:building.id}));
						span.smartMenu(dataReportMenu,{name:'dataReportMenu'});
						span.bind("click",function(){
							$("#msglist").attr("src","<%=basePath%>dataReport!view.action?id="+$(this).find('input').val());
						});
						$("#groupUl"+groupId).append($("<li></li>").append($("<a href=\"javascript:void(0)\"></a>").append(span)));
					}
				}
			});
		}
	}
	function setSelectedCustomers(customers){
		var customerIds = "";
		for(var i = 0 ; i < customers.length; i++){
			customerIds += customers[i].id+",";
		}
		customerIds = deleteLastCharWhenMatching(customerIds,",");
		window.frames[0].setSelectedCustomers(customerIds);
	}
	function reloadIframe(id,groupId){
		$("#msglist").attr("src","<%=basePath%>dataReport!view.action?id="+id);
		initTree();
		setTimeout(function(){
			var tree = $('#browser');
			var group = tree.tree('find',groupId);
			tree.tree('expand',group.target);
			setTimeout(function(){
				var children = tree.tree('getChildren',group.target);
				for(var i = 0; i < children.length; i++){
					if(children[i].id == id) tree.tree('select',children[i].target);
				}
			}, 1000);
		}, 1000);
	}
	function reloadList(){
		window.frames[0].reloadList();
	}
</script>
</head>

<body>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
	        	<td width="182" valign="top">
					<div class="agency" id="resizable">
						<div class="titlebg">数据填报</div>
						<div class="agencybtn">
							<ul>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportGroup_add")){ %>
								<li><a href="javascript:void(0)" onclick="fbStart('新建分组','<%=basePath %>web/client/dataReportGroup_add.jsp',300,80);"><span class="icoadd"></span>新建分组</a></li>
							<%} %>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReport_add")){ %>
								<li><a href="javascript:void(0)" onclick="fbStart('新建报表','<%=basePath%>dataReport!add.action',500,170);"><span class="icoadd"></span>新建报表</a></li>
							<%} %>
							</ul>
						</div>
						<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
							<ul id="browser" class="filetree"></ul>
			          	</div>
					</div>		
				</td>
				<td width="100%" valign="top">
					<iframe src="<%=basePath %>web/client/dataReport_index.jsp" frameborder="0" id="msglist" width="100%"></iframe>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
