<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.preferences.enums.ContactTypeEnum"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String url = BaseAction.rootLocation+"/";
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
					"businessCenterContact.org":"required",
					"businessCenterContact.content":"required"
				},
				messages: {
					"businessCenterContact.org":"请选择联系单位",
					"businessCenterContact.content":"请填写联系内容"
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
				        			getOpener().reloadList('RENTOUTCONTACT',data.id);
				        			fb.end();
				        		},2000);
				        	}
				        } 
				    });
				}
			});
		}
		
		
		function selectOrg(){
			fbStart('选择部门单位','<%=url%>core/org!select.action',520,390);
		}
		function setSelectedOrg(org){
			$("#org").val(org.name);
			$("#orgId").val(org.id);
		}
		</script>
</head>
 
<body>
<form action="<%=basePath %>businessCenterContact!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
				<div class="titlebg">基本信息</div>
				<div class="divlays" style="margin:0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft120"><div style="width: 120px"><span class="psred">*</span>联系单位或部门：</div></td>
							<td class="layerright"><table width="30%" border="0" cellspacing="0" cellpadding="0">
       						 <tbody><tr>
							          <td><input name="businessCenterContact.type" value="<%=ContactTypeEnum.BUSINESSCENTERCONTACT %>" type="hidden"/>
							          <input id="orgId" name="businessCenterContact.orgId" type="hidden" ><input id="org" name="businessCenterContact.org" class="inputauto" onclick="selectOrg()" readonly="readonly"></td>
							          <td width="21" align="center" style="padding-right: 5px;"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectOrg()" style="cursor:pointer"></td>
							        </tr>
						      </tbody></table></td>
						</tr>
						<tr>
							<td class="layertdleft120"><span class="psred">*</span>联系内容：</td>
							<td colspan="3" class="layerright" style="padding-top:2px;"> <textarea name="businessCenterContact.content"  class="textareaauto"  rows="4"></textarea></td>
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

