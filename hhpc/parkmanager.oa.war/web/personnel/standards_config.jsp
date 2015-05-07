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
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initList();
	});
	
	function initList(){
		var height = getTabContentHeight()-75;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-400;
		$("#list").jqGrid({
	    	url:'<%=basePath%>salaryItem!list.action',
			colModel: [
				{label:'id', name:'id',hidden:true,align:"center"},
				{label:'薪资项名称',width:260, name:'name',align:"center"}, 
				{label:'缺省值',width:260,name:'defaultVal',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			multiselect: true		   
		});
	}
		
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function saveSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		var sid = $("#sid").val();
		if(sid==''){
			showTip("请先设定标准编号，标准名称",2000);
			return;
		}
		if(ids==''){
			showTip("请先勾选薪资项",2000);	
			return;
		}
		$.post("<%=basePath%>salaryDefineCfg!save2.action?ids="+ids+"&salaryDefineId="+sid,function(data){
			showTip(data.result.msg,2000);			
        	if(data.result.success){       		
        		setTimeout("getOpener().reloadSalaryDefineCfgList("+sid+");parent.fb.end();", 2000);
        	}
		});				
	}
</script>
</head>
<body>
<!--container-->
<div id="container">
	<input type="hidden" id="sid" value="${result.value.id}"/>
	<div class="msglist" id="msglist">
	  <table id="list" class="jqGridList"><tr><td/></tr></table>		
	</div>
</div>
<div class="buttondiv">
<label><input name="Submit" type="button" class="savebtn" value="" onclick="saveSelected();"/></label>
<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
</div>
<!--//container-->
</body>
</html>
