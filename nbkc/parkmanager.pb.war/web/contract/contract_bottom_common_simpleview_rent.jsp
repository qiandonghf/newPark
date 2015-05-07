<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String action = request.getParameter("action");
%>
<script type="text/javascript">
	function initSubjectList(){
		$("#subjectRentList").jqGrid({
	    	url:'<%=basePath%>subjectRent!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'租用地址', name:'roomName', align:"center"}, 
				{label:'租用面积', name:'roomArea',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0},align:"center",width:40}, 
			    {label:'开始时间', name:'startDate', align:"center",width:40,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
			    {label:'结束时间', name:'endDate', align:"center",width:40, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			multiselect: false,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")}
		});
	}
	function editSubjectRentById(id){
		fbStart('编辑标的',"<%=basePath%>subjectRent!edit.action?id="+id+"&saveFlag="+$("#saveFlag").val(),500,284);
	}
	function deleteSubjectRentById(id){
		if(confirm("确认删除该标的？")){
			$.post("<%=basePath%>subjectRent!delete.action?id="+id+"&saveFlag="+$("#saveFlag").val(),function(){
				$("#subjectRentList").trigger("reloadGrid");
			});
		}
	}
	function reloadSubjectRentList(){
		$("#subjectRentList").trigger("reloadGrid");
	}
	function initBillPlanList(){
		$("#billPLanRentList").jqGrid({
	    	url:'<%=basePath%>billPlanRent!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'类型', name:'feeType.title', align:"center",width:20}, 
				{label:'计费开始时间', name:'startDate', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'计费结束时间', name:'endDate', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'计划金额', name:'planFee',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center",width:30}, 
				{label:'实际金额', name:'realFee',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center",width:30}, 
				{label:'计划付费时间', name:'planPayDate', align:"center",width:30, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'状态', name:'status.title', align:"center",width:30}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			multiselect: false,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")}
		});
		initDepositListList();
	}
	function viewBillPlanRentById(id){
		fbStart('资金计划',"<%=basePath%>billPlanRent!view.action?id="+id,500,284);
	}
	function editBillPlanRentById(id){
		fbStart('编辑资金计划',"<%=basePath%>billPlanRent!edit.action?id="+id,500,315);
	}
	function deleteBillPlanRentById(id){
		if(confirm("确认删除该资金计划？")){
			$.post("<%=basePath%>billPlanRent!delete.action?id="+id,function(){
				$("#billPLanRentList").trigger("reloadGrid");
			});
		}
	}
	function billPlanRentCheckinById(id){
		$.post("<%=basePath%>billPlanRent!checkinById.action?id="+id,function(data){
			showTip(data.result.msg,2000);
			$("#billPLanRentList").trigger("reloadGrid");
		});
	}
	function billPlanRentCheckoutById(id){
		$.post("<%=basePath%>billPlanRent!checkoutById.action?id="+id,function(data){
			showTip(data.result.msg,2000);
			$("#billPLanRentList").trigger("reloadGrid");
		});
	}
	function reloadBillPlanRentList(){
		$("#billPLanRentList").trigger("reloadGrid");
	}
	function initDepositListList(){
		$("#depositList").jqGrid({
	    	url:'<%=basePath%>deposit!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'类型', name:'type.title', align:"center",width:30}, 
				{label:'金额', name:'amount',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center",width:30}, 
				{label:'状态', name:'status.title', align:"center",width:30}, 
				{label:'备注', name:'memo', align:"center"}
			],
			height: 172,
			width: 740,
			rowNum: 0,
			postData:{filters:generateSearchFilters("contractId","eq",$("#contractId").val(),"long")}
		});
	}
	function editDepositById(id){
		fbStart('编辑保证金',"<%=basePath%>deposit!edit.action?id="+id,500,222);
	}
	function deleteDepositById(id){
		if(confirm("确认删除该押金？")){
			$.post("<%=basePath%>deposit!delete.action?id="+id,function(){
				$("#depositList").trigger("reloadGrid");
			});
		}
	}
	function depositCheckinById(id){
		$.post("<%=basePath%>deposit!checkinById.action?id="+id,function(data){
			showTip(data.result.msg,2000);
			$("#depositList").trigger("reloadGrid");
		});
	}
	function depositCheckoutById(id){
		$.post("<%=basePath%>deposit!checkoutById.action?id="+id,function(data){
			showTip(data.result.msg,2000);
			$("#depositList").trigger("reloadGrid");
		});
	}
	function reloadDepositList(){
		$("#depositList").trigger("reloadGrid");
	}
</script>
	<div class="basediv tabswitch" style="margin-top:0px; display:block" id="textname" name="textname">
		<table id="subjectRentList"><tr><td></td></tr></table>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px; display:none" id="textname" name="textname">
		<table id="billPLanRentList"><tr><td></td></tr></table>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px;display:none" id="textname" name="textname">
		<table id="depositList"><tr><td></td></tr></table>
	</div>