<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
	<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
	<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
	<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
	<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
	<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
	<script type="text/javascript">
		$(function(){
			initTip();
			init();
		});
		function reloadSubjectRentList(){
			$("#subjectRentList").trigger("reloadGrid");
		}
		function slide(className){
			if($("#meterlayer").find("a").size()==0){
				showTip("系统未配置合同模板，请联系管理员！");
				return;
			}
			$("."+className).toggle();
		}
		function approval(){
			if(confirm("确认送审?")){
				fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
			}
		}
		function setSelectedUser(user){
			$.post("<%=basePath%>contract!approval.action?id="+$("#contractId").val()+"&ids="+user.id,function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					setTimeout("reloadContractApprovalList()", 2000);
				}
			});
		}
		function executeContract(id){
			if(confirm("确认正式执行合同?")){
				$.post("<%=basePath%>contract!executeContract.action?id="+id,function(data){
					if(data.result.success){
						location.reload();
					}
				});
			}
		}
		function closeContract(id){
			if(confirm("确认关闭合同?")){
				checkBillPlan(id);
			}
		}
		function checkBillPlan(id){
			$.post("<%=basePath%>contract!checkBillPlan.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					checkDeposit(id);
				}
			});
		}
		function checkDeposit(id){
			$.post("<%=basePath%>contract!checkDeposit.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					checkBill(id);
				}
			});
		}
		function checkBill(id){
			$.post("<%=basePath%>contract!checkBill.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					submitClose(id);
				}
			});
		}
		function submitClose(id){
			$.post("<%=basePath%>contract!closeContract.action?id="+id,function(data){
				if(data.result.success){
					location.reload();
				}
			});
		}
		function contractApproval(id){
			fbStart("审批","<%=BaseAction.rootLocation %>/core/approval!edit.action?id="+id,500,170);
		}
		function approvalCallback(){
			reloadContractApprovalList();
		}
		function print(){
			fbStartOnScroll("打印预览","<%=basePath %>contract!print.action?id=${result.value.id}",1000,600);
		}
		
		function printDoc(id){
			$.post("<%=basePath%>contract!loadTemplate.action?id="+id,function(data){
				if(data.result.success){
					window.open("<%=basePath %>contract!printDoc.action?id="+id+"&&templateId="+data.templateId);
				}else{
					showTip(data.result.msg);
				}
			});
		}
	</script>
</head>
<body>
	<div style="margin-bottom: 10px;">
	<input type="hidden" value="${result.value.id}" id="contractId" name="contract.id"/>
	<div class="basediv">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<%-- <c:if test="${approval ne null}" var="approvalFlag">
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="contractApproval(${approval.id})"><span><img src="core/common/images/examine.png"/></span>审批</li>
					</c:if> --%>
					<c:if test="${!approvalFlag}">
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_print")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''"><a href="javascript:void(0);" onclick="printDoc(${result.value.id})"><span><img src="core/common/images/print_16x16.gif"/></span>打印预览<%-- <em class="em"><img src="core/common/images/arrow.png" /></em>
						<div class="meterlayer" id="meterlayer" style="display:none; top:31px;">
							<dl>
								<c:forEach items="${contractTemplateList}" var="template">
								<dt><a href="<%=basePath %>contract!printDoc.action?id=${result.value.id}&templateId=${template.id}" target="_blank">${template.name}</a></dt>
								</c:forEach>
							</dl>
						</div> --%>
					</a></li>
					<%} %>
					<!-- <li onclick="print()" onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/page_view.png"/></span>打印预览</li> -->
					<c:if test="${result.value.state eq 'NEW'}">
					<!-- <li onclick="approval()" onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/examine.png"/></span>送审</li> -->
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_execute")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="executeContract(${result.value.id})"><span><img src="core/common/images/accept.png"/></span>执行合同</li>
					<%} %>
					</c:if>
					<c:if test="${result.value.state eq 'EXECUTE'}">
					<li><img src="core/common/images/line.png" /></li>
					<c:if test = "${result.value.rentState ne 'RENTOFF' }">
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_relet")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('合同续租','<%=basePath %>contract!relet.action?id=${result.value.id}',350,205);"><span><img src="core/common/images/rent1.png"/></span>续租</li>
					<%} %>
					<c:if test="${fn:length(subjectRentList)>1}">
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_subtract")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('合同减租','<%=basePath %>contract!subtract.action?id=${result.value.id}',350,260);"><span><img src="core/common/images/rent2.png"/></span>减租</li>
					<%} %>
					</c:if>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_surrender")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('合同退租','<%=basePath %>contract!surrender.action?id=${result.value.id}',350,290);"><span><img src="core/common/images/rent3.png"/></span>退租</li>
					<%} %>
					</c:if>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contract_close")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="closeContract(${result.value.id})"><span><img src="core/common/images/stop.png"/></span>关闭合同</li>
					<%} %>
					</c:if>
					</c:if>
				</ul>
			</div>
		</div>
		<div class="divlays">
			<jsp:include page="contract_view_common3.jsp"></jsp:include>
			<div style="height: 230px;">
				<div id="bottom">
					<jsp:include page="contract_bottom_navigation_rent.jsp"></jsp:include>
					<jsp:include page="contract_bottom_common_rent_view.jsp"></jsp:include>
					<jsp:include page="contract_bottom_common.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>
