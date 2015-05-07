<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	var paramId = '${param.paramId}';
	$(document).ready(function() {
		if(paramId == 'undefined'){
			paramId == 0;
		}
		initTip();
		initList("list");
	});
	
	
	function ininClick(id){
		var obj = $("#"+id).children().eq(0).children().eq(0).children().eq(0);
		$(obj).click(function(){
			if($(this).hasClass("tree-plus")){
				$("#"+id).parent().children().each(function(){
					var pid = $(this).attr("pids");
					if(pid != undefined && pid.indexOf(","+id+",") != -1){
						$(this).hide();
					}
				});
				/* $("#"+id).parent().children().each(function(){
					var pid = $(this).attr("pids");
					if(pid != undefined && pid.indexOf(","+id+",") != -1){
						var child = $(this).children().eq(0).children().eq(0).children().eq(0);
						if($(child).hasClass("tree-minus")){
							$(child).removeClass("tree-minus");
							$(child).removeClass("ui-icon-triangle-1-s");
							$(child).addClass("tree-plus");
							$(child).addClass("ui-icon-triangle-1-e");
						}
					}
				}); */
			}else{
				$("#"+id).parent().children().each(function(){
					var pid = $(this).attr("pid");
					if(pid != undefined && pid == id){
						$(this).show();
					}
				});
				$("#"+id).parent().children().each(function(){
					var pid = $(this).attr("pid");
					if(pid != undefined && pid == id){
						var child = $(this).children().eq(0).children().eq(0).children().eq(0);
						if($(child).hasClass("tree-minus")){
							var pcid = $(this).attr("id");
							$("tr").each(function(){
								var cid = $(this).attr("pid");
								if(cid != undefined && cid == pcid){
									$(this).show();
								}
							});
						}
					}
				});
			}
		});
	}
	
	
	function initList(list){
		var height = getTabContentHeight()-107;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#"+list).jqGrid({
	    	url:'<%=basePath%>articleType!listAll.action?paramId='+paramId,
	    	treeGrid:true,
	    	treeGridModel: 'adjacency',
	    	ExpandColumn:'name',
	    	dataType:'jsonp',
	    	rownumbers:false,
			colModel: [
				{label:'栏目名称',name:'typeName',align:"center",width:300}, 
				//{label:'网站名称',width:160,name:'typeName1',align:"center",sortable:false, resizable:false}, 
				{label:'排序',width:80,name:'displayOrder',align:"center",hidden:true}, 
				{label:'栏目类别',width:80,name:'kind.title',align:"center",sortable:false, resizable:false}, 
				{label:'上级id',width:80,name:'parentId',hidden:true,align:"center",sortable:false, resizable:false}, 
				{label:'上级ids',width:80,name:'parentIds',hidden:true,align:"center",sortable:false, resizable:false}, 
				{label:'显示',width:80,name:'display.title',align:"center",sortable:false, resizable:false}, 
				{label:'排序顺序',width:80,name:'displayOrder',hidden:true,align:"center",sortable:false, resizable:false}, 
				{label:'显示位置',width:120,name:'displayPosition.dataValue',align:"center",sortable:false, resizable:false}, 
				{label:'管理员',width:80,name:'managerIds',hidden:true,align:"center",sortable:false, resizable:false}, 
				{label:'栏目管理',width:120,name:'managerNames',align:"center",sortable:false, resizable:false}, 
				{label:'管理',width:80, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					ininClick(id);
					var managerIds = $(this).getCell(id,'managerIds');
					var pid = $(this).getCell(id,'parentIds');
					node_id = pid;
					if(pid != ','){
						$("#"+id).attr("pids",pid);
					}
					$("#"+id).attr("pid",$(this).getCell(id,'parentId'));
					var content = "";
					<%
					Map<String, ResourceDto> resourceMap = CmsActivator.getHttpSessionService().getResourceMap();
					boolean add = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_programManage_add");
					boolean edit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_programManage_edit");
					boolean delete = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_programManage_del");
					boolean view = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_programManage_view");
					boolean set = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_programManage_set");
					%>
					<%if(set){%>
					if(managerIds.length > 0)
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"编辑栏目管理员\" onclick=\"setManager('"+id+"','"+managerIds+"');\"  /> ";
					else
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"设置栏目管理员\" onclick=\"setManager('"+id+"','"+managerIds+"');\"  /> ";
					<%} %>
					<%if(view){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%} %>
					<%if(edit){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					<%} %>
					<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%} %>
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
	
	function getSelectedItem(){
		var obj = $("#list tr[aria-selected=true]");
		var typeId = $(obj).attr("id");
		var typeName = $(obj).children().eq(0).text();
		if(typeId == undefined){
			typeId = "";
			typeName = "";
		}
		var kind = $(obj).children().eq(2).text();
		if(kind == '单页文章'){
			window.parent.info.isSingle = true;
		}else{
			window.parent.info.isSingle = false;
		}
		window.parent.info.typeId = typeId;
		window.parent.info.typeName = typeName;
	}
	
	function addCataLog(){
		getSelectedItem();
		fbStart('新建栏目','<%=basePath %>articleType!add.action?paramId='+paramId,700,285);
	}
	
	function editById(id){
		fbStart('编辑','<%=basePath%>articleType!edit.action?id='+id,700,285);
	}
	
	function viewById(id){
		fbStart('查看','<%=basePath%>articleType!view.action?id='+id,700,251);
	}
	
	function loadById(id){
		$("#list").setGridParam({url:'<%=basePath%>articleType!loadById.action?id='+id}).trigger('reloadGrid');
	}
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>articleType!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function setManager(id,ids){
		fbStart('设置栏目管理员','<%=BaseAction.rootLocation %>/core/user!select2.action?objType='+id+"&ids="+ids,520,400);
	}
	
		
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids==""){
			showTip("请选择文章栏目",2000);
		}else if(confirm("确定要删吗")){
			$.post("<%=basePath%>articleType!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function reloadList(){
		location.reload();
	}
	
	function loadById(id){
		paramId = id;
		$("#list").setGridParam({url:'<%=basePath%>articleType!listAll.action?paramId='+paramId}).trigger('reloadGrid');
	}
</script>
</head>
<body>
<!--emailtop-->
<div class="titlebg">网站栏目列表 </div>
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<%if(add){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addCataLog();"><span><img src="core/common/images/emailadd.gif"/></span>新建</li>
			<%} %>
		</ul>
	</div>
</div>
<!--//emailtop-->
<!--container-->
<div class="msglist" id="msglist" style="padding-bottom:0px;">
	<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
	</div>
</div>
<!--//container-->
</body>
</html>