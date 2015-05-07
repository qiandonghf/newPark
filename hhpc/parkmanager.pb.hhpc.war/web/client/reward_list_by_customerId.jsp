<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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


<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initRewardList();
		jqGridResizeRegister("rewardList");
	});
	function initRewardList(){
		$("#rewardList").jqGrid({
	    	url:'<%=basePath%>reward!list.action',
			colModel: [
			    {label:'企业', name:'customer.name',sortable:false, align:"center",width:40}, 
				{label:'奖励类型', name:'type.dataValue',sortable:false, align:"center",width:40}, 
			    {label:'奖金', name:'bonus',sortable:false, align:"center",width:40}, 
			    {label:'奖励日期', name:'rewardDate',sortable:false, align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
			    {label:'详细说明', name:'memo',sortable:false, align:"center",width:40} 
			    <%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
			    ,{label:'管理', name:'manager',sortable:false, align:"center",width:80}
			    <%} %>
			],
			height: 302,
			width:697,
			postData:{filters:generateSearchFilters("customerId","eq",'${result.value.id}',"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
					content += "<img src=\"core/common/images/time.png\" width=\"14\" height=\"14\" title=\"设置为过期\" onclick=\"editPolicyById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deletePolicyById("+id+");\"  /> ";
					<%} %>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function reloadRewardList(){
		$("#rewardList").trigger("reloadGrid");
	}
	function viewRewardById(id){
		fbStart('查看奖励',"<%=basePath%>reward!view.action?id="+id,500,206);
	}
	
	function editRewardById(id){
		fbStart('修改奖励',"<%=basePath%>reward!edit.action?id="+id,500,235);
	}
	function deleteRewardById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>reward!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				reloadRewardList();
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
					<td width="140" valign="top">
					<%if((Boolean)request.getAttribute("service")){ %>
							<jsp:include page="../customer_view_common2.jsp">
								<jsp:param value="13" name="index" />
								<jsp:param value="<%=request.getParameter("id")%>" name="customerId" />
							</jsp:include>
						<%}else{%>
							<jsp:include page="../customer_view_common.jsp">
								<jsp:param value="13" name="index" />
								<jsp:param value="<%=request.getParameter("id")%>" name="customerId" />
							</jsp:include>
						<%} %>
					</td>
					<td valign="top" style="background:#eaeced">
						<div class="pm_view_right" style="width:700px;height: 432px;">
							<div class="basediv" style="margin: 0px;">
								<div class="titlebg">奖励</div>
								<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
								<div class="emailtop">
									<div class="leftemail">
										<ul>
											<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建奖励','<%=basePath %>reward!add.action?id=${result.value.id}',550,235);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
										</ul>
									</div>
								</div>
								<%} %>
								<table id="rewardList" width="100%"><tr><td/></tr></table>
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
