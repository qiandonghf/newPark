<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#merter_fee_right").css("height",getTabContentHeight()-126);
	});
</script>
</head>

<body>
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td valign="top">
		<div class="merters" id="merters">
		<div class="emailtitle">
			<h1>${result.value.subject }</h1>
			<ul>
				<li>发件人：${result.value.sender };</li>
				<li>时　间：<fmt:formatDate value="${result.value.sendDate }" pattern="yyyy年MM月dd日 (E)" /></li>
				<li>收件人：<div style="height:25px; padding-left:50px; margin-top:-25px; overflow-y:auto; overflow-x:hidden">${result.value.to };</div></li>
			</ul>
		</div>
		<div class="emailcontent" id="merter_fee_right">
		<!--emailcenter-->
		<div class="emailcenter">${result.value.content }</div>
		<!--//emailcenter-->
		<!--emaildown-->
		<div class="emaildown">
			<h1>附件${fn:length(result.value.emailAttDtoList) }个</h1>
			<c:forEach items="${result.value.emailAttDtoList }" var="att">
				<div class="downlist">
					<img src="core/common/images/downloadico.png" />
					<ul>
						<li>${att.name }<span></span></li>
						<li><a href="<%=basePath %>mail!downloadAttachment.action?id=${result.value.id}&folder=${folder}&partIndex=${att.partIndex}" >下载</a></li>
					</ul>
				</div>
			</c:forEach>
		</div>
		</div>
		</div>
	</td>
    </tr>
  </table>
</div>
 <!--//container-->
</body>

</html>
