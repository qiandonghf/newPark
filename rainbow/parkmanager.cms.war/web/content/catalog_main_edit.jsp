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

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
var pid = "${result.value.parentType.id}";
$(document).ready(function(){
	initTip();
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
			"articleType.typeName":"required"
		},
		messages: {
			"articleType.typeName":"请填写栏目名称"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			if($("#paramId").val() == ''){
				showTip("所属网站不能为空");
				return;
			}
			if($("#typeId").val() != "${result.value.parentType.id}"){
				var str = "您此次操作更改了上级目录，\n";
				str += "该操作会将当前栏目下的所有下级栏目级别合并，\n";
				str += "成为当前栏目的下级栏目。";
				if(confirm(str) == false){
					return;
				}
			}
			$(form).ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("parent.fb.end();getOpener().reloadList();getOpener().refreshTree();", 2000);
		        	}else{
		        		setTimeout("parent.fb.end();", 2000);
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

function setSelectedParam(param) {
 	$("#paramId").val(param.id);
 	$("#paramName").val(param.name);
}

function selectCatlog(){
	var pId = $("#paramId").val();
	fbStart('选择上级目录','<%=basePath %>web/content/catlog_select.jsp?paramId='+pId+'&kind=LIST',550,358);
}

function setSelectedCatlog(catlog) {
 	$("#typeId").val(catlog.id);
 	$("#typeName").val(catlog.name);
 }
 
function deleteCatlog(catlog) {
 	$("#typeId").val("");
 	$("#typeName").val("");
 }
 
</script>
</head>
<body>
<form action="<%=basePath %>articleType!update.action" method="post" name="form1" id="form1">
<input name="articleType.id" type="hidden" value="${result.value.id}"/>
<input id="paramId" type="hidden" name="articleType.paramId" value="${result.value.paramId}"/>
<!--basediv-->
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">栏目名称：</td>
      <td class="layerright"><input name="articleType.typeName" type="text" class="inputauto"  value="${result.value.typeName}"/></td>
      <td class="layertdleft100">是否隐藏栏目：</td>
      <td class="layerright">
      	 <label>
     	 <input type="radio" name="articleType.display" value="<%=BooleanEnum.YES%>" <c:if test="${result.value.display eq 'YES'}">checked="checked"</c:if>/>&nbsp;显示
         </label>
         <label>
         <input type="radio" name="articleType.display" value="<%=BooleanEnum.NO%>" <c:if test="${result.value.display eq 'NO'}">checked="checked"</c:if> />&nbsp;隐藏
	 	 </label>
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">栏目类型：</td>
      <td class="layerright" colspan="3">
      	<table>
      		<tr>
      			<td>
		       		<enum:select type="com.wiiy.cms.preferences.enums.ArticleKindEnum" 
		       			name="articleType.kind" checked="result.value.kind"/>
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
			<input type="hidden" name="param.id" value="${result.value.param.id}"/>
			<input readonly="readonly" id="paramName" name="param.name" value="${result.value.param.name}" type="text" class="inputauto" />
		</td>
		<td class="layertdleft100">上级目录：</td>
        <td class="layerright">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td><label>
	            <input readonly="readonly" id="typeName" name="articleType.text" type="text" class="inputauto" value="${result.value.text}" onclick="selectCatlog();"/>
	            <input id="typeId" type="hidden" name="articleType.parentId" value="${result.value.parentType.id}" />
	          </label></td>
	          <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCatlog();"/></td>
	          <td width="16" style="padding-left:4px;" title="清空栏目"><img src="core/common/images/cancelico.gif" width="16" height="16" onclick="deleteCatlog();"/></td>
	        </tr>
	      </table>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">排列顺序：</td>
      <td class="layerright"><label>
      	<input name="articleType.displayOrder" type="text" class="inputauto" id="displayOrder" value="${result.value.displayOrder}"/>
      </label></td>
      <td class="layertdleft100">显示位置：</td>
      <td class="layerright">
      	  <label>
		      <select name="articleType.displayPositionId">
		      	<option value="">----请选择----</option>
		      	<c:forEach items="${displayPositions }" var="dataDict">
		      	<option <c:if test="${result.value.displayPositionId eq dataDict.id }">selected="selected"</c:if> 
		      	value="${dataDict.id }">${dataDict.dataValue }</option>
		     	</c:forEach>
		      </select>
	      </label>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">关鍵字：</td>
      <td class="layerright" colspan="3" style="padding-bottom:2px;"><label>
        <textarea name="articleType.keyWord" class="inputauto" style="resize:none;height:60px;">${result.value.keyWord}</textarea>
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">描述：</td>
      <td class="layerright" colspan="3" style="padding-bottom:2px;"><textarea name="articleType.ext2" class="inputauto" style="height:60px;resize:none;">${result.value.ext2}</textarea></td>
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
