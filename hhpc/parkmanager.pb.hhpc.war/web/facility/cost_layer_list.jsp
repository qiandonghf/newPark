<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function() {
	initTip();
	//initList();
});

function initList(){
	var h = window.document.documentElement.clientHeight-100;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-334;
	
	$("#list").jqGrid({
    	url:'<%=basePath%>billPlanFacility!listByFacilityOrderId.action?facilityOrderId=<%=request.getParameter("facilityOrderId")%>',
		colModel: [
			{label:'', width:15,name:'',align:"center",formatter:autoCheck}, 
			{label:'类型', width:70,name:'',align:"center",formatter:feeType}, 
			{label:'实际金额',width:70,name:'realFee',align:"center",formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}}, 
			{label:'计费开始时间',width:80,name:'startDate',align:"center",hidden:true}, 
			{label:'计费结束时间',width:80,name:'endDate',align:"center",hidden:true}, 
			{label:'时间段',width:150,name:'time',align:"center",formatter:time}, 
			{label:'状态',width:50,name:'status.title',align:"center",hidden:true}, 
			{label:'公共设施',width:80,name:'facility',align:"center",hidden:true}, 
			{label:'出账时间',width:80,name:'intoAccountDate',align:"center",hidden:true}, 
			{label:'计划付费',width:80, name:'planPayDate',align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
			{label:'已付金额',width:80, name:'paidFee',align:"center",formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}},
			{label:'最后付费', width:80,name:'lastPayDate',align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
		    {label:'操作',width:80, name:'manager', align:"center", sortable:false, resizable:false}
		],
		height:h,
		width:width,
		shrinkToFit: false,	
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
				if($(this).getCell(id,8)=='未出账'){
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					content += "<img src=\"core/common/images/rece2.gif\" width=\"14\" height=\"14\" title=\"收款出账\" onclick=\"billPlanFacilityCheckinById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/pay2.gif\" width=\"14\" height=\"14\" title=\"退款出账\" onclick=\"billPlanFacilityCheckoutById('"+id+"');\"  /> "; 
				}
				$(this).jqGrid('setRowData',id,{manager:content});
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
function time(cellvalue,options,rowObject){
    var startTime = rowObject["startDate"];
	var endTime = rowObject["endDate"];
	startTime = startTime.substring(0, 10);
	endTime = endTime.substring(0, 10);
	var cellvalue = startTime+" - "+endTime; 
	return cellvalue;
}
function autoCheck(cellvalue,options,rowObject){
    var status = rowObject["status"];
	if(status.title!="未出账" && status.title!="已核销"){
		cellvalue = "<img src=\"core/common/images/rightgreen.png\" title=\"已出账\"/> ";
	}else{
		cellvalue = "";
	}
	return cellvalue;
}

function feeType(cellvalue,options,rowObject){
    var facility = rowObject["facility"];
	var cellvalue = facility.type.title+"费"; 
	return cellvalue;
}

function viewById(id){
	fbStart('查看','<%=basePath%>billPlanFacility!view.action?id='+id,500,370);
}	

function editById(id){
	fbStart('编辑','<%=basePath%>billPlanFacility!edit.action?id='+id,500,370);
}
function billPlanFacilityCheckinById(id){
	$.post("<%=basePath%>billPlanFacility!checkinById.action?id="+id,function(data){
		showTip(data.result.msg,2000);
		reloadList();
	});
}
function billPlanFacilityCheckoutById(id){
	$.post("<%=basePath%>billPlanFacility!checkoutById.action?id="+id,function(data){
		showTip(data.result.msg,2000);
		reloadList();
	});
}

function reloadList(){
	location.reload();
}

function deleteById(id){
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>billPlanFacility!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		reloadList();
        	}
		});
	}
}

function deleteSelected(){
	if(confirm("确定要删吗")){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		$.post("<%=basePath%>billPlanFacility!delete.action?ids="+ids,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		reloadList();
        	}
		});
	}
}
function jumpPage(page){
	var url = '<%=basePath%>billPlanFacility!listByFacilityOrderId.action';
	url += "?page="+page+"&facilityOrderId="+$('#facilityOrderId').val();
	url = encodeURI(url);
	location.href=url;
}
  </script>
</head>

