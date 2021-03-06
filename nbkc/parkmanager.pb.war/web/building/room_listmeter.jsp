<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css"  href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css"  href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css"  href="core/common/style/ui.multiselect.css" />

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
		$("#"+list).jqGrid({
	    	url:'<%=basePath%>roomMeterFee!list.action?id=${param.id}',
			datatype: 'json',
			prmNames: {search: "search"},
			jsonReader: {root:"root",repeatitems: false},
			colModel: [
				{label:'表类型',width:40, name:'type.title', align:"center"},
				{label:'表编号',width:80, name:'meter.orderNo', align:"center"},
				{label:'表序列号', name:'meter.sequenceNo', align:"center"},
				{label:'表读数',width:60, name:'meter.preReading', align:"center"},
				{label:'是否公摊',width:40, name:'share.title', align:"center"},
				{label:'最后抄表日期',width:60, name:'meter.readingDate', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'管理',width:50, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: 139,
			width: 782,
			rowNum: 0,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function editById(id){
		fbStart('编辑水电表费用','<%=basePath%>roomMeterFee!edit.action?id='+id,400,181);
	}
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>roomMeterFee!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				$("#list").trigger("reloadGrid");
			});
		}
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
</script>
</head>

<body style="background:#fff;">
	<div class="pm_msglist">
			<div class="emailtop">
				<div class="leftemail">
					<ul>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('水电表费用设置','<%=basePath %>web/building/room_listmeter_add.jsp?id=${param.id }',400,181);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>水电表费用设置</li>
					</ul>
				</div>
			</div>
			<table id="list" class="jqGridList"><tr><td/></tr></table>
	</div>
</body>
</html>
