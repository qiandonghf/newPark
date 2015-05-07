<%@page import="com.wiiy.pb.activator.PbActivator"%>
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
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		
		<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
		<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
		<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
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
				initForm();
				initDirectorList();
				initInvestmentInvestorList();
				$("#needOffice").change(function(){
					if($(this).val()=='' || $(this).val()=="NO"){
						$("#time").hide();
					} else {
						$("#time").show();
					}
				});
			});
			
			function initDirectorList(){
				$("#directorList").jqGrid({
			    	url:'<%=basePath%>investmentDirector!list.action?id=${result.value.id}',
					colModel: [
						{label:'姓名', name:'name', align:"center"}, 
						{label:'学历', name:'degree.dataValue', align:"center"},
						{label:'专业', name:'specialty', align:"center"},
						{label:'学位或职称', name:'profession', align:"center"},
					    {label:'手机', name:'mobile', align:"center"},
					    {label:'固定电话', name:'phone', align:"center"},
					    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false}
					],
					height: 120,
					width: 690,
					gridComplete: function(){
						var ids = $(this).jqGrid('getDataIDs');
						for(var i = 0 ; i < ids.length; i++){
							var id = ids[i];
							var content = "";
							content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewDirectorById('"+id+"');\"  /> "; 
							content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editDirectorById('"+id+"');\"  /> "; 
							content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteDirectorById('"+id+"');\"  /> ";
							$(this).jqGrid('setRowData',id,{manager:content});
						}
					},
				});
			}
			
			function initInvestmentInvestorList(){
				$("#investmentInvestorList").jqGrid({
			    	url:'<%=basePath%>investmentInvestor!list.action',
					colModel: [
						{label:'投资方', name:'name', align:"center"}, 
						{label:'出资比例', name:'rate', align:"center",formatter:rateFormat}, 
					    {label:'出资方式', name:'capital.dataValue', align:"center"}, 
					    {label:'出生年月', name:'birthDay', align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
					    {label:'学历', name:'degree.dataValue', align:"center"},
					    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false}
					],
					height: 120,
					width: 690,
					gridComplete: function(){
						var ids = $(this).jqGrid('getDataIDs');
						for(var i = 0 ; i < ids.length; i++){
							var id = ids[i];
							var content = "";
							content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
							content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editInvestorById('"+id+"');\"  /> "; 
							content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteInvestorById('"+id+"');\"  /> ";
							$(this).jqGrid('setRowData',id,{manager:content});
						}
					},
					postData: {filters:generateSearchFilters("investmentId","eq",${result.value.id},"long")}
				});
			}
			function rateFormat(cellvalue, options, rowObject){
				if(cellvalue!=null) return (cellvalue.toFixed(2))+"%";
				return "&nbsp;";
			}
			function viewById(id){
				fbStart('投资人信息','<%=basePath %>investmentInvestor!view.action?id='+id,450,251);
			}
			function editDirectorById(id){
				fbStart('负责人信息','<%=basePath %>investmentDirector!edit.action?id='+id,450,251);
			}
			function viewDirectorById(id){
				fbStart('负责人信息','<%=basePath %>investmentDirector!view.action?id='+id,450,251);
			}
			function editInvestorById(id){
				fbStart('投资人信息','<%=basePath %>investmentInvestor!edit.action?id='+id,450,251);
			}
			function deleteDirectorById(id){
				if(confirm("确定要删吗")){
					$.post("<%=basePath%>investmentDirector!delete.action?id="+id,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		reloadInvestmentDirectorList();
			        	}
					});
				}
			}
			function deleteInvestorById(id){
				if(confirm("确定要删吗")){
					$.post("<%=basePath%>investmentInvestor!delete.action?id="+id,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		reloadInvestmentInvestorList();
			        	}
					});
				}
			}
			function deleteSelected(){
				var ids = $("#investmentInvestorList").jqGrid("getGridParam","selarrrow");
				if(ids!='' && confirm("确定要删吗")){
					$.post("<%=basePath%>investmentInvestor!delete.action?ids="+ids,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		reloadInvestmentInvestorList();
			        	}
					});
				}
			}
			function reloadInitDirectorList(invesmentId){
				$("#directorList").setGridParam({url:'<%=basePath%>investmentDirector!list.action?id='+invesmentId}).trigger('reloadGrid');
			}
			function reloadInvestmentDirectorList(){
				$("#directorList").trigger('reloadGrid');
			}
			function reloadInvestmentInvestorList(){
				$("#investmentInvestorList").trigger('reloadGrid');
			}
			function initForm(){
				$("#form1").validate({
					rules: {
						"investment.name":"required",
						//"investment.account":"required",
						"investment.staff":{required:true,positiveinteger:true},
						"investment.regCapital":{required:true,number:true},
						"investment.currencyId":"required",
						"investment.investCapital":{required:true,number:true},
						"investment.outputValue":{required:true,number:true},
						"investment.hostName":"required",
						"investment.importName":"required"
					},
					messages: {
						"investment.name":"请输入单位名称",
						//"investment.account":"请输入企业帐号",
						"investment.staff":"请输入正确的企业人数",
						"investment.regCapital":"请输入正确的注册资本",
						"investment.currencyId":"请选择注册资本币种",
						"investment.investCapital":"请输入正确的计划总投资",
						"investment.outputValue":"请输入正确的预计年产值",
						"investment.hostName":"请选择跟踪人",
						"investment.importName":"请选择引进人"
					},
					errorPlacement: function(error, element){
						showTip(error.html());
					},
					submitHandler: function(form){
						if($("#needOffice").val()==""||$("#needOffice").val()=="NO"){
							$("#officeArea").val("");	
							$("#officeName").val("");	
						}
						$(form).ajaxSubmit({
					        dataType: 'json',		        
					        success: function(data){
				        		var cusId = $("#cusId").val();
				        		showTip(data.result.msg,2000);
				        		if(data.result.success){
					        		setTimeout("getOpener().reloadPage('"+cusId+"');fb.end();", 2000);
					        	};
					        } 
					    });
					}
				});
			}
			function generateCode(){
				$.post("<%=basePath%>investment!generateCode.action",function(data){
					if(data.result.success){
						$("#code").val(data.result.value);
					}
				});
			}
			function setSelectedUser(user){
				if(userType==1){
				$("#hostId").val(user.id);
				$("#hostName").val(user.realName);
				}else if(userType==2){
					$("#importId").val(user.id);
					$("#importName").val(user.realName);
				}
			}
			function selectUser(obj){
				userType=obj;
				fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!selectSelf.action',520,400);
			}
			
			function getCalendarScrollTop(){
				return $("#scrollDiv").scrollTop();
			}
		</script>
	</head>

	<body>
		<form action="<%=basePath %>investment!update.action" method="post" name="form1" id="form1">
			<input id="investmentId" name="investment.id" type="hidden" value="${result.value.id}"/>
			<input id="directorId" name="investmentDirector.id" type="hidden" value="${result.value.id}"/>
			<%--zhf--%>
			<div id="scrollDiv" style="position:relative;">			
				<div class="basediv">
					<input type="hidden" id="cusId" value="${param.id }" />
					<div class="titlebg">基本信息</div>
					<div class="divlays" style="margin:0px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="layertdleft120"><div style="width: 120px"><span class="psred">*</span>拟注册单位名称：</div></td>
								<td colspan="3" class="layerright"><input name="investment.name" type="text" class="inputauto" value="${result.value.name}"/></td>
								<%-- <td class="layertdleft120"><span class="psred">*</span>企业帐号：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="80"><input name="investment.account" type="text" class="inputauto" value="${result.value.account}"/><input id="code" name="investment.code" type="hidden" class="inputauto" value="${result.value.code}"/></td>
											<td width="40" align="center"></td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td> --%>
							</tr>
							<%-- <tr>
								<td class="layertdleft120">企业人数：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="80"><input name="investment.staff" type="text" class="inputauto" value="${result.value.staff}"/></td>
											<td width="40" align="center">人</td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
								<td class="layertdleft120">企业编号：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120"><input id="code" name="investment.code" type="text" class="inputauto" value="${result.value.code}"/></td>
											<td width="85" align="center"><img src="core/common/images/auto.gif" width="75" height="22" style="cursor:pointer;" onclick="generateCode()"/></td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr> --%>
							<tr>
								<td class="layertdleft120"><span class="psred">*</span>注册资本：</td>
								<td width="35%" class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="80"><input name="investment.regCapital" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.regCapital}" pattern="#0.00"/>" /></td>
											<td width="105" align="center"><dd:select key="crm.0005" id="currencyId" name="investment.currencyId" checked="result.value.currencyId"/></td>
											<td>万元</td>
										</tr>
									</table>
								</td>
								<td class="layertdleft120"><span class="psred">*</span>企业人数：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="80"><input name="investment.staff" type="text" class="inputauto" value="${result.value.staff}"/><input id="code" name="investment.code" type="hidden" class="inputauto" value="${result.value.code}"/></td>
											<td width="40" align="center">人</td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="layertdleft120">申请用房：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><enum:select id="needOffice" type="com.wiiy.commons.preferences.enums.BooleanEnum" name="investment.needOffice" checked="result.value.needOffice"/></td>
											<td width="150">
												<table id="time" class="layerright" <c:if test="${result.value.needOffice != 'YES'}">style="display:none;"</c:if> ><tr>
													<td>&nbsp;<input id="officeArea" name="investment.officeArea" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.officeArea}" pattern="#0.00"/>"/></td>
													<td width="40" align="center">㎡</td></tr></table>
											</td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
								
								<td class="layertdleft120"><span class="psred">*</span>计划总投资：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="80"><input name="investment.investCapital" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.investCapital}" pattern="#0.00"/>"/></td>
											<td width="40" align="center">万元</td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="layertdleft120">行业分类：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100"><dd:select id="technicId" name="investment.technicId" key="crm.0002" checked="result.value.technicId"/></td>
										</tr>
									</table>
								</td>
								<td class="layertdleft120">房间名称：</td>
								<td class="layerright"><div style="width: 110px"><input id="officeName" name="investment.officeName" type="text" value="${result.value.officeName }" class="inputauto"/></div></td>
							</tr>
							<tr>
							<td class="layertdleft120"><span class="psred">*</span>预计年产值：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="80"><input name="investment.outputValue" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.outputValue}" pattern="#0.00"/>"/></td>
											<td width="40" align="center">万元</td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
								<td class="layertdleft120">入驻场所：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100"><dd:select id="incubateConfigId" name="investment.incubateConfigId" key="crm.0026" checked="result.value.incubateConfigId"/></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="layertdleft120"><span class="psred">*</span>跟踪人：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="35"><input id="hostId" name="investment.hostId" type="hidden" class="inputauto" value="${result.value.hostId}"/><input id="hostName" name="investment.hostName" value="${result.value.hostName}" readonly="readonly" type="text" class="inputauto" onclick="selectUser(1)" /></td>
											<td width="25" ><img style="position: relative;left:-1px;" onclick="selectUser(1)" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
										</tr>
									</table>
								</td>
								<td class="layertdleft120"><span class="psred">*</span>引进人：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="35"><input id="importId" name="investment.importId" type="hidden" class="inputauto" value="${result.value.importId}"/><input id="importName" name="investment.importName" value="${result.value.importName}" readonly="readonly" type="text" class="inputauto" onclick="selectUser(2)" /></td>
											<td width="25" ><img style="position: relative;left:-1px;" onclick="selectUser(2)" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="layertdleft120">企业类型：</td>
								<td colspan="3" class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="white-space:nowrap;" width="100"><dd:checkbox name="enterpriseTypeIds" key="crm.0030" checked="typeIds"/></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="layertdleft120">实际办公地址：</td>
								<td colspan="3" class="layerright" style="padding-top:2px;"><textarea name="investment.address" class="textareaauto" style="height:40px;">${result.value.address }</textarea></td>
							</tr>
							<tr>
								<td class="layertdleft120">项目概况：</td>
								<td colspan="3" class="layerright" style="padding-top:2px;"><textarea name="investment.projectMemo"  class="textareaauto"  style="height:40px;">${result.value.projectMemo}</textarea></td>
							</tr>
							<tr>
								<td class="layertdleft120">经营范围：</td>
								<td colspan="3" class="layerright" style="padding-top:2px;"><textarea name="investment.businessScope"  class="textareaauto"  style="height:40px;">${result.value.businessScope}</textarea></td>
							</tr>
							<tr>
								<td class="layertdleft120">备注：</td>
								<td colspan="3" class="layerright" style="padding-top:2px;"> <textarea name="investment.memo"  class="textareaauto"  style="height:20px;">${result.value.memo}</textarea></td>
							</tr>
						</table>
					</div>
					<div class="hackbox"></div>
				</div>
				<div>
					<div class="apptab" id="tableid">
						<ul>
							<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">负责人信息</li>
							<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">投资人信息</li>
							<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">注册信息</li>
						</ul>
					</div>
					<div class="basediv tabswitch" style="margin-top:0px; display:block;" id="textname">
						<div class="emailtop">
							<div id="director" class="leftemail">
								<ul>
								<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_director_allAdd")){ %>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('负责人信息','<%=basePath %>web/investment/investmentDirector_add.jsp?investmentId='+$('#investmentId').val(),450,206);"><span><img src="core/common/images/emailadd.gif" /></span>添加</li>
								<%}%>
								<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_director_allDelete")){ %>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png" /></span>删除</li>
								<%}%>
								</ul>
							</div>
						</div>
						<table id="directorList"><tr><td></td></tr></table>
					</div>
					<div class="basediv tabswitch" style="margin-top:0px; display:none;" name="textname" id="textname">
						<div class="emailtop">
							<div class="leftemail">
								<ul>
								<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_investor_allAdd")){ %>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('投资人信息','<%=basePath %>web/investment/investmentInvestor_add.jsp?investmentId='+$('#investmentId').val(),450,251);"><span><img src="core/common/images/emailadd.gif" /></span>添加</li>
								<%}%>
								<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_investor_allDelete")){ %>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png" /></span>删除</li>
								<%}%>
								</ul>
							</div>
						</div>
						<table id="investmentInvestorList"><tr><td></td></tr></table>
					</div>
					<%--zhf--%>
					<div class="basediv tabswitch" style="margin-top:0px; display:none;height:172px;overflow-y:scroll;" name="textname" id="textname">
					<input type="hidden" value="${result.value.regInfo.id}" name="investmentRegInfo.id"/>
					<div class="divlays" style="margin:0px;">
				    <table width="100%" border="0" cellspacing="0" cellpadding="0">
				      <tr>
				        <td class="layertdleft100">注册时间：</td>
				        <td width="35%" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
				          <tr>
				            <td width="150"><input id="regTime" name="investmentRegInfo.regTime" value="<fmt:formatDate value="${result.value.regInfo.regTime}" pattern="yyyy-MM-dd"/>" readonly="readonly" type="text" class="inputauto" onclick="showCalendar('regTime')"/></td>
				            <td width="20" align="center"><img style=" position:relative; left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="showCalendar('regTime')"/></td>
							<td>&nbsp;</td>
				          </tr>
				        </table>
						</td>
				        <td  class="layertdleft100">注册类型：</td>
				        <td width="35%" class="layerright"><dd:select key="crm.0004" name="investmentRegInfo.regTypeId" checked="result.value.regInfo.regTypeId"/></td>
				      </tr>
				       <tr>
				        <td class="layertdleft100">注册资本：</td>
				        <td class="layerright"><label>
				        <input name="investmentRegInfo.regCapital" value="<fmt:formatNumber value="${result.value.regInfo.regCapital}" pattern="#0.00"/>" type="text" class="inputauto" style="width:186px;"/>
				        	万元</label></td>
				        <td class="layertdleft100">币种：</td>
				        <td class="layerright"><dd:select key="crm.0005" name="investmentRegInfo.currencyTypeId" checked="result.value.regInfo.currencyTypeId"/></td>
				      </tr>
				      <tr>
				        <td class="layertdleft100">组织机构代码：</td>
				        <td class="layerright"><input name="investmentRegInfo.organizationNumber" value="${result.value.regInfo.organizationNumber}" type="text" class="inputauto" /></td>
				        <td class="layertdleft100">工商注册号：</td>
				        <td class="layerright"><input name="investmentRegInfo.businessNumber" value="${result.value.regInfo.businessNumber}" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft100">税务登记证：</td>
				        <td class="layerright"><input name="investmentRegInfo.taxNumber" value="${result.value.regInfo.taxNumber}" type="text" class="inputauto" /></td>
				        <td class="layertdleft100">法定代表人：</td>
				        <td class="layerright"><input name="investmentRegInfo.legalPerson" value="${result.value.regInfo.legalPerson}" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft100">法人证件类型：</td>
				        <td class="layerright"><dd:select key="crm.0006" name="investmentRegInfo.documentTypeId" checked="result.value.regInfo.documentTypeId"/></td>
				        <td class="layertdleft100">E-mail：</td>
				        <td class="layerright"><input name="investmentRegInfo.regMail" value="${result.value.regInfo.regMail}" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft100">证件号：</td>
				        <td class="layerright"><input name="investmentRegInfo.documentNumber" value="${result.value.regInfo.documentNumber}" type="text" class="inputauto" /></td>
				        <td class="layertdleft100">移动电话：</td>
				        <td class="layerright"><input name="investmentRegInfo.cellphone" value="${result.value.regInfo.cellphone}" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft100">经营范围：</td>
				        <td class="layerright"><input name="investmentRegInfo.businessScope" value="${result.value.regInfo.businessScope}" type="text" class="inputauto" /></td>
				        <td class="layertdleft100">营业截至日期：</td>
				        <td width="35%" class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="150"><input id="businessExpireDate" readonly="readonly" name="customerInfo.businessExpireDate" value="<fmt:formatDate value="${result.value.regInfo.businessExpireDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="showCalendar('businessExpireDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('businessExpireDate');"/></td>
									<td>&nbsp;</td>
								</tr>
		        			</table>
						</td>
				      </tr>
				      <tr>
				        <td class="layertdleft100">注册地址：</td>
				        <td colspan="3" class="layerright"><input name="investmentRegInfo.regAddress" type="text" class="inputauto" value="${result.value.regInfo.regAddress}"/></td>
				      </tr>
				    </table>
					</div>
				</div>
				</div>
				<div class="buttondiv">
					<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
					<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
				</div>
			</div>
		</form>
	</body>
</html>
