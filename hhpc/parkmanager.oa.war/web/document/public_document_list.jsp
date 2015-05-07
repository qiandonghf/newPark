<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
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
	
	var rootMenu=[
		[
		<%
		Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
		if(OaActivator.getHttpSessionService().isInResourceMap("oa_public_folder")){
		%>
		 	{text:"新建文件夹",
			classname:"smarty_menu_folder_add",
				func:function(){
					fbStart('新建文件夹','<%=basePath %>web/document/public_folder_add.jsp',300,71);
				}
			}
		 <%}%>
		]
	];
	
	var docFolderMenu=[
		[
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_share_folder")){%>
		 	{text:"新建文件夹",
			classname:"smarty_menu_folder_add",
				func:function(){
					fbStart('新建文件夹','<%=basePath %>docPublic!addFolder.action?id='+$(this.parentNode).attr("node-id"),300,71);
				}
			}
		 <%}%>
		],
		[
		<%
		boolean flag = false;
		if(OaActivator.getHttpSessionService().isInResourceMap("oa_public_reName")){
			flag = true;
		%>
			{text:"重命名",
			classname:"smarty_menu_ico1",
				func:function(){
					fbStart('重命名','<%=basePath %>document!edit.action?id='+$(this.parentNode).attr("node-id"),300,71);
				}
			}
		<%}%>
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_public_del")){
			if(flag){
		%>
		   ,
		<%}
			flag = true;
		%>
			{text:"删除",
			classname:"smarty_menu_ico2",
				func:function(){
					if(confirm("您确定要删除")){
						$.post("<%=basePath%>docPublic!delete.action?id="+$(this.parentNode).attr('node-id'),function(data){
							showTip(data.result.msg,3000);
							if(data.result.success){
								location.reload();
								//setTimeout("frames[0].reloadList();");
							}
						});
					}
				}
			}
		<%}%>
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_public_move")){
			if(flag){
		%>
		   ,
		<%}
			flag = true;
		%>
			{text:"移动",
			classname:"smarty_menu_move",
				func:function(){
					fbStart('移动','<%=basePath%>docPublic!move.action?id='+$(this.parentNode).attr("node-id"),300,71);
				}
			}
		<%}%>
		]
	];
	
	$(document).ready(function(){
		refreshTree();
		initTip();
		////$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight());
		$("#treeviewdiv").css("height",getTabContentHeight()-55);
	});
	
	function refreshTree() {
		<%if(OaActivator.getSessionUser(request).getAdmin().equals(BooleanEnum.YES)){%>
			$("#root").smartMenu(rootMenu,{name:'rootMenu'});
		<%}%>
		$.ajax({
		  "url" : "<%=basePath%>docPublic!list.action",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				lines:true,
				onClick:function(node){
					$(this).tree('toggle', node.target);
				},
				"data" : data.documentList
			});
			<%if(OaActivator.getSessionUser(request).getAdmin().equals(BooleanEnum.YES)){%>
				$("#tt .tree-title").smartMenu(docFolderMenu,{name:'docFolderMenu'});
			<%}%>
			$("#tt .tree-title").click(function(){
				var names = $(this).html();
				var ids = $(this.parentNode).attr("node-id");
				parentFolder(this,names,ids);
			});
		  }
		});
	}
	
	function rootClick(){
		frames[0].loadByParentId(null,null);
	}
	function parentFolder(el,names,ids){
		if($(el).parent().parent().parent().prev().children(".tree-title").html()!=null){
			names = $(el).parent().parent().parent().prev().children("..tree-title").html()+","+names;
			ids = $(el).parent().parent().parent().prev().attr("node-id")+","+ids;
			parentFolder($(el).parent().parent().parent().prev().children(".tree-title"),names,ids);
		}else{
			frames[0].loadFolder(ids,names);
		}
	}
</script>

</head>
<body>
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="182" valign="top">
      	<div class="agency" id="resizable" >
        	<div class="titlebg">公共文档目录</div>
      		<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
      			<ul>
	           		<li>
		           		<div class="tree-node droppable" style="cursor: pointer;position: relative; left:-3px;">
			           		<span class="tree-indent"></span>
			           		<span class="tree-icon tree-file"></span><span onclick="rootClick();" id="root">根目录</span>
		           		</div>
	           		</li>
      			</ul>
	           	<ul id="tt">
				</ul>
          	</div>
      </div></td>
      <td width="100%" valign="top">
		<div>
			<iframe src="parkmanager.oa/web/document/public_document_index.jsp" frameborder="0" id="msglist" width="100%"></iframe>
		</div>
	  </td>
    </tr>
  </table>
</div>
</body>
</html>
