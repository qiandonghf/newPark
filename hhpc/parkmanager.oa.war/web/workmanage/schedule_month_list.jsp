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
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script>
   	$(document).ready(function() {
  		$("#resizable").css("height",getTabContentHeight());
	});
</script>
</head>

<body>
<!--emailtop-->
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建日程','<%=basePath %>web/workmanage/schedule_add.jsp',550,313);" ><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.href='<%=basePath %>schedule!list.action'"><span><img src="core/common/images/viewdata.gif"/></span>日历</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.href='<%=basePath %>web/workmanage/schedule_month_list.jsp'"><span><img src="core/common/images/viewdata.gif"/></span>月历</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.href='<%=basePath %>web/workmanage/Schedule_task.jsp'"><span><img src="core/common/images/viewdata.gif"/></span>提醒</li>
		</ul>
	</div>
	<!--//leftemail-->
</div>
<!--//emailtop-->
<div class="cal_m_container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="week_title">
		<th>星期一</th>
		<th>星期二</th>
		<th>星期三</th>
		<th>星期四</th>
		<th>星期五</th>
		<th>星期六</th>
		<th>星期日</th>
	</tr>
</table>
<div class="cal_m_content" id="resizables">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="selected_border">
				<div class="date_box">
					<div class="month_date">1</div>
				</div>
			</td>
			<td class="selected_border">
			<div class="date_box">
				<div class="month_date">2</div>
			</div>
			</td>
			<td class="selected_border">
				<div class="date_box">
					<div class="month_date">3</div>
				</div>
			</td>
			<td class="selected_border">
			<div class="date_box">
				<div class="month_date">4</div>
			</div>
			</td>
			<td class="selected_border">
				<div class="date_box">
					<div class="month_date">5</div>
				</div>
			</td>
			<td class="selected_border">
				<div class="date_box">
					<div class="month_date">6</div>
				</div>
			</td>
			<td class="selected_border">
				<div class="date_box">
					<div class="month_date">7</div>
				</div>
			</td>
		
		</tr>
		<tr>
			<td class="selected_border">
				<div class="date_box">
					<div class="month_date">8</div>
				</div>
			</td>
			<td class="selected_border">
				<div class="date_box">
					<div class="month_date">9</div>
				</div>
			</td>
			<td class="selected_border">
				<div class="date_box">
					<div class="month_date">10</div>
				</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
		
		</tr>
		<tr>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
		
		</tr>
		<tr>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
		
		</tr>
		<tr>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
			<div class="date_box">sdasdf</div>
			</td>
			<td class="selected_border">
				<div class="date_box">sdasdf</div>
			</td>
		</tr>
	</table>
</div>
</div>
</body>
</html>
