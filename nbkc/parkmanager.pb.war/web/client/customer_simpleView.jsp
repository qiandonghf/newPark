<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
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
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initContect();
	});
	function initContect(){
		$("#contectList").jqGrid({
	    	url:'<%=basePath%>contect!list.action',
			colModel: [
				{label:'姓名', name:'name', align:"center"}, 
			    {label:'手机', name:'mobile', align:"center"}, 
			    {label:'固定电话', name:'phone', align:"center"},
			    {label:'主要联系人', name:'main.title', align:"center"}
			],
			height: 160,
			forceFit: true,
			width: 588,
			postData:{filters:generateSearchFilters("customerId","eq",'${result.value.id}',"long")}	    	
		});
		$("#contectInfoList").jqGrid({
	    	url:'<%=basePath%>contectInfo!list.action',
			colModel: [
			    {label:'企业名称', name:'customer.name', align:"center"}, 
			    {label:'联系人', name:'contect.name', align:"center"},
			    {label:'交往日期', name:'startTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
			    {label:'创建人', name:'creator', align:"center"},
			    {label:'管理', name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: 134,
			forceFit: true,
			width: 588,
			pager: '#pager1',
			multiselect: false,
			postData:{filters:generateSearchFilters("customerId","eq",'${result.value.id}',"long")}, 	
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('contectInfo','"+id+"',650,296);\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('contectInfo','"+id+"',650,391);\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('contectInfo','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager1',{add: false, edit: false, del: false, search: false, refresh: false});
	}
	function viewById(test,id,h,w){
		fbStart('查看交往信息',"<%=basePath%>"+test+"!view.action?id="+id,h,w);
	}
	function editById(test,id,h,w){
		fbStart('编辑交往信息',"<%=basePath%>"+test+"!edit.action?id="+id,h,w);
	}
	function deleteById(test,id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>"+test+"!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				$("#"+test+"List").trigger("reloadGrid");
			});
		}
	}
	function reloadList(test){
		$("#"+test+"List").trigger("reloadGrid");
	}
</script>
</head>
<body>
<div class="basediv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="147" valign="top">
				<jsp:include page="../customer_simpleView_common.jsp">
					<jsp:param value="0" name="index"/>
					<jsp:param value="${result.value.id}" name="customerId"/>
				</jsp:include>
			</td>
			<td valign="top">
				<div class="pm_view_right">
					<div class="basediv" style="margin:0px;">
						<div class="titlebg">基本信息</div>
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">跟踪引进：</td>
									<td class="layerright">${host.realName}</td>
									<td class="layertdleft100">企业编号：</td>
									<td width="35%" class="layerright">${result.value.code}</td>
								</tr>
								<tr>
									<td class="layertdleft100">技术领域：</td>
									<td class="layerright">${result.value.technic.dataValue}</td>
									<td class="layertdleft100">入驻状态：</td>
									<td class="layerright">${result.value.parkStatus.title}</td>
								</tr>
								<tr>
									<td class="layertdleft100">企业类型：</td>
									<td class="layerright">${result.value.type.title}</td>
									<td class="layertdleft100">企业来源：</td>
									<td class="layerright">${result.value.source.dataValue}</td>
								</tr>
								<tr>
									<td class="layertdleft100">企业标签:</td>
									<td colspan="3" class="layerright"><div style=" width:auto; height:50px; overflow-x:hidden; overflow-y:scroll"><c:forEach items="${result.value.labelRefs}" var="labelRef">${labelRef.customerLabel.name}&nbsp;</c:forEach></div></td>
								</tr>
							</table>
						</div>
						<div class="hackbox"></div>
					</div>
					<div class="apptab" id="tableid">
						<ul>
							<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">公司信息</li>
							<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">注册信息</li>
							<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">孵化信息</li>
							<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',3)">联系人</li>
							<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',4)">交往信息</li>
							<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',5)">其它</li>
						</ul>
					</div>
					<div class="basediv tabswitch" style="margin:0px;" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">联系地址：</td>
									<td class="layerright">${result.value.customerInfo.address}</td>
								</tr>
								<tr>
									<td class="layertdleft100">办公电话：</td>
									<td class="layerright">${result.value.customerInfo.officePhone}</td>
								</tr>
								<tr>
									<td class="layertdleft100">传真：</td>
									<td class="layerright">${result.value.customerInfo.fax}</td>
								</tr>
								<tr>
									<td class="layertdleft100">邮编：</td>
									<td class="layerright">${result.value.customerInfo.zipCode}</td>
								</tr>
								<tr>
									<td class="layertdleft100">网址：</td>
									<td class="layerright">${result.value.customerInfo.webSite}</td>
								</tr>
								<tr>
									<td class="layertdleft100">E-mail：</td>
									<td class="layerright">${result.value.customerInfo.email}</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="basediv tabswitch" style="margin:0px; display:none;" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">注册时间：</td>
									<td class="layerright"><fmt:formatDate value="${result.value.customerInfo.regTime}" pattern="yyyy-MM-dd"/></td>
									<td  class="layertdleft100">注册类型：</td>
									<td class="layerright">${result.value.customerInfo.regType.dataValue}</td>
								</tr>
								<tr>
									<td class="layertdleft100">注册资本：</td>
									<td class="layerright">${result.value.customerInfo.regCapital}</td>
									<td class="layertdleft100">币种：</td>
									<td class="layerright">${result.value.customerInfo.currencyType.dataValue}</td>
								</tr>
								<tr>
									<td class="layertdleft100">组织机构代码：</td>
									<td class="layerright">${result.value.customerInfo.organizationNumber}</td>
									<td class="layertdleft100">工商注册号：</td>
									<td class="layerright">${result.value.customerInfo.businessNumber}</td>
								</tr>
								<tr>
									<td class="layertdleft100">税务登记证：</td>
									<td class="layerright">${result.value.customerInfo.taxNumber}</td>
									<td class="layertdleft100">法定代表人：</td>
									<td class="layerright">${result.value.customerInfo.legalPerson}</td>
								</tr>
								<tr>
									<td class="layertdleft100">证件类型：</td>
									<td class="layerright">${result.value.customerInfo.documentType.dataValue}</td>
									<td class="layertdleft100">E-mail：</td>
									<td class="layerright">${result.value.customerInfo.regMail}</td>
								</tr>
								<tr>
									<td class="layertdleft100">证件号：</td>
									<td class="layerright">${result.value.customerInfo.documentNumber}</td>
									<td class="layertdleft100">移动电话：</td>
									<td class="layerright">${result.value.customerInfo.cellphone}</td>
								</tr>
								<tr>
									<td class="layertdleft100">经营范围：</td>
									<td class="layerright">${result.value.customerInfo.businessScope}</td>
									<td class="layertdleft100">营业截至日期：</td>
									<td class="layerright"><fmt:formatDate value="${result.value.customerInfo.businessExpireDate}" pattern="yyyy-MM-dd"/></td>
								</tr>
								<tr>
									<td class="layertdleft100">注册地址：</td>
									<td colspan="3" class="layerright">${result.value.customerInfo.regAddress}</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="basediv tabswitch" style="margin:0px; display:none;" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">是否孵化企业：</td>
									<td class="layerright">${result.value.incubated.title}</td>
									<td class="layertdleft100">孵化状态：</td>
									<td class="layerright">${result.value.incubationInfo.status.title}</td>
								</tr>
								<tr>
									<td class="layertdleft100">孵化日期起：</td>
									<td class="layerright"><fmt:formatDate value="${result.value.incubationInfo.incubationStartDate}" pattern="yyyy-MM-dd"/></td>
									<td class="layertdleft100">孵化日期止：</td>
									<td class="layerright"><fmt:formatDate value="${result.value.incubationInfo.incubationEndDate}" pattern="yyyy-MM-dd"/></td>
								</tr>
								<tr>
									<td class="layertdleft100">毕业日期：</td>
									<td class="layerright"><fmt:formatDate value="${result.value.incubationInfo.graduationDate}" pattern="yyyy-MM-dd"/></td>
									<td class="layertdleft100">孵化协议:</td>
									<td class="layerright">
										<a href="core/resources/${result.value.incubationInfo.agreementDocu}">
										<%
											Result<Customer> r = (Result<Customer>)request.getAttribute("result");
											String agreementDocu = r.getValue().getIncubationInfo().getAgreementDocu();
											agreementDocu = agreementDocu.substring(agreementDocu.lastIndexOf("/")+1);
										%>
										<%=agreementDocu %>
										</a>
									</td>
								</tr>
								<tr>
									<td class="layertdleft100">建立创业导师：</td>
									<td colspan="3" class="layerright">${result.value.incubationInfo.tutorSupport.title}</td>
								</tr>
								<tr>
									<td class="layertdleft100">留学生创业：</td>
									<td colspan="3" class="layerright">${result.value.incubationInfo.overseaEnterprise.title}</td>
								</tr>
								<tr>
									<td class="layertdleft100">高新技术企业：</td>
									<td colspan="3" class="layerright">${result.value.incubationInfo.highTechEnterprise.title}</td>
								</tr>
								<tr>
									<td class="layertdleft100">大学生创业：</td>
									<td colspan="3" class="layerright">${result.value.incubationInfo.undergraduateEnterprise.title}</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="basediv tabswitch" style="margin:0px; display:none;" id="textname">
						<div class="emailtop">
							<div class="leftemail">
								<ul>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建联系人','<%=basePath %>contect!addByCustomerId.action?id=${result.value.id}',550,370);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
								</ul>
							</div>
						</div>
						<table id="contectList" width="100%"><tr><td/></tr></table>
					</div>
					<div class="basediv tabswitch" style="margin:0px; display:none;" id="textname">
						<div class="emailtop">
							<div class="leftemail">
								<ul>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建交往信息','<%=basePath %>contectInfo!addByCustomerId.action?id=${result.value.id}',550,300);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
								</ul>
							</div>
						</div>
						<table id="contectInfoList" width="100%"><tr><td/></tr></table>
						<div id="pager1"></div>
					</div>
					<div class="basediv tabswitch" style="margin:0px;display:none;" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">公司描述：</td>
									<td colspan="3" class="layerright" style="padding-bottom:2px;"><div style="height: 75px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.description}</div></td>
								</tr>
								<tr>
									<td class="layertdleft100">备注：</td>
									<td colspan="3" class="layerright"><div style="height: 75px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.memo}</div></td>
								</tr>
								<tr>
									<td class="layertdleft100" style="white-space:nowrap;">最后修改人:</td>
									<td class="layerright" width="35%" >${result.value.modifier}</td>
									<td class="layertdleft100">最后修改时间：</td>
									<td class="layerright" width="35%" ><fmt:formatDate value="${result.value.modifyTime}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="hackbox"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>