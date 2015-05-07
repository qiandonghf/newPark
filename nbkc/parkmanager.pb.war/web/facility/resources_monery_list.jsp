<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
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
	var h = window.document.documentElement.clientHeight-50;
	var dataUrl = "";
	<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){%>
		dataUrl = '<%=basePath%>facilityOrder!list.action';
	<%}%>
	<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Customer)){%>
		dataUrl = '<%=basePath%>facilityOrder!listByUserId.action';
	<%}%>
	$("#list").jqGrid({
    	url:dataUrl,
		colModel: [
			{label:'类型', width:90,name:'facility.type.title', align:"center"}, 
			{label:'设施名称',width:100 ,name:'facility.name', align:"center"}, 
			{label:'开始时间', width:125,name:'startTime', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
		    {label:'结束时间', width:125,name:'endTime', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
		    {label:'合同', width:40,name:'contractId', align:"center",formatter:contractLog},
		    {label:'管理',width:40, name:'manager', align:"center", resizable:false}
		],
		height:h,
		pager: "#pager",
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				content += "<img src=\"parkmanager.pb/web/images/rmb.png\" width=\"14\" height=\"14\" title=\"费用清单\" onclick=\"viewCostById('"+id+"');\"  /> "; 
				$(this).jqGrid('setRowData',id,{manager:content});
			}
		},
	}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
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
	fbStart('查看合同','<%=basePath %>contract!simpleView.action?id='+id,750,467);
}

function viewCostById(id){
	fbStart('费用清单','<%=basePath %>billPlanFacility!serviceListByFacilityOrderId.action?facilityOrderId='+id,720,400);
}

function reloadList(){
	location.reload();
}
function jumpPage(page){
	var url = '<%=basePath%>facilityOrder!serviceList.action';
	url += "?page="+page;
	url = encodeURI(url);
	location.href=url;
}
</script>
</head>

<body>

<div class="basediv" style="height: 280px;">
<input type="hidden" id="id"/>

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td width="25" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">序号</td>
               <td width="45" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">类型</td>
               <td width="50" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">设施名称</td>
               <td width="70" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">开始时间</td>
               <td width="70" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">结束时间</td>
               <td width="30" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">合同</td>
               <td width="30" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">操作</td>
             </tr>
             <c:forEach items="${list}" var="list" varStatus="status">
             <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
               <td class="centertd">${status.index+1}</td>
               <td class="centertd">${list.facility.type.title}</td>
               <td class="centertd">${list.facility.name}</td>
               <td class="centertd"><fmt:formatDate value="${list.startTime}" pattern="yyyy-MM-dd"/></td>
               <td class="centertd"><fmt:formatDate value="${list.endTime}" pattern="yyyy-MM-dd"/></td>
               <td class="centertd">
               		<c:if test="${list.contractId!=null}">
               			<img src="parkmanager.pb/web/images/page_find.gif"  title="查看合同" onclick="viewContract(${list.contractId});"/>
               		</c:if>
               </td>
               <td class="centertd">
               		<a href="javascript:void(0)" title="费用清单"><img src="parkmanager.pb/web/images/rmb.png" onclick="viewCostById(${list.id})"/></a>
               </td>
              
             </tr>
             </c:forEach>
        </table>
      </div>
    
            <div style=" width: 100%; padding-left: 0px;background:#f2f2f2;padding-bottom: 2px; ">
					<%-- <%@include file="../pager.jsp" %> --%>
					 <div class="page" style="border-top:none;height:29px; line-height:29px; border-bottom:2px solid #ccc; background:#f2f2f2; padding-right:160px;">
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
