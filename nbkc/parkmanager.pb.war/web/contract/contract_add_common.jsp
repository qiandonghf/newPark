<%@page import="com.wiiy.crm.preferences.enums.ContractTypeEnum"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String action = request.getParameter("action");
%>
<script type="text/javascript">
		$(function(){
			initTip();
			initForm();
		});
		function setSelectedUser(contect){
			$("#contectName").val(contect.name);
			$("#contectId").val(contect.id);
		}
		function setSelectedCustomer(customer){
			$("#customerId").val(customer.id);
			$("#customerName").val(customer.name);
		}
		function selectContect(){
			fbStart('选择负责人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
		}
		function generateCode(){
			$.post("<%=basePath%>contract!generateCode.action",function(data){
				if(data.result.success){
					$("#contractNo").val(data.result.value);
				}
			});
		}
		function initForm(){
			$("#form1").validate({
				rules: {
					"contract.name":"required",
					"contract.contractNo":"required",
					"contract.signDate":"required",
					"contract.totalAmount":"number",
					"customerName":"required",
					"contectName":"required",
					"contract.startDate":"required",
					"contract.endDate":"required"
				},
				messages: {
					"contract.name":"请输入合同名称",
					"contract.contractNo":"请输入合同编号",
					"contract.signDate":"请选择签订日期",
					"contectName":"请选择负责人",
					"customerName":"请选择企业",
					"contract.startDate":"请选择有效日期开始时间",
					"contract.endDate":"请选择有效日期结束时间"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					if($("#endDate").val()<$("#startDate").val()){
						showTip("有效日期开始时间不能小于有效日期结束时间",3000); 
						return;
					}
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		getOpener().reloadList();
				        		$("#contractId").val(data.contract.id);
				        		$("#bottom").show();
				        		init();
				        	}
				        } 
				    });
				}
			});
		}
	</script>
<input type="hidden" value="0" id="contractId" name="contract.id"/>
	<input type="hidden" name="contract.type" value="<%=ContractTypeEnum.RentContract%>"/>
	<div class="basediv">
		<div class="titlebg">基本信息</div>
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>合同名称：</td>
					<td colspan="3" class="layerright"><input name="contract.name" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>合同编号：</td>
					<td class="layerright" width="270">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="165"><input id="contractNo" name="contract.contractNo" type="text" class="inputauto" /></td>
								<td width="80" align="center"><img src="core/common/images/auto.gif" width="75" height="22" onclick="generateCode()"/></td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100"><span class="psred">*</span>签订日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="signDate" readonly="readonly" name="contract.signDate" type="text" class="inputauto" onclick="showCalendar('signDate')"/></td>
								<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('signDate')"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>有效日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="110"><input id="startDate" name="contract.startDate" readonly="readonly" type="text" class="inputauto" onclick="showCalendar('startDate')"/></td>
								<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('startDate')"/></td>
								<td width="10"><span style="padding-left:4px;padding-right:4px;">—</span></td>
								<td width="110"><input id="endDate" name="contract.endDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('endDate')"/></td>
								<td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('endDate')"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100"><span class="psred">*</span>计划完成日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="finishDate" name="contract.finishDate" readonly="readonly" type="text" class="inputauto" onclick="showCalendar('finishDate');"/></td>
								<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('finishDate')"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="265"><input id="customerName" name="contract.customerName" type="text" class="inputauto" readonly="readonly" /><input type="hidden" id="customerId" name="contract.customerId" type="text" class="inputauto" /></td>
								<td><img src="core/common/images/outdiv.gif" style="position:relative;left:-4px;" width="20" height="22" onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);" style="cursor:pointer"/></td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100">合同总额：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="120"><input name="contract.totalAmount" type="text" class="inputauto" /></td>
								<td align="left">&nbsp;元</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>负责人：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="265"><input id="contectName" name="contectName" type="text" class="inputauto" readonly="readonly" /><input type="hidden" id="contectId" name="contract.managerId" type="text" class="inputauto" /></td>
								<td><img src="core/common/images/outdiv.gif" style="position:relative;left:-4px;" width="20" height="22" onclick="selectContect()" style="cursor:pointer"/></td>
							</tr>
						</table>
					</td>
					<td>&nbsp;</td>
					<td class="layerright">&nbsp;</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>