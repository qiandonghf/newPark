<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
	var typeMenu = [[
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_facility_add")){%>	              
	                 {
	    text: "添加设施",
		classname: "smarty_menu_ico0",
	    func: function() {
			fbStart('新建公共设施->'+$(this).find("input").last().val(),'<%=basePath%>facility!add.action?type='+$(this).find('input').first().val(),530,290);
	    }
	}
	                 <%}%>
	                 ]];
	var facilityMenu = [[
<%
boolean flag=false;
if(PbActivator.getHttpSessionService().isInResourceMap("pb_facility_add")){flag=true;%>               
	                     {
	    text: "编辑",
		classname: "smarty_menu_ico0",
	    func: function() {
			fbStart('编辑设施','<%=basePath%>facility!edit.action?id='+$(this).find('input').val(),530,290);
	    }
	}
<%}%>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_facility_delete")){
	if(flag){%>,<%}%>

	                     {
	    text: "删除",
		classname: "smarty_menu_ico0",
	    func: function() {
			if(confirm("您确定要删除")){
			$.post("<%=basePath%>facility!delete.action?id="+$(this).find('input').val(),function(data){
					showTip(data.result.msg,1000);
					setTimeout("initTree()", 1000);
				});
			}
	    }
	}
	                     <%}%>
	                     ]];
	$(document).ready(function() {
		initTip();
		////$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight());
		$("#treeviewdiv").css("height",getTabContentHeight()-30);
		initTree();
		$(".folder").smartMenu(typeMenu,{name:'typeMenu'});
	});
	function initTree(){
		$("#browser").tree({
			animate: true,
			url:"<%=basePath%>facility!loadType.action",
			onBeforeExpand: function(node){
				$('#browser').tree("select",node.target); 
				$("#browser").tree("options").url="<%=basePath%>facility!loadFacilityByType.action?type="+$(node.target).find("input").val();
			},
			onClick: function(node){
				if($(this).tree("isLeaf",node.target)){
					$("#msglist").attr("src","<%=basePath%>facility!view.action?id="+$(node.target).find("input").val());
				}
			},
			onLoadSuccess: function(node, data){
				var nodes = $(this).tree("getRoots");
				for( var i = 0; i < nodes.length; i++){
					var node = nodes[i];
					if(!$(this).tree("isLeaf",node.target)){
						$(node.target).find(".tree-title").smartMenu(typeMenu,{name:'typeMenu'});
						var children = $(this).tree("getChildren",node.target);
						for( var j = 0; j < children.length; j++){
							var child = children[j];
							$(child.target).find(".tree-title").smartMenu(facilityMenu,{name:'facilityMenu'});
						}
					}
				}
			}
			
		});
	}
	
	function reLoad(id){
		$("#msglist").attr("src","<%=basePath%>facility!view.action?id="+id);
		var node = $('#browser').tree('find', id);
		if(node!=null){
			$('#browser').tree('select', node.target);
		}else{
			initTree();
		}
	}
	function selectBuilding(id,typeId){
		$("#msglist").attr("src","<%=basePath%>facility!view.action?id="+id);
		initTree();
		setTimeout(function(){
			var tree = $('#browser');
			var group = tree.tree('find',typeId);
			tree.tree('expand',group.target);
			setTimeout(function(){
				var children = tree.tree('getChildren',group.target);
				for(var i = 0; i < children.length; i++){
					if(children[i].id == id) tree.tree('select',children[i].target);
				}
			}, 1000);
		}, 1000);
	}
	
	function loadFacilityByTypeId(id){
		if($("#typeLi"+id).hasClass("expandable")){
			var typeId = $("#typeLi"+id).find("input").first().val();
			$.post("<%=basePath%>facility!loadFacilityByTypeId.action?typeId="+typeId,function(data){
				if(data.result.success){
					$("#typeUl"+id).empty();
					for(var i = 0; i < data.result.value.length; i++){
						var facility = data.result.value[i];
						var span = $("<span class=\"file\"></span>").append(facility.name).append($("<input />",{type:"hidden",value:facility.id}));
						span.smartMenu(facilityMenu,{name:'facilityMenu'});
						span.bind("click",function(){
							$("#msglist").attr("src","<%=basePath%>facility!view.action?id="+$(this).find('input').val());
						});
						$("#typeUl"+id).append($("<li></li>").append($("<a href=\"javascript:void(0)\"></a>").append(span)));
					}
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
	        	<td width="182" valign="top">
					<div class="agency" id="resizable">
						<div class="titlebg">设施分类</div>
						<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
						 	<ul id="browser" class="filetree">
						 	</ul>
			          	</div>
					</div>		
				</td>
				<td width="100%" valign="top">
					<div>
						<iframe src="<%=basePath %>web/facility/facility_index.jsp" frameborder="0" id="msglist" width="100%"></iframe>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
