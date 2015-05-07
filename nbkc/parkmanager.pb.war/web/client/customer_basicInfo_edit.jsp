<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initForm();	
		initCustomerModifyLogList();
		initPolicyList();
		parent.document.getElementById("fbCaption").innerHTML="${result.value.name}";
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"customer.name":{
					required: true
				},
				"customer.sourceId":"required",
			},
			messages: {
				
				"customer.name":{
					required: "请输入企业名称"
				},
				"customer.sourceId":"请选择企业来源",
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				var strs =document.getElementsByName("customerQualificationId");
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
			        	showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}

	function reloadPolicyList(){
		$("#policyList").trigger("reloadGrid");
	}
	function initPolicyList(){
		$("#policyList").jqGrid({
	    	url:'<%=basePath%>customerPolicy!list.action',
			colModel: [
				{label:'年度', name:'policy.year',sortable:false, align:"center",width:40}, 
			    {label:'过期', name:'overdue.title',sortable:false, align:"center",width:40}, 
			    {label:'类型', name:'policy.type.dataValue',sortable:false, align:"center",width:40}, 
			    {label:'内容', name:'content',sortable:false, align:"center"}
			    <%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
			    ,{label:'管理', name:'manager',sortable:false, align:"center",width:30}
			    <%} %>
			],
			height: 200,
			forceFit: true,
			width: 698,
			rowNum: 0,
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
	function editPolicyById(id){
		$.post("<%=basePath%>customerPolicy!overdue.action?id="+id,function(data){
			reloadPolicyList();
		});	
	}
	function deletePolicyById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>customerPolicy!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				reloadPolicyList();
			});
		}
	}
	function reloadModifyLogList(){
		$("#customerModifyLogList").trigger("reloadGrid");
	}
	function initCustomerModifyLogList(){
		$("#customerModifyLogList").jqGrid({
	    	url:'<%=basePath%>customerModifyLog!list.action',
			colModel: [
				{label:'变更信息', name:'content',sortable:false, align:"center"}, 
			    {label:'变更时间', name:'modifyLogTime',sortable:false, align:"center",width:40,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"}, 
			    {label:'操作人', name:'creator',sortable:false, align:"center",width:40},
			    {label:'管理', name:'manager',sortable:false, align:"center",width:30}
			],
			height: 110,
			forceFit: true,
			width: 698,
			rowNum: 0,
			postData:{filters:generateSearchFilters("customerId","eq",'${result.value.id}',"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editLogById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteLogById("+id+");\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewLogById(id){
		fbStart('查看变更信息',"<%=basePath%>customerModifyLog!view.action?id="+id,500,300);
	}
	function editLogById(id){
		fbStart('编辑变更信息',"<%=basePath%>customerModifyLog!edit.action?id="+id,500,250);
	}
	function deleteLogById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>customerModifyLog!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				$("#customerModifyLogList").trigger("reloadGrid");
			});
		}
	}
	

</script>
</head>
<body>
<div class="basediv">
<div>
	<table width="100%" border="0" cellspacing="0">
		<tr>
			<td width="140" valign="top">
				<jsp:include page="../customer_view_common2.jsp">
					<jsp:param value="0" name="index"/>
					<jsp:param value="${result.value.id}" name="customerId"/>
				</jsp:include>
			</td>
			<td valign="top">
				<div class="pm_view_right" style="height: 432px;">  
					<form action="<%=basePath %>customer!couUpdate.action" method="post" name="form1" id="form1">
						<input id="ids" name="ids" value="${ids}" type="hidden"/>
						<input id="agreementName" name="incubationInfo.agreementName" value="${result.value.incubationInfo.agreementName}" type="hidden"/>
						<input name="customer.id" value="${result.value.id}" type="hidden"/>
						<input name="customerInfo.id" value="${result.value.customerInfo.id}" type="hidden"/>
						<input name="incubationInfo.id" value="${result.value.incubationInfo.id}" type="hidden"/>
						<div id="scrollDiv">
						<div class="basediv">
							<div class="titlebg">企业基本信息</div>
							<div class="divlays" style="margin:0px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
										<td width="35%" class="layerright"><input id="name" name="customer.name" type="text" class="inputauto" value="${result.value.name}"/></td>
										<td class="layertdleft100"><span class="psred"></span>企业曾用名：</td>
										<td width="35%" class="layerright"><input id="formerName" name="customer.formerName" type="text" class="inputauto" value="${result.value.formerName}"/></td>
									</tr>
								</table>
							</div>
							<div class="hackbox"></div>
						</div>
						<div style="height:260px;">
							<div class="apptab" id="tableid">
								<ul>
									<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">公司信息</li>
									<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">注册信息</li>
									<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">招商信息</li>
								</ul>
							</div>
							<div class="basediv tabswitch" style="margin-top:0px;height:230px;" id="textname">
								<div class="divlays" style="margin:0px;">
							    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class="layertdleft100">联系地址：</td>
											<td width="25%" class="layerright"><input name="customerInfo.address" value="${result.value.customerInfo.address}" type="text" class="inputauto"/></td>
											<td rowspan="6" style="vertical-align:top; padding-left:2px;">
									        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
									              <tr>
									                <td class="layertdleft100" style="text-align:left; padding-left:10px;">企业总人数：</td>
									                <td class="layerright" colspan="3"><label><input name="customerInfo.userCount" value="${result.value.customerInfo.userCount }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									              </tr>
									              <tr>
									                <td class="layertdleft100" style="text-indent:10px;"><span style="float:left;">其中</span>博士后：</td>
									                <td class="layerright"><label><input name="customerInfo.userbsh" value="${result.value.customerInfo.userbsh }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									                <td class="layertdleft100">博士：</td>
									                <td class="layerright"><label><input name="customerInfo.userbs" value="${result.value.customerInfo.userbs }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									              </tr>
									              <tr>
									                <td class="layertdleft100">硕士：</td>
									                <td class="layerright"><label><input name="customerInfo.userss" value="${result.value.customerInfo.userss }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									                <td class="layertdleft100">本科：</td>
									                <td class="layerright"><label><input name="customerInfo.userbk" value="${result.value.customerInfo.userbk }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									              </tr>
									              <tr>
									                <td class="layertdleft100">高级职称：</td>
									                <td class="layerright"><label><input name="customerInfo.usergj" value="${result.value.customerInfo.usergj }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									                <td class="layertdleft100">中级职称：</td>
									                <td class="layerright"><label><input name="customerInfo.userzj" value="${result.value.customerInfo.userzj }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')" /></label></td>
									              </tr>
									              <tr>
									                <td class="layertdleft100">初级职称：</td>
									                <td class="layerright"><label><input name="customerInfo.usercj" value="${result.value.customerInfo.usercj }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									                <td class="layertdleft100">其他：</td>
									                <td class="layerright"><label><input name="customerInfo.userqt" value="${result.value.customerInfo.userqt }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									              </tr>
									              <tr>
									                <td class="layertdleft100">留学生：</td>
									                <td class="layerright" colspan="3"><label><input name="customerInfo.userlxs" value="${result.value.customerInfo.userlxs }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
									              </tr>
									            </table>
									        </td>
										</tr>
										<tr>
											<td class="layertdleft100">办公电话：</td>
											<td><input name="customerInfo.officePhone" value="${result.value.customerInfo.officePhone}" type="text" class="input220" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">传真：</td>
											<td><input name="customerInfo.fax" value="${result.value.customerInfo.fax}" type="text" class="input220" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">邮编：</td>
											<td><input name="customerInfo.zipCode" value="${result.value.customerInfo.zipCode}" type="text" class="input220" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">网址：</td>
											<td><input name="customerInfo.webSite" value="${result.value.customerInfo.webSite}" type="text" class="input220" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">E-mail：</td>
											<td><input name="customerInfo.email" value="${result.value.customerInfo.email}" type="text" class="input220" /></td>
										</tr>
									</table>
								</div>
							</div>
							<div class="basediv tabswitch" style="margin-top:0px; display:none;" id="textname">
								<div class="divlays" style="margin:0px;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class="layertdleft100">注册时间：</td>
											<td width="35%" class="layerright">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><input id="regTime" name="customerInfo.regTime" readonly="readonly" value="<fmt:formatDate value="${result.value.customerInfo.regTime}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('regTime');"/></td>
														<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('regTime');"/></td>
													</tr>
												</table>
											</td>
											<td class="layertdleft100">注册类型：</td>
											<td width="35%" class="layerright"><dd:select name="customerInfo.regTypeId" key="crm.0004" checked="result.value.customerInfo.regTypeId"/></td>
										</tr>
										<tr>
											<td class="layertdleft100">注册资本：</td>
											<td class="layerright"><input name="customerInfo.regCapital" value="<fmt:formatNumber value="${result.value.customerInfo.regCapital}" pattern="#0.00"/>" type="text" style="width:100px;" class="inputauto" /> 万元  <dd:select name="customerInfo.currencyTypeId" checked="result.value.customerInfo.currencyTypeId" key="crm.0005"/></td>
											<td class="layertdleft100">工商注册号：</td>
											<td class="layerright"><input name="customerInfo.businessNumber" value="${result.value.customerInfo.businessNumber}" type="text" class="inputauto" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">组织机构代码：</td>
											<td class="layerright"><input name="customerInfo.organizationNumber" value="${result.value.customerInfo.organizationNumber}" type="text" class="inputauto" /></td>
											<td class="layertdleft100">法定代表人：</td>
											<td class="layerright"><input name="customerInfo.legalPerson" value="${result.value.customerInfo.legalPerson}" type="text" class="inputauto" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">国税登记号：</td>
											<td width="35%" class="layerright"><input id="taxNumberG" name="customerInfo.taxNumberG" value="${result.value.customerInfo.taxNumberG }" type="text" class="inputauto" /></td>
											<td class="layertdleft100">地税登记号：</td>
											<td width="35%" class="layerright"><input id="taxNumberD" name="customerInfo.taxNumberD" value="${result.value.customerInfo.taxNumberD }" type="text" class="inputauto" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">法人证件类型：</td>
											<td class="layerright"><dd:select name="customerInfo.documentTypeId" key="crm.0006" checked="result.value.customerInfo.documentTypeId"/></td>
											<td class="layertdleft100">E-mail：</td>
											<td class="layerright"><input name="customerInfo.regMail" value="${result.value.customerInfo.regMail}" type="text" class="inputauto" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">证件号：</td>
											<td class="layerright"><input name="customerInfo.documentNumber" value="${result.value.customerInfo.documentNumber}" type="text" class="inputauto" /></td>
											<td class="layertdleft100">移动电话：</td>
											<td class="layerright"><input name="customerInfo.cellphone" value="${result.value.customerInfo.cellphone}" type="text" class="inputauto" /></td>
										</tr>
										<tr>
											<td class="layertdleft100">注册地址：</td>
											<td class="layerright"><input name="customerInfo.regAddress" value="${result.value.customerInfo.regAddress}" type="text" class="inputauto" /></td>
											<td class="layertdleft100">营业截至日期：</td>
											<td class="layerright">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><input id="businessExpireDate" readonly="readonly" name="customerInfo.businessExpireDate" value="<fmt:formatDate value="${result.value.customerInfo.businessExpireDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('businessExpireDate');"/></td>
														<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('businessExpireDate');"/></td>
													</tr>
							        			</table>
							        		</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="basediv tabswitch" style="margin-top:0px; display:none;" id="textname">
								<div class="divlays" style="margin:0px;">
							    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
									        <td class="layertdleft100" style="white-space:nowrap;">企业实际注资：</td>
									        <td width="35%" class="layerright"><input name="customerInfo.realCapital" value="${result.value.customerInfo.realCapital }" type="text" class="inputauto" style="width:100px;" /> 万元</td>
									        <td class="layertdleft100">一般纳税人：</td>
											<td width="35%" class="layerright"><enum:radio styleClass="incubated" name="customerInfo.ybnsr" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.customerInfo.ybnsr"/></td>
										</tr>
										<tr>
											<td class="layertdleft100">引进时间：</td>
											<td class="layerright">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="20px;"><input id="parkTime" readonly="readonly" value="<fmt:formatDate value="${result.value.parkTime}" pattern="yyyy-MM-dd"/>" name="customer.parkTime" type="text" class="inputauto" onclick="showCalendar('parkTime');"/></td>
														<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('parkTime');"/></td>
													</tr>
							        			</table>
							        		</td>
											<td class="layertdleft100">自营进出口权：</td>
											<td width="35%" class="layerright"><enum:radio styleClass="incubated" name="customerInfo.zyjck" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.customerInfo.zyjck"/></td>
										</tr>
										<tr>
											<td class="layertdleft100">上报类型：</td>
											<td class="layerright"><enum:select id="reportType" name="customer.reportType" type="com.wiiy.crm.preferences.enums.CustomerRouteTypeEnum" checked="result.value.reportType"/></td>
											<td class="layertdleft100">是否园区内：</td>
											<td width="35%" class="layerright"><enum:radio styleClass="incubated" name="customerInfo.inPark" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.customerInfo.inPark"/></td>
										</tr>
										<tr>
											<td class="layertdleft100">纳税所在地：</td>
											<td width="35%" class="layerright"><dd:select id="taxAddressId" name="customerInfo.taxAddressId" key="crm.0028" checked="result.value.customerInfo.taxAddressId"/></td>
											<td class="layertdleft100">是否大厦内：</td>
											<td width="35%" class="layerright"><enum:radio styleClass="incubated" name="customerInfo.inBuild" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.customerInfo.inBuild"/></td>
										</tr>
										<tr>
											<td class="layertdleft100">股东构成：</td>
											<td colspan="3" class="layerright" style="padding-bottom:2px;"><textarea id="shareholder" name="customerInfo.shareholder"  class="textareaauto" style="height:20px;">${result.value.customerInfo.shareholder }</textarea></td>
										</tr>
										<tr>
											<td class="layertdleft100">经营地址：</td>
											<td colspan="3" class="layerright" ><textarea name="customerInfo.managerAddress"  class="textareaauto" style="height:20px;">${result.value.customerInfo.address }</textarea></td>
										</tr>
										<tr>
											<td class="layertdleft100">经营范围：</td>
											<td colspan="3"  class="layerright">
											<textarea name="customerInfo.businessScope"  class="textareaauto"  style="height:40px;">${result.value.customerInfo.businessScope}</textarea>
											</td>
										</tr>
									</table>
								</div>
							</div>
							
							
							
						</div>
						<div class="buttondiv">
							<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
							<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end()"/></label>
						</div>
						</div>
					</form>
					<div class="hackbox"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</div>
<div style="height: 5px;"></div>
</body>
</html>