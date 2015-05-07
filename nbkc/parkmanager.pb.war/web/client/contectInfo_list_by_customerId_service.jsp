<%@page import="com.wiiy.ps.activator.PsActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />


<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initList("list");
		jqGridResizeRegister("list");
	});
	function initList(list){
		$("#"+list).jqGrid({
	    	url:'<%=basePath%>contectInfo!list.action',
			colModel: [
				{label:'企业名称', name:'customer.name', align:"center"}, 
				{label:'交往类型', name:'type.dataValue', align:"center",width:70}, 
				{label:'走访人员', name:'contect.realName', align:"center",width:80}, 
				{label:'交往日期', name:'startTime',formatter:'date',formatoptions:{srcformat:'Y-m-d H:i',newformat:'Y-m-d H:i'}, width:120, align:"center"}, 
				{label:'创建人', name:'creator', width:80, align:"center"}, 
			    {label:'管理', name:'manager', align:"center", sortable:false, resizable:false,width:60}
			    
			],
			height: 302,
			width: 698,
			shrinkToFit: false,
			postData:{filters:generateSearchFilters("customerId","eq",'${param.id}',"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_contectInfoView")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%}%>
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_contectInfoEdit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					<%}%>
					<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_contectInfoDel")){%>
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
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function viewById(id){
		fbStart('查看交往信息','<%=basePath%>contectInfo!view.action?id='+id,500,251);
	}
	function editById(id){
		fbStart('编辑交往信息','<%=basePath%>contectInfo!edit.action?id='+id,500,306);
	}
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>contectInfo!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				$("#list").trigger("reloadGrid");
			});
		}
	}
</script>

</head>

<body>
		<div class="basediv">
			<!--divlay-->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="140" valign="top"><jsp:include page="../customer_view_common2.jsp">
							<jsp:param value="2" name="index" />
							<jsp:param value="<%=request.getParameter("id")%>" name="customerId" />
						</jsp:include></td>
					<td valign="top">
						<div class="pm_view_right" style="height: 432px;">
							<div class="basediv" style="margin: 0px;">
								<div class="titlebg">交往信息</div>
								<div class="emailtop">
									<div class="leftemail">
										<ul>
										<%if(PsActivator.getHttpSessionService().isInResourceMap("ps_serviceCenter_contectInfoAdd")){%>
											<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建交往信息','<%=basePath %>contectInfo!addByCustomerId.action?id=${param.id}',550,300);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
											<%} %>
										</ul>
									</div>
								</div>
								<table id="list" width="100%">
									<tr>
										<td />
									</tr>
								</table>
								<div id="pager"></div>
								<div class="hackbox"></div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
</body>
</html>
