<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${rootLocation}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
 <script>
$(document).ready(function() {
	/* //$("#resizable").resizable(); */
	$("#resizable").css("height",window.parent.document.documentElement.clientHeight-52);
	//右击菜单
	var imageMenuData = [
	    [{
	        text: "加载",
			classname: "smarty_menu_ico0",
	        func: function(e) {
	            if (confirm("您确定要加载")) {
	            	sendRequest("load", $(this).attr("bundleId"));
	            }
	        }
	    }, {
	        text: "卸载",
			classname: "smarty_menu_ico2",
	        func: function(e) {
				if (confirm("您确定要卸载")) {
					sendRequest("unload", $(this).attr("bundleId"));
				}
	        }
	    }]
	];
	
/* 	$("#appul li").smartMenu(imageMenuData);
 */
	$("#appul li").click(function(){
		$(this).attr("class", "appli2");
		$(this).siblings().attr("class", "appli1");
		$("#bundleId").val($(this).attr("bundleId"));
		sendRequest("detail", $(this).attr("bundleId"));
	});
	sendRequest("detail", $(".appli2").attr("bundleId"));

});

function goTab(tabUri) {
	if ($("#bundleId").val() == null || $("#bundleId").val() == "") {
		location.href="${contextLocation}"+tabUri;
	} else {
		location.href="${contextLocation}"+tabUri+"?bundleId="+$("#bundleId").val();
	}
}
function sendRequest(action, bundleId) {
    $.ajax({
        async : false,
        url:"${contextLocation}appConsole!"+action+".action",
        type:"post",
        data:{"bundleId" : bundleId},
        error:function (XMLHttpRequest, textStatus, errorThrown) {
            alert(errorThrown);
        },
        success:function(r) {
            if (r.success) {
            	$("#app_name").text(r.value.name);
            	$("#app_version").text(r.value.version);
            	$("#app_isPlugin").text(r.value.isPlugin.title);
            	$("#app_status").text(r.value.status.title);
            	$("#app_lastChangeStatus").text(r.value.lastChangeStatus);
            	$("#app_msg").html("<pre>"+r.value.msg+"</pre>");
            } else {
            	alert(r.msg);
            }
        }
    });
}
</script>
</head>

<body>

<!--container-->
<div id="container">
<input type="hidden" name="bundleId" id="bundleId" value="${bundleId}" />
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="182" valign="top">
			<div class="agency" id="resizable" >
			<!--titlebg-->
			<div class="titlebg">应用列表</div>
			<!--//titlebg-->
			<!--applist-->
			<div class="applist">
				<ul id="appul">
					<c:forEach var="app" items="${appDtoList}" varStatus="rowStatus">
					<c:if test="${empty bundleId and rowStatus.first}">
						<li class="appli2" bundleId="${app.bundleId}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${not empty bundleId and app.bundleId eq bundleId}">
						<li class="appli2" bundleId="${app.bundleId}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${empty bundleId and not rowStatus.first}">
						<li class="appli1" bundleId="${app.bundleId}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${not empty bundleId and app.bundleId ne bundleId}">
						<li class="appli1" bundleId="${app.bundleId}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
			<!--//applist-->
            </div></td>
        <td width="100%" valign="top">
		<!--msglist-->
		<div class="msglist" id="msglist">
		<!--titlebg-->
			<div class="titlebg">应用信息</div>
		 <!--//titlebg-->
		<!--appmsglist-->
		<div class="appmsglist">
			<!--apptab-->
 			<div class="apptab" id="apptab">
				<ul>
					<li class="apptabliover" ><a href="javascript:goTab('appConsole.action')">应用信息</a></li>
					<li class="apptabli" ><a href="javascript:goTab('appParam.action')">应用参数</a></li>
					<li class="apptabli"><a href="javascript:goTab('dataDict.action')">数据字典</a></li>
				</ul>
			</div>
 			<!--//apptab-->
			<!--appname应用信息-->
			<div class="appname">
				
			  <div class="divlays">
			    <form id="form1" name="form1" method="post" action="">
			      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td class="layertdleft100">应用名称：</td>
                      <td id="app_name">&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="layertdleft100">版本：</td>
                      <td id="app_version">&nbsp;</td>
                    </tr>
                     <tr>
                      <td class="layertdleft100">是否插件：</td>
                      <td id="app_isPlugin">&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="layertdleft100">状态：</td>
                      <td id="app_status">&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="layertdleft100">注册日期：</td>
                      <td id="app_lastChangeStatus">&nbsp;</td>
                    </tr>
<!--                     <tr>
                      <td class="layertdleft100">注册日志查看：</td>
                      <td><input name="textfield4" type="text" class="input200" /></td>
                    </tr>
 -->
                   </table>
                </form>
		      </div>
		    </div>
		</div>
		<!--//appmsglist-->
		<div id="app_msg" class="application">
		</div>
        </div>
		<!--//msglist-->		
		</td>
      </tr>
  </table>
</div>
<!--//container-->
</body>
</html>
