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
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initList();
		$("#msglist").css("padding-bottom","0px");
	});
	
	function initList(){
		var height = getTabContentHeight()-107;
		var width = $(this).width()-1;
		$("#list").jqGrid({
	    	url:'<%=basePath%>article!listByNormal.action?kind=LIST&paramId=${param.paramId}',
			colModel: [
				{label:'文章标题', name:'title',align:"center",width:300}, 
				{label:'更新时间', width:160,name:'modifyTime', align:"center",hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'所属栏目',width:140,name:'articleType.typeName',align:"center"}, 
				{label:'点击量',width:80,name:'hits',align:"center"}, 
				{label:'发布人', width:120,name:'editor', align:"center"},
				{label:'发布', name:'pubed.title',width:40,align:"center"}, 
				{label:'信息', name:'record',hidden:true,width:40,align:"center"}, 
				{label:'发布时间', name:'pubTime',align:"center",width:80,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
			    {label:'管理',width:80, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			multiselect: true,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					var type = $(this).getCell(id,'pubed.title');
					var record = $(this).getCell(id,'record');
					<%
					Map<String, ResourceDto> resourceMap = CmsActivator.getHttpSessionService().getResourceMap();
					boolean add = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_add");
					boolean edit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_edit");
					boolean delete = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_del");
					boolean view = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_view");
					boolean noticeView = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_view");
					%>
					<%if(view){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%} %>
					<%if(noticeView){%>
					if(record != '')
						content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看回执\" onclick=\"noticeById('"+id+"');\"  /> ";
					<%} %>
					if(type == "否"){
						content += "<img src=\"core/common/images/uploadicon.png\" width=\"14\" height=\"14\" title=\"发布\" onclick=\"publishById('"+id+"');\"  /> ";
						<%if(edit){%>
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
						<%} %>
					}else{
						content += "<img src=\"core/common/images/back.png\" width=\"14\" height=\"14\" title=\"撤回\" onclick=\"backById('"+id+"');\"  /> ";
					}
					<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%} %>
					$("#msglist").css("padding-bottom","0px");
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
	
	<%-- function manager(cellvalue, options, rowObject){
		var id = rowObject["id"];
		var type = rowObject["pubed"];
		var content = "";
		<%
		Map<String, ResourceDto> resourceMap = CmsActivator.getHttpSessionService().getResourceMap();
		boolean add = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_add");
		boolean edit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_edit");
		boolean delete = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_del");
		boolean view = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_normal_view");
		%>
		<%if(view){%>
		content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
		<%} %>
		if(type.title == "否"){
			content += "<img src=\"core/common/images/uploadicon.png\" width=\"14\" height=\"14\" title=\"发布\" onclick=\"publishById('"+id+"');\"  /> ";
			<%if(edit){%>
			content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
			<%} %>
		}else{
			content += "<img src=\"core/common/images/back.png\" width=\"14\" height=\"14\" title=\"撤回\" onclick=\"backById('"+id+"');\"  /> ";
		}
		<%if(delete){%>
		content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
		<%} %>
		$(this).jqGrid('setRowData',id,{manager:content});
		return content;
	} --%>
	
	function viewById(id){
		fbStart('查看','<%=basePath%>article!view.action?id='+id,800,457);
	}	
	function noticeById(id){
		parent.parent.addTab("回执",'core/common/images/service.png',"<%=basePath%>web/system/receipt.jsp?id="+id);
	}	
	
	function editById(id){
		fbStart('编辑','<%=basePath%>article!edit.action?id='+id,800,490);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function loadByTypeId(typeId,paramId){
		$("#list").setGridParam({url:'<%=basePath%>article!loadByTypeId.action?typeId='+typeId+'&paramId='+paramId+'&kind=LIST'}).trigger('reloadGrid');
	}
	
	function listByNormal(paramId){
		$("#list").setGridParam({url:'<%=basePath%>article!listByNormal.action?kind=LIST&paramId='+paramId}).trigger('reloadGrid');
	}
	
	function publishById(id){
		if(confirm("确定要发布吗")){
			$.post("<%=basePath%>article!publish.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function backById(id){
		if(confirm("确定要撤回吗")){
			$.post("<%=basePath%>article!back.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function deleteById(id){
		if(confirm("确定要放入回收站吗")){
			$.post("<%=basePath%>article!recycle.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids==""){
			showTip('请先选择文章',2000);	
		}else if(confirm("确定要放入回收站吗")){
			$.post("<%=basePath%>article!recycle.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function doSearch(){
		var postData = $("#list").jqGrid("getGridParam", "postData"); 
		var sdata = { 
			searchContent: $("#searchContent").val(),  
		};  
		$.extend(postData, sdata);  
		$("#list").trigger("reloadGrid", [{page:1}]);
	}
</script>
</head>
<body>
<div class="titlebg">列表文章</div>
<!--emailtop-->
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<%if(add){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('文章新建','<%=basePath %>web/content/content_addByNormal.jsp',800,555);"><span><img src="core/common/images/emailadd.gif"/></span>添加</li>
			<%} %>
			<%if(delete){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
			<%} %>
			<li>
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
			      <tr>
			        <td width="65" align="right">搜索内容：</td>
			        <td width="120"><label>
			        	<input id="searchContent" name="searchContent" value="${searchContent }" class="data inputauto"/>
			        </label></td>
			        <td width="85" align="center"> <input name="Submit" type="button" class="searchbtn" value="" onclick="doSearch()"/></td>
			        <td>&nbsp;</td>
			      </tr>
			    </table>
			</li>
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
