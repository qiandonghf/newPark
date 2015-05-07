<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
					"carportOutContact.customer":"required",
					"carportOutContact.reason":"required",
					"carportOutContact.carport":"required"
				},
				messages: {
					"carportOutContact.customer":"请选择企业",
					"carportOutContact.reason":"请说明原因",
					"carportOutContact.carport":"请填写车位号"
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
				        			getOpener().reloadList('CARPORTOUTCONTACT',data.id);
				        			fb.end();
				        		},2000);
				        	}
				        } 
				    });
				}
			});
		}
		
		
		function selectCustomer(){
			fbStart('选择退赁单位','<%=basePath%>customer!select.action',520,390);
		}
		function setSelectedCustomer(customer){
			$("#customerId").val(customer.id);
			$("#customer").val(customer.name);
		}
		function selectRoom(){
			var src = '<%=basePath%>room!select.action?customerId='+$("#customerId").val();
			fbStart('选择房间',src,520,400);
		}
		function setSelectedRoom(room){
			var building = room["building.name"];
			var name = room.name;
			var area = room.buildingArea;
			var description = building+" "+name+" "+area+"平方米";
			$("#room").val(description);
			$("#roomId").val(room.id);
		}
		function setSelectedUser(user){
			$("#responsibleId").val(user.id);
			$("#responsible").val(user.realName);
			$("#phone").val(user.mobile);
		}
		function selectUser(){
			fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
		}
		</script>
</head>
 
<body>
<form action="<%=basePath %>carportOutContact!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
				<div class="titlebg">基本信息</div>
				<div class="divlays" style="margin:0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft120"><div style="width: 120px"><span class="psred">*</span>退赁单位：</div></td>
							<td class="layerright"><table width="70%" border="0" cellspacing="0" cellpadding="0">
       						 <tbody><tr>
							          <td><input name="carportOutContact.type" value="<%=ContactTypeEnum.CARPORTOUTCONTACT %>" type="hidden"/>
							          <input id="customerId" name="carportOutContact.customerId" type="hidden" ><input id="customer" name="carportOutContact.customer" class="inputauto" onclick="selectCustomer()" readonly="readonly"></td>
							          <td width="21" align="center" style="padding-right: 5px;"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCustomer()" style="cursor:pointer"></td>
							        </tr>
						      </tbody></table></td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>退租单位经办人：</td>
							<td class="layerright" >
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="35"><input id="responsibleId" name="carportOutContact.responsibleId" type="hidden" class="inputauto" /><input id="responsible" name="carportOutContact.responsible" readonly="readonly" type="text" class="inputauto" onclick="selectUser()" /></td>
										<td width="25"><img style="position: relative;left:-1px;" onclick="selectUser()" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
									</tr>
								</table>
							</td>
							<td class="layertdleft120">联系电话：</td>
							<td class="layerright">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="160"><input id="phone" name="carportOutContact.phone" type="text" class="inputauto" /></td>
										<td width="40" align="center"></td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>原租赁车位号：</td>
							<td class="layerright"><input name="carportOutContact.carport" type="text" class="inputauto"></input></td>
							<td class="layertdleft120">车位个数：</td>
							<td class="layerright">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="160"><input name="carportOutContact.number" type="text" class="inputauto" /></td>
										<td width="40" align="center"></td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>原租赁期限：</td>
					      	<td class="layerright">
						      	<table border="0" cellspacing="0" cellpadding="10">
						        	<tbody>
							          	<tr>
								            <td width="80"><input id="rentStart" name="carportOutContact.rentStart" type="text" readonly="readonly" class="inputauto"  onclick="showCalendar('rentStart');" /></td>
								            <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('rentStart')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
								            <td>&nbsp;至&nbsp;</td>
								            <td width="80"><input id="rentEnd" name="carportOutContact.rentEnd" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('rentEnd');" /></td>
								            <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('rentEnd')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
							          	</tr>
						        	</tbody>
					      		</table>
				      		</td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>退赁时间核实：</td>
					      	<td class="layerright">
						      	<table border="0" cellspacing="0" cellpadding="10">
						        	<tbody>
							          	<tr>
								            <td width="160"><input id="rentOutStart" name="carportOutContact.rentOutStart" type="text" readonly="readonly" class="inputauto"  onclick="showCalendar('rentOutStart');" /></td>
								            <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('rentOutStart')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
								            <td>&nbsp;至&nbsp;</td>
								            <td width="160"><input id="rentOutEnd" name="carportOutContact.rentOutEnd" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('rentOutEnd');" /></td>
								            <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('rentOutEnd')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
							          	</tr>
						        	</tbody>
					      		</table>
				      		</td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>退租原因：</td>
							<td colspan="3" class="layerright" style="padding-top:2px;"> <textarea name="carportOutContact.reason"  class="textareaauto"  rows="4"></textarea></td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>退赁金额：</td>
							<td colspan="3" class="layerright" style="padding-top:2px;"> <textarea name="carportOutContact.money"  class="textareaauto"  rows="4"></textarea></td>
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

