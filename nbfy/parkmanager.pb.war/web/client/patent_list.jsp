<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
$(document).ready(function(){
	initTip();
	initList("list");
});
function initList(list){
	var height = getTabContentHeight()-105;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#"+list).jqGrid({
    	url:'<%=basePath%>patent!list.action',
		colModel: [
			{label:'企业名称', name:'customer.name', align:"center",width:180}, 
			{label:'专利名称', name:'name', align:"center",width:210}, 
			{label:'专利号', name:'serialNo', align:"center"}, 
			{label:'专利申请人', name:'appler', align:"center",width:80}, 
			{label:'专利状态', name:'state.dataValue',width:80, align:"center"}, 
			{label:'专利申请日期',width:80, name:'applyTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center",hidden:true}, 
			{label:'专利类型',width:80, name:'type.dataValue', align:"center"}, 
			{label:'专利来源',width:100, name:'source.dataValue', index:'source.dataValue', align:"center"}, 
			{label:'授权购买日期',width:80, name:'buyTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
			{label:'专利失效日期',width:80, name:'expireTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center", hidden:true},
			{label:'是否发布',width:60, name:'pub.title', align:"center", hidden:true},
		    {label:'管理', width:70,name:'manager', align:"center", sortable:false, resizable:false}
		    
		],
		height: height,
		width: width,
		shrinkToFit: false,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_patent_view")){%>
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_patent_edit")){%>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_patent_delete")){%>
				content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
				<%}%>
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

function reloadList(){
	$("#list").trigger("reloadGrid");
}
function viewById(id){
	fbStart('查看专利信息','<%=basePath%>patent!view.action?id='+id,650,262);
}
function editById(id){
	fbStart('编辑专利信息','<%=basePath%>patent!edit.action?id='+id,650,281);
}
function deleteById(id){
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>patent!delete.action?id="+id,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function deleteByIds(){
	var selectedRowIds =   
	$("#list").jqGrid("getGridParam","selarrrow"); 
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>patent!delete.action?ids="+selectedRowIds,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function doSearch(){
	search(getSearchFilters());
}
function search(filters){
	$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
}
function exportDate(){
		var columns = "{";
		$.each($("#list").getGridParam("colModel"),function(){
			if(this.label && this.name!="manager" && !this.hidden){
				columns += "\"" + this.name + "\"" + ":" + "\"" + this.label + "\",";
			}
		});
		columns = deleteLastCharWhenMatching(columns,",");
		columns += "}";
		$("#columns").val(columns);
		$("#exportForm").submit();
	}
</script>
</head>
<body >
<div class="emailtop">
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_patent_add")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建专利','<%=basePath %>web/client/patent_add.jsp',650,281);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_patent_delete")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		</ul>
	</div>
</div>

<div class="searchdivkf">
    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
     <tr>
        <td width="70">企业名称： </td>
        <td width="105"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td>
            	 <search:input  dataType="string" field="customer.name" op="cn" inputClass="inputauto" />
          	</td>
          </tr>
        </table>       
         <label></label></td>
        <td width="70" align="right">专利名称：</td>
        <td width="105"><search:input dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
        <td width="50" align="right">类型：</td>
        <td width="105">
        	<search:choose dataType="string" field="typeId" op="eq">
      			<dd:select styleClass="data" key="crm.0010"/>
      		</search:choose>
     	</td>
        <td width="50" align="right">状态：</td>
        <td width="105">
      		<search:choose dataType="string" field="stateId" op="eq">
      			<dd:select styleClass="data" key="crm.0011"/>
      		</search:choose>
   	 	</td>
        <td width="75" align="center"><img src="core/common/images/search.jpg" width="75" height="22" border="0" usemap="#Map" /></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
</div>
<div id="container">
	<div class="msglist" id="msglist">
	  <table id="list" class="jqGridList"><tr><td/></tr></table>
	  <div id="pager"></div>
	</div>
</div>
<map name="Map" id="Map">
  <area shape="rect" coords="2,1,51,21" href="javascript:vide(0)" onclick="doSearch()"/>
  <area shape="rect" coords="56,1,76,21" href="javascript:vide(0)" onclick="fbSearch('高级搜索','<%=basePath %>web/client/patent_search.jsp',550,333);"/>
</map>
</body>
</html>
