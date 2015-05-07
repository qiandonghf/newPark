<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>

<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#template").css("height",getTabContentHeight()-60);
	});
	
	function configTemplate(id){
		$("#msglist").show();
		$(".libg").removeClass("libg");
		$("#template"+id).addClass("libg");
		$("#templateName").html($(".libg").children().first().html()+"&nbsp;&nbsp;&nbsp;");
		$(".dataProperty:checked").attr("checked",false);
		$.post("<%=basePath%>dataTemplate!loadConfig.action?id="+id,function(data){
			if(data.result.success){
				loadTree(data.result.value);
			}
		});
	}
	function getTreeSelectedIds(tree){
		var roots = $("#"+tree).tree("getRoots");
		var propertyIds = "";
		for(var i = 0; i < roots.length; i++){
			if(roots[i].checked) {
				propertyIds += this.id +",";
			}
		}
	}
	function saveTemplateConfig(){
		var names = document.getElementsByName("dataId");   
		var ids = "";
	    var len = names.length;   
		if (len > 0) {   
			var i = 0;   
			for (i = 0; i < len; i++){
			   if(names[i].checked){
			      var id = names[i].value;
				  ids += id+",";
			   }
			}   
	    } 
		ids = deleteLastCharWhenMatching(ids,",");
		$.post("<%=basePath%>webInfoConfig!save.action",{"ids":ids},function(data){
			if(data.result.success){
				showTip(data.result.msg,2000);
			}
		});
	}
	
</script>

</head>
<body>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			
			<td width="100%" valign="top">
				<div class="msglist" id="msglist">
					<div class="datatemplate" id="template">
						<ul style="padding:5px 10px; overflow:hidden; zoom:1; height:150px; overflow:auto;" id="tt" class="select-list">
                   			<c:forEach items="${list}" var="w">
                   			<li><input type="checkbox" name="dataId" class="dataId" value="${w.id}"  <c:if test="${w.isCheck eq true}">checked="checked"</c:if> /><label>${w.title}</label></li>
                   			</c:forEach>
                        </ul>
					</div>
					<div class="buttondiv" style="padding-top: 5px;">
						<a href="javascript:void(0)" title="" class="btn_bg" onclick="saveTemplateConfig()"><span><img src="core/common/images/savebtnicon.gif" />订阅</span></a>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>