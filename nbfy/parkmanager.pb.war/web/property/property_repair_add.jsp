<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<style type="text/css">
	.combo{
		position: relative;
	}
</style>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initParent();
		initForm();
	});
	
	function initParent(){
		$('#cc2').combotree({
			panelHeight:100,
			"url" : "<%=BaseAction.rootLocation %>/core/org!treeOrgs.action",
			onSelect : function(node) {
		    	$("#orgName").val(node.text);
		    	$("#orgId").val(node.id);
		    }
		});
		$(".combo-panel").height("80px;");
	}
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"propertyFix.reportTime":"required",
				"propertyFix.reportAddr":"required",
				"propertyFix.reportReason":"required",
				"propertyFix.phone":"mobileOrPhone"
			},
			messages: {
				"propertyFix.reportTime":"请选择报修日期",
				"propertyFix.reportAddr":"请填写报修地点",
				"propertyFix.reportReason":"请填写报修原因",
				"propertyFix.phone":"请正确填写联系方式"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	
	 function setSelectedOrg(selectedOrg) {
     	$("#orgId").val(selectedOrg.id);
     	$("#orgName").val(selectedOrg.name);
     }
	 function setSelectedRoom(room){
			$("#reportAddr").val(room["building.park.name"]+" "+room["building.name"]+" "+room.name);
		}
	 
	 function setSelectedCustomer(customer){
		$("#reporter").val(customer.name);
		$("#customerId").val(customer.id);
	}

	 
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>propertyFix!save.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="titlebg">报修信息</div>
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>报修日期：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="155">
          	<input readonly="readonly" id="reportTime" name="propertyFix.reportTime" type="text" class="inputauto" value="<%=DateUtil.format(new Date())%>" onclick="return showCalendar('reportTime', 'y-mm-dd');"/></td>
          <td>
          	<img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('reportTime', 'y-mm-dd');"/></td>
        </tr>
       </table>
      </td>
      <td class="layertdleft100">接待人员：</td>
      <td class="layerright"><input name="propertyFix.receiver" type="text" class="input100" /></td>
      <td class="layertdleft100">联系电话：</td>
      <td class="layerright"><input name="propertyFix.phone" type="text" class="input100" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">报修方式：</td>
      <td class="layerright">
      	  <dd:select id="methodId" name="propertyFix.methodId" key="pb.0011"/>
      </td>
      <td class="layertdleft100">报修类型：</td>
      <td class="layerright">
    	  <dd:select id="typeId" name="propertyFix.typeId" key="pb.0010"/>
      </td>
      <td class="layertdleft100">报修单号：</td>
      <td class="layerright"><input name="propertyFix.oddNo" type="hidden" class="input100" value="${oddNum}"/>${oddNum}</td>
    </tr>
    <tr>
      <td class="layertdleft100">报修人：</td>
      <td colspan="5" class="layerright">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="155"><label>
	            <input id="reporter" name="propertyFix.reporter" type="text" class="inputauto" />
	            <input id="customerId" name="propertyFix.customerId" type="hidden"/>
	          </label></td>
	          <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择企业','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!select.action',520,390);"/></td>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">报修部门：</td>
      <td colspan="5" class="layerright">
     	  <div>
		      <input id="cc2" name="propertyFix.orgId" style="width:175px;" value="----请选择----"/>
		      <input id="orgName" type="hidden" name="propertyFix.orgName" />
              <input id="orgId" type="hidden" name="propertyFix.orgId" />
		  </div>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>报修地点：</td>
      <td colspan="5" class="layerright">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="155"><label>
	          		<c:if test="${reportAddr == null}">
			      		<input name="propertyFix.reportAddr" id="reportAddr" type="text" class="inputauto" />
			      	</c:if>
			      	<c:if test="${reportAddr != null}">
			      		&nbsp;&nbsp;${reportAddr}<input name="propertyFix.reportAddr" id="reportAddr" value="${reportAddr}" type="hidden" class="inputauto" />
			      	</c:if>
	          </label></td>
	          <c:if test="${reportAddr == null}">
		          <td width="20">
			          	<img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('地点选择','<%=basePath%>room!select.action',520,400);"/>
		          </td>
	          </c:if>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>报修原因：</td>
      <td colspan="5" class="layerright"><label>
        <textarea name="propertyFix.reportReason" style="height:40px;" class="textareaauto"></textarea>
      </label></td>
    </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->

<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
