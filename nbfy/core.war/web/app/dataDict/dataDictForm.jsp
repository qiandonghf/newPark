<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${rootLocation}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link href="core/common/style/ui.jqgrid.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/grid.inlinedit.js"></script>
<script>
$(document).ready(function() {
	initTip();
	initList();
});
function initList(){
	//var height = window.parent.document.documentElement.clientHeight-640;
	$("#list").jqGrid({
    	url:'${contextLocation}dataDict!list.action',
    	postData : {filters:getSearchFilters()},
		datatype: 'json',
		prmNames: {search: "search"},
		jsonReader: {root:"root",repeatitems: false},
		colModel: [
			{name:'canWrite', hidden:true, hidedlg:true}, 
			{name:'parentId', hidden:true, hidedlg:true}, 
			{label:'数据值', editable:true, editoptions : {"class":"core_input_no_border"}, name:'dataValue', index:'dataValue', align:"center"}, 
			{label:'显示序号', editable:true, editoptions : {"class":"core_input_no_border"}, name:'displayOrder', index:'displayOrder', width:60, align:"center"}, 
		    {label:'管理', name:'manager', index:'manager', title:false, width:80, align:"center", sortable:false, search:false, fixed:true}, 
		],
		//height: height,
		autowidth: true,//宽度自动
		multiselect: false,//是否可以多选
		rownumbers: true,//显示行顺序号，从1开始递增。此列名为'rn'
		loadui: 'block',//当执行ajax请求时 启用Loading提示，但是阻止其他操作
		gridComplete: function(){
			var rowDatas = $(this).jqGrid("getRowData");
 			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < rowDatas.length; i++){
				var id = ids[i];
				var selRow = $("#list").jqGrid("getRowData",id);
				var content = "";
				content += "<img src=\"core/common/images/edit.gif\" alt=\"编辑\" title=\"编辑\" onclick=\"editById('"+id+"');\"/> "; 
				content += "<img src=\"core/common/images/del.gif\" alt=\"删除\" title=\"删除\" onclick=\"deleteById('"+id+"');\"/>";
				$(this).jqGrid('setRowData',id,{manager:content});
			}
			setTimeout(addNewRow, 100);
 		},
 		editurl: "${contextLocation}dataDict!save.action",
		gridview: true
	});
}
var addedNewRow = false;
function addNewRow() {
	if (addedNewRow) return;
	addedNewRow = true;
	var newId = getNewId();
	$("#list").jqGrid("addRowData", newId, {parentId:$("#filter_data").val(), dataValue:"", displayOrder:""});
	$("#list").jqGrid("editRow", newId);
	$("#list").jqGrid('setRowData',newId,{manager:"<img src=\"core/common/images/emailadd.gif\" alt=\"添加\" title=\"添加\" onclick=\"saveAndCreateDataDict('"+newId+"');\"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"});
}
function saveAndCreateDataDict(id) {
	var inputDataValue = $("#"+escId4JQuery(id+"_dataValue")).val();
 	if (inputDataValue==null || trim(inputDataValue)=="") {
		showTip("数据值不能为空!", 2000);
		return;
	}
	var inputDisplayOrder = $("#"+escId4JQuery(id+"_displayOrder")).val();
	if (inputDisplayOrder==null || !checkIntValue(inputDisplayOrder)) {
		showTip("显示序号不能为空且为数字!", 2000);
		return;
	}
	$("#list").jqGrid('saveRow',id,{successfunc: 
		function(response) {
	 		eval("var root="+response.responseText);
			if (root.result.success) {
        		addedNewRow = false;
        		$("#list").trigger("reloadGrid");
			} else {
				$("#list").jqGrid("editRow", root.id);
	            showTip(root.result.msg, 2000);
			}
		}
	});	
}
function getNewId() {
	var ids = $("#list").jqGrid('getDataIDs');
	var parentId = $("#filter_data").val();
	for (var i = 99; i > 9; i --) {
		if (notExisted(ids, parentId+i)) {
			return parentId + i; 
		}
	}
	for (var i = 9; i > 0; i --) {
		if (notExisted(ids, parentId + "0" + i)) {
			return parentId + "0" + i; 
		}
	}
}

function notExisted(ids, id) {
	if (ids.length == 0) return true;
	for (var j = 0; j < ids.length; j ++) {
		if (ids[j] == id) return false;
	}
	return true;
}

function editById(id){
	$("#list").jqGrid("editRow", id, true);
	var content = "";
	content += "<img src=\"core/common/images/saveico.gif\" alt=\"保存\" title=\"保存\" onclick=\"saveDataDict('"+id+"');\"/> "; 
	content += "<img src=\"core/common/images/cancelico.gif\" alt=\"取消\" title=\"取消\" onclick=\"restoreDataDict('"+id+"');\"/>";
	$("#list").jqGrid('setRowData',id,{manager:content});
}
function saveDataDict(id) {
	$("#list").saveRow(id);
	var content = "";
	content += "<img src=\"core/common/images/edit.gif\" alt=\"编辑\" title=\"编辑\" onclick=\"editById('"+id+"');\"/> "; 
	content += "<img src=\"core/common/images/del.gif\" alt=\"删除\" title=\"删除\" onclick=\"deleteById('"+id+"');\"/>";
	$("#list").jqGrid('setRowData',id,{manager:content});
}
function restoreDataDict(id) {
	$("#list").restoreRow(id);
	var content = "";
	content += "<img src=\"core/common/images/edit.gif\" alt=\"编辑\" title=\"编辑\" onclick=\"editById('"+id+"');\"/> "; 
	content += "<img src=\"core/common/images/del.gif\" alt=\"删除\" title=\"删除\" onclick=\"deleteById('"+id+"');\"/>";
	$("#list").jqGrid('setRowData',id,{manager:content});
}
function deleteById(id){
	var selRow = $("#list").jqGrid("getRowData",id);
	if(confirm("确定要删吗")){
		$.post("${contextLocation}dataDict!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		addedNewRow = false;
        		$("#list").trigger("reloadGrid");
				//setTimeout(addNewRow, 10000);
        	}
		});
	}
}
</script>
</head>

<body style="background:#fff">
<!--basediv-->
<div class="basediv" style="height:175px;margin-bottom: 10px;">
	<input id="filter_name" class="field" type="hidden" value="parentId"/>
	<input id="filter_op" class="op" type="hidden" value="eq"/>
	<input id="filter_dataType" class="dataType" type="hidden" value="string"/>
	<input id="filter_data" type="hidden" class="data" value="${id}"/>

  <!--divlays-->
  	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="list">	
	</table>
</div>
</body>
</html>
