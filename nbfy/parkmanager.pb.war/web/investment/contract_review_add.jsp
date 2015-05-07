<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	initTip();
	initForm();
});

function initForm(){
	$("#form1").validate({
		rules:{
			"contractReview.contract.name":"required",
			"contractReview.contract.contractNo":"required",
			"contractReview.date":"required"
		},
		messages: {
			"contractReview.contract.name":"请填写合同名称",
			"contractReview.contract.contractNo":"请填写合同号",
			"contractReview.date":"请选择时间"
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
		        		setTimeout(function(){		        			
		        			getOpener().location.reload();
		        			fb.end();
		        		},2000);
		        	}
		        } 
		    });
		}
	});
}

/* function contractReview(supply){
	$("#supplyId").val(supply.id);
	$("#supplyName").val(supply.name);
	$("#supplySpec").val(supply.spec);	
	$("#supplyUnit").val(supply.unit);
	
} */

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
<form id="form1" name="form1" method="post" action="<%=basePath%>contractReview!save.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>合同名称：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="390">
	          <input id="name" name="contractReview.name" value="${contract.name }" class="inputauto" type="text" readonly="readonly"/>
	          <input  name="contractReview.contractId" value="${contract.id}" class="inputauto" type="hidden" />
          </td>         
        </tr>
      </table></td>
      </tr>
  <tr>
      <td class="layertdleft100"><span class="psred">*</span>合同号：</td>
      <td class="layerright">     
      	<input id="contect" value="${contract.contractNo }" name="contractReview.contractNo" type="text" class="inputauto"  />
      </td>
    </tr>
     <tr>
      <td class="layertdleft100"><span class="psred">*</span>日期：</td>
      <td class="layerright"><table width="110px" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="80">
          	<input id="date" name="contractReview.date" type="text" readonly="readonly" class="inputauto" onclick="return showCalendar('date');"/></td>
          <td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22"  style="position: relative;left: -4px;" onclick="return showCalendar('date');"/></td>
        </tr>
      </table></td>
      </tr>
     
    <tr>
      <td class="layertdleft100"><span class="psred"></span>部门：</td>
      <td class="layerright">     
      	<input id="department" name="contractReview.department" type="text" class="inputauto"  />
      </td>
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
