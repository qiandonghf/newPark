<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight());
	});
	
	function changeIframe(element,src){
		$(".libg").removeClass("libg");
		$(element).addClass("libg");
		$("#msglist").attr("src",src);
	}
</script>
</head>

<body>
<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="182" valign="top"><div class="agency" id="resizable" >
        <div class="titlebg">参数设置</div>
		<div class="datalist">
			<ul>
				<li><a href="javascript:void(0);" onclick="changeIframe(this,'<%=basePath %>park!parkFeeList.action')" class="libg">水电气单价</a></li>
				<li><a href="javascript:void(0);" onclick="changeIframe(this,'<%=basePath %>web/property/feeShare_list.jsp')">费用类型</a></li>
			</ul>
		</div>
		<!--datalist-->
       </div></td>
      <td width="100%" valign="top">
		  <div class="msglist" >
			<iframe src="<%=basePath %>park!parkFeeList.action" frameborder="0" id="msglist" name="msglist" width="100%"></iframe>
		  </div>
	  </td>
    </tr>
  </table>
  
</div>
<!--//container-->
</body>
</html>
