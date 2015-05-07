<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科技园区信息管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>核心管理系统</title>
<style type="text/css">
body,div,ul,li,h1,h2,h3,h4,h5,h6,form,pre,input,textarea,td,th,dd,dl,dt,hr,p{ margin:0px; padding:0px;}
img{ border:none;}
body,botton,input,select,textarea{ font:12px/1.5 sumsin,tahoma,Helvetica, Arial, sans-serif;margin:0; padding:0;}
li,dd dt{ list-style:none;}
.hackbox{ clear:both;}
.searchdiv{ padding:10px 10px 20px 10px;}
.counts{ color:#000; font-weight:bold; font-size:14px;}
.searchlist{ width:550px; padding:10px 20px 10px 0; overflow-x:hidden; overflow-y:auto}
.searchlist ul li{padding-bottom:5px;}
.searchlist .bluetitle{color:#00c; font-size:16px;}
.red{ color:#f00;}
.searchlist .black{ color:#000; line-height:20px; font-size:12px;}
.page{padding-top:10px; height:26px; line-height:26px; text-align:right; padding-right:22px; width:550px;}
.page a:link,.page a:visited,.page a:hover{ color:#36c; text-decoration:none;}
.page .pres{ width:42px; height:24px; line-height:24px; padding:0px 5px; border:1px solid #ccc; display:inline-block; padding-left:15px; cursor:pointer; margin-right:10px; text-align:left;}
.page .num{ width:26px; height:24px; line-height:24px; margin-right:5px; border:1px solid #ccc; text-align:center; color:#36c; display:inline-block; position:relative; top:2px; _top:1px; cursor:pointer;}
.page .numavtive{ width:26px; height:24px; line-height:24px; margin-right:5px; border:1px solid #fd6d01; text-align:center; color:#fd6d3f; display:inline-block; position:relative; top:2px; _top:1px; background:#ffede1;cursor:pointer; font-weight:bold;}
.page .numline{ width:20px; height:24px; line-height:24px; text-align:center; color:#333; display:inline-block;}
.page .nexts{ width:42px; height:24px; line-height:24px; padding:0px 10px 0px 5px; border:1px solid #ccc; display:inline-block;  padding-left:8px; cursor:pointer; margin-right:10px; text-align:left;}
.page .nextText{ height:24px; line-height:24px; color:#333; text-align:center; display:inline-block;}
.page .input{ width:50px; height:24px; line-height:24px; display:inline-block;}
.page .inputs{ width:30px; height:18px; line-height:18px; border:1px solid #999; text-align:center;}
.page .searchdiv{ width:45px; display:inline-block;}
.page .btn{ width:41px; height:20px;  border:none; position:relative; top:4px; *+top:0px; _top:-1px;}


.searchInput { padding:10px 0 10px; border-bottom:1px solid #ccc; margin-bottom:20px;}
.searchInput .ipt { font-size:14px; height:28px; width:200px; vertical-align:middle;}
.searchInput .btn {width: 95px;height: 32px; font-size:14px; vertical-align:middle; padding: 0;}

.searchInput .tab { padding-bottom:10px; font-size:14px;  }
.searchInput .tab a { margin:0 5px; color:#333;}
.searchInput .tab a.on { font-weight:bold;}
</style>

<script type="text/javascript">
	function jumpPage(pageNo){
		var url = "<%=basePath%>search.action?keyword="+document.getElementById("keyword").value+"&pageNo="+pageNo;
		url = encodeURI(url);
		location.href=url;
	}
</script>

</head>
<body>
<div class="searchdiv" id="searchdiv">
    <div class="searchInput">
    	<!-- <p class="tab">
        	<a href="#" title="" class="on">文档</a>
            <a href="#" title="">文件</a>
            <a href="#" title="">附件</a>
        </p> -->
        
        <div>
        	<input type="text" id="keyword" name="" class="ipt" value="${keyword}"/>
            <input type="button" value="搜索" class="btn" onclick="jumpPage(1);"/>
        </div>
        
    </div>
	<div class="counts">关键字：${keyword} <span class="red">总${page.totalCount}条</span></div>
	<div class="searchlist">
		<ul>
			<c:forEach items="${page.result}" var="document">
			<li class="bluetitle"><a href="${document.url}" target="_black">${document.title}</a></li>
			<li class="black">${document.content}</li>
			</c:forEach>
		</ul>
	</div>
	<jsp:include page="pager.jsp" />
</div>
</body>
</html>
