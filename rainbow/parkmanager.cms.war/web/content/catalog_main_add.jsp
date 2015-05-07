<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/demo/demo.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/tree/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/common/tree/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	var info = getOpener().info;
	$("#paramId").val(info.paramId);
	$("#paramName").val(info.paramName);
	if(info.isSingle){
		showTip(info.typeName+'的类型为\"单页文章\",不能作为其他栏目的上级目录!',3000);
		var left = $("body").width()-$("#tip").width();
		$("#tip").css("left",left/2);
	}else{
		$("#typeId").val(info.typeId);
		$("#typeName").val(info.typeName);
	}
	initForm();
	$("#custom").change(function(){
		if($(this).attr("checked") == 'checked')
			$("#customVal").show();
		else
			$("#customVal").hide();
	});
});



function reload(){
	$('#cc').combotree('reload');
}
function setValue(){
	$('#cc').combotree('setValue', 2);
}
function getValue(){
	var val = $('#cc').combotree('getValue');
}
function disable(){
	$('#cc').combotree('disable');
}
function enable(){
	$('#cc').combotree('enable');
}


function initForm(){
	$("#form1").validate({
		rules: {
			"articleType.kind":"required",
			"param.name":"required",
			"articleType.typeName":"required"
		},
		messages: {
			"articleType.kind":"请选择内容模型",
			"param.name":"请选择所属网站",
			"articleType.typeName":"请填写栏目名称"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			$(form).ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("parent.fb.end();getOpener().reloadList();getOpener().refreshTree();", 2000);
		        	}
		        } 
		    });
		}
	});
}

function selectParam(){
	var name = $("#paramName").val();
	name = encodeURI(name);
	name = encodeURI(name);
	fbStart('选择所属网站','<%=basePath %>web/content/singleParamSelector.jsp?name='+name+"&id="+$("#paramId").val(),400,352);
}

function setSelectedCatlog(catlog) {
 	$("#typeId").val(catlog.id);
 	$("#typeName").val(catlog.name);
 }
 
function setSelectedParam(param) {
	$("#paramId").val(param.id);
 	$("#paramName").val(param.name);
 }
 
function selectCatlog(){
	var pId = $("#paramId").val();
	if(pId == null || pId==''){
		showTip("请先选择一个网站",2000);
		return;
	}
	fbStart('选择上级目录','<%=basePath %>web/content/catlog_select.jsp?paramId='+pId+'&kind=LIST',550,358);
}

</script>
</head>

<body>
<form action="<%=basePath %>articleType!save.action" method="post" name="form1" id="form1">
<input id="paramId" type="hidden" name="articleType.paramId" value="${id }" />
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">栏目名称：</td>
      <td class="layerright"><input name="articleType.typeName" type="text" class="inputauto"/></td>
      <td class="layertdleft100">是否隐藏栏目：</td>
      <td class="layerright">
      	 <label>
     	 <input type="radio" name="articleType.display" checked="checked" value="YES"/>&nbsp;显示
         </label>
         <label>
         <input type="radio" name="articleType.display" value="NO"/>&nbsp;隐藏
	 	 </label>
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">栏目类型：</td>
      <td class="layerright" colspan="3">
      	<table>
      		<tr>
      			<td>
		       		<enum:select type="com.wiiy.cms.preferences.enums.ArticleKindEnum" name="articleType.kind" />
      			</td>
      			<td>
      				<label style="overflow:hidden;margin-right:3px;"><input type="checkbox" id="custom" <c:if test="${not empty result.value.url}">checked="checked"</c:if> style="margin:3px 2px 3px 5px;display:block;float:left;"/><span>自定义</span></label>
      			</td>
      			<td id="customVal" <c:if test="${empty result.value.url}">style="display:none;"</c:if>><input  name="articleType.url" type="text" class="input170"  value="${result.value.url}"/></td>
      		</tr>
      	</table>
      </td>
    </tr>
    <tr>
		<td class="layertdleft100">所属网站：</td>
		<td class="layerright">
			<input readonly="readonly" id="paramName" name="param.name" type="text" class="inputauto"/>
		</td>
		<td class="layertdleft100">上级目录：</td>
		<td class="layerright">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			   <tr>
			     <td><label>
			       <input readonly="readonly" id="typeName" name="articleType.text" type="text" class="inputauto" onclick="selectCatlog();"/>
			       <input id="typeId" type="hidden" name="articleType.parentId" />
			     </label></td>
			     <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCatlog();"/></td>
			     <td>&nbsp;</td>
			   </tr>
			 </table> 
		</td>
    </tr>
    <tr>
      <td class="layertdleft100">排列顺序：</td>
      <td class="layerright">
		<input id="displayOrder" name="articleType.displayOrder" type="text" class="inputauto"/>
      </td>
      <td class="layertdleft100">显示位置：</td>
      <td class="layerright">
	      <label>
		      <select name="articleType.displayPositionId">
		      	<option value="">----请选择----</option>
		      	<c:forEach items="${displayPositions }" var="dataDict">
		      	<option value="${dataDict.id }">${dataDict.dataValue }</option>
		     	</c:forEach>
		      </select>
	      </label>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">关鍵字：</td>
      <td class="layerright" colspan="3" style="padding-bottom:2px;"><label>
        <textarea name="articleType.keyWord" class="inputauto" style="resize:none;height:60px;"></textarea>
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">描述：</td>
      <td class="layerright" colspan="3" style="padding-bottom:2px;"><textarea name="articleType.ext2" class="inputauto" style="height:60px;resize:none;"></textarea></td>
    </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
