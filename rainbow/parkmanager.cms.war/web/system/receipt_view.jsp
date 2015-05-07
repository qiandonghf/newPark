<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	initTip();
});

function deleteAttr(obj,id) {
	var obj = $(obj).parent().parent().parent();
	var path = $(obj).children().eq(1).val();
	if(confirm("确定删除回执")){
		$.ajax({
			type:"POST",
			 url: "<%=basePath %>receiptAtt!delete.action",
			data:"filePath="+path+"&id="+id,
			success: function(msg){
			     showTip(msg.result.msg,2000);
			     if(msg.result.success){
			    	 $(obj).remove();
			     }
			}
		}); 
	}
}

function downAttr(path,name){
	location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
}

</script>
<style>
	.layerright{
		word-break:break-all;
		width:32%;
	}
	.layertdleft100{
		white-space:nowrap;
		width:18%;
	}
</style>
<style>
	.attrdown{
		height:60px;
		width:100%;
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
		color:#666;
		border:0px;
	}
	.height60{
		height:60px;
	}
	
</style>
</head>

<body style="">
	<input id="param" type="hidden" name="param.id" value="${result.value.id}"/>
	 <input id="imgPath" name="imgPath" type="hidden"/>
	<div class="basediv">
		<!-- <div class="titlebg">网站基本信息</div> -->
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred"></span>企业名称：</td>
					<td width="29%" class="layerright">${result.value.customerName }</td>
					<td class="layertdleft100"><span class="psred"></span>姓名：</td>
					<td width="29%" class="layerright">${result.value.name }</td>
				</tr>
				<tr>
					<td width="40%" class="layertdleft100"><span class="psred"></span>职务：</td>
					<td width="29%" class="layerright">${result.value.position}</td>
					<td width="40%" class="layertdleft100"><span class="psred"></span>联系电话：</td>
					<td width="29%" class="layerright">${result.value.phone}</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>回执内容：</td>
					<td class="layerright" colspan="3" style="padding-left:0px;">
						<textarea class="inputauto" readonly="readonly" style="border:0px;height:80px;resize:none;color:#666;padding-left:4px;">${result.value.content }</textarea>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>附件：</td>
					<td class="layerright" colspan="3" style="padding-left:0px;height:60px;">
						<div class="attrdown">
							<!-- 上传的专题文件列表 -->
							<div id="topicList2" style="display:block;">
								<c:forEach items="${result.value.receiptAtts }" var="att">
									<div class="downlist2">
										<img src="core/common/images/downloadico.png" />
										<input type="hidden" value="${att.newName }" />
										<ul>
											<li>
												<input readonly class="oldName" title="${att.oldName }" value="${att.oldName }" />
											</li>
											<li>
												<a href="javascript:void(0)" onclick="deleteAttr('${att.newName }','${att.oldName }')">下载</a>
												<a href="javascript:void(0)" onclick="deleteAttr(this,${att.id })">删除</a>
											</li>
										</ul>
									</div>
								</c:forEach>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
</body>
</html>
