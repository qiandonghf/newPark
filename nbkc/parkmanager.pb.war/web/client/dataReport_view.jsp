<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.DataReport"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.crm.preferences.enums.ReportStatusEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(function(){initList();
		initTip();
	});
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function initList(){
		var height = getTabContentHeight()-167;
		var width = window.parent.parent.document.documentElement.clientWidth-(window.parent.screenLeft-window.parent.parent.screenLeft)-190;
		$("#list").jqGrid({
	    	url:'<%=basePath%>dataReportToCustomer!list.action?id=${result.value.id}',
			colModel: [
				{label:'企业', name:'customer.name',width:260, align:"center"}, 
				{label:'报表名称', name:'report.name',width:80, align:"center"}, 
				{label:'报表类型', name:'report.reportType.title',width:80,align:"center"}, 
				{label:'类型', name:'report.reportType',width:80,align:"center",hidden:true}, 
				{label:'数据时间', name:'report.date', width:90,align:"center",formatter:formatDate}, 
			    {label:'日期', name:'report.dataTime',width:90, align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'},hidden:true},
				{label:'报表状态', name:'report.status.title',width:80, align:"center", index:'status',hidden:true},
				{label:'填报日期', name:'fillTime', align:"center",width:80, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
				{label:'填报状态', name:'status.title', align:"center",width:50},
			    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false,width:70}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportToCustomer_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportToCustomer_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportToCustomer_back")){%>
					content += "<img src=\"core/common/images/back.png\" width=\"14\" height=\"14\" title=\"退回\" onclick=\"backById('"+id+"');\"  /> "; 
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportToCustomer_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
				<%}%>
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
	function formatDate(cellvalue,options,rowObject){
		var type = rowObject["report"].reportType.title;
		var dataTime = rowObject["report"].dataTime;
		var year;
		var month;
		if(type=="月报"){
		    year = dataTime.substring(0,4);
			month = dataTime.substring(5,7);
			if(month<10){
				month = dataTime.substring(6,7);
			}
			cellvalue = year+"年"+month+"月";
		}
		if(type=="季报"){
			year = dataTime.substring(0,4);
			month = dataTime.substring(5,7);
			if(month<10){
				month = dataTime.substring(6,7);
			}
			cellvalue = year+"年"+month/3+"季度";
		}
		if(type=="半年报"){
			year = dataTime.substring(0,4);
			month = dataTime.substring(5,7);
			if(month<10){
				month = dataTime.substring(6,7);
			}
			if(month==6){
				cellvalue = year+"年上半年";
			}
			if(month==12){
				cellvalue = year+"年下半年";
			}
		}
		if(type=="年报"){
			year = dataTime.substring(0,4);
			cellvalue = year+"年";
		}
		if(type=="临时"){
			year = dataTime.substring(0,10);
			cellvalue = year;
		} 
		return cellvalue;
	}
	
	function viewById(id){
		window.open("<%=basePath%>dataReportToCustomer!view.action?id="+id+"&type=view",'查看报表','height=700,width=750,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
	}
	function backById(id){
		if(confirm("确定要退回吗")){
			fbStart("数据报送退回原因","<%=basePath%>web/client/dataReportToCustomer_backSuggestion.jsp?id="+id,500,170);
		}
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>dataReportToCustomer!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>dataReportToCustomer!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function editById(id){
		window.open("<%=basePath%>dataReportToCustomer!edit.action?id="+id,'数据填报','height=700,width=750,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
		<%-- fbStart('编辑企业报表','<%=basePath %>dataReportToCustomer!edit.action?id='+id,800,540,false); --%>
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function refresh(){
		if($(".tabswitch").size()==2){
			$("#list").trigger("reloadGrid");
		}else{
			location.reload();
		}
	}
	function closeReport(){
		if(confirm("是否关闭${result.value.name}报表")){
			$.post("<%=basePath%>dataReport!close.action?id=${result.value.id}",function(data){
				showTip(data.msg);
				setTimeout("location.reload();parent.fb.end();", 500);
			});
		}
	}
	function openReport(){
		if(confirm("是否打开${result.value.name}报表")){
			$.post("<%=basePath%>dataReport!open.action?id=${result.value.id}",function(data){
				setTimeout("location.reload();parent.fb.end();", 500);
			});
		}
	}
	
	function setSelectedCustomers(customerIds){
		var action = $("#action").val();
		var url = "<%=basePath%>dataReport!"+action+".action?id=${result.value.id}&ids="+customerIds;
		showTip("正在发布中，请稍等......",200000);
		$.post(url,function(data){
			showTip(data.msg);
			if(data.result.success){
				setTimeout("location.reload();parent.fb.end();", 500);
			}
		});
	}
	
	function publishReport(){
		$("#action").val("publish");
		fbStart('发布','<%=basePath %>customer!multiSelect.action',520,400);
	}
	function addCustomer(){
		$("#action").val("addCustomer");
		fbStart('添加企业','<%=basePath %>customer!multiSelect.action',520,400);
	}
</script>
</head>

<body>
<input id="action" type="hidden" value="addCustomer"/>
<div class="titlebg">企业数据填报列表</div>
<div class="apptab" id="tableid">
	<ul>
		<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">基本信息</li>
		<% 
			Result<DataReport> r = (Result<DataReport>)request.getAttribute("result");
			if(!r.getValue().getStatus().equals(ReportStatusEnum.UNPUB)){
		%>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">填报数据</li>
		<% 	}%>
	</ul>
</div>
<div class="tabswitch">
	<div class="pm_msglist" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">报表名称：</td>
				<td class="layerright">${result.value.name}</td>
			</tr>
			<tr>
				<td class="layertdleft100">数据模板：</td>
				<td class="layerright">${result.value.template.name}</td>
			</tr>
			<tr>
				<td class="layertdleft100">报表类型：</td>
				<td class="layerright">${result.value.reportType.title}</td>
			</tr>
			<tr>
				<td class="layertdleft100">日期：</td>
				<td class="layerright">
					<fmt:formatDate value="${result.value.dataTime}" pattern="yyyy" var="year"/>
					<fmt:formatDate value="${result.value.dataTime}" pattern="M" var="month"/>
					<%
						int t = -1;
						switch(r.getValue().getReportType()){
							case TEMP: t++;
							case MONTH: t++;
							case SEASON: t++;
							case HALFYEAR: t++;
							case YEAR: t++;
						}
					%>
					<span id="dataTimeYear" class="dataTime" <%if(t==4){%>style="display: none;"<%} %>>${year}&nbsp;年</span>
					<span id="dataTimeHalfyear" class="dataTime" <%if(t!=1){%>style="display: none;"<%} %>>
						<c:if test="${6==month}">上半年</c:if>
						<c:if test="${12==month}">下半年</c:if>
					</span>
					<span id="dataTimeSeason" class="dataTime" <%if(t!=2){%>style="display: none;"<%} %>>
						<c:if test="${3==month}">一季度</c:if>
						<c:if test="${6==month}">二季度</c:if>
						<c:if test="${9==month}">三季度</c:if>
						<c:if test="${12==month}">四季度</c:if>
					</span>
					<span id="dataTimeMonth" class="dataTime" <%if(t!=3){%>style="display: none;"<%} %>>${month}&nbsp;月</span>
					<span id="dataTimeOther" class="dataTime" <%if(t!=4){%>style="display: none;"<%} %>>
						<fmt:formatDate value="${result.value.dataTime}" pattern="yyyy-MM-dd"/>
					</span>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">填报截至日期：</td>
				<td class="layerright"><fmt:formatDate value="${result.value.finishTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">报表状态：</td>
				<td class="layerright">${result.value.status.title}</td>
			</tr>
			<tr>
				<td class="layertdleft100">备注：</td>
				<td class="layerright">已上报企业${finishCount}家，未上报企业<span class="redweight">${unFinishCount}</span>家</td>
			</tr>
		</table>
	</div>
	<div class="buttondiv" style="margin-top:5px;">
		<% if(r.getValue().getStatus().equals(ReportStatusEnum.UNPUB)&&PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportToCustomer_publish")){ %>
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="publishReport()"><span><img src="core/common/images/savebtnicon.gif" />发布</span></a>
		<% 	} else if(!r.getValue().getStatus().equals(ReportStatusEnum.CLOSE)){ %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReport_close")){ %>
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="closeReport();"><span><img src="core/common/images/closebtnicon.gif" />关闭</span></a>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReport_count")){ %>
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="fbStart('${result.value.name}','<%=basePath %>dataReport!count.action?id=${result.value.id}',700,439);"><span><img src="core/common/images/count.png" />统计</span></a>
		<%  } %>
		<%  } %>
		<% if(r.getValue().getStatus().equals(ReportStatusEnum.CLOSE)&&PbActivator.getHttpSessionService().isInResourceMap("pb_dataReport_open")){ %>
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="openReport();"><span><img src="core/common/images/viewbtn.png" />打开</span></a>
		<%  } %>
	</div>
</div>
<% 
	if(!r.getValue().getStatus().equals(ReportStatusEnum.UNPUB)){
%>
<div class="tabswitch" style="display: none;">
	<div class="pm_msglist" >
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<% 	if(!r.getValue().getStatus().equals(ReportStatusEnum.CLOSE)&&PbActivator.getHttpSessionService().isInResourceMap("pb_dataReport_addCustomer")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addCustomer()"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>添加企业</li>
					<%  } %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataReportToCustomer_delete")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
					<%} %>
				</ul>
			</div>
		</div>
		<div class="searchdiv">
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="65" algin="right">企业名称： </td>
					<td width="180">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<search:input dataType="string" field="customer.name" op="cn" inputClass="inputauto"/>
									<search:choose dataType="long" field="reportId" op="eq">
										<input class="data" value="${result.value.id}" name="reportId" type="hidden"/>
									</search:choose>
								</td>
							</tr>
						</table>
					</td>
					<td width="85" align="center">
						<input type="submit" name="Submit3" value="" class="searchbtn" onclick="doSearch()"/>
					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</div>
		<table id="list" class="jqGridList"><tr><td></td></tr></table>
		<div id="pager"></div>
	</div>
</div>
<% 	}%>
</body>
</html>