<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/easyslider1.7/css/slider.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>web/style/ps.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/easyslider1.7/js/easySlider1.7.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initSlider();
		initOrder();
		initFee();
		jqGridResizeRegister("orderList","feeList");
	});
	function initSlider(){
		$(".slider").easySlider({
			auto: true,
			continuous: true,
			speed: 800			
		});
	}
	function initOrder(){		
		var height = getTabContentHeight()-78;
		var width = window.parent.document.documentElement.clientWidth-190;
		$("#orderList").jqGrid({
	    	url:'<%=basePath%>facilityOrder!list.action',
			colModel: [
				{label:'企业', name:'customer.name', align:"center"}, 
				{label:'使用开始时间', name:'startTime', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
			    {label:'使用结束时间', name:'endTime', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
			    {label:'状态', name:'status.title', align:"center"},
			    {label:'管理', name:'manager', align:"center", resizable:false}
			],
			height: height,
			width: width,
			pager: "#orderPage",
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewOrderById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editOrderById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteOrderById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			},
			postData:{filters:generateSearchFilters("facilityId","eq",'${result.value.id}',"long")},
			postData:{filters:generateSearchFilters("customerId","eq",'${customerId}',"long")}
		}).navGrid('#orderPage',{add: false, edit: false, del: false, search: false});
	}
	function initFee(){		
		var height = window.parent.document.documentElement.clientHeight-113;
		var width = window.parent.document.documentElement.clientWidth-190;
		$("#feeList").jqGrid({
	    	url:'<%=basePath%>facilityOrderFee!list.action',
			colModel: [
				{label:'企业', name:'customer.name', align:"center"}, 
				{label:'金额', name:'amount', align:"center"}, 
				{label:'计划付费时间', name:'planPayTime', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
			    {label:'出账时间', name:'checkoutTime', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
			    {label:'是否已出账', name:'bcheckout.title', align:"center"},
			    {label:'是否自动出账', name:'bauto.title', align:"center"},
			    {label:'管理', name:'manager', align:"center", resizable:false}
			],
			height: height,
			width: width,
			pager: "#feePage",
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewOrderById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editOrderById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteOrderById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			},
			postData:{filters:generateSearchFilters("facilityId","eq",'${result.value.id}',"long")}
		}).navGrid('#feePage',{add: false, edit: false, del: false, search: false});
	}
	function deleteOrderById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>facilityOrder!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#orderList").trigger("reloadGrid");
	        	}
			});
		}
	}
	function deleteOrders(){
		var ids = $("#orderList").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>facilityOrder!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#orderList").trigger("reloadGrid");
	        	}
			});
		}
	}
	function reloadOrderList(){
		$("#orderList").trigger("reloadGrid");
	}
	function viewOrderById(id){
		fbStart('查看使用申请','<%=basePath %>facilityOrder!view.action?id='+id,500,268);
	}
	function editOrderById(id){
		fbStart('编辑使用申请','<%=basePath %>facilityOrder!edit.action?id='+id,500,268);
	}
</script>
</head>

<body>
<!--basediv-->
<div class="basediv">
<div class="divlays">
<!--基本信息-->
<div class="pm_msglist" style="margin-top:0px; display:block" id="textname" name="textname">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">设施名称：</td>
      <td class="layerright">${result.value.name}</td>
      <td class="layertdleft100">所在楼宇：</td>
      <td class="layerright">${result.value.building.park.name}-${result.value.building.name}</td>
    </tr>
    <tr>
      <td class="layertdleft100">资源类型：</td>
      <td class="layerright">${result.value.type.title}</td>
      <td class="layertdleft100">结算方式：</td>
      <td class="layerright">${result.value.checkType.title}</td>
    </tr>
    <tr>
      <td class="layertdleft100">状态：</td>
      <td class="layerright">${result.value.status.title}</td>
      <td class="layertdleft100">是否收费：</td>
      <td class="layerright">${result.value.bcharge.title}</td>
    </tr>
    <tr>
      <td class="layertdleft100">单价：</td>
      <td class="layerright">${result.value.price}</td>
      <td class="layertdleft100">独享资源：</td>
      <td class="layerright">${result.value.bshare.title}</td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr>
      <td class="layertdleft100">介绍：</td>
      <td class="layerright"><div style="height:30px;overflow-y:auto; overflow-x:hidden;word-break:break-all; word-wrap:break-word; ">${result.value.summary}</div></td>
    </tr>
  </table>
  </div>
</div>
<!--//基本信息-->
<c:if test="${result.value.bshare eq 'YES'}">
	<iframe scrolling="auto" src="<%=basePath %>facility!facilityWeekInfo.action?id=${result.value.id}" id="facilityWeekInfo" name="facilityWeekInfo" frameborder="0" height="250" width="100%"></iframe>
</c:if>
</div>
</div>
<!--basediv-->
</body>
</html>
