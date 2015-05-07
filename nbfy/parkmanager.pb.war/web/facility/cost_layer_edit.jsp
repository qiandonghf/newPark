<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<form action="<%=basePath %>billPlanFacility!update.action" method="post" name="form1" id="form1">
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
             	${result.value.facility.name}
             	<input type="hidden" name="billPlanFacility.facilityId" value="${result.value.facilityId}"/> 
      			<input type="hidden" name="billPlanFacility.facilityOrderId" value="${result.value.facilityOrderId}"/>
      			<input type="hidden" name="billPlanFacility.contractId" value="${result.value.contractId}"/>
      			<input type="hidden" name="billPlanFacility.id" value="${result.value.id}"/>
          </td>
        </tr>
        <tr>
          <td class="layertdleft100">费用类型：</td>
          <td class="layerright"><label>
          		${result.value.facility.type.title}费
          </label></td>
        </tr>
        <tr>
          <td class="layertdleft100">计划金额：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><input name="billPlanFacility.planFee" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.planFee}" pattern="#0.00"/>"/></td>
              <td>&nbsp; 元 本期设置优惠之前的金额 </td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">实际金额：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><input name="billPlanFacility.realFee" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.realFee}" pattern="#0.00"/>"/></td>
              <td>&nbsp; 元 本期实际需要支付的金额 </td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">计费日期：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><input readonly="readonly" id="billPlanFacilityStartTime" name="billPlanFacility.startDate" type="text" class="inputauto" onclick="showCalendar('billPlanFacilityStartTime')" value="<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>"/></td>
              <td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('billPlanFacilityStartTime')"/></td>
              <td width="18">—</td>
              <td width="100" align="center"><input readonly="readonly" id="billPlanFacilityEndTime" name="billPlanFacility.endDate" type="text" class="inputauto" onclick="showCalendar('billPlanFacilityEndTime')" value="<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/>"/></td>
              <td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('billPlanFacilityEndTime')"/></td>
              <td align="center">&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">计划付费日期：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><input readonly="readonly" name="billPlanFacility.planPayDate" id="planPayDate" type="text" class="inputauto" onclick="showCalendar('planPayDate')" value="<fmt:formatDate value="${result.value.planPayDate}" pattern="yyyy-MM-dd"/>"/></td>
              <td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('planPayDate')"/></td>
              <td>&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <%-- <tr>
          <td class="layertdleft100">自动出帐：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="20"><label>
                <input value="<%=BooleanEnum.YES %>" type="checkbox" name="billPlanFacility.autoCheck" <c:if test="${result.value.autoCheck eq 'YES'}">checked="checked"</c:if> />
              </label></td>
              <td> 系统将在计划付费日期到来后自动生成账单 </td>
            </tr>
          </table></td>
        </tr>
        <tr>
	      <td class="layertdleft100">出帐状态：</td>
	      <td class="layerright">
	      	 <enum:select type="com.wiiy.crm.preferences.enums.BillPlanStatusEnum" name="billPlanFacility.status" styleClass="incubated" checked="result.value.status"/>
	      </td>
	    </tr> --%>
		
		<tr>
	      <td class="layertdleft100"><p>出账时间：</p></td>
	      <td class="layerright">
	     	 <table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		          <td width="100"><input readonly="readonly" name="billPlanFacility.intoAccountDate" id="intoAccountDate" type="text" value="<fmt:formatDate value="${result.value.intoAccountDate}" pattern="yyyy-MM-dd"/>" class="inputauto" onclick="showCalendar('intoAccountDate')"/></td>
		          <td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('intoAccountDate')"/></td>
		          <td>&nbsp;</td>
		        </tr>
	     	 </table>
	      </td>
       </tr>
        
	 <tr>
      <td class="layertdleft100">滞纳金：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100"><input name="billPlanFacility.overdueFee" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.overdueFee}" pattern="#0.00"/>"/></td>
          <td>&nbsp; 元 </td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100">最后付费日期：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100"><input readonly="readonly" name="billPlanFacility.lastPayDate" id="lastPayDate" type="text"  value="<fmt:formatDate value="${result.value.lastPayDate}" pattern="yyyy-MM-dd"/>" class="inputauto" onclick="showCalendar('lastPayDate')"/></td>
          <td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('lastPayDate')"/></td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
    </tr>
	 <tr>
      <td class="layertdleft100">已付金额：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100"><input name="billPlanFacility.paidFee" type="text" class="inputauto"  value="<fmt:formatNumber value="${result.value.paidFee}" pattern="#0.00"/>" /> </td>
          <td>&nbsp; 元 </td>
        </tr>
      </table></td>
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
