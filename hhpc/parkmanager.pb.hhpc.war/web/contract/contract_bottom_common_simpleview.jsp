<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String action = request.getParameter("action");
%>
<script type="text/javascript">
	function init(){
		initSubjectList();
		initBillPlanList();
		initContractAttList();
		initDepositListList();
		initContractMemoList();
		initModifyList();
		initApprovalList();
	} 
	function initContractAttList(){
		$("#contractAttList").jqGrid({
	    	url:'<%=basePath%>contractAtt!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'名称', name:'name', align:"center"}, 
				{label:'上传时间', name:'createTime', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
			    {label:'管理', name:'manager', align:"center",hidden:true, resizable:false,width:30,sortable:false}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			multiselect: false,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editContractAttById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteContractAttById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function editContractAttById(id){
		fbStart('编辑附件',"<%=basePath%>contractAtt!edit.action?id="+id,350,70);
	}
	function deleteContractAttById(id){
		if(confirm("确认删除该附件？")){
			$.post("<%=basePath%>contractAtt!delete.action?id="+id,function(){
				$("#contractAttList").trigger("reloadGrid");
			});
		}
	}
	function reloadContractAttList(){
		$("#contractAttList").trigger("reloadGrid");
	}
	function initContractMemoList(){
		$("#contractMemoList").jqGrid({
	    	url:'<%=basePath%>contractMemo!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'内容', name:'memo', align:"center"}, 
				{label:'提交时间', name:'createTime', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'管理', name:'manager', align:"center",hidden:true, resizable:false,width:30,sortable:false}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			multiselect: false,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewContractMemoById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editContractMemoById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteContractMemoById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewContractMemoById(id){
		fbStart('查看备忘',"<%=basePath%>contractMemo!view.action?id="+id,500,170);
	}
	function editContractMemoById(id){
		fbStart('编辑备忘',"<%=basePath%>contractMemo!edit.action?id="+id,500,170);
	}
	function deleteContractMemoById(id){
		if(confirm("确认删除该备忘？")){
			$.post("<%=basePath%>contractMemo!delete.action?id="+id,function(){
				$("#contractMemoList").trigger("reloadGrid");
			});
		}
	}
	function reloadContractMemoList(){
		$("#contractMemoList").trigger("reloadGrid");
	}
	function initApprovalList(){
		$("#contractApprovalList").jqGrid({
	    	url:'<%=basePath%>contractApproval!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'结果', name:'state.title', align:"center",width:30}, 
				{label:'意见', name:'memo', align:"center"}, 
				{label:'提交时间', name:'createTime', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'管理', name:'manager', align:"center",hidden:true, resizable:false,width:30,sortable:false}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			multiselect: false,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewContractApprovalById('"+id+"');\"  /> "; 
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewContractApprovalById(id){
		fbStart('查看审批',"<%=basePath%>contractApproval!view.action?id="+id,500,170);
	}
	function reloadContractApprovalList(){
		$("#contractApprovalList").trigger("reloadGrid");
	}
	function initModifyList(){
		$("#contractModifyList").jqGrid({
	    	url:'<%=basePath%>contractModifyLog!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'操作', name:'operation', align:"center",width:30}, 
				{label:'详情', name:'memo', align:"center"}, 
				{label:'变更时间', name:'createTime', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'管理', name:'manager', align:"center",hidden:true, resizable:false,width:30,sortable:false}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			multiselect: false,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewContractModifyById('"+id+"');\"  /> "; 
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewContractModifyById(id){
		fbStart('查看变更',"<%=basePath%>contractModifyLog!view.action?id="+id,500,170);
	}
</script>
	<div class="basediv tabswitch" style="margin-top:0px; display:none" id="textname" name="textname">
		<table id="contractAttList"><tr><td></td></tr></table>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px; display:none" id="textname" name="textname">
		<table id="contractMemoList"><tr><td></td></tr></table>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px; display:none" id="textname" name="textname">
		<table id="contractApprovalList"><tr><td></td></tr></table>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px; display:none" id="textname" name="textname">
		<table id="contractModifyList"><tr><td></td></tr></table>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px; display:none;" id="textname" name="textname">
		<div class="leftemail" style="height: 197px;">
			${result.value.policy}
		</div>
	</div>