<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String urlPath = BaseAction.rootLocation+"/";
%>
<script>
$(document).ready(function() {
	initNoticeList();
});
function initNoticeList(){
	$("#list").empty();
	$.post("<%=BaseAction.rootLocation %>/parkmanager.oa/notice!initNoticeList.action",function(data){
		 if(data.noticeList!=null){
			var noteList = data.noticeList;
			var noteLi = "";
			for(var i = 0;i<noteList.length;i++){
				var li = "";
				var id = noteList[i].id;
				var time = noteList[i].time.substring(0,10);
				var name = noteList[i].title;
				if(name.length>12){
					name = name.substring(0,12)+"...";
				}
				li = "<li><a href='javascript:void(0)' onclick='openNotice("+id+")' ><font color='#333333'>"+name+"</font></a>&nbsp;<span class='cor_999'>"+time+"</span>";
				li = li+"</li>";
				noteLi+=li;
			}
			$("#list").append(noteLi);
		 }
	});
}

function openNotice(id){
	window.open('<%=urlPath%>parkmanager.oa/notice!viewById.action?id='+id);
}

function setstateParma(){
	fbStart("参数设置", "<%=basePath%>web/column_webInfo.jsp", 300, 300);
}
function tj(){
	alert("该版本不支持园区体检");
}
</script>
    <img src="core/common/images/tj-reset.gif" onclick="tj();"/>
    <div class="console-side-box">
    	<div class="gWel-info-more">            
            <div class="gWel-info-more-nav" id="right-tab">
				<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
                    <div class="gWel-info-more-nav-aText">消息公告</div>
                </div>
                   <!-- <div style="padding-left:10px;"><li style="color:blue;">&nbsp;&nbsp; <a style="cursor: pointer;" onclick="setstateParma()">设置新闻参数</a></li></div> -->                
            	<div style="float: right;">
            		<a style="text-decoration: none;" href="<%=urlPath%>parkmanager.oa/web/desktop/notice_add.jsp" class="floatbox" data-fb-options="afterBoxEnd:`reloadNoticeList();`">发布</a>
            		<%-- <a style="text-decoration: none;" href="javascript:void(0);" onclick="fbStart('新建公告信息','<%=urlPath%>parkmanager.oa/web/desktop/notice_add.jsp',600,350);">发布</a> --%>
            	</div>
            </div>
            <div class="gWel-info-more-line"></div>
          	<div class="gWel-info-more-cnt" id="right-cont">
	   			<ul class="list_sy_5" id="list"></ul>
                <ul class="list_sy_5" style="display:none;"></ul> 
            </div>
        	</div>
    </div>
