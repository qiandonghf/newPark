<%@page import="com.wiiy.pb.activator.PbActivator"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>web/style/ps.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/easyslider1.7/css/slider.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/easyslider1.7/js/easySlider1.7.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initSlider();
		initOrder();
		jqGridResizeRegister("orderList","feeList");
		var h=window.document.documentElement.clientHeight;
		var h2 = h-$("#detilView").height()-$("#memoView").height()-65;
		$("#facilityWeekInfo").css({height:h2});
	});
	function initSlider(){
		$(".slider").easySlider({
			auto: true,
			continuous: true,
			speed: 800			
		});
	}
	function initOrder(){		
		var height = getTabContentHeight()-138;
		var width = window.parent.document.documentElement.clientWidth-190;
		$("#orderList").jqGrid({
	    	url:'<%=basePath%>facilityOrder!list.action?facilityId=${result.value.id}',
			colModel: [
				{label:'设施名称', name:'facility.name',width:150, align:"center"}, 
				{label:'企业名称', name:'customer.name', align:"center",width:180}, 
				{label:'开始时间',width:140, name:'startTime', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
			    {label:'结束时间',width:140, name:'endTime', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
			    {label:'合同', width:50,name:'contractId', align:"center",formatter:contractLog},
			    {label:'管理',width:100, name:'manager', align:"center", resizable:false}
			],
			shrinkToFit: false,	
			height: height,
			width: width,
			pager: "#orderPage",
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"parkmanager.pb/web/images/rmb.png\" width=\"14\" height=\"14\" title=\"费用清单\" onclick=\"viewCostById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewOrderById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editOrderById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteOrderById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			},
			postData:{filters:generateSearchFilters("facilityId","eq",'${result.value.id}',"long")}
		}).navGrid('#orderPage',{add: false, edit: false, del: false, search: false});
	}
	
	function contractLog(cellvalue,options,rowObject){
		var id = rowObject["contractId"];
		var cellvalue = "";
		if(id!=null){
			cellvalue += "<img src=\"parkmanager.pb/web/images/page_find.gif\" width=\"14\" height=\"14\" title=\"查看合同\" onclick=\"viewContract('"+id+"');\"  /> ";
		}
		return cellvalue;
	}
	
	function viewContract(id){
		fbStart('查看合同','<%=basePath %>contract!view.action?id='+id,750,467);
	}
	
	function viewCostById(id){
		fbStart('费用清单','<%=basePath %>billPlanFacility!listByFacilityOrderId.action?facilityOrderId='+id,720,370);
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
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" valign="top">
				<div class="titlebg">设施信息</div>
				<div class="apptab" id="tableid">
					<ul>
					<%int flag=-1;
					if(PbActivator.getHttpSessionService().isInResourceMap("pb_facility_basicView")){flag++;%>
						<li class="apptabli<%if(flag==0) {%>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">基本信息</li>
					<%} %>
					<% if(PbActivator.getHttpSessionService().isInResourceMap("pb_facility_useView")){flag++;%>
						<li class="apptabli<%if(flag==0) {%>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">使用情况</li>
					<%} %>
					</ul>
				</div>
				<%int flag2=-1;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_facility_basicView")){flag2++;%>
				<div class="pm_msglist tabswitch" style="<%if(flag2!=0){%>display:none;<%}%>"id="textname" name="textname">
				<c:if test="${result.value.bshare eq 'YES'}">
					<div class="emailtop">
						<div class="leftemail">
							<ul>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('查看${result.value.name}使用情况','<%=basePath %>facility!facilityWeekInfo.action?id=${result.value.id}',780,300);"><span><img src="core/common/images/view.png" width="14" height="15" /></span>使用申请</li>
							</ul>
						</div>
					</div>
				</c:if>
					<div class="divlays">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" id="detilView">
							<tr>
								<td valign="top">
									<table  border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class="layertdleft100">设施名称：</td>
											<td class="layerright" width="200" align="left">${result.value.name}</td>
											<td class="layertdleft100">资源类型：</td>
											<td class="layerright" width="100" align="left">${result.value.type.title}</td>
										</tr>
										<tr>
											<td class="layertdleft100">状态：</td>
											<td class="layerright" width="200" align="left">${result.value.status.title}</td>
											<td class="layertdleft100">单价：</td>
											<td class="layerright" width="100" align="left">${result.value.price}&nbsp;元</td>
										</tr>
										<tr>
											<td class="layertdleft100">
												<c:if test="${result.value.building.name!=null}">
													所在楼宇：
												</c:if>
												<c:if test="${result.value.building.name==null}">
													所在园区：
												</c:if>
											</td>
											<td class="layerright" width="100" align="left">
												<c:if test="${result.value.building.name!=null}">${result.value.building.park.name}-${result.value.building.name}</c:if>
												<c:if test="${result.value.building.name==null}">${result.value.parkName}</c:if>
											</td>
											<td class="layertdleft100">结算方式：</td>
											<td class="layerright" width="100" align="left">${result.value.checkType.title}</td>
										</tr>
										<tr>
											<td class="layertdleft100">是否收费：</td>
											<td class="layerright" width="100" align="left">${result.value.bcharge.title}</td>
											<td class="layertdleft100">独享资源：</td>
											<td class="layerright" width="100" align="left">${result.value.bshare.title}</td>
										</tr>
									</table>          
								</td>
								<td align="left" valign="top">
									<c:if test="${result.value.photos ne ''}">
									<div class="slidercontainer">
										<div class="slider">
											<ul>				
												<c:forTokens items="${result.value.photos}" delims="," var="photo">
													<li><img src="core/resources/${photo}" width="260" height="190" /></li>
												</c:forTokens>
											</ul>
										</div>
									</div>
									</c:if>
								</td>
							</tr>
							
								
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" id="memoView">
							<tr>
								<td class="layertdleft100">介绍：</td>
								<td class="layerright"> <div style=" vertical-align:middle;height:50px; overflow-x:hidden; overflow-y:auto;word-break:break-all; word-wrap:break-word;">
	       							${result.value.summary}
	       						</div></td>
							</tr>
						</table>
						
					</div>
				</div>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_facility_useView")){flag2++; %>
				<div class="pm_msglist tabswitch" style="<%if(flag2!=0){%>display:none;<%}%>">
					<div class="emailtop">
						<div class="leftemail">
							<ul>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('公共设施使用申请','<%=basePath %>facilityOrder!add.action?facilityId=${result.value.id}',500,268);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteOrders()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
							</ul>
						</div>
					</div>
					<table id="orderList"><tr><td></td></tr></table>
					<div id="orderPage"></div>
				</div>
				<div class="pm_msglist tabswitch" style="<%if(flag2!=0){%>display:none;<%}%>">
					<table id="feeList"><tr><td></td></tr></table>
					<div id="feePage"></div>
				</div>
				<%} %>
			</td>
		</tr>
	</table>
</div>
</body>
</html>