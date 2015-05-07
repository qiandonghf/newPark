<%@page import="com.wiiy.pb.activator.PbActivator"%>
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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
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
	$(document).ready(function() {
		initTip();
		initStaffer();
		jqGridResizeRegister("stafferList");
	});
	function initStaffer(){
		$("#stafferList").jqGrid({
	    	url:'<%=basePath%>staffer!list.action',
			colModel: [
				{label:'姓名', name:'name',align:"center"}, 
				{label:'职位',width:80, name:'position.dataValue', align:"center"}, 
			    {label:'联系电话', name:'phone',align:"center"},
			    {label:'Email',width:250, name:'email',align:"center"}, 
			    {label:'学位', width:80,name:'degree.dataValue', align:"center"}, 
			    {label:'是否股东',width:100, name:'stockHolder.title', align:"center"}, 
			    {label:'管理', name:'manager',align:"center",sortable:false, resizable:false}
			],
			height: 302,//加上分页栏高度为106
			forceFit: true,
			multiselect: false,
			width: 698,
			postData:{filters:generateSearchFilters("customerId","eq",<%=request.getParameter("id") %>,"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_stafferView")){ %>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_stafferEdit")){ %>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  />"; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_stafferDel")){ %>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  />";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false, refresh: false});
	}
	function viewById(id){
		fbStart('查看主要人员','<%=basePath%>staffer!view.action?id='+id,500,400);
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>staffer!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#stafferList").trigger("reloadGrid");
	        	}
			});
		}
	}
	function editById(id){
		fbStart('编辑主要人员','<%=basePath %>staffer!edit.action?id='+id,500,430);
	}
	function reloadList(){
		$("#stafferList").trigger("reloadGrid");
	}
</script>
</head>

<body>
<div class="basediv">
    <!--divlay-->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="140" valign="top">
				<jsp:include page="../customer_view_common2.jsp">
					<jsp:param value="4" name="index"/>
					<jsp:param value="<%=request.getParameter("id") %>" name="customerId"/>
				</jsp:include>
			</td>
            <td valign="top">
				<div class="pm_view_right" style="width:700px;height: 432px;">
					<div class="basediv" style="margin:0px;">
					<div class="titlebg">主要人员</div>
					<div class="emailtop">
						<div class="leftemail">
							<ul>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_stafferAdd")){ %>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建主要人员','<%=basePath %>staffer!addByCustomerId.action?id=<%=request.getParameter("id") %>',650,326);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
							<%} %>
							</ul>
						</div>
					</div>
					<table id="stafferList" width="100%"><tr><td/></tr></table><div id="pager"></div>
				<div class="hackbox"></div>
				</div>
		</div>
		</td>
		</tr>
		</table>
		
</div>
<div style="height: 5px;"></div>
</body>
</html>
