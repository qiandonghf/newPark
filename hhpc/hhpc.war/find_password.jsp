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
		<script type="text/javascript">
		function submitform(){

			if($("#username").val()==''){
				alert("请输入账号");
				$("#username").focus();
				return false;
			}
			if($("#realName").val()==''){
				alert("请输入姓名");
				$("#realName").focus();
				return false;
			}
			if($("#code").val()==''){
				alert("请输入证件号");
				$("#code").focus();
				return false;
			}
			if($("#reason").val()==''){
				alert("请输入申诉理由");
				$("#reason").focus();
				return false;
			}
			
			$("#form").submit();
			
		}	
		</script>

	</head>

	<body background="image/body_bg.png">
		<jsp:include page="top.jsp"></jsp:include>
		<div class="content"><!--网站主体 -->
			
				<div class="list-content" style="border:1px solid #666666; background:#ffffff">
					<div class="sba-nav" style="display:inline">
						您在的位置：<a href="<%=basePath %>" target="_blank">首页</a> &gt;
						<b>忘记密码</b>
					</div>
					<form id="form" action="<%=basePath %>passwordReset_submit.action" method="post">
					<div class="article">
                    	<table cellpadding="0" class="passwd_tb" cellspacing="0" border="0" width="70%" align="center">
							<tr>
								<td align="right" width="100"><font>*</font>帐号类型:</td>
								<td><input name="entity.userType"  type="radio" checked="true" value="STUDENT"/> 学生
									<input name="entity.userType"  type="radio" value="TEACHER"/> 教师
									<input name="entity.userType"  type="radio" value="COMPANY"/> 企业
								
								</td>
							</tr>
							<tr>
								<td align="right" width="100"><font>*</font>帐号:</td>
								<td><input name="entity.username" id="username" class="input_text" type="text" value="" /></td>
							</tr>
							
							<tr>
								<td align="right" width="100"><font>*</font>姓名:</td>
								<td><input name="entity.realName" id="realName" class="input_text" type="text"  value="" /></td>
							</tr>
							<tr>
								<td align="right" width="100"><font>*</font>证件类型:</td>
								<td><input name="entity.type" type="radio" checked="true" value="0"/> 学生证
									<input name="entity.type"  type="radio" value="1"/> 教师证
									<input name="entity.type"  type="radio" value="2"/> 身份证
								
								</td>
							</tr>
							<tr>
								<td align="right" width="100"><font>*</font>证件号:</td>
								<td><input name="entity.code" id="code"  class="input_text" type="text" value="" /></td>
							</tr>
							<tr>
								<td align="right" width="100"><font>*</font>申诉理由:</td>
								<td><textarea id="reason" name="entity.reason" value="" cols="50" rows="6" ></textarea></td>
							</tr>
							<tr>
								<td align="right" width="100" style="height:60px; line-height:60px;"></td>
								<td align="left" ><input type="button" style="width:160px; height:30px;" name="button" id="button" value="提交" onclick="submitform()"/></td>
							</tr>
						</table>
					</div>
					</form>
				</div>
			
		</div><!--网站主体 -->
		<jsp:include page="bottom.jsp"></jsp:include>
	</body>
</html>
