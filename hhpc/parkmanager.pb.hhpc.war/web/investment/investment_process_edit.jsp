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
			"investmentProcess.name":"required",
			"investmentProcess.contect":"required",
			"investmentProcess.phone":"required",
			"investmentProcess.projectMemo":"required"
		},
		messages: {
			"investmentProcess.name":"请填写入住企业",
			"investmentProcess.contect":"请填写联系人",
			"investmentProcess.phone":"请填写电话",
			"investmentProcess.projectMemo":"请填写项目"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			$('#form1').ajaxSubmit({ 
		        dataType: 'json',		        
		        success: function(data){
	        		var id=$("#id").val();
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout(function(){
		        			getOpener().location.href='<%=basePath%>investmentProcess!list.action?id='+id;
		        			fb.end();
		        		},2000);
		        	}
		        } 
		    });
		}
	});
}

function setSelectedSupply(supply){
	$("#supplyId").val(supply.id);
	$("#supplyName").val(supply.name);
	$("#supplySpec").val(supply.spec);	
	$("#supplyUnit").val(supply.unit);
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
<form id="form1" action="<%=basePath%>investmentProcess!update.action"  name="form1" method="post" >
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td class="layertdleft100"><span class="psred">*</span>入驻企业：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="390">
	          <input id="id" name="investmentProcess.id" value="${id}"  class="inputauto" type="hidden"/>
	          <input id="name" name="investmentProcess.name" value="${result.value.name }"  class="inputauto" type="text"/>
          </td>         
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>联系人：</td>
      <td class="layerright">     
      	<input id="contect" value="${result.value.contect }" name="investmentProcess.contect" type="text" class="inputauto"  />
      </td>
    </tr>
     <tr>
      <td class="layertdleft100"><span class="psred">*</span>联系电话：</td>
      <td class="layerright">
	  <label>
	  <input id="phone" name="investmentProcess.phone" value="${result.value.phone }" type="text" class="inputauto" style="padding-left:2px; height:20px; line-height:20px; border:1px solid #e0e0e0;width: 100px;" />
	  </label>	  </td>
     </tr>
     <tr>
      <td class="layertdleft100"><span class="psred">*</span>项目：</td>
      <td class="layerright">     	
      	<input id="projectMemo" value="${result.value.projectMemo }" name="investmentProcess.projectMemo" type="text" class="inputauto" />
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">其他：</td>
      <td class="layerright"><textarea id="other" name="investmentProcess.other" rows="8" class="textareaauto">${result.value.other}</textarea></td>
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
