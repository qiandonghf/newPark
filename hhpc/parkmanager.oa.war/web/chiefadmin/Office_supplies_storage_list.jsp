<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=BaseAction.rootLocation%>/" />
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
$(document).ready(function() {
	initTip();
	initList();
});
function initList(){
	var height = getTabContentHeight()-75;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#list").jqGrid({
    	url:'<%=basePath%>supplyStockIn!listAll.action',
		colModel: [
			{label:'商品名称', name:'supply.name',width:"125", align:"center"}, 
			{label:'供应商', name:'supplier',width:"90", align:"center"}, 
		    {label:'库存号', name:'id', width:"75", align:"center"}, 
		    {label:'价格', name:'price',width:"115",formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"},
		    {label:'入货数量', name:'amount', width:"105",formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0},align:"center"},
		    {label:'总额', name:'cost', width:"100",align:"center",formatter:subcost},
		    {label:'入库日期', name:'inTime',width:"85", align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
		    {label:'购买人', name:'purchaser',width:"100", align:"center"},
		    {label:'操作', name:'manager', align:"center", width:"50",resizable:false}
		],
		shrinkToFit: false,
		height: height,
		width: width,
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

function subcost(cellvalue,options,rowObject){
	cellvalue = "￥"+cellvalue;
	return cellvalue;
}

function viewById(id){
	fbStart('查看','<%=basePath%>supplyStockIn!view.action?id='+id,480,200);
}
function editById(id){
	fbStart('编辑入库','<%=basePath %>supplyStockIn!edit.action?id='+id,500,200);
}
function deleteById(id){
	if(confirm("确定要删吗")){
		$.post("<%=basePath%>supplyStockIn!delete.action?id="+id,function(data){
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
		$.post("<%=basePath%>supplyStockIn!delete.action?ids="+ids,function(data){
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
<form action="<%=basePath%>supplyStockIn!export.action" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
</form>
	<!--emailtop-->
	<div class="emailtop">
		<div class="leftemail">
			<ul>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''"
					onclick="fbStart('入库详单','<%=basePath %>web/chiefadmin/Office_supplies_storage_add.jsp',500,200);"><span><img
						src="core/common/images/emailadd.gif" /></span>新建</li>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''" onclick="deleteByIds()"><span><img
						src="core/common/images/emaildel.png" /></span>删除</li>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li>
			</ul>
		</div>
	</div>
	<!--//emailtop-->
	<!--container-->
	<div class="msglist" id="msglist">
		<!--弹层效果-->
		<div class="layeruser" id="layerdiv" style="display: none;">
			<div class="layerlist">
				<form action="" method="post">
					<ul>
						<li>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="checkboxs"><label> <input
											type="checkbox" name="checkbox3" value="checkbox" />
									</label></td>
									<td class="layername">账号</td>
								</tr>
								<tr>
									<td class="checkboxs"><input type="checkbox"
										name="checkbox32" value="checkbox" /></td>
									<td class="layername">用户名</td>
								</tr>
								<tr>
									<td class="checkboxs"><input type="checkbox"
										name="checkbox33" value="checkbox" /></td>
									<td class="layername">邮箱</td>
								</tr>
								<tr>
									<td class="checkboxs"><input type="checkbox"
										name="checkbox34" value="checkbox" /></td>
									<td class="layername">所属部门</td>
								</tr>
							</table>
						</li>
					</ul>
				</form>
			</div>
		</div>
		<!--//弹层效果-->
		<!--titlebg-->
		<!--//titlebg-->
		
		<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
		</div>
		
		
	</div>
	<!--//container-->
</body>
</html>
