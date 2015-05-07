<%@ page language="java"
	import="java.util.*,com.wiiy.commons.action.BaseAction,com.site.Activator"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>申请入驻</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/site/web/css/style.css" type="text/css"
	media="all" />
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div id="main">
		<div class="wrap">
			<div class="contact">
				<h3>申请入驻</h3>
				<form>
					<div>
						<span><label>申请公司</label></span> <span><input type="text"
							value="" /></span>
					</div>
					<div>
						<span><label>Email</label></span> <span><input type="text"
							value="" /></span>
					</div>
					<div>
						<span><label>申请概述</label></span> <span><textarea></textarea></span>
					</div>
					<div>
						<span><a href="#" class="gradiant small green">提交申请</a></span>

					</div>
				</form>
			</div>
			<jsp:include page="menu.jsp"></jsp:include>
		</div>
		<div class="clear"></div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>