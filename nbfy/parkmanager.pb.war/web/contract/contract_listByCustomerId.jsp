<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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

<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
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
		$("#list").jqGrid({
	    	url:'<%=basePath%>contract!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'合同名称', name:'name', align:"center"}, 
				{label:'合同编号', name:'contractNo', align:"center",width:80}, 
				{label:'合同金额', name:'totalAmount',formatter:'number',width:60,formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0},align:"center"}, 
			    {label:'合同到期日', name:'endDate', align:"center",width:60,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'状态', name:'state.title', align:"center",width:30},
			    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false,width:25}
			],
			height: 329,//加上分页栏高度为106
			forceFit: true,
			multiselect: false,
			width: 698,
			postData:{filters:generateSearchFilters("customerId","eq",<%=request.getParameter("id") %>,"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewById(id){
		fbStart('查看合同','<%=basePath %>contract!view.action?id='+id,750,467);
	}
	function editById(id){
		fbStart('编辑合同','<%=basePath %>contract!edit.action?id='+id,750,437);
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>contract!delete.action?id="+id,function(data){
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
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>contect!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function slideDown(id){
		if($('#'+id).is(':hidden')){
			$('#'+id).slideDown();
		}else{
			$('#'+id).slideUp();
		}
		installListener(id);
	}
	var over = false;
	var timer;
	function installListener(id){
		$("#"+id).mouseout(function(){
			over = false;
			timer = setTimeout(function(){
				if(!over){
					$('#'+id).slideUp();
				}
			},1000);
		});
		$("#"+id).mouseover(function(){
			over = true;
			clearTimeout(timer);
		});
	}
	function clearSessionCache(){
		$.post("<%=basePath%>contract!clearSessionCache.action");
	}
	var needConfirmClose = true;
	function closeConfirm(){
		if(needConfirmClose){
			if(confirm("关闭当前窗口会丢失已保存的信息\n\t确定关闭吗!")){
				clearSessionCache();
				return true;
			}
			return false;
		}
		return true;
	}
</script>

</head>
<body>
<div class="basediv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="147" valign="top">
				<jsp:include page="../customer_view_common.jsp">
					<jsp:param value="6" name="index"/>
					<jsp:param value="<%=request.getParameter("id") %>" name="customerId"/>
				</jsp:include>
			</td>
			<td valign="top">
				<div class="pm_view_right" style="height: 432px;">
				<div class="basediv" style="margin:0px;">
					<div class="titlebg">合同列表</div>
					<table id="list" width="100%"><tr><td/></tr></table><div id="pager"></div>
					<div class="hackbox"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>