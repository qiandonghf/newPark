<%@page import="com.wiiy.cms.entity.ArticleType"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.cms.entity.Param"%>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script>
	var nodeIds = -1;
	var load;
	$(document).ready(function(){
		//refreshTree();
		initTip();
		$("#resizable").css("height",getTabContentHeight()-10);
		$("#treeviewdiv").css("height",getTabContentHeight()-50);
		initClick();
		load = new Array($("#treeviewdiv").find(".menu-hit").size());
		var clickId =$(".tree-node-selected").attr("node-id");
		if(clickId != undefined){
			$("#msglist").css("height",getTabContentHeight());
			$("#msglist").attr("src","parkmanager.cms/web/content/topicContent_list.jsp?paramId="+$(".tree-node-selected").attr("node-id"));
		}
		$("#resizable").height(530);
		$("#resizable").css("padding-bottom",0);
		$("#treeviewdiv").css("padding-bottom",20);
	});
	function rootClick(){
		frames[0].loadByParentId(null,null);
	}
	
	function initClick(){
		$("#treeviewdiv").find(".menu-hit").click(function(node){
			var index = $(this.parentNode).attr("node-id");
			if(load[index] == undefined)
				load[index] = false;
			var cssId = "tt"+index;
			var tree = $("#"+cssId);
			if($(this).hasClass("tree-collapsed")){
				$(this).removeClass("tree-collapsed");
				$(this).addClass("tree-expanded");
				$(this.parentNode).children().eq(1).addClass("tree-folder-open");
				if(load[index] == false){
					load[index] = true;
					refreshTree(tree,index);
				}else
					$(tree).show();
			}else{
				$(this).removeClass("tree-expanded");
				$(this).addClass("tree-collapsed");
				$(this.parentNode).children().eq(1).removeClass("tree-folder-open");
				$(tree).hide();
			}
		});
		
		$("#treeviewdiv").find(".menu-node").each(function(){
			$(this).children().eq(2).click(function(node){
				$(".tree-node-selected").removeClass("tree-node-selected");
				$(this.parentNode).addClass("tree-node-selected");
				reloadListByNormal($(this.parentNode).attr("node-id"));
			});
		});
	}
		 
	function refreshTree(obj,id) {
			$.ajax({
				  type:"POST",
				  url:"<%=basePath%>articleType!contentTreeList.action?paramId="+id+"&articleKind=TOPIC",
				  success: function(data){
					$(obj).tree({
						animate: true,
						"data" : data.articleTypeList
					});
					var nodes = $(obj).tree("getRoots");
					for( var i = 0; i < nodes.length; i++){
						var node = nodes[i];
						$(node.target).find(".tree-title").click(function(node){
							$(".tree-node-selected").removeClass("tree-node-selected");
							var typeId = $(this.parentNode).attr("node-id");
							loadByTypeId(typeId,id);
						});
						var children = $(this).tree("getChildren",node.target);
						for( var j = 0; j < children.length; j++){
							var child = children[j];
							$(child.target).find(".tree-title").click(function(node){
								$(".tree-node-selected").removeClass("tree-node-selected");
								var typeId = $(this.parentNode).attr("node-id");
								loadByTypeId(typeId,id);
							});
						}
					}
					$(obj).show();
				  }
				}); 
	}
	
	function loadByTypeId(typeId,id){
		frames[0].loadByTypeId(typeId,id);
	}
	function reloadList(){
		frames[0].reloadList();
	}
	function reloadListByNormal(paramId){
		frames[0].listByNormal(paramId);
	}
</script>
<style type="text/css">
	.left16 .tree-node{
		padding-left:16px;
	}
</style>
</head>
<body>
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="182" valign="top">
      	<div class="agency" id="resizable" >
        	<div class="titlebg">栏目列表</div>
      		<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
      			<% 
      				List<Param> params = (List<Param>)request.getAttribute("params"); 
      				int index = -1;
      				for(Param param : params){
      					index ++;
      					if(index == 0){
      			%>
   				<div class="menu-node tree-node-selected"  node-id="<%=param.getId() %>" style="cursor: pointer;white-space:nowrap;">
    			<%}else{ %>
	   				<div class="menu-node <%=(index == 0 ?"tree-node-selected":"")%>"  node-id="<%=param.getId() %>" style="cursor: pointer;white-space:nowrap;">
	    		<%} %>	
	    				<span class="menu-hit tree-collapsed"></span>
	    				<span class="tree-icon tree-folder"></span>
	    				<span class="tree-title"><%=param.getName() %></span>
	   				</div>
   				<ul id="tt<%=param.getId() %>" style="display:none;" class="left16"></ul>
   				<%} %>	
          		</div>
      		</div>
      	</div>
      </td>
      <td width="100%" valign="top">
		<div>
			<iframe src="" frameborder="0" id="msglist" width="100%"></iframe>
		</div>
	  </td>
    </tr>
  </table>
</div>
</body>
</html>
