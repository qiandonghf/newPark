<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.pb.entity.FacilityOrder"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/><title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css"/>


<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		initForm();
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"billPlanFacility.planFee":"number",
				"billPlanFacility.realFee":"number",
				"billPlanFacility.startDate":"required",
				"billPlanFacility.endDate":"required",
				"billPlanFacility.planPayDate":"required"
			},
			messages: {
				"billPlanFacility.planFee":"请填写计划金额",
				"billPlanFacility.realFee":"请填写实际金额",
				"billPlanFacility.startDate":"请选择计费开始日期",
				"billPlanFacility.endDate":"请选择计费结束日期",
				"billPlanFacility.planPayDate":"请选择计划付费日期"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if($("#billPlanFacilityEndTime").val()>=$("#billPlanFacilityStartTime").val()){
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		setTimeout("getOpener().reloadList();fb.end();", 2000);
				        	}
				        } 
				    });
				} else {
					showTip("计费结束日期必须大于计费开始日期");
				}
			}
		});
	}
</script>
</head>

<body>
<form action="<%=basePath %>billPlanFacility!save.action" method="post" name="form1" id="form1">
  <!--basediv-->
  <div class="basediv">
    <!--titlebg-->
    <!--//titlebg-->
    <!--divlay-->
    <div class="divlays" style="margin:0px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="layertdleft100">设施名称：</td>
          <td class="layerright">
             	${facilityOrder.facility.name}
      			<input type="hidden" name="billPlanFacility.facilityId" value="${facilityOrder.facility.id}"/> 
      			<input type="hidden" name="billPlanFacility.facilityOrderId" value="${facilityOrder.id}"/>
      			<input type="hidden" name="billPlanFacility.contractId" value="${facilityOrder.contractId}"/>
          </td>
        </tr>
        <tr>
          <td class="layertdleft100">费用类型：</td>
          <td class="layerright">
            	${facilityOrder.facility.type.title}费
          </td>
        </tr>
        <tr>
          <td class="layertdleft100">计划金额：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><input name="billPlanFacility.planFee" type="text" class="inputauto" /></td>
              <td>&nbsp; 元 本期设置优惠之前的金额 </td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">实际金额：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><input name="billPlanFacility.realFee" type="text" class="inputauto" /></td>
              <td>&nbsp; 元 本期实际需要支付的金额 </td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">计费日期：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><input readonly="readonly" id="billPlanFacilityStartTime" name="billPlanFacility.startDate" type="text" class="inputauto" onclick="showCalendar('billPlanFacilityStartTime')"/></td>
              <td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('billPlanFacilityStartTime')"/></td>
              <td width="18">—</td>
              <td width="100" align="center"><input readonly="readonly" id="billPlanFacilityEndTime" name="billPlanFacility.endDate" type="text" class="inputauto" onclick="showCalendar('billPlanFacilityEndTime')"/></td>
              <td width="20"><img style=" position:relative; left:2px;" style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('billPlanFacilityEndTime')"/></td>
              <td align="center">&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">计划付费日期：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><input readonly="readonly" name="billPlanFacility.planPayDate" id="planPayDate" type="text" class="inputauto" onclick="showCalendar('planPayDate')"/></td>
              <td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('planPayDate')"/></td>
              <td>&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <%-- <tr>
          <td class="layertdleft100">自动出帐：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="20"><label>
                <input value="<%=BooleanEnum.YES %>" type="checkbox" name="billPlanFacility.autoCheck" />
              </label></td>
              <td></td>
            </tr>
          </table></td>
        </tr> --%>
        <tr>
          <td class="layertdleft100">备注：</td>
          <td class="layerright"><label>
            <textarea name="billPlanFacility.memo" class="textareaauto" style="height:50px;"></textarea>
          </label></td>
        </tr>
      </table>
    </div>
    <!--//divlay-->
    <div class="hackbox"></div>
  </div>
  <!--//basediv-->
  <!--//basediv-->
  <div class="buttondiv">
    <label>
      <input name="Submit" type="submit" class="savebtn" value="" />
    </label>
    <label>
      <input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/>
    </label>
  </div>
</form>
</body>
</html>
