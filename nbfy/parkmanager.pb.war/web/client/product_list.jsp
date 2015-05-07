<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	    	url:'<%=basePath%>product!list.action',
			colModel: [
				{label:'企业名称', name:'customer.name', index:'customer',  align:"center",sortable:false,width:180}, 
			    {label:'产品名称', name:'name', index:'name', width:70, align:"center",width:150}, 
			    {label:'技术领域', name:'technic.dataValue', index:'technic', width:140, align:"center"},
			    {label:'产品阶段', name:'stage.dataValue', index:'stage', width:80, align:"center",sortable:false}, 
			    {label:'管理', name:'manager', index:'manager', width:70, fixed:true, align:"center", sortable:false, search:false}, 
			],
			shrinkToFit: false,
			height: height,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_product_view")){ %>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_product_edit")){ %>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  />"; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_product_delete")){ %>
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
		fbStart('查看项目与产品','<%=basePath%>product!view.action?id='+id,500,317);
	}
	
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>product!delete.action?id="+id,function(data){
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
			$.post("<%=basePath%>product!delete.action?ids="+selectedRowIds,function(data){
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
	
	function editById(id){
		fbStart('编辑项目与产品','<%=basePath %>product!edit.action?id='+id,500,413);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
</script>

</head>

<body >
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_product_add")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建项目与产品','<%=basePath%>web/client/product_add.jsp',500,398);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_product_delete")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		</ul>
	</div>
	<!--//leftemail-->
</div>

<div class="searchdivkf">
  <form id="form2" name="form2" method="post" action="">
    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="50">企业： </td>
        <td width="180">
            <search:input  dataType="string" field="customer.name" op="cn" inputClass="inputauto" />
        </td>
        <td width="50" align="right">产品：</td>
        <td width="105"><label>
        	<search:input id="name" dataType="string" field="name" op="cn" inputClass="inputauto"/>
        </label></td>
		<td width="50" align="right">领域：</td>
        <td width="105">
        	<search:choose dataType="string" field="technicId" op="eq">
        		<dd:select styleClass="data" key="crm.0002" />
        	</search:choose>
        </td>
		<td width="50" align="right">阶段：</td>
        <td width="105">
        <search:choose dataType="string" field="stageId" op="eq">
        	<dd:select styleClass="data" key="crm.0013" />
        	</search:choose>
        </td>
        <td width="75" align="center">
          <img src="core/common/images/search.jpg" width="75" height="22" border="0" usemap="#Map" />
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
   
  </form>
</div>
 <table id="list" class="jqGridList"><tr><td/></tr></table>
  <!--分页开始-->
  <div id="pager"></div>
<!--//container-->
<map name="Map" id="Map">
<area shape="rect" coords="2,1,53,29" href="javascript:vido(0)" onclick="doSearch();"/>
<area shape="rect" coords="57,1,75,24" href="javascript:vido(0)" onclick="fbSearch('高级搜索','<%=basePath%>web/client/product_search.jsp',550,150);" />
</map>
</body>
</html>
