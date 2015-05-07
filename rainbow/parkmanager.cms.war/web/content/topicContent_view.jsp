<%@page import="com.wiiy.cms.entity.ArticleAtt"%>
<%@page import="com.wiiy.cms.preferences.enums.ArticleKindEnum"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ page import="com.wiiy.commons.*"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>员工月报</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" >
	$(function(){
	});
	
	function exportTopic(filePath,fileName){
		var url = "<%=basePath%>article!export.action?filePath="+filePath+"&fileName="+fileName;
		$("#downLoad").attr("src",url);
	}
</script>
<style type="text/css">
	#content{
		padding-right:2px;
		padding-bottom:2px;
	}
	
	.downlist{
		margin:10px 0px;
	}
	
	.attrdown{
		vertical-align:middle; 
		padding:0px 5px 0px 5px; 
		height:60px;
		width:600px; 
		overflow:hidden;
	}
	.downlist img{
		float:left; 
		padding-right:5px; 
		position:relative; 
		top:2px;
	}
	.downlist a:link{
		color: #1f699d;
	}
	.downlist span{
		line-height:16px;
		display:block;
	}
	.downlist input{
		border:0px;
		width:500px;
	}
	
	#hide{
		float:left;
		width:auto;
		display:none;
	}
</style>
</head>

<body>
<iframe id="downLoad" src="about:blank" style="display:none" width="0px" height="0px"></iframe>
<form action="" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td class="layertdleft100">文章标题：</td>
       <td class="layerright">${result.value.title}</td>
    </tr>
    <tr>
       <td class="layertdleft100">文章栏目：</td>
       <td class="layerright">
	        ${result.value.articleType.typeName}
       </td>
    </tr>
    <tr>
       <td class="layertdleft100 contentTitle">专题：</td>
       <td id="content" style="" class="layerright">
			<div class="attrdown">
				<c:forEach items="${result.value.articleAtts }" var="att">
					<div class="downlist">
						<img src="core/common/images/downloadico.png" />
						<span class="hide">${att.oldName}</span>
						<a href="javascript:void(0)" onclick="exportTopic('${att.newName}','${att.oldName}');">下载</a>
						<!-- <a href="javascript:void(0)" onclick="rename(this)">重命名</a>
						<a href="javascript:void(0)" onclick="deleteAttr(this)">删除</a> -->
					</div>
				</c:forEach>
			</div>
       </td> 
    </tr>
  </table>
</div>
<div id="hide"></div>
<!--//divlay-->
<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div style="height:5px;"></div>
<!-- <div class="buttondiv">
</div> -->
</form>
</body>
</html>
