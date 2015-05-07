<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.preferences.enums.ContactTypeEnum"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
		
		<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
		<script type="text/javascript" src="core/common/ckeditor/adapters/jquery.js"></script>
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
		}) ;
		function initForm(){
			$("#form1").validate({
				rules: {
					"investmentContact.investmentName":"required"
				},
				messages: {
					"investment.name":"请选择项目"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		setTimeout(function(){		        			
				        			getOpener().reloadList('INVESTMENTCONTACT',data.id);
				        			fb.end();
				        		},2000);
				        	}
				        } 
				    });
				}
			});
		}
		
		
		function setSelectedInvestment(rowData){
			$("#investmentName").val(rowData.name);
			$("#investmentId").val(rowData.id);
			$("#staff").val(rowData.staff);
			$("#regCapital").val(rowData.regCapital);
			$("#investCapital").val(rowData.investCapital);
			$("#officeArea").val(rowData.officeArea);
			$("#outputValue").val(rowData.outputValue);
			$("#businessScope").val(rowData.businessScope);
		}
		
		function selectInvestment(){
			fbStart('选择项目','<%=basePath%>investment!select.action',520,400);
		}
		function setSelectedUser(user){
			$("#linkmanId").val(user.id);
			$("#linkman").val(user.name);
		}
		function selectUser(){
			var investmentId = $("#investmentId").val();
			if(investmentId==null || investmentId== "" ){
				showTip("请先选择项目",2000);
				return;
			}
			
			fbStart('选择联系人','<%=BaseAction.rootLocation %>/parkmanager.pb/web/investment/investmentDirector_select.jsp?investmentId='+investmentId,520,400);
		}
		</script>
</head>
 
<body>
<form action="<%=basePath %>investmentContact!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
				<div class="titlebg">基本信息</div>
				<div class="divlays" style="margin:0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft100"><div style="width: 120px"><span class="psred">*</span>项目名称：</div></td>
							<td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
       						 <tbody><tr>
							          <td><input name="investmentContact.type" value="<%=ContactTypeEnum.INVESTMENTCONTACT %>" type="hidden"/>
							          <input id="investmentId" name="investmentContact.investmentId" value="${result.value.id }" type="hidden" /><input id="investmentName" value="${result.value.name }" name="investmentContact.investmentName" class="inputauto" onclick="selectInvestment()" readonly="readonly"/></td>
							          <td width="21" align="center" style="padding-right: 5px;"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectInvestment()" style="cursor:pointer"/></td>
							        </tr>
						      </tbody></table></td>
							<td class="layertdleft100"><span class="psred">*</span>企业人数：</td>
							<td class="layerright">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="80"><input id="staff" name="investmentContact.staff" type="text" class="inputauto" value="${result.value.staff }" readonly="readonly"/></td>
										<td width="40" align="center">人</td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="layertdleft100"><span class="psred">*</span>注册资本：</td>
							<td class="layerright">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="80"><input id="regCapital" name="investmentContact.regCapital" type="text" value="${result.value.regCapital }" class="inputauto" readonly="readonly"/></td>
										<td width="40" align="center">万元</td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</td>
							<td class="layertdleft100"><span class="psred">*</span>计划总投资：</td>
							<td class="layerright">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="80"><input id="investCapital" name="investmentContact.investCapital" type="text" value="${result.value.investCapital }" class="inputauto" readonly="readonly"/></td>
										<td width="40" align="center">万元</td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="layertdleft100">用房面积：</td>
							<td class="layerright">
								<table width="50%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td >
											<td><input  id="officeArea" name="investmentContact.officeArea" type="text" value="${result.value.officeArea }" class="inputauto" readonly="readonly"/></td>
											<td width="40" align="center">㎡</td>
										</td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</td>
							<td class="layertdleft100"><span class="psred">*</span>预计年产值：</td>
							<td class="layerright">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="80"><input id="outputValue" name="investmentContact.outputValue" value="${result.value.outputValue }" type="text" class="inputauto" readonly="readonly"/></td>
										<td width="40" align="center">万元</td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="layertdleft100"><span class="psred"></span>联系人：</td>
							<td class="layerright" >
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="35"><input id="linkmanId" name="investmentContact.linkmanId" type="hidden" class="inputauto" /><input id="linkman" name="investmentContact.linkman" readonly="readonly" type="text" class="inputauto" onclick="selectUser()" /></td>
										<td width="25"><img style="position: relative;left:-1px;" onclick="selectUser()" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="layertdleft100">经营范围：</td>
							<td colspan="3" class="layerright" style="padding-top:2px;"><textarea id="businessScope" name="investmentContact.businessScope"  class="inputauto" style="height:40px;resize:none;" readonly="readonly">${result.value.businessScope }</textarea></td>
						</tr>
						<tr>
							<td class="layertdleft100">情况说明：</td>
							<td colspan="3" class="layerright" style="padding-top:2px;"> <textarea name="investmentContact.description"  class="inputauto" style="height:40px;resize:none;"></textarea></td>
						</tr>
					</table>
				</div>
				<div class="hackbox"></div>
			</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value=" " /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value=" " onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>

