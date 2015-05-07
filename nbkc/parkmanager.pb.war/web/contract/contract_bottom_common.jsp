<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String action = request.getParameter("action");
String operation = request.getParameter("operation");
%>
<script type="text/javascript">
	function init(){
		initSubjectList();
		initBillPlanList();
		initContractAttList();
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
				{label:'路径', name:'newName', align:"center",hidden:true}, 
				{label:'上传时间', name:'createTime', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
			    {label:'管理', name:'manager', align:"center", resizable:false,width:30,sortable:false}
			],
			height: 145,
			width: 740,
			rowNum: 0,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractAtt_download")){%>
					content += "<img src=\"core/common/images/down.png\" width=\"14\" height=\"14\" title=\"下载\" onclick=\"downloadContractAttById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractAtt_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editContractAttById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractAtt_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteContractAttById('"+id+"');\"  /> ";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function downloadContractAttById(id){
		var path = $("#contractAttList").getCell(id,4);
		var name = $("#contractAttList").getCell(id,3);
		location.href="<%=BaseAction.rootLocation %>/core/resources/"+path+"?name="+name;
	}
	function editContractAttById(id){
		fbStart('编辑附件',"<%=basePath%>contractAtt!edit.action?id="+id,350,70);
	}
	function deleteContractAttById(id){
		if(confirm("确认删除合同附件")){
			$.post("<%=basePath%>contractAtt!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					$("#contractAttList").trigger("reloadGrid");
				}
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
			    {label:'管理', name:'manager', align:"center", resizable:false,width:30,sortable:false}
			],
			height: 145,
			width: 740,
			rowNum: 0,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractMemo_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewContractMemoById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractMemo_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editContractMemoById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractMemo_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteContractMemoById('"+id+"');\"  /> ";
					<%}%>
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
		if(confirm("确认删除合同备忘")){
			$.post("<%=basePath%>contractMemo!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					$("#contractMemoList").trigger("reloadGrid");
				}
			});
		}
	}
	function reloadContractMemoList(){
		$("#contractMemoList").trigger("reloadGrid");
	}
	function initApprovalList(){
		$("#contractApprovalList").jqGrid({
	    	url:'<%=BaseAction.rootLocation %>/core/approval!listContractApproval.action?groupId=${groupIds}',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'审批人', name:'userName', align:"center",width:30}, 
				{label:'结果', name:'status.title', align:"center",width:30}, 
				{label:'意见', name:'suggestion', align:"center"}, 
				{label:'提交时间', name:'approvalTime', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'管理', name:'manager', align:"center", resizable:false,width:30,sortable:false}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			postData:{filters:generateSearchFilters("status","ne",'UNDETERMINED',"com.wiiy.core.preferences.enums.ApprovalStatusEnum")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_approval_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewContractApprovalById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_approval_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteContractApprovalById('"+id+"');\"  /> "; 
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function deleteContractApprovalById(id){
		$.post("<%=BaseAction.rootLocation %>/core/approval!delete.action?id="+id,function(){
			$("#contractApprovalList").trigger("reloadGrid");
		});
	}
	function viewContractApprovalById(id){
		fbStart('查看审批',"<%=BaseAction.rootLocation %>/core/approval!view.action?id="+id,500,170);
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
			    {label:'管理', name:'manager', align:"center", resizable:false,width:30,sortable:false}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractModifyLog_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewContractModifyById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractModifyLog_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteContractModifyById('"+id+"');\"  /> "; 
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function deleteContractModifyById(id){
		$.post("<%=basePath%>contractModifyLog!delete.action?id="+id,function(){
			$("#contractModifyList").trigger("reloadGrid");
		});
	}
	function viewContractModifyById(id){
		fbStart('查看变更',"<%=basePath%>contractModifyLog!view.action?id="+id,500,170);
	}
	function reloadContractModifyList(){
		$("#contractModifyList").trigger("reloadGrid");
	}
</script>
<%int flag3=-1;
	if(PbActivator.getHttpSessionService().isInResourceMap("pb_subjectRent_list")){
		flag3++;
	}
	if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_list")){
		flag3++;
	}
	if(PbActivator.getHttpSessionService().isInResourceMap("pb_deposit_list")){
		flag3++;
	}
%>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractAtt_list")){flag3++; %>

	<div class="basediv tabswitch" style="margin-top:0px;<%if(flag3!=0){ %>display:none;<%} %>" id="textname" name="textname">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractAtt_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建合同附件','<%=basePath %>web/contract/contractAtt_add.jsp?id='+$('#contractId').val(),450,198);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				<%} %>
				</ul>
			</div>
		</div>
		<table id="contractAttList"><tr><td></td></tr></table>
	</div>
<%} %>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractMemo_list")){flag3++; %>
	<div class="basediv tabswitch" style="margin-top:0px;<%if(flag3!=0){ %>display:none;<%} %>" id="textname" name="textname">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractMemo_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建合同备忘','<%=basePath %>web/contract/contractMemo_add.jsp?id='+$('#contractId').val(),450,167);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				<%} %>
				</ul>
			</div>
		</div>
		<table id="contractMemoList"><tr><td></td></tr></table>
	</div>
<%} %>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_approval_list")){flag3++; %>
	<div class="basediv tabswitch" style="margin-top:0px;<%if(flag3!=0){ %>display:none;<%} %>" id="textname" name="textname">
		<c:if test="${result.value.state eq 'COMFIRM' or result.value.state eq 'COMFIRMYES' or result.value.state eq 'COMFIRMNO'}">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('合同审批','<%=basePath %>web/contract/contractApproval_add.jsp?id='+$('#contractId').val(),450,167);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				</ul>
			</div>
		</div>
		</c:if>
		<table id="contractApprovalList"><tr><td></td></tr></table>
	</div>
<%} %>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractModifyLog_list")){flag3++; %>
	<div class="basediv tabswitch" style="margin-top:0px;<%if(flag3!=0){ %>display:none;<%} %>" id="textname" name="textname">
		<table id="contractModifyList"><tr><td></td></tr></table>
	</div>
<%} %>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_favorable")){flag3++; %>
	<div class="basediv tabswitch" style="margin-top:0px;<%if(flag3!=0){ %>display:none;<%} %>" id="textname" name="textname">
		<div class="leftemail" style="height: 197px;">
		<%if(operation!=null && operation.equals("edit")){ %>
			<textarea name="contract.policy" style="height: 100%;width: 100%">${result.value.policy}</textarea>
		<%} else {%>
			${result.value.policy}
		<%}%>
		</div>
	</div>
<%} %>