<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>

<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(function() {
		initTip();
		$("#resizable").css("height",getTabContentHeight()-35);
		$("#msglist").css("height",getTabContentHeight()-35);
		$('#msglist').height($(window).height()-84).width($(window).width()-$('#resizable').width()-5);
		$("#resizable").resizable({
			resize : function() {
				$('#msglist').width($(window).width() - $('#resizable').width() - 5);
				$("#list").setGridWidth($("#resizable").width());
				$("#list2").setGridWidth($("#pm_scrolldiv").width());
			},
			minWidth : 500,
			maxWidth : 800
		});
		initList();
		initList2();
	});
	function initList(){
		var height = $("#resizable").height()-70;
		var width = $("#resizable").width();
		$("#list").jqGrid({
			url:'<%=basePath%>billPlanRent!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'企业名称', name:'contract.customerName', align:"center"}, 
				{label:'费用类型', name:'feeType.title', align:"center",width:60}, 
				{label:'开始时间', name:'startDate', align:"center",width:70,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'结束时间', name:'endDate', align:"center",width:70,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'金额', name:'planFee',formatter:'number',width:60,formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"}, 
			    {label:'管理', name:'manager', align:"center", width:60 ,resizable:false,sortable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			postData:{filters:getSearchFilters()},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_checkin")){%>
					content += "<img src=\"core/common/images/rece2.gif\" width=\"14\" height=\"14\" title=\"收款出账\" onclick=\"checkinById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_billPlanRent_checkout")){%>
					content += "<img src=\"core/common/images/pay2.gif\" width=\"14\" height=\"14\" title=\"退款出账\" onclick=\"checkoutById('"+id+"');\"  /> ";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager',{refresh: false, add: false, edit: false, del: false, search: false});
	}
	function viewById(id){
		fbStart('查看',"<%=basePath%>billPlanRent!view.action?id="+id,500,284);
	}
	function checkinById(id){
		var row = $("#list").jqGrid('getRowData',id);
		row.checkout = "收";
		if($("#list2").jqGrid('addRowData',row.id,row)){
			$("#list").jqGrid('delRowData',id);
			document.getElementById(id).style.backgroundColor="#EFFFDA";
			$('#selectIds').val($("#list2").jqGrid('getDataIDs'));
		}
	}
	function checkoutById(id){
		var row = $("#list").jqGrid('getRowData',id);
		row.checkout = "支";
		if($("#list2").jqGrid('addRowData',row.id,row)){
			$("#list").jqGrid('delRowData',id);
			document.getElementById(id).style.backgroundColor="#FFF0F0";
			$('#selectIds').val($("#list2").jqGrid('getDataIDs'));
		}
	}
	function initList2(){
		var height = $("#resizable").height()-70;
		var width = $("#pm_scrolldiv").width();
		$("#list2").jqGrid({
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'企业名称', name:'contract.customerName', align:"center"}, 
				{label:'费用类型', name:'feeType.title', align:"center",width:60}, 
				{label:'出账类型', name:'checkout', align:"center",width:60}, 
				{label:'开始时间', name:'startDate', align:"center",width:70, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'结束时间', name:'endDate', align:"center",width:70, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'金额', name:'planFee',formatter:'number',width:60}, 
			    {label:'管理', name:'manager', align:"center", width:30 ,resizable:false,sortable:false}
			],
			pager:"",
			height: height,
			width: width,
			datatype: "local",//默认json数据类型
			multiselect: false,//可以多选
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"取消\" onclick=\"deleteById('"+id+"');\"  /> "; 
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function deleteById(id){
		var row = $("#list2").jqGrid('getRowData',id);
		if($("#list").jqGrid('addRowData',row.id,row)){
			$("#list2").jqGrid('delRowData',id);
			$('#selectIds').val($("#list2").jqGrid('getDataIDs'));
		}
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function checkout(){
		var ids = $("#list2").jqGrid('getDataIDs');
		if(ids==null || ids.length==0) return;
		var types = new Array();
		for(var i = 0 ; i < ids.length; i++){
			var id = ids[i];
			var row = $("#list2").jqGrid('getRowData',id);
			if(row.checkout=="收"){
				types[i] = "in";
			} else {
				types[i] = "out";
			}
		}
		var url = "<%=basePath%>billPlanRent!batchCheckout.action";
		$.post(url,{"ids":ids.toString(),"types":types.toString(),"autoRemind":$("#autoRemind").attr("checked")},function(data){
			showTip(data.result.msg,2000);
			if(data.result.success){
				$("#list2").jqGrid("clearGridData");
			}
		});
	}
</script>
</head>

<body>
	<search:choose dataType="long" field="id" op="ni">
	<input type="hidden" id="selectIds" class="data"/>
	</search:choose>
	<search:choose dataType="com.wiiy.crm.preferences.enums.BillPlanStatusEnum" field="status" op="eq">
	<input type="hidden" class="data" value="UNCHECK"/>
	</search:choose>
	<div class="emailtop">
		<div class="leftemail">
			<ul>
			<c:choose>
				<c:when test="${askedFromDesktop eq 'yes'}">
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" class="" onclick="javascript:window.location.href='bill!checkout.action'"><span><img src="core/common/images/back.png"></span>返回</li>
				</c:when>
				<c:otherwise>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" class="" onclick="history.back(-1);"><span><img src="core/common/images/back.png"></span>返回</li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</div>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="522" valign="top">
					<div class="agency" id="resizable" style="width:580px;">
						<div class="searchdivkf">
							<form id="form2" name="form2" method="post" action="">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
									<tbody>
										<tr>
											<td width="99" class="righttd">出帐日期截止至：</td>
											<td width="90">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<search:choose dataType="java.util.Date" field="planPayDate" op="le">
																<input id="planPayDate" value="${date}" name="planPayDate" type="text" class="data inputauto" onclick="showCalendar('planPayDate');"/>
															</search:choose>
														</td>
														<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('planPayDate');"/></td>
													</tr>
												</table>
											</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<search:choose dataType="long" field="contract.customerId" op="eq">
															<input type="hidden" id="customerId" class="data"/>
															</search:choose>
															<search:choose dataType="string" field="contract.customerName" op="cn">
															<input onkeyup="$('#customerId').val('')" id="customerName" name="endTime" type="text" class="data inputauto"/>
															</search:choose>
														</td>
														<td width="20"><img style="cursor:pointer;" src="core/common/images/outdiv.gif" width="20" height="22"  onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);"/></td>
													</tr>
												</table>
											</td>
											<td width="90" style="padding-left: 3px;padding-right: 3px;">
												<search:choose dataType="com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum" field="feeType" op="eq">
												<enum:select type="com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum" styleClass="data"/>
												</search:choose>
											</td>
											<td width="90"><label><img src="core/common/images/search.gif" width="75" height="22" border="0" onclick="doSearch()"></label></td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
						<div class="pm_msglist" style="border:none; margin:0;">
							<table id="list"><tr><td></td></tr></table>
							<div id="pager"></div>
						</div>
					</div>
				</td>
				<td width="100%" valign="top">
					<div class="pm_msglist" id="msglist" style="border:none; margin:0;">
						<div class="titlebg">出帐记录:</div>
						<div id="textname" name="textname">
							<table id="list2"><tr><td></td></tr></table>
							<div class="page" style=" border-top:none; border-bottom:none;">
								<div class="floatrightdiv" style="width:auto; float:right;">
									<input type="checkbox" id="autoRemind" checked="checked" name="set"/>&nbsp;
									<label for="autoRemind" title="发送短信给帐单企业">自动催缴</label>
								</div>
								<label style="float:left; padding-left:10px; margin-top:4px;"><input name="Submit4" type="button" class="czbtn2" value="" onclick="checkout();" /></label>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- <map name="Map" id="Map">
		<area shape="rect" coords="1,2,50,21" href="javascript:void(0)" onclick="doSearch()"/>
		<area shape="rect" coords="54,0,73,19" href="javascript:void(0)" onclick="doSearch()" />
	</map> -->
</body>
</html>
