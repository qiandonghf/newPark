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
		initRiskCapitalList()
		jqGridResizeRegister("riskCapitalList");
	});
	function initRiskCapitalList(){
		$("#riskCapitalList").jqGrid({
	    	url:'<%=basePath%>customerRiskCapital!list.action',
			colModel: [
				{label:'机构名称', name:'orgName',sortable:false, align:"center",width:120}, 
			    {label:'金额', name:'money',sortable:false, align:"center",width:120}, 
			    {label:'币种', name:'currencyType.dataValue',sortable:false, align:"center",width:40}, 
			    {label:'时间', name:'time',sortable:false, align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
			    {label:'备注', name:'memo',sortable:false,hidden:true, align:"center"}
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
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewRiskById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editRiskById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteRiskById("+id+");\"  /> ";
					<%} %>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewRiskById(id){
		fbStart('查看风险投资',"<%=basePath%>customerRiskCapital!view.action?id="+id,600,151);
	}
	function editRiskById(id){
		fbStart('编辑风险投资',"<%=basePath%>customerRiskCapital!edit.action?id="+id,600,177);
	}
	function deleteRiskById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>customerRiskCapital!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				reloadRiskCapitalList();
			});
		}
	}
	function reloadRiskCapitalList(){
		$("#riskCapitalList").trigger("reloadGrid");
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
								<jsp:param value="12" name="index" />
								<jsp:param value="<%=request.getParameter("id")%>" name="customerId" />
							</jsp:include>
						<%}else{%>
							<jsp:include page="../customer_view_common.jsp">
								<jsp:param value="12" name="index" />
								<jsp:param value="<%=request.getParameter("id")%>" name="customerId" />
							</jsp:include>
						<%} %>
					</td>
					<td valign="top" style="background:#eaeced ">
						<div class="pm_view_right" style="width:700px;height: 432px;">
							<div class="basediv" style="margin: 0px;">
								<div class="titlebg">风险投资</div>
								<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
									<div class="emailtop">
										<div class="leftemail">
											<ul>
												<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建风险投资','<%=basePath %>customer!addRiskCapital.action?id=${result.value.id}',600,177);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
											</ul>
										</div>
									</div>
								<%} %>
								<table id="riskCapitalList" width="100%"><tr><td/></tr></table>
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
