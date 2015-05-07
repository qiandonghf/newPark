<%@page import="com.wiiy.cms.preferences.enums.NewsTypeEnum"%>
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
<title>普通文章</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" >
	$(document).ready(function() {
	});
	
</script>
<style>
	.attrdown{
		margin-top:5px;
		padding-left:5px;
		border:1px solid #e4e4e4;
		height:60px;
		overflow-y:auto;
 		overflow-x: none;
	}
	.downlist,.downlist2{
		width:210px;
		padding:4px 10px;
	}
	
	.downlist img,.downlist2 img{
		float:left; 
		padding-right:5px; 
		position:relative; 
		top:2px;
	}
	.downlist a:link{
		color: #1f699d;
		padding-right: 10px;
	}
	.downlist2 a:link{
		color: #1f699d;
		padding-right: 10px;
	}
	
	.downlist input,.downlist2 input{
		border:0px;
	}
	.height60{
		height:60px;
	}
	
</style>
</head>

<body>
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td class="layertdleft100">联盟名称：</td>
       <td class="layerright">${result.value.name }</td>
       <td class="layertdleft100">联盟标题：</td>
       <td class="layerright">${result.value.title }</td>
    </tr>
    <tr>
       <td class="layertdleft100">网址域名：</td>
       <td class="layerright">${result.value.website }</td>
	   <td class="layertdleft100">自定义属性：</td>
       <td class="layerright">
       	  <c:if test="${result.value.toped eq 'YES' }">
       	  	置顶
       	  </c:if>
       	  <c:if test="${result.value.recommend eq 'YES' }">
       	  	首页推荐
       	  </c:if>
       	  <c:if test="${result.value.bold eq 'YES' }">
       	  	加粗
       	  </c:if>
	   </td>
    </tr>
    <tr>
	   <td class="layertdleft100">联系电话：</td>
       <td class="layerright">${result.value.phone }</td>
       <td class="layertdleft100"><span class="psred"></span>Email：</td>
       <td class="layerright">${result.value.email }</td>
    </tr>
    <tr>
		<td class="layertdleft100"><span class="psred"></span>所属网站：</td>
		<td class="layerright">
			${result.value.param.name }
		</td>
       <td class="layertdleft100"><span class="psred"></span>文章栏目：</td>
       <td class="layerright">
	      ${result.value.articleType.typeName }
      </td>
    </tr>
    <tr>
    	<td class="layertdleft100">联盟logo：</td>
    	<td colspan="3" id="topicList" class="height60">
    		<div class="downlist">
    			<img src="core/common/images/downloadico.png"/>
    			<ul>
    				<li>
    					<input readonly="" name="federation.oldName" value="mayun.jpg" onblur="loseFocus(this)"/>
    				</li>
    				<li>
    					<a href="javascript:void(0)" onclick="">下载</a>
    				</li>
    			</ul>
    		</div>
    	</td>
    </tr>
    <tr>
       <td class="layertdleft100">文章内容：</td>
       <td class="layerright" colspan="3" style="padding-top:1px;">
     		<textarea id=content name="federation.content" readonly="readonly" style="resize:none;border:0px;color:#666;height:200px;margin-top:2px;" class="inputauto">${result.value.content }</textarea>
			<script type="text/javascript">
				CKEDITOR.replace( 'content',{height:125});
			</script>
       </td>
    </tr>
    <tr>
       <td class="layertdleft100">附件：</td>
       <td class="layerright" colspan="3" style="padding-top:1px;">
       		<div id="topic">
				<div class="attrdown">
					<!-- 上传的专题文件列表 -->
					<div id="topicList2" style="display:block;">
					</div>
				</div>
			</div>
       </td>
    </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="" style="height:5px;"></div>
</body>
</html>
