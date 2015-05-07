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
		initKnowledge();
		jqGridResizeRegister("patentList","copyrightList","certificationList");
	});
	function initKnowledge(){
		$("#patentList").jqGrid({
	    	url:'<%=basePath%>patent!list.action',
			colModel: [
			    {label:'专利名称', name:'name', align:"center"},
			    {label:'专利申请人', name:'appler', align:"center"}, 
			    {label:'专利号', name:'serialNo', align:"center"},
			    {label:'专利状态', name:'state.dataValue', align:"center"},
			    {label:'专利申请日期', name:'applyTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
			    {label:'专利类型', name:'type.dataValue', align:"center"},
			    {label:'管理', name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: 299,//加上分页栏高度为106
			forceFit: true,
			width:697,
			multiselect: false,
			pager: '#pager1',
			postData:{filters:generateSearchFilters("customerId","eq",<%=request.getParameter("id") %>,"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('patent','"+id+"',650,245);\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('patent','"+id+"',650,371);\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('patent','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager1',{add: false, edit: false, del: false, search: false, refresh: false});
		
		$("#copyrightList").jqGrid({
	    	url:'<%=basePath%>copyright!list.action',
			colModel: [
				{label:'著作权名称', name:'name', index:'name', align:"center"}, 
				{label:'著作权号', name:'serialNo', index:'serialNo',  align:"center"}, 
				{label:'著作权类型', name:'type.dataValue', index:'type.dataValue', align:"center"}, 
				{label:'生效日期', name:'effectivetime', index:'effectivetime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"}, 
				{label:'失效日期', name:'expireTime', index:'expireTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
				{label:'管理', name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: 299,
			forceFit: true,
			width:697,
			multiselect: false,
			pager: '#pager2',
			postData:{filters:generateSearchFilters("customerId","eq",<%=request.getParameter("id") %>,"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('copyright','"+id+"',500,322);\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('copyright','"+id+"',500,459);\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('copyright','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager1',{add: false, edit: false, del: false, search: false, refresh: false});
		
		$("#certificationList").jqGrid({
	    	url:'<%=basePath%>certification!list.action',
			colModel: [
				{label:'认证名称', name:'name', index:'name', align:"center"}, 
				{label:'认证类型', name:'type.dataValue', index:'type', align:"center"}, 
				{label:'认证编号', name:'serialNo', index:'serialNo', align:"center"}, 
				{label:'认证日期', name:'certTime', index:'certTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"}, 
				{label:'认证机构', name:'agency', index:'agency', align:"center"},
				{label:'管理', name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: 299,
			forceFit: true,
			width:697,
			multiselect: false,
			pager: '#pager3',
			postData:{filters:generateSearchFilters("customerId","eq",<%=request.getParameter("id") %>,"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('certification','"+id+"',500,280);\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('certification','"+id+"',500,407);\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('certification','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager1',{add: false, edit: false, del: false, search: false, refresh: false});
		
		$("#brandList").jqGrid({
	    	url:'<%=basePath%>brand!list.action',
			colModel: [
				{label:'商标名称', name:'name', align:"center"}, 
			{label:'商标编号', name:'brandNo', align:"center"}, 
			{label:'企业名称', name:'customer.name', align:"center",width:180}, 
			{label:'注册人',width:80, name:'register', align:"center"}, 
			{label:'注册地址', name:'registerAddress', align:"center",formatter:addrFormat}, 
			{label:'注册有效期',width:160, name:'startDate', align:"center",formatter:dateFormat}, 
			{label:'授权时间',width:90, name:'grantDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center"}, 
			{label:'注册有效期开始日期',width:80, name:'startDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center",hidden:true}, 
			{label:'注册有效期结束日期',width:80, name:'endDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center", hidden:true},
			{label:'详细说明', name:'memo', align:"center", hidden:true},
		    {label:'管理', width:75,name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: 299,
			forceFit: true,
			width:697,
			multiselect: false,
			pager: '#pager3',
			postData:{filters:generateSearchFilters("customerId","eq",<%=request.getParameter("id") %>,"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('brand','"+id+"',500,280);\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('brand','"+id+"',500,407);\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('brand','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager1',{add: false, edit: false, del: false, search: false, refresh: false});
	}
	function addrFormat(cellvalue,options,rowObject){
		 var registerAddress = rowObject["registerAddress"];
		   if(registerAddress.length > 15){
			   cellvalue = registerAddress.substring(0,14)+"......";
		   }
		   return cellvalue;
	}
	function dateFormat(cellvalue,options,rowObject){
		var startDate = rowObject["startDate"];
		var endDate = rowObject["endDate"];
		if(startDate!=null && endDate!=null){
			startDate = startDate.substring(0,10);
			endDate = endDate.substring(0,10);
			cellvalue = startDate+"至"+endDate;
		}
		return cellvalue;
	}
	function viewById(test,id,h,w){
		fbStart('查看知识产权信息',"<%=basePath%>"+test+"!view.action?id="+id,h,w);
	}
	function editById(test,id,h,w){
		fbStart('编辑知识产权信息',"<%=basePath%>"+test+"!edit.action?id="+id,h,w);
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
<!--basediv-->
<div class="basediv">
    <!--divlay-->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="140" valign="top">
				<jsp:include page="../customer_view_common.jsp">
					<jsp:param value="5" name="index"/>
					<jsp:param value="<%=request.getParameter("applyId")%>" name="gardenApplyId"/>
					<jsp:param value="<%=request.getParameter("id") %>" name="customerId"/>
				</jsp:include>
			</td>
            <td valign="top" style="background:#eaeced ">
				<div class="pm_view_right" style="width:700px;height: 432px;">
				<!--table切换开始-->
					<div class="apptab" id="tableid">
					<ul>
						<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">专利</li>
						<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">著作权</li>
						<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">认证</li>
						<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',3)">商标</li>
					</ul>
				</div>
			<!--//table切换开始-->
			<!--专利-->
			<div class="basediv tabswitch" style="margin:0px;" id="textname">
				<div class="emailtop">
					<div class="leftemail">
						<ul>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建专利','<%=basePath %>patent!addByCustomerId.action?id=<%=request.getParameter("id") %>',650,267);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
						</ul>
					</div>
				</div>
				<table id="patentList" width="100%"><tr><td/></tr></table><div id="pager1"></div>
			</div>	
			<!--著作权-->
			<div class="basediv tabswitch" style="margin:0px;display:none" id="textname">
				<div class="emailtop">
					<!--leftemail-->
					<div class="leftemail">
						<ul>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建著作权','<%=basePath %>copyright!addByCustomerId.action?id=<%=request.getParameter("id") %>',500,355);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
						</ul>
					</div>
				</div>
				<table id="copyrightList" width="100%"><tr><td/></tr></table><div id="pager2"></div>
			</div>			
			<!--认证-->
			<div class="basediv tabswitch" style="margin:0px; display:none" id="textname">
				<div class="emailtop">
					<!--leftemail-->
					<div class="leftemail">
						<ul>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建认证','<%=basePath %>certification!addByCustomerId.action?id=<%=request.getParameter("id") %>',500,302);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
						</ul>
					</div>
				</div>	
				<table id="certificationList" width="100%"><tr><td/></tr></table><div id="pager3"></div>
			</div>		
			<!--商标-->
			<div class="basediv tabswitch" style="margin:0px; display:none" id="textname">
				<div class="emailtop">
					<!--leftemail-->
					<div class="leftemail">
						<ul>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建商标','<%=basePath %>brand!addByCustomerId.action?id=<%=request.getParameter("id") %>',500,302);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
						</ul>
					</div>
				</div>	
				<table id="brandList" width="100%"><tr><td/></tr></table><div id="pager3"></div>
			</div>		
		</div>
		</td>
		</tr>
		</table>
</div>
</body>
</html>
