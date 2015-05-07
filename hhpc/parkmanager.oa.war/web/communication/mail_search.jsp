<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
	});
	
	function searchMail(){
		if(!$("#subject").val() && !$("#mailFrom").val() && !$("#mailTo").val()) return false;
		var item = $(":checked")
		var len=item.length; 
		if(len>0){ 
			$("#content").val($("#subject").val());
		}
		$("#searchForm").submit();
	}
	
	function mailInfo(mail,id){
		var folder = $("#folder").val();
		var cssText = "font-weight: normal;";
		mail.style.cssText = cssText;
		<%-- fbStart('查看邮件','<%=basePath %>mail!mail.action?id='+id+'&folder='+folder,712,366); --%>
		
		window.open('<%=basePath %>mail!mailRelay.action?id='+id+'&type='+4+'&folder='+folder,'查看邮件','height=500,width=700,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
	}
	
	function highlight(el){
		$(el).addClass("highlight");
		$(el).siblings().removeClass("highlight").css("background","#fff");
	}
</script>
</head>

<body>
<div class="basediv">
	<div class="titlebg">输入要搜索的词，并单击“立即查找”</div>
 		<form id="searchForm" action="<%=basePath %>mail!searchMail.action" method="post">
 			<input type="hidden" name="folder" value="${param.folder }"/>
 			<input type="hidden" id="content" name="content" />
			<div class="divlays" style="margin:0px;">
  				<table width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>
  					<tr>
      					<td class="layertdleft100" style="width:150px;">在主题中查找这些词：</td>
      					<td class="layerright" style="width:200px;"><input id="subject" name="subject" type="text" class="inputauto"></td>
      					<td class="" >&nbsp;&nbsp;<input id="ckb" type="checkbox" style="vertical-align:middle;" /><span style="vertical-align:middle;">同时搜索邮件正文</span></td>
    				</tr>
    				<tr>
      					<td class="layertdleft100" style="width:150px;">发件人：</td>
					    <td class="layerright" style="width:200px;"><input id="mailFrom" name="mailFrom" type="text" class="inputauto"></td>
					    <td class="" >&nbsp;</td>
    				</tr>
				    <tr>
				      <td class="layertdleft100" style="width:150px;">收件人：</td>
				      <td class="layerright" style="width:200px;"><input id="mailTo" name="mailTo" type="text" class="inputauto"></td>
				      <td class="layerright">
      					<a href="javascript:void(0)" onclick="searchMail();" title="" class="btn_bg"><span><img src="core/common/images/search_icon.gif">立即查找</span></a>
					  </td>
				    </tr>
  					</tbody>
  				</table>
			</div>
		</form>
	<div class="hackbox"></div>
</div>

<div class="basediv">
    <div class="emailtop">
		<div class="leftemail">
			<ul>
               	<li style="cursor:default;">搜索结果</li>
			</ul>
		</div>
	</div>
	<div class="" style="margin:0px;">
	 <div class="pm_msglist" style="border:0px; margin:0px;">
     <div class="overflowYauto" id="overflowAuto" style="height:300px;">
     <!--[if lte ie 8]> <div style="+zoom:1"><![endif]-->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tbody><tr>
                <td width="20" class="tdleftc"><img src="core/common/images/uploadfj.gif" width="7" height="12"></td>
                <td class="tdcenterL">收件人</td>
                <td class="tdleftc">主题</td>
                <td class="tdleftc">接收时间</td>
                </tr>
              <c:forEach items="${result.value }" var="mail" varStatus="status">
              	<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'" style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;" onclick="mailInfo(this,${mail.id});highlight(this);">
	                <td class="centertd"><c:if test="${mail.containAttach }">&nbsp;<img src="core/common/images/uploadfj.gif" width="7" height="12" /></c:if></td>
	                <td class="lefttd" >${fn:substring(mail.sender,0,8)}<c:if test="${fn:length(mail.sender) > 8 }">...</c:if>
	                <td class="centertd">${fn:substring(mail.subject,0,10)}<c:if test="${fn:length(mail.subject) > 10 }">...</c:if></td>
	                <td class="centertd"><fmt:formatDate value="${mail.sendDate }" pattern="yyyy-MM-dd" />&nbsp;</td>
              	</tr>
              </c:forEach>
            </tbody></table>
      </div>
	  </div>
	</div>
</div>
<div style="height:4px; overflow:hidden;">&nbsp;</div>
</form>
</body>
</html>
