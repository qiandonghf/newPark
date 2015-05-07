<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/js/calendar.js"></script>
<script type="text/javascript" src="core/common/js/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/js/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initForm();
});
function initForm(){
	$("#form1").validate({
		rules:{
			"supplyApply.supply.name":"required",
			"supplyApply.applyTime":"required",
			"supplyApply.amount":"number",
			"supplyApply.applyer":"required",
			"supplyApply.memo":"required"
		},
		messages: {
			"supplyApply.supply.name":"请选择商品",
			"supplyApply.applyTime":"请选择申请时间",
			"supplyApply.amount":"请正确填写申请数量",
			"supplyApply.applyer":"请选择申请人",
			"supplyApply.memo":"请填写备注"
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

function setSelectedSupply(supply){
	$("#supplyId").val(supply.id);
	$("#supplyName").val(supply.name);
}

function setSelectedUser(user){
	$("#applyer").val(user.realName);
}

/* function setSelectedUsers(users){
	var ids = "";
	var names = "";
	for(var i = 0; i < users.length; i++){
		ids += users[i].id+",";
		names += users[i].name+",";
	}
	ids = deleteLastCharWhenMatching(ids,",");
	$("#ids").val(ids);
	names = deleteLastCharWhenMatching(names,",");
	$("#applyer").val(names);
} */

</script>
</head>

<body>
<form id="form1" action="<%=basePath%>supplyApply!update.action"  name="form1" method="post" >
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>商品名称：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="390">
          	<input id="id" name="supplyApply.id" type="hidden" value="${result.value.id}"/>
          	<input id="supplyId" name="supplyApply.supplyId" type="hidden" value="${result.value.supplyId}"/>
          	<input id="supplyName"  value="${result.value.supply.name}"  readonly="readonly" class="inputauto"  onclick="fbStart('选择商品','<%=basePath %>supply!select.action',520,400);"/>
          </td>
          <td width="20">
          	<img src="core/common/images/outdiv.gif" width="20" height="22" style="position: relative;left:-4px;" onclick="fbStart('选择商品','<%=basePath %>supply!select.action',520,400);"/>
          </td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>申请人：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="390">
          	<input id="applyer" name="supplyApply.applyer" value="${result.value.applyer}" readonly="readonly" type="text" class="inputauto" onclick="fbStart('选择申请人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);"/></td>
          <td width="20" align="center">
          	<img src="core/common/images/outdiv.gif" width="20" height="22" style="position: relative;left:-4px;" onclick="fbStart('选择申请人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>申请时间：</td>
      <td class="layerright"><table width="110px" border="0" cellspacing="0" cellpadding="0">
        <tr>
           <td width="80">
          	<input id="applyTime" name="supplyApply.applyTime" type="text" readonly="readonly" class="inputauto" value="<fmt:formatDate value="${result.value.applyTime}" pattern="yyyy-MM-dd"/>" onclick="return showCalendar('applyTime');"/></td>
          <td width="20">
          	<img src="core/common/images/timeico.gif" width="20" height="22"  style="position: relative;left: -4px;" onclick="return showCalendar('applyTime');"/></td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>申请数量：</td>
      <td class="layerright">
	  <label>
	  <input id="amount" name="supplyApply.amount" type="text" value="<fmt:formatNumber value="${result.value.amount}" pattern="#0.00"/>" class="inputauto" style="padding-left:2px; height:20px; line-height:20px; border:1px solid #e0e0e0;width: 100px;"/>
	  </label>	  </td>
      </tr>
    <%-- <tr>
     	<td class="layertdleft100"><span class="psred">*</span>审批状态：</td>
        <td class="layerright">
      		${result.value.status.title}  
        </td>
    </tr> --%>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>备注：</td>
      <td class="layerright"><textarea id="memo" name="supplyApply.memo" rows="8" class="textareaauto">${result.value.memo}</textarea></td>
      </tr>
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
