<%@page import="com.wiiy.commons.action.BaseAction"%>
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
<title></title>
<style>
	ul,li { list-style:none;}
	a { margin:0 5px;}
</style>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/work.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
 
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript"> 
	$(document).ready(function(){
		initTab();
	});
	function initTab(){
		$(".tt").each(function() {
			attachMenuEvent(this);
		});
	}
 
	function attachMenuEvent(element) {
		$(element).click(function(e) {
			e.preventDefault();
			var plugin= trim($(this).text());
			if (parent.parent.$('#tt').tabs('exists',plugin)){
				parent.parent.$('#tt').tabs('select', plugin);
			} else {
				var url=$(this).attr("href");
				parent.parent.$('#tt').tabs('add',{
					title:plugin,
					content: '<iframe src="'+url+'" frameborder="0" height="'+(document.documentElement.clientHeight)+'" width="100%"></iframe>',
					closable:true
				});
			}
			return false;
		});
	}
</script>
</head>

<body>





<div style=" padding:50px 50px 0; text-align:left; ">
<img src="core/common/images/info.png" />
</div>

<!--container-->
<ul style="font-size:14px; padding:20px 50px 0; color:#666; line-height:2;">
<li style="background:url(../common/images/paragraph.gif) no-repeat left center; padding-left:10px;">
抱歉，您未配置权限</li>
</ul>
</body>
</html>
