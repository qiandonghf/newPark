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
					"tenementCenterContact.customer":"required",
					"tenementCenterContact.roomId":"required",
					"tenementCenterContact.content":"required"
				},
				messages: {
					"tenementCenterContact.customer":"请选择企业",
					"tenementCenterContact.roomId":"请选择房间",
					"tenementCenterContact.content":"请填写联系内容"
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
				        			getOpener().reloadList('TENEMENTCENTERCONTACT',data.id);
				        			fb.end();
				        		},2000);
				        	}
				        } 
				    });
				}
			});
		}
		
		
		function selectCustomer(){
			fbStart('选择客户','<%=basePath%>customer!select.action',520,390);
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
		</script>
</head>
 
<body>
<form action="<%=basePath %>tenementCenterContact!update.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
<input type="hidden" name="tenementCenterContact.id" value="${result.value.id }" />
				<div class="titlebg">基本信息</div>
				<div class="divlays" style="margin:0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft120"><div style="width: 120px"><span class="psred">*</span>租赁客户名称：</div></td>
							<td class="layerright"><table width="60%" border="0" cellspacing="0" cellpadding="0">
       						 <tbody><tr>
							          <td><input name="tenementCenterContact.type" value="<%=ContactTypeEnum.TENEMENTCENTERCONTACT %>" type="hidden"/>
							          <input id="customerId" name="tenementCenterContact.customerId" type="hidden" value="${result.value.customerId }" /><input id="customer" name="tenementCenterContact.customer" value="${result.value.customer }" class="inputauto" onclick="selectCustomer()" readonly="readonly"/></td>
							          <td width="21" align="center" style="padding-right: 5px;"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCustomer()" style="cursor:pointer"/></td>
							        </tr>
						      </tbody></table></td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>原租赁房屋 房号/面积：</td>
							<td class="layerright">
								<table width="60%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
										<input type="hidden" name="tenementCenterContact.roomId" id="roomId" value="${result.value.roomId }"  />
										<input id="room" type="text" value='${result.value.room.building.name }${result.value.room.name} ${result.value.room.buildingArea }平方米' class="inputauto" onclick="selectRoom()" readonly="readonly"/></td>
										<td width="21" align="center" style="padding-right: 5px;"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectRoom()" style="cursor:pointer"/></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>联系内容：</td>
							<td colspan="3" class="layerright" style="padding-top:2px;"> <textarea name="tenementCenterContact.content"  class="textareaauto"  rows="4">${result.value.content }</textarea></td>
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

