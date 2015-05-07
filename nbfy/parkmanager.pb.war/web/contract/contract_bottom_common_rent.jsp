<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				{label:'房间ID', name:'roomId', align:"center",hidden:true}, 
				{label:'租用地址', name:'roomName', align:"center"}, 
				{label:'租用面积', name:'roomArea',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0},align:"center",width:40}, 
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
				var roomIds = new Array();
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var roomId = $(this).getCell(id,"roomId");
					roomIds.push(roomId);
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_subjectRent_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewSubjectRentById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_subjectRent_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editSubjectRentById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_subjectRent_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteSubjectRentById('"+id+"');\"  /> ";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
				$("#roomIds").val(roomIds);
			}
		});
	}
	function editSubjectRentById(id){
		fbStart('编辑标的',"<%=basePath%>subjectRent!edit.action?id="+id+"&saveFlag="+$("#saveFlag").val(),500,284);
	}
	function viewSubjectRentById(id){
		fbStart('查看标的',"<%=basePath%>subjectRent!view.action?id="+id+"&saveFlag="+$("#saveFlag").val(),500,284);
	}
	function deleteSubjectRentById(id){
		if(confirm("确认删除该标的？")){
			$.post("<%=basePath%>subjectRent!delete.action?id="+id+"&saveFlag="+$("#saveFlag").val(),function(data){
				showTip(data.result.msg,2000);
				$("#subjectRentList").trigger("reloadGrid");
			});
		}
	}
	function generateBillPlanRentById(id){
		if($("#contractId").val()==''){
			showTip("请先保存合同");
			return;
		}
		fbStart('自动生成资金计划','<%=basePath%>subjectRent!generatePlan.action?id='+id,500,307);
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
				{label:'状态', name:'status.title', align:"center",width:30}, 
			    {label:'管理', name:'manager', align:"center", resizable:false,width:36,sortable:false}
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
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewBillPlanRentById('"+id+"');\"  /> "; 
					<%}%>
					if($(this).getCell(id,9)=='未出账'){
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_edit")){%>	
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editBillPlanRentById('"+id+"');\"  /> "; 
						<%}%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_delete")){%>
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteBillPlanRentById('"+id+"');\"  /> ";
						<%}%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_checkin")){%>
						content += "<img src=\"core/common/images/rece2.gif\" width=\"14\" height=\"14\" title=\"收款出账\" onclick=\"billPlanRentCheckinById('"+id+"');\"  /> "; 
						<%}%>
					}
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
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
		if(confirm("确认收款出账?")){
			$.post("<%=basePath%>billPlanRent!checkinById.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				$("#billPLanRentList").trigger("reloadGrid");
			});
		}
	}
	function billPlanRentCheckoutById(id){
		if(confirm("确认退款出账?")){
			$.post("<%=basePath%>billPlanRent!checkoutById.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				$("#billPLanRentList").trigger("reloadGrid");
			});
		}
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
				{label:'备注', name:'memo', align:"center"}, 
			    {label:'管理', name:'manager', align:"center", resizable:false,width:35,sortable:false}
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
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deposit_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewDepositById('"+id+"');\"  /> ";
					<%}%>
					if($(this).getCell(id,5)=='未出账'){
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deposit_edit")){%>
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editDepositById('"+id+"');\"  /> "; 
						<%}%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deposit_delete")){%>
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteDepositById('"+id+"');\"  /> ";
						<%}%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deposit_checkin")){%>
						content += "<img src=\"core/common/images/rece2.gif\" width=\"14\" height=\"14\" title=\"收款出账\" onclick=\"depositCheckinById('"+id+"');\"  /> ";
						<%}%>
					} 
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deposit_checkout")){%>
						if($(this).getCell(id,5)=='收款出账'){
							content += "<img src=\"core/common/images/pay2.gif\" width=\"14\" height=\"14\" title=\"退款出账\" onclick=\"depositCheckoutById('"+id+"');\"  /> ";
						}
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewDepositById(id){
		fbStart('查看保证金',"<%=basePath%>deposit!view.action?id="+id,500,222);
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
		if(confirm("确认收款出账?")){
			$.post("<%=basePath%>deposit!checkinById.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				$("#depositList").trigger("reloadGrid");
			});
		}
	}
	function depositCheckoutById(id){
		if(confirm("确认退款出账?")){
			$.post("<%=basePath%>deposit!checkoutById.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				$("#depositList").trigger("reloadGrid");
			});
		}
	}
	function reloadDepositList(){
		$("#depositList").trigger("reloadGrid");
	}
</script>
<%int flag2=-1;
if(PbActivator.getHttpSessionService().isInResourceMap("pb_subjectRent_list")){flag2++;
%>
	<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname" name="textname">
	<input type="hidden" id="roomIds"/>
		<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_subjectRent_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建租赁房间','<%=basePath %>web/contract/subjectRent_add.jsp?saveFlag='+$('#saveFlag').val()+'&contractId='+$('#contractId').val()+'&startDate='+$('#startDate').val()+'&endDate='+$('#endDate').val(),500,284);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				<%} %>
				</ul>
			</div>
		</div>
		<table id="subjectRentList"><tr><td></td></tr></table>
	</div>
<%} %>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_list")){flag2++;%>
	<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname" name="textname">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建资金计划','<%=basePath %>billPlanRent!add.action?id='+$('#contractId').val()+'&roomIds='+$('#roomIds').val()+'&startDate='+$('#startDate').val()+'&endDate='+$('#endDate').val(),500,284);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				<%} %>
				</ul>
			</div>
		</div>
		<table id="billPLanRentList"><tr><td></td></tr></table>
	</div>
<%} %>
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deposit_list")){flag2++;%>
	<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname" name="textname">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deposit_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建保证金','<%=basePath %>deposit!add.action?id='+$('#contractId').val(),500,222);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				<%} %>
					<li style="display:none" onmouseover="this.className='libg'" onmouseout="this.className=''" ><span><img src="core/common/images/print_16x16.gif" /></span>收据打印</li>
				</ul>
			</div>
		</div>
		<table id="depositList"><tr><td></td></tr></table>
	</div>
<%}%>