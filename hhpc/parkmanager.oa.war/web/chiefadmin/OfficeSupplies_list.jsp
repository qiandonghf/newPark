<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<!-- <link rel="stylesheet" type="text/css" href="parkmanager.oa/web/style/cord_icon.css"/> -->

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
	var supplyCategoryMenu=[[
      	{
     		text:"重命名",
     		classname:"smarty_menu_ico1",
     		func:function(){
     			fbStart('重命名','<%=basePath%>supplyCategory!edit.action?id='+$(this.parentNode).attr("node-id"),300,80);
     		}
     	},{
     		text:"删除",
     		classname:"smarty_menu_ico2",
     		func:function(){
     			if(confirm("您确定要删除")){
     				$.post("<%=basePath%>supplyCategory!delete.action?id="+$(this.parentNode).attr("node-id"),function(data){
     					showTip(data.result.msg,2000);
     					if(data.result.success){
    						refreshTree();
    						setTimeout("reloadList();");
    				}});
     			}
     		}
     	}],[{
    		text:"添加",
    		classname:"smarty_menu_ico0",
    		func:function(){
    			fbStart('添加','<%=basePath%>supplyCategory!addSupplyCategoryByParentId.action?id='+$(this.parentNode).attr("node-id"),300,80);
    		}
    	}]];
	
	var supplyLabel=[[
          	{
           		text:"重命名",
           		classname:"smarty_menu_ico1",
           		func:function(){
           			fbStart('重命名','<%=basePath%>supplyCategory!edit.action?id='+$(this.parentNode).attr("node-id"),300,80);
           		}
           	},{
           		text:"删除",
           		classname:"smarty_menu_ico2",
           		func:function(){
           			if(confirm("您确定要删除")){
           				$.post("<%=basePath%>supplyCategory!delete.action?id="+$(this.parentNode).attr("node-id"),function(data){
           					showTip(data.result.msg,2000);
           					if(data.result.success){
        						refreshTree();
        						setTimeout("reloadList();");
        				}});
           			}
           		}
           	}]];
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight()-11);
		$("#treeviewdiv").css("height",getTabContentHeight()-90);
		refreshTree();
		initList();
		jqGridResizeRegister("list");
	});
	
	function refreshTree(){
		$.ajax({
			  "url" : "<%=basePath%>supplyCategory!treeList.action",
			  type:"POST",
			  success: function(data){
				$("#tt").tree({
					animate: true,
					lines:true,
					"data" : data.supplyCategories
				}); 
					var nodes = $("#tt").tree("getRoots");
					for( var i = 0; i < nodes.length; i++){
						var node = nodes[i];
						<%if(BooleanEnum.YES.equals(OaActivator.getSessionUser(request).getAdmin())){%>
							$(node.target).find(".tree-title").smartMenu(supplyCategoryMenu,{name:'supplyCategoryMenu'});
						<%}%>
						var children = $(this).tree("getChildren",node.target);
						for( var j = 0; j < children.length; j++){
							var child = children[j];
								<%if(BooleanEnum.YES.equals(OaActivator.getSessionUser(request).getAdmin())){%>
									$(child.target).find(".tree-title").smartMenu(supplyLabel,{name:'supplyLabel'});
								<%}%>
							$(child.target).find(".tree-title").click(function(node){
								var ids = $(this.parentNode).attr("node-id");
								loadSupplyByCategoryId(ids);
							});
						}
					}
			  }
			});
	}
	
	
	function loadSupplyByCategoryId(categoryId){
		if(categoryId ==null){
			$("#list").setGridParam({url:'<%=basePath%>supply!listAll.action',postData:{filters:''}}).trigger('reloadGrid'); 
		}
		else
			$("#list").setGridParam({url:'<%=basePath%>supply!loadSupplyByCategoryId.action?id='+categoryId,postData:{filters:''}}).trigger('reloadGrid');
	}
	
	function initList(){
		var height = getTabContentHeight()-107;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-185;
		$("#list").jqGrid({
	    	url:'<%=basePath%>supply!listAll.action',
			colModel: [
				{label:'所属分类',width:70, name:'category.name',align:"center"}, 
				/* {label:'分类外键',name:'categoryId',align:"center",hidden:true}, 
				{label:'所属分类ID',name:'categoryIds',align:"center",hidden:true},  */
				{label:'物品名称',width:110, name:'name',align:"center"}, 
				{label:'编号',width:55, name:'id',align:"center"}, 
				{label:'规格',width:90, name:'spec',align:"center"}, 
				{label:'计量单位',width:70, name:'unit',align:"center"},
				{label:'是否启用库存警示', width:120, name:'alarm.title', align:"center"},
				{label:'备注', name:'memo', align:"center",formatter:count},
				{label:'库存总数',width:90, name:'stock',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"},
			    {label:'管理',width:50, name:'manager', align:"center", sortable:false, resizable:false}
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
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
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
	
	function viewById(id){
		fbStart($("#list").getRowData(id).name,'<%=basePath %>supply!check.action?id='+id,698,450);
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
	
	function count(cellvalue,options,rowObject){
		   var memo = rowObject["memo"];
		   var cellvalue = memo;
		   if(memo.length > 15){
			   cellvalue = memo.substring(0,14)+"......";
		   }
		   return cellvalue;
		}
	
	function editById(id){
		fbStart('编辑办公用品信息','<%=basePath%>supply!edit.action?id='+id,590,240);
	}
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>supply!delete.action?id="+id,function(data){
				if(data.result!=null){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("#list").trigger("reloadGrid");
		        	}
				}else{
					showTip("没有权限");
				}
			});
		}
	}
	function deleteByIds(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>supply!delete.action?ids="+ids,function(data){
				if(data.result!=null){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("#list").trigger("reloadGrid");
		        	}
				}else{
					showTip("没有权限");
				}	
			});
		}
	}

	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
</script>
</head>

<body>
<form action="<%=basePath%>supply!export.action?type=1" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
</form>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="182" valign="top">
				<div class="agency" id="resizable" >
					<div class="titlebg">办公用品类型</div>
					<div class="agencybtn">
						<ul>
						<%if(BooleanEnum.YES.equals(OaActivator.getSessionUser(request).getAdmin())){ %>
							<li><a href="javascript:void(0)" onclick="fbStart('类型分类','<%=basePath %>web/chiefadmin/SupplyCategory_add.jsp',300,80);"><span class="icoadd"></span>添加类型</a></li>
						<%}%>
						</ul>
					</div>
					<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
						<ul id="tt"></ul>
					</div>
				</div>
			</td>
			<td width="100%" valign="top" >
				<div class="titlebg">办公用品列表</div>
					<div class="emailtop">
						<div class="leftemail">
							<ul>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建办公用品','<%=basePath%>supply!add.action',590,240);"><span><img src="core/common/images/emailadd.gif"/></span>新建</li>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li>
							</ul>
						</div>
					</div>
				<div style="overflow: auto;">
					<table id="list" class="jqGridList"><tr><td/></tr></table>
					<div id="pager"></div>
				</div>
			</td>
		</tr>
	</table>
</div>

</body>
</html>