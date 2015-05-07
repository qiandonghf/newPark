<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
   <script type="text/javascript">
    
    $(document).ready(function() {
		initTip();
	});
	function toSubmit(){
		$('#lockScreenForm').ajaxSubmit({
			success:function(result, statusText) {
				if (result.success) {
			    	parent.fb.end();
				} else {
			    	showTip("密码不正确!", 2000);
				}
			}
		});
	}
	
	
	function document.onkeydown(){
		var e = event || window.event;
        key = e.keyCode;
	    if(key == 116 || key == 13 || key==27 || (e.ctrlKey && key == 82) || (e.ctrlKey && key == 65) || (key == 9) || (key == 38) || (key == 40)) {
	    	event.keyCode=0;
	    	event.cancelBubble=true;
	    	return false;
		}
	}
	
	function window.parent.document.onkeydown(){
		var e = event || window.parent.event;
        key = e.keyCode;
	    if(key == 116 || key == 13 || key==27 || (e.ctrlKey && key == 82) || (e.ctrlKey && key == 65) || (key == 9) || (key == 38) || (key == 40)) {
	    	window.parent.event.keyCode=0;
	    	window.parent.event.cancelBubble=true;
	    	return false;
		}
	}
	
	function nocontextmenu(){
		 event.cancelBubble = true
		 event.returnValue = false;
		 return false;
	}

	function norightclick(){
		var e = event || window.event;
	 	if (window.Event){
	  		if (e.which == 2 || e.which == 3)
	   		return false;
	 	}else if (event.button == 2 || event.button == 3){
			event.cancelBubble = true;
			event.returnValue = false;
	   	return false;
	  }
	}
	function nocontextmenu2(){
		window.parent.event.cancelBubble = true;
		window.parent.event.returnValue = false;
	 	return false;
	}

	function norightclick2(){
		var e = event || window.parent.event;
		if (window.parent.Event){
	  		if (e!=null && (e.which == 2 || e.which == 3))
	   			return false;
	 	}else if (window.parent.button == 2 || window.parent.button == 3){
		  	window.parent.cancelBubble = true;
		  	window.parent.returnValue = false;
	   		return false;
	  	}
	}
	
	document.oncontextmenu = nocontextmenu;  // for IE5+
	document.onmousedown = norightclick;  // for all others
	window.parent.document.oncontextmenu = nocontextmenu2; 
	window.parent.document.onmousedown = norightclick2;
	
</script>
</head>

<body>
<form id="lockScreenForm" name="lockScreenForm" method="post" action="${contextLocation}login!unlockScreen.action">
<div class="basediv">
<div class="lockScreen" style="margin:0px;">
	<input name="user.username" type="hidden" value="${user.username}" />
	<input name="user.password" type="password" class="lock-pwd" value="请输入密码解锁" id="lock-pwd" />
</div>
<div class="hackbox"></div>
</div>
<div class="buttondiv">
	<a href="javascript:void(0)" title="" class="btn_bg" onclick="toSubmit()" ><span><img src="core/common/images/lock_open.png">解锁</span></a>
</div>
</form>
</body>
<script type="text/javascript">
	shBlur("lock-pwd","#333");	//焦点
	//焦点内容转换
	function shBlur(obj,cor){ //获取对象，需要转换的颜色
		var that = document.getElementById(obj),
		txt	 = that.value,
		cor2 = that.style.color;//获取原文字颜色
		that.onfocus=function(){
			if (that.value==txt){
				that.value='';
				that.style.color=cor;	
			}
		};
		that.onblur=function(){
			if (!that.value){	
				that.value = txt;
				that.style.color=cor2;
			}
		};
	}
</script>
</html>
