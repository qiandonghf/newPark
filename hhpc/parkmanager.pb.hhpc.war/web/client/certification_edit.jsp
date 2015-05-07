<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initForm();
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"customer.name":"required",
				"certification.name":"required",
				"certification.typeId":"required"
			},
			messages: {
				"customer.name":"请选择企业",
				"certification.name":"请输入认证名称",
				"certification.typeId":"请选择认证类型"
				
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
			        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
</script>
</head>
<body>
<form action="<%=basePath %>certification!update.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
      <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="350">
            	<input id="customerId" name="certification.customerId" type="hidden" /><input id="customerName" name="customer.name" readonly="readonly" value="${result.value.customer.name }" class="inputauto" />
            	<input type="hidden" name="certification.id" value="${result.value.id }"/>
            </td>
            <td><img src="core/common/images/outdiv.gif" style="position: relative;left:-4px;" width="20" height="22" onclick="fbStart('选择企业','<%=basePath%>customer!select.action',520,400);"/></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">认证编号：</td>
      <td class="layerright"><input id="serialNo" name="certification.serialNo" value="${result.value.serialNo }" type="text" class="inputauto" /></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>认证类型：</td>
      <td class="layerright">
      	<dd:select id="type" name="certification.typeId" key="crm.0017" checked="result.value.typeId"/>
     </td>
    </tr>
    <tr>
    <td class="layertdleft100">是否发布：</td>
      <td class="layerright">
      	<enum:radio name="certification.pub" checked="result.value.pub" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO"/>
      </td>
    </tr>
	<tr>
      <td class="layertdleft100">认证时间：</td>
      <td class="layerright"><table width="205" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="120"><input id="certTime" name="certification.certTime" readonly="readonly" value="<fmt:formatDate value="${result.value.certTime }" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('certTime');"/></td>
          <td><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('certTime');"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>认证名称：</td>
      <td class="layerright"><label>
      <input id="name" name="certification.name" value="${result.value.name }" type="text" class="inputauto" id="starttime2323" />
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">认证机构：</td>
      <td class="layerright"><input id="agency" name="certification.agency" value="${result.value.agency }" type="text" class="inputauto" id="starttime22" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">认证摘要：</td>
      <td class="layerright"><label>
      <textarea id="summery" name="certification.summery"  style="height:80px;" class="textareaauto" id="starttime2322">${result.value.summery }</textarea>
      </label></td>
    </tr>
    <%-- <tr>
      <td class="layertdleft100">创建人：</td>
      <td class="layerright">
      	${result.value.creator }
   	  </td>
   	  </tr>
    <tr>
      <td class="layertdleft100">创建时间：</td>
      <td class="layerright">
     	<fmt:formatDate value="${result.value.createTime }" pattern="yyyy-MM-dd"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改人：</td>
      <td class="layerright">
      	${result.value.modifier }
   	  </td>
   	  </tr>
    <tr>
      <td class="layertdleft100">最后修改时间：</td>
      <td class="layerright">
      	<fmt:formatDate value="${result.value.modifyTime }" pattern="yyyy-MM-dd"/>
      </td>
    </tr> --%>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="buttondiv">
   <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
