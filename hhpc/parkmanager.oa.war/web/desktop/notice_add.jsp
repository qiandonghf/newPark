<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page import="com.wiiy.oa.preferences.enums.NoticeStatusEnum"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
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
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function(){
	initTip();
	initForm();
});

function initForm(){
	$("#form1").validate({
		rules: {
			"notice.name":"required",
			"notice.incubator":"required",
			"notice.issuer":"required",
			"notice.state":"required",
			"notice.issueTime":"required",
			"notice.content":"required"
		},
		messages: {
			"notice.name":"请输入公告标题",
			"notice.issuer":"请输入发布者",
			"notice.incubator":"请输入发布来源",
			"notice.state":"请选择发布状态",
			"notice.issueTime":"请选择发布时间",
			"notice.content":"请填写公告内容"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			var att  = "";
			var path = "";
			var name = "";
			var size = "";
			$(".attPath").each(function(){
				path = $(this).attr("value");
				name = $(this).prev(".attName").attr("value");
				size = $(this).prev().prev(".size").attr("value");
				att += path+","+size+","+name+";";
			});
			var type = $("#isCenter").val();
			if(type == "YES"){
				$("#nCenter").val("YES");
			}else if(type == "NO"){
				$("#nCenter").val("NO");
			}
			if(checkCK){
				//$("#contentText").val(CKEDITOR.instances.content.document.getBody().getText());
				$("#content").val(CKEDITOR.instances.content.getData());
				$(form).ajaxSubmit({
			        dataType: 'json',	
			        success: function(data){
		        		showTip(data.result.msg,2000);
	        			if(data.result.success){
			        		setTimeout("fb.end()", 2000);
			        	}
			        } 
			    });
			}
		}
	});
}
function checkCK(){
	for (instance in CKEDITOR.instances) {
		CKEDITOR.instances[instance].updateElement();
	}
	if(isNull("content","文章内容")){
		showTip("请输入文章内容",2000);
		return false;
	}else{
		return true;
	}
} 
</script>
</head>
 
<body>
<form action="<%=basePath %>notice!rmiSave.action" method="post" name="form1" id="form1">
<input name="notice.state" type="hidden" value="<%=NoticeStatusEnum.ISSUED %>"/>
<input id="nCenter" name="notice.center" type="hidden" value="<%=BooleanEnum.NO%>"/>
<!--basediv-->
<div class="basediv">
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>公告标题：</td>
        <td class="layerright"><input name="notice.name" type="text" class="inputauto" /></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>发布者：</td>
        <td class="layerright"><input name="notice.issuer" value="<%=OaActivator.getAppConfig().getConfig("NoticeSign").getParameter("name") %>" type="text" class="inputauto" /></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>发布来源：</td>
        <td class="layerright"><input name="notice.incubator" value="<%=OaActivator.getAppParamService().loadIncubatorName() %>" type="text" class="inputauto" /></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>发布日期：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
             <td width="150"><input id="issueTime" name="notice.issueTime" readonly="readonly" type="text" class="inputauto" value="<fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd"/>" onclick="showCalendar('issueTime')"/></td>
			 <td width="20" align="center"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="showCalendar('issueTime')"/></td>
          </tr>
        </table>          
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">公告内容：</td>
        <td class="layerright"><label>
          <textarea id="content" name="notice.content" style="height:200px;" rows="15" class="textareaauto"></textarea>
          <script type="text/javascript">CKEDITOR.replace( 'content',{height:125});</script>
        </label></td>
      </tr>
    </table>
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="allbtncancel" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>

