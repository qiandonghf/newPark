<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
	});
	function checkForm(){
		if ($("#email").val()!="") {
			if (checkEmail("email","Email")==false) {
				return;
			}
		}
		if (notNull("customerName","企业名称") && notNull("name","姓名")) {
			var objs = $(".manager");
			var isManager = "";
			var isLegal = "";
			for(var i = 0;i<objs.length;i++){
				if(objs.get(i).checked){
					isManager = $(objs.get(i)).val();
				}
			}
			objs = $(".legal");
			for(var i = 0;i<objs.length;i++){
				if(objs.get(i).checked){
					isLegal = $(objs.get(i)).val();
				}
			}
			if(isManager == "YES" || isLegal == "YES"){
				var customerId = $("#customerId").val();
				var id = $("#stafferId").val();
				$.post("<%=basePath %>staffer!check.action?id="+id+"&&customerId="+customerId+"&&isManager="+isManager+"&&isLegal="+isLegal,function(data){
					if(!data.result.success){
						if(confirm(data.result.msg)){
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
					}else{
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
			}else{
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
		}
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
</script>
</head>

<body>
<form action="<%=basePath %>staffer!update.action" method="post" name="form1" id="form1">
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
		<td width="350"><input id="stafferId"  name="staffer.id" type="hidden" value="${result.value.id }"/>
		<input id="customerId" name="staffer.customerId" type="hidden" value="${result.value.customerId }" /><input id="customerName" type="text" class="inputauto" value="${result.value.customer.name }" readonly="readonly" onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);"/></td>
		<td><img style="cursor:pointer;" src="core/common/images/outdiv.gif" style="position:relative;left:-4px;" width="20" height="22"  onclick="fbStart('选择企业','<%=basePath%>customer!select.action',520,400);"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>姓名：</td>
      <td class="layerright"><input name="staffer.name" type="text" class="inputauto" id="name" value="${result.value.name }" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">性别：</td>
      <td class="layerright">
		<enum:radio name="staffer.gender" checked="result.value.gender" type="com.wiiy.commons.preferences.enums.GenderEnum" defaultValue="Female" />
	  </td>
    </tr>
    <tr>
	    <td class="layertdleft100">出生年月：</td>
		<td class="layerright">
			<table width="30%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><input id="birth" name="staffer.birth" readonly="readonly" value="<fmt:formatDate value="${result.value.birth}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="showCalendar('birth');"/></td>
					<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('birth');"/></td>
				</tr>
	    	</table>
	    </td>
    </tr>
    <tr>
      <td class="layertdleft100">职位：</td>
      <td class="layerright">
      	<dd:select id="positionId" name="staffer.positionId" key="crm.0014" checked="result.value.positionId"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">职称：</td>
      <td class="layerright">
      	<input id="professional" type="text" class="input100" name="staffer.professional" value="${result.value.professional }"></input>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">政治面貌：</td>
      <td class="layerright">
      	<dd:select id="politicalId" name="staffer.politicalId" key="crm.0029" checked="result.value.politicalId"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">联系电话：</td>
      <td class="layerright"><input name="staffer.phone" type="text" class="inputauto" id="phone" value="${result.value.phone }"/></td>
    </tr>
    
    <tr>
      <td class="layertdleft100">Email：</td>
      <td class="layerright"><input name="staffer.email" type="text" class="inputauto" id="email" value="${result.value.email }"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">学位：</td>
      <td class="layerright">
      	<dd:select id="degreeId" name="staffer.degreeId" key="crm.0015" checked="result.value.degreeId"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">学历：</td>
      <td class="layerright"><input name="staffer.education" value="${result.value.education }" type="text" class="inputauto" id="education" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">毕业学校：</td>
      <td class="layerright"><input name="staffer.studySchool" type="text" class="inputauto" id="studySchool" value="${result.value.studySchool }"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">留学国家：</td>
      <td class="layerright"><input name="staffer.abroadCountry" value="${result.value.abroadCountry }" type="text" class="inputauto" id="abroadCountry" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">是否总经理：</td>
      <td class="layerright">
      	 <enum:radio styleClass="manager" name="staffer.manager" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="${result.value.manager }"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否法人：</td>
      <td class="layerright">
      	 <enum:radio styleClass="legal" name="staffer.legal" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="${result.value.legal }"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否留学员：</td>
      <td class="layerright">
      	<enum:radio name="staffer.studyAbroad" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="${result.value.studyAbroad }"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否股东：</td>
      <td class="layerright">
      	<enum:radio name="staffer.stockHolder" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="${result.value.stockHolder }"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否发布网站</td>
      <td class="layerright">
      	 <enum:radio name="staffer.pub" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="${result.value.pub }"/>
      </td>
    </tr>
    <%-- <tr>
      <td class="layertdleft100">创建人：</td>
      <td class="layerright">${result.value.creator }</td>
    </tr>
    <tr>
      <td class="layertdleft100">创建时间：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.createTime }" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改人：</td>
      <td class="layerright">${result.value.modifier }</td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改时间：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.modifyTime }" pattern="yyyy-MM-dd"/></td>
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
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm();" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
