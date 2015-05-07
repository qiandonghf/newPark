<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
	});
	function toSubmit(){
		var checked = false;
		$(".ids").each(function(){
			if($(this).attr("checked")){
				checked = true;
			}
		});
		if(checked){
			$("form").ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("getOpener().reloadPolicyList();parent.fb.end();", 2000);
		        	}
		        } 
		    });
		} else {
       		showTip("请选择政策",1000);
		}
	}
	function checkAllIds(){
		if($("#checkAll").attr("checked")){
			$(".ids").attr("checked",true);
		} else {
			$(".ids").attr("checked",false);
		}
	}
</script>
</head>

<body>
<form action="<%=basePath%>customerPolicy!save.action" method="post" id="form">
<input id="customerId" name="customerPolicy.customerId" value="${id}" type="hidden" />
<div class="basediv">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td valign="top"><div>
      <div class="userrightdivC" style="height:260px;overflow-y: auto;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="35" class="tdleftc"><label>
              <input type="checkbox" id="checkAll" value="checkbox" onclick="checkAllIds();"/>
            </label></td>
            <td width="100" class="tdcenter">发布年度</td>
            <td width="60" class="tdcenter">类型</td>
            <td class="tdrightc">内容</td>
            </tr>
           <c:forEach items="${policyList}" var="policy">
          <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
            <td class="centertd"><label>
              <input type="checkbox" class="ids" name="ids" value="${policy.id}"/>
            </label></td>
            <td class="centertd">${policy.year}</td>
            <td class="centertd">${policy.type.dataValue}</td>
            <td class="lefttd">${fn:substring(policy.content,0,50)}</td>
            </tr>
           </c:forEach>
        </table>
      </div>
  </tr>
</table>
<div class="hackbox"></div>
</div>
</form>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="rightbtn" value="" onclick="toSubmit()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  <label></label>
</div>
</body>
</html>