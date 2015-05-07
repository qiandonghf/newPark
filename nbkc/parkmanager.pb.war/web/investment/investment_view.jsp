<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		
		<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript">
			$(function(){
				$('#investRight_height').css('height',getTabContentHeight()-8);
				$('#investRight_height2').css('height',getTabContentHeight()-12);
				$('#investRight_height3').css('height',getTabContentHeight()-46);
			});
		</script>
	</head>

	<body style="padding-bottom: 2px;">
		<div class="basediv" id="investRight_height">
		<div class="divlays" id="investRight_height2" style="margin:0px;">
		<jsp:include page="common.jsp">
			<jsp:param value="0" name="index"/>
			<jsp:param value="${id}" name="investmentId"/>
			<jsp:param value="${result.value.investmentStatus}" name="investmentStatus"/>
		</jsp:include>
		<div class="pm_msglist" id="investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		<div>
			<div class="emailtop">
				<div class="leftemail">
					<ul>
					 <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_allEdit")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('编辑申请单','<%=basePath%>investment!edit.action?id=${result.value.id}',700,538);"><span><img src="core/common/images/edit.gif" /></span>编辑</li>
					 <%}%>
					 <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_allPrint")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/print_16x16.gif" /></span><a href="<%=basePath %>investment!print.action?id=${result.value.id}" style="color:#333; text-decoration:none;" target="_blank">打印申请单</a></li>
					 <%}%>
					</ul>
				</div>
			</div>
			<div class="apptable" style="border-top:none; border-left:none;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="tdleft" width="100">拟注册单位名称</td>
									<td colspan="3" class="tdleftbg"><label>&nbsp; ${result.value.name}</label></td>
									<%-- <td width="80" class="tdleft">编号</td>
									<td width="100" class="tdleftbg">&nbsp; ${result.value.code}</td> --%>
									<td class="tdleft" width="100">申请用房面积</td>
									<td class="tdleftbg" width="250"><c:if test="${result.value.needOffice == 'YES' }"><fmt:formatNumber value="${result.value.officeArea}" pattern="#0.00"/>㎡</c:if></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="tdleft" width="80">经营范围</td>
									<td class="tdleftbg" style="height:50px;">&nbsp; ${result.value.businessScope}</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" class="tdleft">总投资</td>
	      						<td width="165" class="tdleftbg"><c:if test="${result.value.investCapital ne null}"><fmt:formatNumber value="${result.value.investCapital}" pattern="#0.00"/>万元</c:if></td>
								<td width="80" class="tdleft">注册资本</td>
								<td width="100" class="tdleftbg">&nbsp; <c:if test="${result.value.regCapital ne null}"><fmt:formatNumber value="${result.value.regCapital}" pattern="#0.00"/>万元(${result.value.currency.dataValue})</c:if></td>
								<td width="79" class="apptdcenter">企业人数</td>
								<td width="100" class="tdleftbg" >&nbsp; <c:if test="${result.value.staff ne null}">${result.value.staff}人</c:if></td>
							</tr>
						</table>
					</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" class="apptdcenter">负责人</td>
								<td width="50" class="apptdcenter" >学历</td>
								<td width="100" class="apptdcenter">专业</td>
								<td width="100" class="apptdcenter">学位或职称</td>
								<td width="150" class="apptdcenter">手机</td>
								<td width="120" class="apptdcenter">固定电话</td>
							</tr>
							<c:forEach items="${invesmentDirectorList}" var="director">
							<tr>
								<td class="apptdcenterwhite">&nbsp; ${director.name}</td>
								<td class="apptdcenterwhite">&nbsp; ${director.degree.dataValue}</td>
								<td class="apptdcenterwhite">&nbsp; ${director.specialty}</td>
								<td class="apptdcenterwhite">&nbsp; ${director.profession}</td>
								<td class="apptdcenterwhite">&nbsp; ${director.mobile}</td>
								<td class="apptdcenterwhite">&nbsp; ${director.phone}</td>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" class="apptdcenter">投资方</td>
								<td width="50" class="apptdcenter" >出资比例</td>
								<td width="100" class="apptdcenter">出资方式</td>
								<td width="100" class="apptdcenter">学历</td>
								<td width="150" class="apptdcenter">职称</td>
								<td width="120" class="apptdcenter">毕业院校</td>
							</tr>
							<c:forEach items="${investmentInvestorList}" var="investor">
							<tr>
								<td class="apptdcenterwhite">&nbsp; ${investor.name}</td>
								<td class="apptdcenterwhite" ><c:if test="${investor.rate!=null}"><fmt:formatNumber value="${investor.rate}" pattern="#0.00"/>%</c:if></td>
								<td class="apptdcenterwhite">&nbsp; ${investor.capital.dataValue}</td>
								<td class="apptdcenterwhite">&nbsp; ${investor.degree.dataValue}</td>
								<td class="apptdcenterwhite">&nbsp; ${investor.profession}</td>
								<td class="apptdcenterwhite">&nbsp; ${investor.school}</td>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="tdleftw">项目概况及预期发展前景： </td>
							</tr>
							<tr>
								<td class="tdleftbg" style="height:50px;">&nbsp;${result.value.projectMemo}</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" style="height:50px;"class="tdleftw">备注</td>
								<td class="tdleftbg">&nbsp;${result.value.memo}</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
	</div>
	</div>
	</div>
	</body>
</html>
