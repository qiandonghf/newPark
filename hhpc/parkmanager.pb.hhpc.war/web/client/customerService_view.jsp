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
				$(".layerright").css("width","235px");
			});
			
			
			function edit(id){
				fbStart("基本信息编辑","<%=basePath%>customerService!edit.action?id="+id,700,308);
			}
			function del(id){
				if(confirm("确认要删除？")){
					$.post("<%=basePath%>customerService!delete.action?id="+id,function(data){
						showTip(data.result.msg,2000);
						if(data.result.success){
							location.reload();
						}
					});
				}			
			}
			
		</script>
		<style>
			.del_icon{
				overflow:hidden;
				background: url(core/common/images/layerdiv.png) -2px -53px;
				background-repeat: no-repeat;
				width: 15px;
				display: inline-block;
				float: left;
			}
			.apptable .tdleft{
				text-align:right;
			}
			.apptable .layerright{
				border-bottom:#cbcbcb 1px solid;
			}
			.apptable .layerright input{
				color:#666;
			}
		</style>
	</head>

	<body style="padding-bottom: 2px;background-color:#fff;">
		<div class="basediv" id="investRight_height" style="border:0px;margin:0px;">
			<div class="divlays" id="investRight_height2" style="margin:0px;padding:0px;padding-right:5px;">
				<jsp:include page="common.jsp">
					<jsp:param value="0" name="index"/>
					<jsp:param value="${id}" name="customerServiceId"/>
				</jsp:include>
				<div class="pm_msglist" id="investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
					<div>
						<div class="emailtop">
							<div class="leftemail">
								<ul>
								 <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_edit")){ %>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="edit(${result.value.id})"><span><img src="core/common/images/edit.gif" /></span>编辑</li>
								 <%}%>
								 <% if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_delete")){
				               	 %>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="del(${result.value.id },${result.value.creatorId })"><span class="del_icon" style="top:2px;height:18px;"></span>删除</li>
								<%} %>
								</ul>
							</div>
						</div>
						<div class="titlebg2" style="margin:2px 20px 0px 2px;text-align:center;line-height:27px; background:#e1e1e1; color:#000;"><strong>企业服务联系单</strong></div>
						<div class="apptable" style="border:1px solid #e1e1e1;margin-right:20px;margin-left:2px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
				        		<tr>
				        			<td class="tdleft">企业名称：</td>
									<td class="layerright" colspan="3">${result.value.customerName }</td>
							    </tr>
							    <tr>
									<td class="tdleft">联系人：</td>
									<td class="layerright">${result.value.contect }</td>
									<td class="tdleft">服务类型：</td>
									<td class="layerright">${result.value.type.dataValue }</td>
								</tr>
								<tr>
									<td class="tdleft">联系电话：</td>
									<td class="layerright">${result.value.phone }</td>
									<td class="tdleft">受理开始日期：</td>
									<td class="layerright">
										<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd" />			
									</td>
								</tr>
								<tr>
									<td class="tdleft">受理人：</td>
									<td class="layerright">${result.value.user.username }</td>
									<td class="tdleft">受理结束日期：</td>
									<td class="layerright">
										<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd" />
									</td>
								</tr>
								<tr>
									<td class="tdleft">服务结果：</td>
									<td class="layerright">${result.value.result.title }</td>
									<td class="tdleft">状态：</td>
									<td class="layerright">${result.value.status.title }</td>
								</tr>
								<tr>
									<td class="tdleft">情况说明：</td>
									<td class="layerright" colspan="3" style="padding:2px 3px 2px 5px;">
										<textarea style="color:#666;height:40px;padding-left:0px;resize:none;border:0px;" readonly="readonly" class="inputauto">${result.value.description}</textarea>
									</td>
								</tr>
								<tr>
									<td class="tdleft" style="border-bottom:0px;">企业意见及建议：</td>
									<td class="layerright" colspan="3" style="padding:2px 3px 2px 5px;border-bottom:0px;">
										<textarea style="color:#666;height:40px;padding-left:0px;resize:none;border:0px;" readonly="readonly" class="inputauto">${result.value.suggest}</textarea>
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
