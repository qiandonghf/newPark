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
				initTip();
				$('#investRight_height').css('height',getTabContentHeight());
				$('#investRight_height2').css('height',getTabContentHeight());
				$('#investRight_height3').css('height',getTabContentHeight()-33);
				initNums();
			});
			
			function initNums(){
				var nums = "${result.value.staffInfo}";
				var numArray = nums.split(",");
				$(".inlinetdRight").each(function(i){
					$(this).text(numArray[i]);
				});
				checkNums();
			}
			
			function checkNums(){
				var num = 0;
				/*
					第一个循环是各职称的总人数
				*/
				var zz = 0;
				var jz = 0;
				for(var i = 0;i<7;i++){
					var zc1 = Number($(".inlinetdRight").eq(i).text());//某个职称专职
					var zc2 = Number($(".inlinetdRight").eq(i+7).text());//某个职称兼职
					zz += zc1;
					jz += zc2;
					num =zc1+zc2;
					num == 0 ? $(".rightReadOnly").eq(i+1).text("") :$(".rightReadOnly").eq(i+1).text(num);
					zz == 0 ? $(".rightReadOnly").eq(8).text("") :$(".rightReadOnly").eq(8).text(zz);
					jz == 0 ? $(".rightReadOnly").eq(9).text("") :$(".rightReadOnly").eq(9).text(jz);
					zz = Number($(".rightReadOnly").eq(8).text());//专职
					jz =  Number($(".rightReadOnly").eq(9).text());//兼职
				}
				for(var i = 1,num = 0; i <= 7; i++){
					num += Number($(".rightReadOnly").eq(i).text());
				}
				num == 0 ? $(".rightReadOnly").eq(0).text(""):$(".rightReadOnly").eq(0).text(num);//员工总数
			}
			
			
			function edit(id){
				fbStart('编辑申请单','<%=basePath%>investment!edit.action?id='+id,700,479);
			}
			
			function del(id,uid){
				var cid = '<%=PbActivator.getSessionUser().getId() %>';
				if(cid != uid){
					showTip("只能删除本人创建的申请单",2000);
					return;
				}
				if(confirm("确定要删除吗")){
					$.post("<%=basePath%>investment!delete.action?id="+id,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.location.reload();", 2000);
			        	}
					});
				}
			}
		</script>
		<style>
			table{
				table-layout:fixed;
			}
			#inline_table td{
				height:24px;
			}
			#inline_table .tdleft2{
				background-color:#f2f2f2;
				border-right:1px solid #ddd;;
				border-bottom:1px solid #ddd;;
				color:#666;
			}
			#inline_table .inlinetdRight{
				border-bottom:1px solid #ddd;;
				border-right:1px solid #ddd;;
				padding-right:4px;
				padding-left:2px;
				color: #666;
			}
			.inlinetdRight input{
				text-align:center;
				width:100%;
				border: 0px;
				border-bottom: 1px solid #666;
			}
			#inline_table .rightReadOnly{
				border-bottom:1px solid #ddd;;
				border-right:1px solid #ddd;;
				padding-right:4px;
				padding-left:2px;
				color: #666;
			}
			.rightReadOnly input{
				text-align:center;
				width:100%;
				border: 0px;
				border-bottom: 1px solid #666;
			}
			.del_icon{
				overflow:hidden;
				background: url(core/common/images/layerdiv.png) -2px -53px;
				background-repeat: no-repeat;
				width: 15px;
				display: inline-block;
				float: left;
			}
			.apptable .tdleft{
				width:120px;
				text-align:right;
			}
			.pm_msglist{
				margin-right:8px;
			}
		</style>
	</head>

	<body style="padding-bottom: 2px;background-color:#fff;">
		<div class="basediv" id="investRight_height" style="border:0px;margin:0px;">
		<div class="divlays" id="investRight_height2" style="margin:0px;padding:0px;">
		<jsp:include page="common.jsp">
			<jsp:param value="0" name="index"/>
			<jsp:param value="${id}" name="investmentId"/>
		</jsp:include>
		<div class="pm_msglist" id="investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		<div>
			<div class="emailtop">
				<div class="leftemail">
					<ul>
					 <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_editBasic")||
							 PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_incubation_editBasic")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="edit(${result.value.id})"><span><img src="core/common/images/edit.gif" /></span>编辑</li>
					 <%}%>
					 <% if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_delete") ||
							PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_incubation_delete")){
	               	 %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="del(${result.value.id },${result.value.creatorId })"><span class="del_icon" style="top:2px;height:18px;"></span>删除</li>
					<%} %>
					</ul>
				</div>
			</div>
			<div class="apptable" style="border-top:none; border-left:none;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        		<tr>
				        <td class="tdleft">企业名称：</td>
				        <td class="tdleftbg">${result.value.name }</td>
				        <td class="tdleft">企业类型：</td>
				        <td class="tdleftbg">${result.value.type }</td>
				    </tr>
					<tr>
						<td class="tdleft">详细地址：</td>
						<td class="tdleftbg">${result.value.address }</td>
						<td class="tdleft">办公场地面积：</td>
						<td class="tdleftbg">${result.value.officeArea }</td>
					</tr>
					<tr>
				        <td class="tdleft">法定代表人：</td>
				        <td class="tdleftbg">${result.value.legalPerson }</td>
				        <td class="tdleft">联系人：</td>
				        <td class="tdleftbg">${result.value.contactPerson }</td>
      			   </tr>
      			   <tr>
				        <td class="tdleft">法定代表人联系电话：</td>
				        <td class="tdleftbg">${result.value.legalPersonPhone }</td>
				        <td class="tdleft">联系人联系电话：</td>
				        <td class="tdleftbg">${result.value.contactPhone }</td>
       			   </tr>
       			   <tr>
						<td class="tdleft">法定代表人E-mail：</td>
						<td class="tdleftbg">${result.value.legalPersonEmail }</td>
						<td class="tdleft">联系人E-mail：</td>
						<td class="tdleftbg">${result.value.contactEmail }</td>
				   </tr>
				   <tr>
				        <td class="tdleft">项目名称：</td>
				        <td colspan="3" class="tdleftbg">${result.value.projectName }</td>
			       </tr>
			       <tr>
						<td colspan="4">
							<table id="inline_table" width="100%" border="0" cellspacing="0" cellpadding="0">
					          <tr>
					            <td class="tdleft" rowspan="5" colspan="2" align="center" valign="middle">企业职工人员状况：</td>
					            <td class="tdleft2" colspan="2" rowspan="2" align="center" valign="middle">人员构成</td>
					            <td class="tdleft2" colspan="2" rowspan="2" align="center" valign="middle">职工总数</td>
					            <td class="tdleft2" colspan="4" align="center" valign="middle">科技人员</td>
					            <td class="tdleft2" colspan="2" align="center" valign="middle">财务人员</td>
					            <td class="tdleft2" rowspan="2" align="center" valign="middle">其<br/>他</td>
					          </tr>
					          <tr>
					            <td class="tdleft2" align="center" valign="middle">博士</td>
					            <td class="tdleft2" align="center" valign="middle">硕士</td>
					            <td class="tdleft2" align="center" valign="middle">本科</td>
					            <td class="tdleft2" align="center" valign="middle">大专</td>
					            <td class="tdleft2" align="center" valign="middle">会计</td>
					            <td class="tdleft2" align="center" valign="middle">出纳</td>
					          </tr>
					          <tr>
					            <td class="tdleft2" colspan="2" align="center" valign="middle">总&nbsp;&nbsp;数</td>
					            <td class="rightReadOnly" colspan="2" align="center" valign="middle"></td>
					            <td class="rightReadOnly" align="center" valign="middle"></td>
					            <td class="rightReadOnly" align="center" valign="middle"></td>
					            <td class="rightReadOnly" align="center" valign="middle"></td>
					            <td class="rightReadOnly" align="center" valign="middle"></td>
					            <td class="rightReadOnly" align="center" valign="middle"></td>
					            <td class="rightReadOnly" align="center" valign="middle"></td>
					            <td class="rightReadOnly" align="center" valign="middle"></td>
					          </tr>
					          <tr>
					            <td class="tdleft2" rowspan="2" align="center" valign="middle">其<br/>中</td>
					            <td class="tdleft2" align="center" valign="middle">专职</td>
					            <td class="rightReadOnly" colspan="2" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					          </tr>
					          <tr>
					            <td class="tdleft2" align="center" valign="middle">兼职</td>
					            <td class="rightReadOnly" colspan="2" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					            <td class="inlinetdRight" align="center" valign="middle"></td>
					          </tr>
							</table>
						</td>
			       </tr>
			       <tr>
				        <td class="tdleft">项目的技术特点、<br/>市场状况</td>
        				<td colspan="3" class="tdleftbg">
          					<div class="inputauto" style="border:0px;height:40px;overflow:hidden;overflow-y:auto;">${result.value.marketSituation}</div>
          				</td>
			       </tr>
			       <tr>
				        <td class="tdleft" >项目的来源说明和知识产权情况</td>
				        <td colspan="3" class="tdleftbg">
          					<div class="inputauto" style="border:0px;height:40px;overflow:hidden;overflow-y:auto;">${result.value.propertyRight}</div>
				        </td>
				   </tr>
				   <tr>
				        <td class="tdleft">经营范围</td>
				        <td colspan="3" class="tdleftbg">
          					<div class="inputauto" style="border:0px;height:40px;overflow:hidden;overflow-y:auto;">${result.value.businessScope}</div>
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
