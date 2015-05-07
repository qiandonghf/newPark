<%@page import="com.wiiy.web.listener.InitListener"%>
<%@page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<script type="text/javascript">
	var cid = "";
	function SetHome(obj,vrl){ 
		try{ 
			obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl); 
		} 
		catch(e){ 
			if(window.netscape) { 
				try { 
					netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); 
				} 
				catch (e) { 
					alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。"); 
				} 
				var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch); 
				prefs.setCharPref('browser.startup.homepage',vrl); 
			}else{ 
				alert("您的浏览器不支持，请按照下面步骤操作：1.打开浏览器设置。2.点击设置网页。3.输入："+vrl+"点击确定。"); 
			} 
		} 
	} 
	function shoucang(sTitle,sURL){ 
		try{ 
			window.external.addFavorite(sURL, sTitle); 
		} 
		catch (e){ 
			try{ 
				window.sidebar.addPanel(sTitle, sURL, ""); 
			} 
			catch (e){ 
				alert("加入收藏失败，请使用Ctrl+D进行添加"); 
			} 
		} 
	} 
	function clickText(obj){
		if($(obj).val() == "搜索站内信息"){
			$(obj).val("");
			$(obj).css("color","#333");
		}
		return;
	};
	
	function onblurs(obj){
		if($(obj).val() == ""){
			$(obj).css("color","rgb(194, 188, 188)");
			$(obj).val("搜索站内信息");
		}
		return;
	}
	
	function oncliwhile(){
		
	}
	function doSearch(id,fid){
		cid = id;
		if(checkForm()){
			$("#"+fid).submit();
		}
		return;
	}
	
	function checkForm(){
		if($("#"+cid).val()==null || $("#"+cid).val().replace(/(^\s*)|(\s*$)/g, "")==''){
			alert("请输入搜索内容");
			$("#"+cid).focus();
			return false;
		}
		if($("#"+cid).val() == '搜索站内信息'){
			$("#"+cid).val("");
			alert("请输入搜索内容");
			$("#"+cid).focus();
			return false;
		}
		return true;
	}
	
	function save(id){
		$("#"+id).ajaxSubmit({ 
	        dataType: 'json',		        
	        success: function(data){
        		alert(data.result.msg,2000);
	        	if(data.result.success){
	        		dealAction(id);
	        	}
	        } 
	    });
	}
	
</script>
<div id="header">
  <div class="top">
    <div class="logo" > <a href="http://www.hhpc.gov.cn/"><img src="images/logo.gif" width="400" height="83" alt="logo" /></a></div>
    <!---顶部右侧开始---->
    <div class="top_right" >
      <div id="site_nav">
      	<a href="javascript:;" onclick="SetHome(this,window.location);">设为首页</a> | 
      	<a href="javascript:;" onclick="shoucang(document.title,window.location);">加入收藏</a> | 
      	<a href="login.action">登录</a></div>
		<form action="<%=BaseAction.rootLocation %>/search.action" method="post" name="form" id="form1">
			<div id="search">
		        <ul>
		            <li class="left"> <span class="TPL_username_1" id="searchs" name="searchs"></span>
		              <input name="searchContent" style="color:rgb(194, 188, 188);" type="text" class="search_input" onblur="onblurs(this);" id="keyword" onclick="clickText(this);" value="搜索站内信息"/>
		            </li>
		            <li class="right">
		              <input type="button" class="btn" style="cursor:pointer;" onclick="doSearch('keyword','form1');" value="" src="images/search.gif"  />
		            </li>
		        </ul>
			</div>
      		<div class="hackbox"></div>
		</form>
    </div>
    <!---顶部右侧结束----> 
  </div>
</div>