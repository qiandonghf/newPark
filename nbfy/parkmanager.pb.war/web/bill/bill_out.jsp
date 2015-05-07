<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String customerName = "" ;
if (request.getParameter("customerName") != null) {
	 customerName = request.getParameter("customerName"); //查询的where条件
	customerName = new String(customerName.getBytes("iso-8859-1"),
			"UTF-8");
	request.setAttribute("customerName", customerName);
}
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css"/>


<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		$("#msglist").css("height",getTabContentHeight());
		initList();
	});
	
	function initList(){
		var path = null;
		var couId = $("#couId").val();
		if(couId  == null || couId == ''){
			path = '<%=basePath%>bill!loadBill.action?type=out' ;
		}else{
			path = "<%=basePath%>bill!outBill.action?customerId=${param.id}" ;
		}
		var height = 290;
		var width = 685;
		$("#list").jqGrid({
			url:path,
			colModel: [
				{label:'拆分', name:'billSplit', align:"center",hidden:true}, 
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'企业名称', name:'customer.name', align:"center"}, 
				{label:'费用类型', name:'billType.typeName', align:"center",width:60}, 
				{label:'计费开始时间', name:'feeStartTime', align:"center",width:80,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'计费结束时间', name:'feeEndTime', align:"center",width:80,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'金额', name:'factPayment',formatter:'number',width:60,formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"}, 
				{label:'出帐日期', name:'checkoutTime', align:"center",width:80,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
			    {label:'管理', name:'manager', align:"center", width:60 ,resizable:false,sortable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var split = $(this).getCell(id,'billSplit');
					var content = "";
					content += "<img src=\"core/common/images/xtopico2.png\" width=\"14\" height=\"14\" title=\"拆分\" onclick=\"apart('"+id+"');\"  /> "; 
					if(split!='1'){
					content += "<img src=\"core/common/images/Epre.gif\" width=\"14\" height=\"14\" title=\"退回\" onclick=\"backById('"+id+"');\"  /> "; 
					}
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager',{refresh: false, add: false, edit: false, del: false, search: false});
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function doSearch(){
		if(!$("#customerId").val()){
			showTip("请先选择一个企业");
			return;
		}
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function setSelectedRoom(room){
		$("#roomId").val(room.id);
		$("#roomName").val(room.name);
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
	function backById(id){
		$.post("<%=basePath%>bill!back.action?id="+id,function(data){
			showTip(data.result.msg,2000);
			if(data.result.success){
				$("#list").trigger("reloadGrid");
			}
		});
	}
	function apart(id){
		//var id = $("#list").jqGrid("getGridParam","selrow");
		if(id!=null){
			if($("#list").jqGrid("getGridParam","selarrrow").toString().indexOf(",")>-1){
				showTip("只能选择一条账单数据");
			} else {
				var row = $("#list").jqGrid('getRowData',id);
				fbStart('金额拆分','<%=basePath%>web/bill/bill_apart.jsp?id='+row.id+"&totalAmount="+row.factPayment,400,120);
			}
			
		} else {
			showTip("请选择要拆分的账单");
		}
	}
	function income(){
		if($("#list").jqGrid("getGridParam","selarrrow")!=""){
			fbStart('结算单','<%=basePath%>bill!confirm.action?ids='+$("#list").jqGrid("getGridParam","selarrrow").toString()+"&payTime="+$("#payTime").val(),730,400);
		} else {
			showTip("请选择账单");
		}
	}
	 function selectPaymentByID(){
	    	var ids = $("#list").jqGrid("getGridParam","selarrrow");
			var isIdsNull =($("#list").getDataIDs().length<=0);
			if(isIdsNull){
	    		showTip("请选企业");	
	    	} else{
	    		if (ids == '')return showTip("请选择退款记录"); ;
	    		fbStart('退款通知单',"<%=basePath%>bill!outInformListById.action?ids="+ids,800,600); 		
	    	}
		} 
	 function loadCustomerBycoustomerIds(){
			var coustomerIds = $("#customerId").val();
			$("#list").setGridParam({url:'<%=basePath%>bill!outBill.action?customerId='+coustomerIds}).trigger('reloadGrid');
		}
</script>
</head>

<body>
<search:choose dataType="com.wiiy.crm.preferences.enums.BillInOutEnum" field="inOut" op="eq">
<input type="hidden" class="data" value="OUT"/>
</search:choose>
<search:choose dataType="com.wiiy.crm.preferences.enums.BillStatusEnum" field="status" op="eq">
<input type="hidden" class="data" value="UNPAID"/>
</search:choose>
<div class="basediv">
	<div class="titlebg">查询</div>
	<div class="divlays" style="margin:0px;">
		<input id="couId" type="hidden" value="${param.id }"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">企业名称：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>	
								<search:choose dataType="long" field="customerId" op="eq">
								<input type="hidden" id="customerId" class="data" value="${param.id }"/>
								</search:choose>
								<search:choose dataType="string" field="customer.name" op="cn">
								<input onkeyup="$('#customerId').val('')" readonly="readonly" id="customerName" name="endTime" value="${customerName }" type="text" class="data inputauto" />
								</search:choose>
							</td>
							<td width="20" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择企业','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!select.action',520,400);" style=" cursor:pointer;"/></td>
						</tr>
					</table>
				</td>
				<td colspan="2" class="layerright"><input name="Submit3" type="submit" class="search_cx" value="" onclick="loadCustomerBycoustomerIds()"/></td>
			</tr>
		</table>
	</div>
	<div class="hackbox"></div>
</div>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<div class="emailtop">
		<div class="leftemail">
			<ul>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="selectPaymentByID()"><span><img src="core/common/images/bill_04.gif" /></span>退款通知单</li>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('添加账单','<%=basePath%>web/bill/bill_add.jsp',500,370);"><span><img src="core/common/images/billadd.gif" /></span>补收</li>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="reloadList()"><span><img src="core/common/images/refresh2.gif"></span>刷新</li>
			</ul>
		</div>
		</div>
		<div class="pm_msglist" style="border-top:0px; margin:0px;">
			<table id="list"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:1px;background:#f2f2f2">
				<tr>
					<td class="layertdleft100">退款时间：</td>
					<td width="200" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input readonly="readonly" value="<%=DateUtil.format(new Date()) %>" type="text" class="inputauto" id="payTime" onclick="showCalendar('payTime')"/></td>
								<td width="25" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('payTime')"/></td>
							</tr>
						</table>
					</td>
					<td align="right">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<div class="buttondiv">
	<a href="javascript:void(0)" title="" class="btn_bg" onclick="income()"><span><img src="core/common/images/bill_01.gif" />退款</span></a>
	<a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end();"><span><img src="core/common/images/closebtnicon.gif" />取消</span></a>
</div>
</body>
</html>
