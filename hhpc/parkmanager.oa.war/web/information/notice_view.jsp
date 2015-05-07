<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page import="com.wiiy.hibernate.Result"%>
<%@ page import="com.wiiy.oa.entity.Notice"%>
<%@ page import="com.wiiy.oa.preferences.enums.NoticeStatusEnum"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>公告信息</title>
<link rel="stylesheet" type="text/css" href="parkmanager.oa/web/style/oawork.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript">
$(function(){
	initTip();
	if($("#attNames").val()!=""){
		var attNames = {};
		var attSizes = {};
		var attPaths = {};
		attNames = $("#attNames").val().split(",");
		attSizes = $("#attSizes").val().split(",");
		attPaths = $("#attPaths").val().split(",");
		var size = attNames.length;
		$("#attSize").html("附件"+size+"个");
		$.each(attNames,function(i){
			var path = attPaths[i];
			var name = attNames[i];
			 var src = "<img src=\"core/common/images/downloadico.png\" width=\"14\" height=\"14\" title=\"下载\" onclick=\"downLoad('"+path+"','"+name+"');\"  /> ";
			var li1 = $("<li></li>").append(attNames[i]).append($("<span></span>").append("("+attSizes[i]+"KB)"));
			var li2 = $("<li></li>").append("<a href='javascript:void(0)' onclick=\"downLoad('"+path+"','"+name+"');\">下载</a>");
			var ul = $("<ul></ul>").append(li1).append(li2);
			$("#attList").append($("<div class='downlist'></div>").append(src).append(ul)); 
			
			/* <div class="downlist">
			<img src="core/common/images/downloadico.png" />
			<ul>
				<li>项目说明文档.rar<span>(20KB)</span></li>
				<li><a href="javascript:void(0)">下载</a><a href="javascript:void(0)">打开</a></li>
			</ul>
		  </div> */
		});
	}
});
function downLoad(path,name){
	location="/core/resources/"+path+"?name="+name;
}

function onUploadSuccess(file, data, response){
	$("#newName").val($.parseJSON(data).path);
	$("#attList").append($("<li></li>").append("<label></label>").append($.parseJSON(data).originalName).append("<input type='hidden' value='"+$.parseJSON(data).size+"' class='size' /><input type='hidden' value='"+$.parseJSON(data).originalName+"' class='attName' /><input type='hidden' value='"+$.parseJSON(data).path+"' class='attPath' />").append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
		$.post("core/resources/"+$.parseJSON(data).path+"-d");
		$(this).parent().remove();
	}})));
}



</script>
</head>

<body>
<input id="attNames" type="hidden" value="${attNames }"/>
<input id="attSizes" type="hidden" value="${attSizes }"/>
<input id="attPaths" type="hidden" value="${attPaths }"/>
<div class="oaworknews"  id="resizable" style="overflow-x:hidden; overflow-y:auto;">
	<div class="newview">
		<h1>${result.value.name }</h1>
		<h2><fmt:formatDate value="${result.value.issueTime }" pattern="yyyy-MM-dd"/>发布</h2>
		<ul>
			<li>
			  ${result.value.content }
			</li>
		</ul>
        <!--emaildown-->
			<div class="emaildown" id="attList">
				<h1 id="attSize"></h1>
	</div>
    
</div>
</div>
</body>
</html>
