<%@page import="com.wiiy.ps.activator.PsActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initProject();
		jqGridResizeRegister("productList","projectApplyList");
	});
	function initProject(){
		$("#productList").jqGrid({
	    	url:'<%=basePath%>product!list.action',
			colModel: [
			    {label:'产品名称', name:'name',align:"center"}, 
			    {label:'技术领域', name:'technic.dataValue', align:"center"},
			    {label:'产品阶段', name:'stage.dataValue',align:"center"}, 
			    {label:'管理', name:'manager',width:80, align:"center",sortable:false, resizable:false}
			],
			height: 299,//加上分页栏高度为106
			forceFit: true,
			width: 698,
			multiselect: false,
			pager: '#pager1',
			postData:{filters:generateSearchFilters("customerId","eq",<%=request.getParameter("id") %>,"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_projectApplyView")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('项目信息','product','"+id+"',500,352);\"  /> ";
					<%}%>
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_projectApplyEdit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('项目信息','product','"+id+"',500,503);\"  /> ";
					<%}%>
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_projectApplyDel")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('product','"+id+"');\"  /> ";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager1',{add: false, edit: false, del: false, search: false, refresh: false});
		
		$("#projectApplyList").jqGrid({
	    	url:'<%=basePath%>projectApply!list.action',
			colModel: [
				{label:'项目名称', name:'name',align:"center"}, 
				{label:'产品名称', name:'product.name',align:"center"}, 
			    {label:'申报年度', name:'applyYear',width:60,  align:"center"},
			    {label:'申报类型', name:'applyType.dataValue',width:60,  align:"center"}, 
			    {label:'申请金额(万元)',width:80, name:'amount',align:"center"}, 
			    {label:'管理', name:'manager', index:'manager',width:60,align:"center",sortable:false, resizable:false} 
			],
			height: 299,
			forceFit: true,
			width: 698,
			multiselect: false,
			pager: '#pager2',
			postData:{filters:generateSearchFilters("customerId","eq",<%=request.getParameter("id") %>,"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_projectApplySBView")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('项目申报情况','projectApply','"+id+"',500,400);\"  /> ";
					<%}%>
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_projectApplySBEdit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('项目申报情况','projectApply','"+id+"',500,519);\"  /> ";
					<%}%>
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_projectApplySBDel")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('projectApply','"+id+"');\"  /> ";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager2',{add: false, edit: false, del: false, search: false, refresh: false});
	}	
	
	function viewById(name,test,id,h,w){
		fbStart('查看'+name,"<%=basePath%>"+test+"!view.action?id="+id,h,w);
	}
	function editById(name,test,id,h,w){
		fbStart('编辑'+name,"<%=basePath%>"+test+"!edit.action?id="+id,h,w);
	}
	function deleteById(test,id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>"+test+"!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				$("#"+test+"List").trigger("reloadGrid");
			});
		}
	}
	function reloadList(test){
		$("#"+test+"List").trigger("reloadGrid");
	}
</script>
</head>

<body>
<div class="basediv">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
             <td width="140" valign="top">
				<jsp:include page="../customer_view_common2.jsp">
					<jsp:param value="3" name="index"/>
					<jsp:param value="<%=request.getParameter("id") %>" name="customerId"/>
				</jsp:include>
			</td>
            <td valign="top">
				<div class="pm_view_right" style="height: 432px;">
				<!--基本信息-->
				<!--table切换开始-->
				<div class="apptab" id="tableid">
					<ul>
						<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">项目信息</li>
						<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">项目申报情况</li>
					</ul>
				</div>
				<!--//table切换开始-->
				<div class="basediv tabswitch" style="margin:0px;" name="textname" id="textname">
				<div class="emailtop">
					<div class="leftemail">
						<ul>
						<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_projectApplyAdd")){ %>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建项目与产品','<%=basePath %>product!addByCustomerId.action?id=<%=request.getParameter("id") %>',500,400);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
						<%} %>
						</ul>
					</div>
				 </div>
				 <table id="productList" width="100%"><tr><td/></tr></table><div id="pager1"></div>
				</div>
				
				<div class="basediv tabswitch" style="margin:0px;display:none;" name="textname" id="textname">
					<div class="emailtop">
						<div class="leftemail">
							<ul>
							<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_projectApplySBAdd")){ %>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建项目申报情况','<%=basePath %>projectApply!addByCustomerId.action?id=<%=request.getParameter("id") %>',500,416);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
							<%} %>
							</ul>
						</div>
					</div>
					<table id="projectApplyList" width="100%"><tr><td/></tr></table><div id="pager2"></div>
				</div>
		</div>
		</td>
		</tr>
		</table>
		
</div>
<!--//basediv-->
</body>
</html>
