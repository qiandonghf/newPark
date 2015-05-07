<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/jquery.treeview.css" />

<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.treeview.js"></script>
<script type="text/javascript" src="core/common/js/jquery.treeview.edit.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initList();
	});
	
	function initList(){
		var height = getTabContentHeight()-175;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>workClass!list.action',
			colModel: [
				{label:'序列', width:30,name:'id',align:"center"},
				{label:'班次名称', width:80,name:'name',align:"center"},
				{label:'上班时间', name:'startTime', align:"center"},
				{label:'下班时间', name:'endTime', align:"center"}
			],
			height: height,
			width: width,
			rowNum: 10,//设置表格中显示的记录数如果服务器返回记录数大于此值则只显示rowNum条 -1不检查此项
			rowList: [],//用来调整表格显示的记录数
			recordtext: "共 {2} 条",	// 共字前是全角空格
			autowidth: true,//宽度自动
			multiboxonly: false,
			viewrecords: true,//是否显示总记录数
			shrinkToFit: true,
			multiselect: true,//是否可以多选 
			rownumbers: false,//显示行顺序号，从1开始递增。此列名为'rn'
			loadui: 'block',//当执行ajax请求时 启用Loading提示，但是阻止其他操作
			pager: '#pager'//指定分页栏对象
		});
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function GetRequest() {
		// 获得父页面传过来的请求URL后面的请求参数
		   var url = location.search; //获取url中"?"符后的字串 
		   var theRequest = new Object(); 
		   if (url.indexOf("?") != -1) { 
		      var str = url.substr(1); 
		      strs = str.split("&"); 
		      for(var i = 0; i < strs.length; i ++) { 
		         theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]); 
		      } 
		   } 
		   return theRequest; 
		} 
	
	var workClassArray = new Array();
	var workClass={id:"${workClass.id}", name:"${workClass.name}"};
	function submitSelectedWorkClass() {
		// 选择班次，并将对应的节点的id传回父页面
		// 以便把班次名称和班次id输入到对应的节点
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		for(var i=0;i<ids.length;i++){
			var rowData = $("#list").jqGrid("getRowData", ids[i]);
			workClass = {id :ids[i], name : rowData.name};
			workClassArray.push(workClass);
		}
		if (workClass.id == "") {
			showTip("未选择班次", 1000);
			return;
		}
		var Request = new Object();
		Request = GetRequest();
		var trueId,falseId;
		trueId = Request['trueId'];
		falseId = Request['falseId'];
		getOpener().setSelectedWorkClass(workClassArray,trueId,falseId);
		fb.end();
	}
	
	function rest(){//设置某一日为休息
		workClass = {id :"", name :"休息"};
		var Request = new Object();
		Request = GetRequest();
		var trueId = Request['trueId'];
		var falseId = Request['falseId'];
		getOpener().setRest(workClass,trueId,falseId);
		fb.end();
	}
</script>

</head>

<body >
<div class="basediv">
	<table width="100%" border="0" cellspacing="0" cellpadding="10">
	  <tr>
	    <td valign="top">
		  <table id="list" class="jqGridList"><tr><td/></tr></table>
		  <div id="pager"></div>
	    </td>
	  </tr>
	</table>
	<div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="rightbtn" value="" onclick="submitSelectedWorkClass();"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  <label><input name="Submit3" type="button" class="restbtn" value="" onclick="rest();"/></label>
</div>
</body>
</html>
