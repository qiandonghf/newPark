<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
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
	    	url:'<%=basePath%>staffer!list.action',
			colModel: [
			    {label:'企业名称', name:'customer.name', index:'customer', align:"center",width:180}, 
				{label:'姓名', name:'name', index:'name',align:"center",width:90}, 
				{label:'职位', name:'position.dataValue', index:'position',align:"center",width:90}, 
			    {label:'联系电话', name:'phone', index:'phone', width:120, align:"center",fixed:true,sortable:false},
			    {label:'固定电话', name:'telephone', index:'telephone', width:120, align:"center",fixed:true,sortable:false},
			    {label:'Email', name:'email', index:'email', align:"center",sortable:false}, 
				{label:'性别', name:'gender.title',width:80,align:"center",hidden:true}, 
				{label:'出生年月', name:'birth',width:80,formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center",hidden:true}, 
				{label:'政治面貌', name:'political.dataValue',width:80,align:"center",hidden:true}, 
			    {label:'学位', name:'degree.dataValue', index:'degree', width:80, align:"center",sortable:false}, 
				{label:'学历', name:'education',width:80,align:"center",hidden:true}, 
				{label:'毕业学校', name:'studySchool',width:80,align:"center"}, 
				{label:'留学国家', name:'abroadCountry',width:80,align:"center",hidden:true}, 
				{label:'是否总经理', name:'manager.title',width:80,align:"center"}, 
				{label:'是否法人', name:'legal.title',width:80,align:"center"}, 
				{label:'是否留学人员', name:'studyAbroad.title',width:80,align:"center",hidden:true}, 
			    {label:'是否股东', name:'stockHolder.title', index:'stockHolder', width:50, align:"center",hidden:true,sortable:false,fixed:true}, 
			    {label:'管理', name:'manager', index:'manager', width:70, fixed:true, align:"center", sortable:false, search:false}, 
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_staffer_view")){ %>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_staffer_edit")){ %>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  />"; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_staffer_delete")){ %>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  />";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			},
			gridview: true
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
		    caption : "列选择",
		    title : "选择要显示的列",
		    onClickButton : function(){
		        $(this).jqGrid('columnChooser');
		    }
		});
	}
	function viewById(id){
		fbStart('查看主要人员','<%=basePath%>staffer!view.action?id='+id,500,486);
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>staffer!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function deleteByIds(){
		var selectedRowIds =   
		$("#list").jqGrid("getGridParam","selarrrow"); 
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>staffer!delete.action?ids="+selectedRowIds,function(data){
				showTip(data.result.msg,1000);
				$("#list").trigger("reloadGrid");
			});
		}
	}
	function editById(id){
		fbStart('编辑主要人员','<%=basePath %>staffer!edit.action?id='+id,500,516);
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	
	function setSelectedCustomer(customer){
	     $("#customerId").val(customer.id);
	     $("#customerName").val(customer.name);
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function toImportCard() {
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(confirm("确定要导入名片夹（客户-主要人员）吗")){
			showTip("正在导入名片，请稍候...",100000);
			$.post('<%=basePath %>staffer!importCard.action?ids='+ids,
				function(data){
					showTip(data.result.msg,2000);
				}
			);
		 }
	 }
</script>
</head>

<body >
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_staffer_add")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建主要人员','<%=basePath%>/web/client/staffer_add.jsp',500,516);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_staffer_delete")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_staffer_importCard")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="toImportCard()"><span><img src="core/common/images/card.png"/></span>导入名片</li>
		<%} %>
		</ul>
	</div>
	<!--//leftemail-->
</div>


<div class="searchdivkf">
  <form id="form2" name="form2" method="post" action="">
    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="50" algin="right">企业： </td>
        <td width="140">
        <search:input  dataType="string" field="customer.name" op="cn" inputClass="inputauto" />
        </td>
        <td width="50" align="right">姓名：</td>
        <td width="60"><label>
          <search:input id="name" dataType="string" field="name" op="cn" inputClass="inputauto"/>
        </label></td>
        <td width="50" align="right">职位：</td>
        <td width="100">
        <search:choose dataType="string" field="positionId" op="eq">
     		<dd:select styleClass="data" key="crm.0014" />
		</search:choose>
        </td>
        <td width="45" align="right">学位：</td>
        <td width="100">
        <search:choose dataType="string" field="degreeId" op="eq">
     		<dd:select styleClass="data" key="crm.0015" />
		</search:choose>
        </td>
        <td width="75" align="center"><img src="core/common/images/search.jpg" width="75" height="22" border="0" usemap="#Map" /></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
  </form>
</div>
<table id="list" class="jqGridList"><tr><td/></tr></table>
  <!--分页开始-->
  <div id="pager"></div>
  <!--分页结束-->
  
<map name="Map" id="Map">
  <area shape="rect" coords="2,1,51,21" href="javascript:vide(0)" onclick="doSearch()"/>
  <area shape="rect" coords="56,1,76,21" href="javascript:vide(0)" onclick="fbSearch('高级搜索','<%=basePath%>web/client/staffer_search.jsp',550,305);"/>
</map>
</body>
</html>