<body>
<div class="basediv" style="height: 300px;">
<input type="hidden" id="id"/>
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建费用清单','<%=basePath %>billPlanFacility!addByFacilityId.action?facilityOrderId=${facilityOrderId}',500,320);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
		</ul>
	</div>
</div>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td width="35" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">序号</td>
               <td width="25" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'"></td>
               <td width="80" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">类型</td>
               <td width="80" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">实际金额</td>
               <td width="150" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">时间段</td>
               <td width="80" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">已付金额</td>
               <td width="80" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">最后付费</td>
               <td width="90" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">操作</td>
             </tr>
             <c:forEach items="${list}" var="list" varStatus="status">
             <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
               <td class="centertd">${status.index+1}</td>
               <td class="centertd">
           			<c:if test="${list.status eq 'INCHECKED' or list.status eq 'OUTCHECKED'}">
           				<img src="core/common/images/rightgreen.png" title="已出账"/>
           			</c:if>
           			<input type="hidden" id="facilityOrderId" value="${list.facilityOrderId}"/>
               </td>
               <td class="centertd">${list.facility.type.title}费</td>
               <td class="centertd"><fmt:formatNumber value="${list.realFee}" pattern="#0.00"/></td>
               <td class="centertd"><fmt:formatDate value="${list.startDate}" pattern="yyyy-MM-dd"/>--<fmt:formatDate value="${list.endDate}" pattern="yyyy-MM-dd"/></td>
               <td class="centertd"><fmt:formatNumber value="${list.paidFee}" pattern="#0.00"/></td>
               <td class="centertd"><fmt:formatDate value="${list.lastPayDate}" pattern="yyyy-MM-dd"/></td>
               <td class="centertd">
               		<a href="javascript:void(0)" title="查看"><img src="core/common/images/viewbtn.gif" onclick="viewById(${list.id})"/></a>
               		<c:if test="${list.status eq 'UNCHECK'}">
               		<a href="javascript:void(0)" title="编辑"><img src="core/common/images/edit.gif" onclick="editById(${list.id})"/></a>
               		<a href="javascript:void(0)" title="删除"><img src="core/common/images/del.gif" onclick="deleteById(${list.id})"/></a>
               		<a href="javascript:void(0)" title="收款出账"><img src="core/common/images/rece2.gif" onclick="billPlanFacilityCheckinById(${list.id})"/></a>
               		<a href="javascript:void(0)" title="退款出账"><img src="core/common/images/pay2.gif" onclick="billPlanFacilityCheckoutById(${list.id})"/></a>
               		</c:if>
               </td>
              
             </tr>
             </c:forEach>
        </table>
      </div>
           <div style=" width: 100%; padding-left: 180px;background:#f2f2f2;padding-bottom: 2px; ">
					<%-- <%@include file="../pager.jsp" %> --%>
					 <div class="page" style="border-top:none;height:29px; line-height:29px; border-bottom:2px solid #ccc; background:#f2f2f2; padding-right:335px;">
						<ul>
							<li>
								<c:if test="${pager.total==0}" var="nodata">无数据显示</c:if>
								<c:if test="${!nodata}">
								<c:if test="${pager.page>1}" var="firstPage">
								<span class="first" onclick="jumpPage(1)"></span><span class="pre" onclick="jumpPage(${pager.page-1})"></span>
								</c:if>
								<c:if test="${!firstPage}">
								<span class="first"></span><span class="pre"></span>
								</c:if>
								<c:if test="${pager.page==pager.total}" var="total">
								<span>显示&nbsp;${pager.rows*(pager.page-1)+1}&nbsp;-&nbsp;${pager.records}</span>
								</c:if>
								<c:if test="${!total}">
								<span>显示&nbsp;${pager.rows*(pager.page-1)+1}&nbsp;-&nbsp;${pager.rows*pager.page}</span>
								</c:if>
								<c:if test="${pager.page<pager.total}" var="lastPage">
								<span class="next" onclick="jumpPage(${pager.page+1})"></span><span class="last" onclick="jumpPage(${pager.total})"></span>
								</c:if>
								<c:if test="${!lastPage}">
								<span class="next"></span><span class="last"></span>
								</c:if>
								共&nbsp;${pager.records}&nbsp;条
								</c:if>
							</li>
						</ul>
					</div>
			</div>
                  
</body>
</html>
