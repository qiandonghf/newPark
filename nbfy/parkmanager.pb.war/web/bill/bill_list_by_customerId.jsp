<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script>
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight());
		$("#treeviewdiv").css("height",getTabContentHeight()-30);
		$("#browser").tree({
			animate: true,
			lines: true,
			onClick: function(node){
				if($(this).tree("isLeaf",node.target)){
					$("#list").setGridParam({url:'<%=basePath%>bill!listByTypeId.action?id='+$(node.target).find("input").val()}).trigger('reloadGrid');
				}
			}
		});
		initList();
	});
	function initList(){
		var id = <%=request.getParameter("id")%>;
		$("#list").jqGrid({
	    	url:'<%=basePath%>bill!loadBill.action?id='+id,
			colModel: [
				{label:'企业名称', name:'customer.name', align:"center",hidden:true}, 
				{label:'流水号', name:'number', align:"center"}, 
			    {label:'费用类型', name:'billType.typeName', align:"center",width:90}, 
				{label:'收支', name:'inOut.title', align:"center",width:60}, 
			    {label:'结算金额', name:'factPayment', align:"center",width:100},
			    {label:'出账日期', name:'checkoutTime', align:"center",width:85, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'结算日期', name:'payTime', align:"center",width:85, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'状态', name:'status.title', align:"center",width:80},
			    {label:'管理', name:'manager', align:"center",sortable:false,width:40, resizable:false}
			],
			height: 329,
			forceFit: true,
			width: 698,
			multiselect: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					if($(this).getCell(id,9)=='未支付'){
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
						content += "<img src=\"core/common/images/hexiao.gif\" width=\"14\" height=\"14\" title=\"核销\" onclick=\"chargeoffById('"+id+"');\"  /> "; 
					}
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewById(id){
		fbStart($("#list").getRowData(id)["customer.name"],'<%=basePath %>bill!view.action?id='+id,550,310);
	}
	function editById(id){
		fbStart('编辑账单','<%=basePath %>bill!edit.action?id='+id,500,370);
	}
	function chargeoffById(id){
		if(confirm("确定要核销吗")){
			$.post("<%=basePath%>bill!chargeoff.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function deleteById(id){
		if(confirm("确定要删除吗")){
			$.post("<%=basePath%>bill!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>bill!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
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
</script>
</head>

<body>
<div class="basediv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="147" valign="top">
				<jsp:include page="../customer_view_common.jsp">
					<jsp:param value="7" name="index"/>
					<jsp:param value="<%=request.getParameter("id") %>" name="customerId"/>
				</jsp:include>
			</td>
			<td valign="top">
				<div class="pm_view_right" style="height: 432px;">
				<div class="basediv" style="margin:0px;">
					<div class="titlebg">账单列表</div>
					<table id="list" width="100%"><tr><td/></tr></table><div id="pager"></div>
					<div class="hackbox"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
