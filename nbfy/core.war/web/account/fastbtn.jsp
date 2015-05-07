<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		$("#fbt_height").css("height",getTabContentHeight());
	});
	function initTab(){
		$(".tt").each(function() {
			attachMenuEvent(this);
		});
	}

	function attachMenuEvent(element) {
		$(element).click(function(e) {
			e.preventDefault();
			var plugin=trim($(this).text());
			var icon = ($(this).children().val()).substring(1).replace('.png','_min.png');
			if (parent.parent.$('#tt').tabs('exists',plugin)){
				parent.parent.$('#tt').tabs('select', plugin);
			} else {
				var url=$(this).attr("href");
				parent.parent.$('#tt').tabs('add',{
					title:plugin,
					iconCls:'icon-reload',
					content: '<iframe src="'+url+'" frameborder="0" height="'+(document.documentElement.clientHeight+33)+'" width="100%"></iframe>',
					closable:true
				});
			}
			var span = parent.parent.$('#tt').find("span:contains('"+plugin+"')");
			span.next().css("background","url('"+icon+"') no-repeat");
			return false;
		});
	}
</script>
</head>
<body>
<div id="fbt_height" style="overflow-y: auto;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
		<div class="emailtop">
			<!--leftemail-->
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('添加快速按钮','<%=basePath %>web/account/fastbtn_add.jsp',430,229);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>添加</li>				
				</ul>
			</div>
			<!--//leftemail-->
		</div>
	<!--快速按钮-->
		<!--btnlist-->
		<c:forEach items="${moduleList}" var="module">
		<div class="btnlist">
			<h1>${module.name}</h1>
			<ul>
				<c:forEach items="${menuList}" var="menu">
					<c:if test="${module.idSpace == menu.moduleId}">
						<li>
						<a class="tt" href="${menu.uri}" style="text-decoration: none;"><input type="hidden" value="${menu.icon}"/><img src="${menu.icon}" width="32" height="32" />
					  		<p>${menu.name}</p>
						</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<div class="hackbox"></div>
		</div>
		</c:forEach>
		<!--//btnlist-->
	</td>
  </tr>
</table>
</div>
</body>
</html>
