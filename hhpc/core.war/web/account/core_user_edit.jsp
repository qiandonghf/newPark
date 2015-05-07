<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery.treeview.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css" />
 
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#useredit").css("height",getTabContentHeight()-32);
	});
	function changeClass(dom){
		$(dom).removeClass().addClass('apptabliover');
		$(dom).parent().siblings().find('.apptabliover').removeClass().addClass('apptabli');
	}
	function reloadButton(src){
		$("#useredit").attr("src",src);
	}
</script>
</head>

<body>
<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="100%" valign="top">
			<div class="apptab" id="apptab">
				<ul>
					<a href="/core/self.action" target="useredit"><li onclick="changeClass(this);" class="apptabliover" >个人设置</li></a>
					<a href="core/userTopButton!list.action" target="useredit"><li onclick="changeClass(this);" class="apptabli">快速按钮</li></a>
					<a href="core/userEmailParam!emailByUserId.action" target="useredit"><li onclick="changeClass(this);" class="apptabli">邮箱设置</li></a>
				</ul>
			</div>
			<div class="appname">
			<iframe src="/core/self.action" frameborder="0" name="useredit" id="useredit" width="100%" style="overflow-x: hidden;"/>
		    </div>
		</td>
      </tr>
  </table>
</div>
<!--//container-->
</body>
</html>