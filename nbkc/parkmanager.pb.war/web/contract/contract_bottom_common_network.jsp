<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String action = request.getParameter("action");
%>
<script type="text/javascript">
	function initSubjectList(){
		$("#subjectNetworkList").jqGrid({
	    	url:'<%=basePath%>subjectNetwork!list.action?id='+$("#contractId").val(),
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'宽带', name:'facility.name', align:"center"}, 
				{label:'IP段', name:'ip', align:"center",width:40}, 
				{label:'接入端口数', name:'port', align:"center",width:40}, 
				{label:'公网IP数', name:'publicIP', align:"center",width:40}, 
			    {label:'开始时间', name:'startDate', align:"center",width:40,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
			    {label:'结束时间', name:'endDate', align:"center",width:40, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'管理', name:'manager', align:"center",width:35, resizable:false,sortable:false}
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
					//content += "<img src=\"core/common/images/profile.gif\" width=\"14\" height=\"14\" title=\"自动生成资金计划\" onclick=\"generateBillPlanRentById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editSubjectNetworkById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteSubjectNetworkById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function editSubjectNetworkById(id){
		fbStart('编辑标的',"<%=basePath%>subjectNetwork!edit.action?id="+id,500,284);
	}
	function deleteSubjectNetworkById(id){
		if(confirm("确认删除该标的？")){
			$.post("<%=basePath%>subjectNetwork!delete.action?id="+id,function(){
				$("#subjectNetworkList").trigger("reloadGrid");
			});
		}
	}
	function reloadSubjectNetworkList(){
		$("#subjectNetworkList").trigger("reloadGrid");
	}
	function initBillPlanList(){
		$("#billPlanFacilityList").jqGrid({
	    	url:'<%=basePath%>billPlanFacility!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'宽带', name:'facility.name', align:"center"}, 
				{label:'计费开始时间', name:'startDate', align:"center",width:60,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'计费结束时间', name:'endDate', align:"center",width:60,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'计划金额', name:'planFee',formatter:'number',width:40,formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"}, 
				{label:'实际金额', name:'realFee',formatter:'number',width:40,formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"}, 
				{label:'计划付费时间', name:'planPayDate', align:"center",width:60, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'状态', name:'status.title', align:"center",width:40}, 
			    {label:'管理', name:'manager', align:"center", resizable:false,width:70,sortable:false}
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
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewBillPlanFacilityById('"+id+"');\"  /> "; 
					if($(this).getCell(id,9)=='未出账'){
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editBillPlanFacilityById('"+id+"');\"  /> "; 
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteBillPlanFacilityById('"+id+"');\"  /> ";
						content += "<img src=\"core/common/images/rece2.gif\" width=\"14\" height=\"14\" title=\"收款出账\" onclick=\"billPlanFacilityCheckinById('"+id+"');\"  /> "; 
						content += "<img src=\"core/common/images/pay2.gif\" width=\"14\" height=\"14\" title=\"退款出账\" onclick=\"billPlanFacilityCheckoutById('"+id+"');\"  /> "; 
					}
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewBillPlanFacilityById(id){
		fbStart('资金计划',"<%=basePath%>billPlanFacility!view.action?id="+id,500,284);
	}
	function editBillPlanFacilityById(id){
		fbStart('编辑资金计划',"<%=basePath%>billPlanFacility!editNetworkPlan.action?id="+id,500,315);
	}
	function deleteBillPlanFacilityById(id){
		if(confirm("确认删除该资金计划？")){
			$.post("<%=basePath%>billPlanFacility!delete.action?id="+id,function(){
				$("#billPlanFacilityList").trigger("reloadGrid");
			});
		}
	}
	function billPlanFacilityCheckinById(id){
		if(confirm("确认收款出账?")){
			$.post("<%=basePath%>billPlanFacility!checkinById.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				$("#billPlanFacilityList").trigger("reloadGrid");
			});
		}
	}
	function billPlanFacilityCheckoutById(id){
		if(confirm("确认退款出账?")){
			$.post("<%=basePath%>billPlanFacility!checkoutById.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				$("#billPlanFacilityList").trigger("reloadGrid");
			});
		}
	}
	function reloadBillPlanFacilityList(){
		$("#billPlanFacilityList").trigger("reloadGrid");
	}
</script>
	<div class="basediv tabswitch" style="margin-top:0px; display:block" id="textname" name="textname">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建租赁标的','<%=basePath %>subjectNetwork!add.action?id='+$('#contractId').val()+'&startDate='+$('#startDate').val()+'&endDate='+$('#endDate').val(),500,284);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				</ul>
			</div>
		</div>
		<table id="subjectNetworkList"><tr><td></td></tr></table>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px; display:none" id="textname" name="textname">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建资金计划','<%=basePath %>billPlanFacility!addNetworkPlan.action?id='+$('#contractId').val()+'&&customerId='+$('#customerId').val()+'&startDate='+$('#startDate').val()+'&endDate='+$('#endDate').val(),500,284);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				</ul>
			</div>
		</div>
		<table id="billPlanFacilityList"><tr><td></td></tr></table>
	</div>
	