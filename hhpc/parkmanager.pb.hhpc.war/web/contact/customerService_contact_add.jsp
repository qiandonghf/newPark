<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.preferences.enums.ContactTypeEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		initForm();
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"customerServiceContact.customerName":"required",
				"customerServiceContact.typeId":"required",
				"customerServiceContact.contect":"required",
				"customerServiceContact.startDate":"required",
				"customerServiceContact.phone":"required",
				"customerServiceContact.description":"required"
			},
			messages: {
				"customerServiceContact.customerName":"请选择企业",
				"customerServiceContact.typeId":"请选择服务类型",
				"customerServiceContact.contect":"请填写联系人",
				"customerServiceContact.startDate":"请选择受理开始日期",
				"customerServiceContact.phone":"请填写联系电话",
				"customerServiceContact.description":"请填写情况说明"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if($("#startDate").val()>$("#endDate").val()){
					showTip("受理开始日期不能大于受理结束日期",2000);
					return;
				}
				$(form).ajaxSubmit({
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout(function(){
			        			getOpener().reloadList('CUSTOMERSERVICECONTACT',data.id);
			        			parent.fb.end();
			        		},2000);
			        	}
			        } 
			    });
			}
		});
	}
	
	function loadContectsByCustomerId(id){
		$.post("<%=basePath%>contect!loadContectsByCustomerId.action?id="+id,function(data){
			if(data.result.success){
				var list = data.result.value;
				var contectId = $("#contectId");
				contectId.empty();
				contectId.append($("<option></option>",{value:""}).append("----请选择----"));
				for(var i = 0; i < list.length; i++){
					var contect = list[i];
					contectId.append($("<option></option>",{value:contect.id}).append(contect.name));
				}
			} else {
				showTip(data.result.msg,2000);
			}
		});
	}
	
	function loadUsersByOrgId(id){
		$.post("<%=BaseAction.rootLocation %>/core/user!loadUsersByOrgId.action?id="+id,function(data){
			if(data.result.success){
				var list = data.result.value;
				var userId = $("#userId");
				userId.empty();
				userId.append($("<option></option>",{value:""}).append("----请选择----"));
				for(var i = 0; i < list.length; i++){
					var user = list[i];
					userId.append($("<option></option>",{value:user.id}).append(user.username));
				}
			} else {
				showTip(data.result.msg,2000);
			}
		});
	}
	
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
		loadContectsByCustomerId(customer.id);
	}
	
	function setSelectedOrg(selectedOrg) {
    	$("#user_org_id").val(selectedOrg.id);
    	$("#user_org_name").val(selectedOrg.name);
    	loadUsersByOrgId(selectedOrg.id);
    }
</script>
</head>

<body>
<form action="<%=basePath %>customerServiceContact!save.action" method="post" name="form1" id="form1">
	<div class="basediv">
	<input type="hidden" name="customerServiceContact.type" value="<%=ContactTypeEnum.CUSTOMERSERVICECONTACT %>"/>
		<div class="titlebg">基本信息</div>
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
					<td class="layerright" style="width:250px;">
						<table border="0" cellspacing="0" cellpadding="0" width="250">
							<tr>
								<td width=""><input id="customerId" value="" name="customerServiceContact.customerId" type="hidden" /><input id="customerName" name="customerServiceContact.customerName" value="" type="text" class="inputauto" readonly="readonly" /></td>
								<td width="21" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);" style="cursor:pointer"/></td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100"><span class="psred">*</span>服务类型：</td>
					<td class="layerright">
						<dd:select key="crm.0024" name="customerServiceContact.typeId"/>
            		</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>联系人：</td>
			        <td class="layerright">
			           <input name="customerServiceContact.linkman" type="text" class="inputauto" style="width:98%;" />
			        </td>
					<td class="layertdleft100"><span class="psred">*</span>受理日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
					          <td><input name="customerServiceContact.startDate" readonly="readonly" type="text" class="inputauto" id="startDate"  value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"    onclick="return showCalendar('startDate');" /></td>
					          <td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('startDate');" /></td>
					        </tr>
						</table>
					</td>
				 </tr>
				 <tr>
				 	<td class="layertdleft100"><span class="psred">*</span>联系电话：</td>
				 	<td class="layerright"><input name="customerServiceContact.telephone" type="text" class="inputauto" style="width:98%;" /></td>
				 	<td class="layertdleft100"><span class="psred">*</span>受理人：</td>
				 	<td class="layerright"><%=PbActivator.getSessionUser(request).getRealName()%>
			          	<input type="hidden" name="customerServiceContact.userId" value="<%=PbActivator.getSessionUser(request).getId()%>"/>
			        </td>
			 	</tr>
			 	<tr>
			 		<td class="layertdleft100"><span class="psred">*</span>情况说明：</td>
				 	<td colspan="3" class="layerright"><textarea name="customerServiceContact.description"  class="textareaauto"  style="height:50px;"></textarea></td>
			 	</tr>
		 	</table>
	 	</div>
	 	<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end()"/></label>
	</div>
</form>
</body>
</html>