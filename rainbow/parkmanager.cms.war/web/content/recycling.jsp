<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.cms.entity.Param"%>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script>
	$(document).ready(function(){
		//refreshTree();
		refreshBtn();
		initTip();
		$("#resizable").css("height",getTabContentHeight()-10);
		var id = $("#index").val();
		if(id != undefined){
			$("#msglist").attr("src","parkmanager.cms/web/content/recycling_list.jsp?paramId="+id);
			$("#msglist").css("height",getTabContentHeight());
			$("#treeviewdiv").css("height",getTabContentHeight()-28);
			$("#index").parent().addClass("treeClicked");
		}
	});
	
	function rootClick(){
		frames[0].loadByParentId(null,null);
	}
	
	/*
		初始化网站点击事件
	*/
	function refreshBtn(){
		$(".tree-node").each(function(){
			$(this).mouseover(function(){
				$(this).addClass("tree-node-hover");
			});
			$(this).mouseout(function(){
				$(this).removeClass("tree-node-hover");
			});
		});
		$("#tt").find(".tree-title").parent().click(function(){
			$(".treeClicked").removeClass("treeClicked");
			$(this).addClass("treeClicked");
			var id = $(this).attr("node-id");
			$("#msglist").attr("src","parkmanager.cms/web/content/recycling_list.jsp?paramId="+id);
		});
	}	 
		
	function loadById(id){
		frames[0].loadById(id);
	}
	
	function reloadList(){
		frames[0].reloadList();
	}
	
	function refreshTree(){
		location.reload();
	}
</script>
<style type="text/css">
	.treeClicked{
		background-color:#FBEC88;
	}
</style>
</head>
<body>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="182" valign="top">
					<div class="agency" id="resizable">
						<div class="titlebg">网站列表</div>
						<div class="treeviewdiv" style="overflow-Y: auto;"
							id="treeviewdiv">
							<ul id="tt">
								<% List<Param> params = (List<Param>)request.getAttribute("params"); 
									int index = 0;
									for(Param param : params){
								%>
									<li>
										<div class="tree-node " node-id="<%=param.getId() %>" node-ids="<%=param.getManagerIds() %>" style="cursor: pointer;margin:2px;">
											<%if(index == 0){ %>
											<input type="hidden" id="index" value="<%=param.getId()%>"/>
											<%} %>
											<span class="tree-icon tree-file"></span>
											<span class="tree-title"><%=param.getName()%></span>
										</div>
									</li>
								<%index ++;}%>
							</ul>
						</div>
					</div>
				</td>
				<td width="100%" valign="top">
					<div>
						<iframe src=""
							frameborder="0" id="msglist" width="100%"></iframe>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
