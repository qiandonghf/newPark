<%@page import="com.wiiy.crm.preferences.enums.ContractItemEnum"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String contractIds = request.getParameter("contractIds");
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
		var height = getTabContentHeight()-107;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>contract!listRelet.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'合同编号', name:'contractNo', align:"center",width:120}, 
				{label:'合同名称', name:'name', align:"center",width:180}, 
				{label:'合同类型', name:'item.title',index:'item', align:"center",width:130}, 
				{label:'合同企业', name:'customer.name',index:'customer', align:"center"}, 
				{label:'合同金额', name:'totalAmount',hidden:true,width:80,formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0},align:"center"}, 
			    {label:'合同到期日期', name:'endDate', align:"center",width:80,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'合同开始日期', name:'startDate',hidden:true,width:80, align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'计划完成日期', name:'finishDate',hidden:true,width:80, align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'状态', name:'state.title',index:'state', align:"center",width:70},
			    {label:'管理', name:'operation', align:"center", resizable:false,sortable:false,width:78}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
/* 				    content += "<img src=\"core/common/images/application_form_add.png\" width=\"14\" height=\"14\" title=\"发起合同审核会签\" onclick=\"review('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/application_add.png\" width=\"14\" height=\"14\" title=\"发起到期合同审批会签\" onclick=\"expire('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
 */					
 				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_delete")){%>
 					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
 				<%}%>
					$(this).jqGrid('setRowData',id,{operation:content});
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
	function deleteById(id){
		if(confirm("删除合同将同时删除该合同所有会签，确定要删吗")){
			$.post("<%=basePath%>contract!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function viewById(id){
		fbStart('查看合同','<%=basePath %>contract!view.action?id='+id,765,467);
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
			$.post("<%=basePath%>contract!delete.action?ids="+ids,function(data){
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
	
	function exportDate(){
		var columns = "{";
		$.each($("#list").getGridParam("colModel"),function(){
			if(this.label && this.name!="operation" && !this.hidden){
				columns += "\"" + this.name + "\"" + ":" + "\"" + this.label + "\",";
			}
		});
		columns = deleteLastCharWhenMatching(columns,",");
		columns += "}";
		$("#columns").val(columns);
		$("#exportForm").submit();
	}
	
	function expire(id){	
		$.post("<%=basePath %>contractExpireApproval!checkExist.action?id="+id,function(data){
			if(data.result.success){
				fbStart('到期合同审批会签','<%=basePath %>contractExpireApproval!add.action?id='+id,550,180);
			}else{
				showTip("您已经发起过该会签！！！");
			}
		});
		
	}
	
	function review(id){
		if(confirm("确定要发起会签吗")){
			$.post("<%=basePath %>contractReview!checkExist.action?id="+id,function(data){
				if(data.result.success){
						showTip("会签发起成功");
				}else{
					showTip("您已经发起过该会签！！！");
				}
			});
		 }
	}
</script>

</head>
<body>
<form action="<%=basePath%>contract!export.action?fileName=THROWALEASE" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
</form>
<div class="emailtop" style="position:relative;z-index:99999;">
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_delete")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_export")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif"/></span>导出</li>
		<%} %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="reloadList()"><span><img src="core/common/images/refresh3.png"/></span>刷新</li>
		</ul>
	</div>
</div>
<div class="searchdiv">
	<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="70">合同名称： </td>
			<td width="150">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="150"><search:input dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
					</tr>
				</table>
			</td>
			<td width="45" align="right">类型：</td>
			<td width="90"><search:choose dataType="com.wiiy.crm.preferences.enums.ContractItemEnum" field="item" op="eq"><enum:select styleClass="data" name="contract.type" type="com.wiiy.crm.preferences.enums.ContractItemEnum"/></search:choose></td>
			<td width="45" align="right">状态：</td>
			<td width="100"><search:choose dataType="com.wiiy.crm.preferences.enums.ContractStatusEnum" field="state" op="eq"><enum:select styleClass="data" name="contract.status" type="com.wiiy.crm.preferences.enums.ContractStatusEnum"/></search:choose></td>
			<td width="75" align="center"><label><img src="core/common/images/search.gif" width="75" height="22" border="0" onclick="doSearch()" /></label></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</div>
<div  id="container">
	<div class="msglist" style="display:block;" id="textname" name="textname">
		<table id="list" class="jqGridList"><tr><td></td></tr></table>
		<div id="pager"></div>
	</div>
</div>
</body>
</html>