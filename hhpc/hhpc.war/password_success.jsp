<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
		<title>台州生命科学与工程学院</title>
		<link rel="stylesheet" href="image/list.css">
	    <link href="easyslider1.7/css/screen.css" rel="stylesheet" type="text/css" media="screen" />
		<script type="text/javascript" src="<%=basePath %>guest/script/jquery-1.7.2.min.js"></script>
	   	<script type="text/javascript" src="<%=basePath %>jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
	    <script type="text/javascript" src="<%=basePath %>guest/script/slides.min.jquery.js"></script>
	    <script type="text/javascript" src="<%=basePath %>guest/script/nav.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/tools.js"></script>
 </head>
  <body background="image/body_bg.png">
    <jsp:include page="top.jsp"></jsp:include>
    <div class="content"><!--网站主体 -->
				<div class="list-content" style="border:1px solid #666666; background:#ffffff">
					<div class="sba-nav" style="display:inline">
						您在的位置：<a href="<%=basePath %>" target="_blank">首页</a> &gt;
						<b>忘记密码</b>
					</div>
					<div class="article" style="height:200px; margin-top:60px;" align="center">
                    	<table cellpadding="0" class="passwd_tb" cellspacing="0" border="0" width="70%" align="center">
							<tr>
								<td style="font-size:16px;">密码重置申请已提交，管理员会与您取得电话联系，请耐心等待。</td>
							</tr>
						</table>
					</div>
				</div>
		</div><!--网站主体 -->
    <jsp:include page="bottom.jsp"></jsp:include>
  </body>
</html>
