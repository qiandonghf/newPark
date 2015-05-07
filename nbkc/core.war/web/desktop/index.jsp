<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>    
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科技园区信息管理系统</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/web/style/oawork.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#merters li").each(function(index){
		$("#merters li").eq(index).click(function(){
			$("#merters li").removeClass("livisited").addClass("lilink");
			$("#merters li").eq(index).removeClass("lilink").addClass("livisited");
		});
	});
	$("#resizable").css("height",getTabContentHeight());
	$(".contentDiv").width(window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft));
});
function reloadList(){
	location.reload();
}
</script>
</head>

<body>
<div class="contentDiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	    <td valign="top">
			<iframe scrolling="no" id="resizable" frameborder="0" width="100%" src="<%=basePath%>index!desktop.action" name="desktop"></iframe>
		</td>
	    <td width="33" valign="top" style="background: url(core/common/images/workbg.gif);">
			<div class="oaworkright" id="merters">
				<ul>
					<a style="text-decoration: none;" href="<%=basePath%>index!desktop.action" target="desktop"><li class="livisited">工<br/>作<br/>台</li></a>
					<%-- <a style="text-decoration: none;" href="<%=BaseAction.rootLocation%>/parkmanager.cms/article!listAll.action" target="desktop"><li class="lilink">新<br/>闻<br/>中<br/>心</li></a> --%>
					<a style="text-decoration: none;" href="<%=basePath %>userTopButton!desktopList.action" target="desktop"><li class="lilink">快<br/>速<br/>按<br/>钮</li></a>
				</ul>
			</div>
		</td>
  	</tr>
</table>
</div>
</body>
</html>
