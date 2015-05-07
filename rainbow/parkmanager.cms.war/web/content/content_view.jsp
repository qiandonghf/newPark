<%@page import="com.wiiy.cms.preferences.enums.NewsTypeEnum"%>
<%@page import="com.wiiy.cms.preferences.enums.ArticleKindEnum"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>

<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript" >
	$(document).ready(function() {
		
	});
	
</script>
<style>
	.layerright{
		word-break:break-all;
	}
	.layertdleft100{
		white-space:nowrap;
		width:13%;
		text-overflow:ellipsis;  
	}
	span{
		width:288px;
		white-space:nowrap;
		display:block;
		overflow:hidden;
	}
</style>
</head>

<body>
<form action="" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td class="layertdleft100">文章标题：</td>
       <td class="layerright" title="${result.value.title }"><span>${result.value.title }</span></td>
       <td class="layertdleft100">文章副标题：</td>
       <td class="layerright" title="${result.value.subtitle }"><span >${result.value.subtitle }</span></td>
    </tr>
    <tr>
       <td class="layertdleft100">发布时间：</td>
       <td class="layerright"><span><fmt:formatDate value="${result.value.pubTime }" pattern="yyyy-MM-dd HH:mm"/></span></td>
	   <td class="layertdleft100">自定义属性：</td>
       <td class="layerright">
       	  <c:if test="${result.value.toped eq 'YES'}"><span>置顶</span></c:if>
       	  <c:if test="${result.value.recommend eq 'YES'}"><span>首页推荐</span></c:if>
       	  <c:if test="${result.value.bold eq 'YES'}"><span>加粗</span></c:if>
	   </td>
    </tr>
    <tr>
       <td class="layertdleft100">TAG标签：</td>
       <td class="layerright" title="${result.value.tags }"><span >${result.value.tags }</span></td>
       <td class="layertdleft100">文章来源：</td>
       <td class="layerright"><span>${result.value.source }</span></td>
    </tr>
    <tr>
		<td class="layertdleft100">所属网站：</td>
		<td class="layerright" width="220">
			<span>${result.value.param.name }</span>
		</td>
       <td class="layertdleft100">文章栏目：</td>
       <td class="layerright" width="220">
       		<span>${result.value.articleType.typeName }</span>
      </td>
    </tr>
    <tr>
       <td class="layertdleft100">关键字：</td>
       <td class="layerright">
       		<div style="height:40px;margin-top:2px;margin-bottom:2px;overflow-y:scroll;">${result.value.keyWord }</div>
       </td>
       <td class="layertdleft100">内容摘要：</td>
       <td class="layerright">
       		<div style="height:40px;margin-top:2px;margin-bottom:2px;overflow-y:scroll;">${result.value.summery }</div>
       </td>
    </tr>
    <tr>
    	<td class="layertdleft100">新闻类别：</td>
    	<td class="layerright">
    	<span>
    		<c:if test="${not empty result.value.newsType.title }">${result.value.newsType.title }</c:if>
    		<c:if test="${empty result.value.newsType.title }"><%=NewsTypeEnum.WORDS.getTitle() %></c:if>
    	</span>
    	</td>
    	<td colspan="2" class="height60">
    		<c:if test="${!(empty result.value.photo) }">
	    		<img style="display:block;float:left;" src="core/common/images/downloadico.png" />
	    		<span style="color:#666;display:block;float:left;margin-left:5px;line-height:30px;">${result.value.oldName }</span>
    		</c:if>
    	</td>
    </tr>
    <tr>
       <td class="layertdleft100">文章内容：</td>
       <td class="layerright" colspan="3" style="padding-top:1px;">
       		<div style="height:200px;margin-top:2px;overflow-y:scroll;">
       			${result.value.content }
       		</div>
       </td>
    </tr>
    <tr>
       <td class="layertdleft100">附件上传：</td>
       <td class="layerright" colspan="3" style="padding-top:1px;">
       		<div style="height:80px;overflow-y:scroll;">
       			<c:forEach items="${result.value.articleAtts }" var="att">
					<div style="display:block;margin:10px;">
						<img style="display:block;float:left;" src="core/common/images/downloadico.png" />
	    				<span style="color:#666;display:block;float:left;margin-left:5px;line-height:30px;">${att.oldName }</span>
					</div>
					<div style="clear:both;"></div>
				</c:forEach>
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
<div class="" style="margin:0px;height:5px;">
  <!-- <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="closeFrame();"/></label> -->
</div>
</form>
</body>
</html>
