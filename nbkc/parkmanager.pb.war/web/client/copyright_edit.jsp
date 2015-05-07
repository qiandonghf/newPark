<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
				"copyright.name":"required",
				"copyright.typeId":"required"
			},
			messages: {
				"customer.name":"请选择企业",
				"copyright.name":"请输入著作权名称",
				"copyright.typeId":"请选择著作权类型"
				
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(notNull("applyTime","申请日期") && notNull("effectivetime","生效日期")){
					if($("#effectivetime").val()<$("#applyTime").val()){
						showTip("生效日期不能小于申请日期",5000);
						return;
					}
				}
				if(notNull("expireTime","失效日期") && notNull("effectivetime","生效日期")){
					if($("#expireTime").val()<$("#effectivetime").val()){
						showTip("失效日期不能小于生效日期",5000);
						return;
					}
				}
				if(notNull("applyTime","申请日期") && notNull("expireTime","失效日期")){
					if($("#expireTime").val()<$("#applyTime").val()){
						showTip("失效日期不能小于申请日期",5000);
						return;
					}
				}
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
<form action="<%=basePath %>copyright!update.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="350">
            	<input id="customerId" name="copyright.customerId" type="hidden" /><input id="customerName" name="customer.name" readonly="readonly" value="${result.value.customer.name }" class="inputauto" />
            	<input type="hidden" name="copyright.id" value="${result.value.id }"/>
            </td>
            <td><img src="core/common/images/outdiv.gif" style="position: relative;left:-4px;" width="20" height="22" onclick="fbStart('选择企业','<%=basePath%>customer!select.action',520,400);"/></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>著作权名称：</td>
      <td class="layerright"><input id="name" name="copyright.name" value="${result.value.name }"  type="text" class="inputauto" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">著作权号：</td>
      <td class="layerright"><label>
      <input id="serialNo" name="copyright.serialNo" value="${result.value.serialNo }"  type="text" class="inputauto"  />
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">申请日期：</td>
      <td colspan="3" class="layerright"><table width="205" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="180"><input name="copyright.applyTime" readonly="readonly" value="<fmt:formatDate value="${result.value.applyTime }" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" id="applyTime" onclick="return showCalendar('applyTime');" /></td>
          <td><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('applyTime');" /></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">著作申请人：</td>
      <td class="layerright"><label>
      <input id="appler" name="copyright.appler" value="${result.value.appler }"  type="text" class="inputauto"  />
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>著作权类型：</td>
      <td class="layerright">
        <dd:select id="type" name="copyright.typeId" key="crm.0009" checked="result.value.typeId"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">生效日期：</td>
      <td class="layerright"><table width="205" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="180"><input name="copyright.effectivetime" value="<fmt:formatDate value="${result.value.effectivetime }" pattern="yyyy-MM-dd"/>"  type="text" readonly="readonly" class="inputauto" id="effectivetime" onclick="return showCalendar('effectivetime');"/></td>
          <td><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('effectivetime');"   /></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">失效日期：</td>
      <td class="layerright"><table width="205" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="180"><input name="copyright.expireTime"  value="<fmt:formatDate value="${result.value.expireTime }" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly" class="inputauto"  id="expireTime" onclick="return showCalendar('expireTime');"/></td>
          <td><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('expireTime');"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
    	<td class="layertdleft100">是否发布：</td>
      <td class="layerright">
      	<enum:radio name="patent.pub" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.pub"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">著作权摘要：</td>
      <td class="layerright"><label>
      <textarea name="copyright.summery" style=" height:80px;" class="textareaauto" id="summery">${result.value.summery }</textarea>
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
