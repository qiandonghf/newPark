<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
				$('#investRight_height').css('height',getTabContentHeight());
				$('#investRight_height2').css('height',getTabContentHeight());
				$('#investRight_height3').css('height',getTabContentHeight()-33);
			});
			
			function edit(id){
				fbStart('编辑法人信息','<%=basePath%>investment!legalEdit.action?id='+id,700,332);
			}
		</script>
		<style>
			table{
				table-layout:fixed;
			}
			#inline_table td{
				height:24px;
			}
		</style>
	</head>

	<body style="padding-bottom: 2px;background-color:#fff;">
		<div class="basediv" id="investRight_height" style="border:0px;margin:0px;">
		<div class="divlays" id="investRight_height2" style="margin:0px;padding:0px;">
		<jsp:include page="common.jsp">
			<jsp:param value="1" name="index"/>
			<jsp:param value="${id}" name="investmentId"/>
		</jsp:include>
		<div class="pm_msglist" id="investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		<div>
			<div class="emailtop">
				<div class="leftemail">
					<ul>
					 <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_businessPlan_legalEdit")||
							 PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_legalEdit")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="edit(${result.value.id})"><span><img src="core/common/images/edit.gif" /></span>编辑</li>
					 <%}%>
					</ul>
				</div>
			</div>
			<div class="apptable" style="border-top:none; border-left:none;border-right:none;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  				<tr>
				        <td class="tdleft">姓名：</td>
				        <td class="tdleftbg">${result.value.name }</td>
				        <td class="tdleft">出生年月：</td>
				        <td class="tdleftbg"><fmt:formatDate value="${result.value.birthDay }" pattern="yyyy-MM-dd" /></td>
				     </tr>
				     <tr>
				        <td class="tdleft">性别：</td>
				        <td class="tdleftbg">${result.value.gender.title }</td>
				        <td class="tdleft">文化程度：</td>
				        <td class="tdleftbg">${result.value.degree.dataValue }</td>
				      </tr>
				      <tr>
				        <td class="tdleft">政治面目：</td>
				        <td class="tdleftbg">${result.value.political.dataValue }</td>
				        <td class="tdleft">技术职称：</td>
				        <td class="tdleftbg">${result.value.profession }</td>
				      </tr>
				      <tr>
				        <td class="tdleft">企业名称：</td>
				        <td class="tdleftbg">${result.value.customer }</td>
				        <td class="tdleft">担任职务：</td>
				        <td class="tdleftbg">${result.value.position }</td>
				      </tr>
				      <tr>
				        <td class="tdleft">原工作单位：</td>
				        <td class="tdleftbg">${result.value.original }</td>
				        <td class="tdleft">离职方式：</td>
				        <td class="tdleftbg">${result.value.leaveBy }</td>
				      </tr>
				      <tr>
				        <td class="tdleft">家庭住址：</td>
				        <td colspan="3" class="tdleftbg">${result.value.address }</td>
				      </tr>
				      <tr>
				        <td class="tdleft">主要学历<br/>（获得何种学位）</td>
				        <td colspan="3" class="tdleftbg" style="padding-bottom:1px;">
				          <div class="inputauto" style="height:50px;border:0px;overflow:hidden;overflow-y:auto;">${result.value.specialty }</div>
				        </td>
				        </tr>
				        <tr>
				        <td class="tdleft">工作简历<br/>（有何发明、论著，获得何种奖励）</td>
				        <td colspan="3" class="tdleftbg" style="padding-bottom:1px;">
				          <div class="inputauto" style="height:70px;border:0px;overflow:hidden;overflow-y:auto;">${result.value.resume }</div>
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
