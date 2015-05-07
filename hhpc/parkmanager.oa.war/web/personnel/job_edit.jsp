<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/demo/demo.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/tree/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initForm();
	});
	
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"position.name":"required",
				"position.post":"required",
				"orgName":"required"
			},
			messages: {
				"position.name":"请填写姓名",
				"position.post":"请填写职位",
				"orgName":"请选择所属部门或公司"
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
	
	function setSelectedOrg(selectedOrg){
		$("#orgId").val(selectedOrg.id);
		$("#orgName").val(selectedOrg.name);
	}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>position!update.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>姓名：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	      <td width="118">
	        <input name="position.name" type="text" class="inputauto" value="${result.value.name}"/>
	        <input name="position.id" type="hidden" value="${result.value.id}"/>
      	  </td>
	    </tr>
	  </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>职位：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	      <td width="118">
	        <input name="position.post" type="text" class="inputauto" value="${result.value.post}"/>
      	  </td>
	    </tr>
	  </table></td>
    </tr>
    <tr>
    	<td class="layertdleft100" style="white-space:nowrap;"><span class="psred">*</span>所属部门或公司：</td>
        <td class="layerright">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
				<td width="200"><input id="orgId" name="position.orgId" value="${result.value.orgId}"  type="hidden" /><input id="orgName" name="orgName" value="${result.value.org.name}" class="inputauto" readonly="readonly" onclick="fbStart('选择部门','<%=BaseAction.rootLocation %>/core/org!select.action',520,400);"/></td>
				<td><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择部门','<%=BaseAction.rootLocation %>/core/org!select.action',520,400);"/></td>
			</tr>
     		</table>
     	</td>
    
    </tr>
    <tr>
      <td class="layertdleft100">职责：</td>
      <td><textarea name="position.memo" cols="44" class="textarea248" id="end">${result.value.memo}</textarea></td>
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
