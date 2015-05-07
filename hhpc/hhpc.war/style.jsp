<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String url = BaseAction.rootLocation+"/";
%>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<link rel="stylesheet" type="text/css" href="css/index.css" />
<link rel="stylesheet" type="text/css" href="css/base.css" />
<link rel="stylesheet" type="text/css" href="css/menu.css" />
<link rel="stylesheet" type="text/css" href="css/portal.css"/>
<link rel="stylesheet" type="text/css" href="css/zzsc.css" />
<link rel="stylesheet" type="text/css" href="css/login.css" />
<style>
.msgpage {
	height: 22px;
	line-height: 22px;
	background: #ff8a00;
	text-align: center;
	padding: 0px 5px;
	color: #fff;
	position: fixed;
	left: 40%;
	top: 32%;
	z-index: 99999;
}
</style>

<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
	<script type="text/javascript">
		function jumpPage(page){
			var url = "<%=BaseAction.rootLocation+path%>${category.url}&id=${category.id}&page="+page;
			url = encodeURI(url);
			location.href=url;
		}
		
		function go(){
			var page = $("input[name='page']").val();
			page = page.replace(/[^\d]/g,'');
			if(page != ''){
				if(page <= "${pager.total}"){
					if(page == "${pager.page}"){
						alert("当前页面即是请求跳转的页面");
						$("input[name='page']").val('')	
						return;
					}					
					jumpPage(page);
				}
				else{
					$("input[name='page']").val('')					
					alert("跳转的页数应小于总页数");
				}
			}else{
				alert("请输入要跳转的页数");
			}
		}
		
	</script>

