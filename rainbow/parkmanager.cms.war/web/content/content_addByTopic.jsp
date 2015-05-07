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
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript" >
	$(document).ready(function() {
		initTip();
		initForm();
		initUploadify("fileUpload");
	});
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"article.title":"required",
				"article.articleType.text":"required"
			},
			messages: {
				"article.title":"请填写专题标题",
				"article.articleType.text":"请选择专题栏目"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$("#filePath").val(getTopic());
				$(form).ajaxSubmit({
			        dataType: 'json',	
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	
	function initUploadify(id){
		var location = "<%=BaseAction.rootLocation %>/";
		$("#"+id).uploadify({
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'cms','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: location+"core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: 65,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'uploadLimit'       : 1,
			'buttonText'		: "专题上传", //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: "支持格式:zip",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.zip",//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess,
			'removeCompleted'	: true,
			'uploadstart'		: uploadstart
		});
	}
	function onUploadSuccess(file, data, response) {
		var data = $.parseJSON(data);
		var path = data.path;
		var oldName = data.originalName;
		setText(path,oldName);
	}
	
	function uploadstart(){
    }

	//成功上传文件后显示上传的文件
	function setText(path,oldName){
		var htmlText = $("#topicList").html();
		htmlText += '<div class="downlist">';
		htmlText +='<img src="core/common/images/downloadico.png" />';
		htmlText +='<input type="hidden" value="'+path+'"></input>';
		htmlText +='<ul>';
		htmlText +='<li><input readonly title="'+oldName+'" value="'+oldName+'" onblur="loseFocus(this)"/>';
		htmlText +='</li><li>';
		//htmlText +='<a href="javascript:void(0)" onclick="">下载</a>';
		htmlText +='<a href="javascript:void(0)" onclick="rename(this)">重命名</a>';
		htmlText +='<a href="javascript:void(0)" onclick="deleteAttr(this)">删除</a>';
		htmlText +='</li>';
		htmlText +='</ul>';
		htmlText +='</div>';
		$("#topicList").html(htmlText);
	}
	
	//删除上传的文件
	function deleteAttr(obj) {
		var obj = $(obj).parent().parent().parent();
		var path = $(obj).children().eq(1).val();
		$.ajax({
			type:"POST",
			 url: "<%=basePath %>article!deleteByFilePath.action",
			data:"filePath="+path,
			success: function(msg){
			     showTip(msg.result.msg,2000);
			     if(msg.result.success){
			    	 $(obj).remove();
			     }
			}
		});
	}
	
	//重命名
	function rename(obj){
		var obj = $(obj).parent().parent();
		var child = $(obj).children().eq(0).children().eq(0);
		$(child).removeAttr("readonly");
		$("#hide").text($(child).val());
		if($("#hide").width()+5 < $("#topic").width()-20)
			$(child).css("width",$("#hide").width()+5+"px");
		else
			$(child).css("width","500px");
		$(child).focus();
	}
	
	//重命名失去焦点
	function loseFocus(obj){
		var newName = $(obj).val();
		var oldName = $(obj).attr('title');
		if(newName != oldName){
			$(obj).attr('title',newName);
			$(obj).val(newName);
		}
		$("#hide").text($(obj).val());
		if($("#hide").width()+5 < $("#topic").width()-20)
			$(obj).css("width",$("#hide").width()+5+"px");
		else
			$(obj).css("width","500px");
		$(obj).attr("readonly","readonly");
	}
	
	function getTopic(){
		var topicPaths = '[';
		var obj = $("#topicList").children();
		$(obj).each(function (i){
			var child = $(this).children();
			var str = "{\"filePath\" : \""+$(child).eq(1).val()+"\",";
			str += "\"fileName\" : \""+$(child).eq(2).children().eq(0).children().eq(0).val()+"\"}";
			topicPaths += str+",";
		})
		if(topicPaths.lastIndexOf(",") == topicPaths.length-1)
			topicPaths = topicPaths.substr(0,topicPaths.length-1);
		return topicPaths+"]";
	}
	
  	
  	function setSelectedCatlog(catlog) {
  	 	$("#typeId").val(catlog.id);
  	 	$("#typeName").val(catlog.name);
  	 }
  	
  	function selectParam(){
  		var name = $("#paramName").val();
  		name = encodeURI(name);
  		name = encodeURI(name);
  		fbStart('选择所属网站','<%=basePath %>web/content/singleParamSelector.jsp?memo=article&kind=TOPIC&name='+name+"&id="+$("#paramId").val(),400,352);
  	}

  	function setSelectedParam(param) {
  	 	$("#paramId").val(param.id);
  	 	$("#paramName").val(param.name);
  	 	if(param.id != oldId){
  	 		$("#typeId").val("");
  	  	 	$("#typeName").val("");
  	 	}
  	}
  	
  	function setSelectedCatlog(catlog) {
  	 	$("#typeId").val(catlog.id);
  	 	$("#typeName").val(catlog.name);
  	}
  	
  	function selectCatlog(){
  		var pId = $("#paramId").val();
  		if(pId == null || pId==''){
  			showTip("请先选择一个网站",2000);
  			return;
  		}
  		fbStart('选择文章栏目','<%=basePath %>web/content/catlog_select.jsp?paramId='+pId+"&kind=LIST&memo=article",550,400);
  	}
</script>
<style type="text/css">
	.attrdown{
		margin-top:5px;
		padding-left:5px;
		border:1px solid #e4e4e4;
		height:60px;
		overflow-y:auto;
 		overflow-x: none;
	}
	.downlist{
		margin:10px 0px;
	}
	
	.downlist img{
		float:left; 
		padding-right:5px; 
		position:relative; 
		top:2px;
	}
	.downlist a:link{
		color: #1f699d;
		padding-right: 10px;
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
<form action="<%=basePath %>article!topicSave.action" method="post" name="form1" id="form1">
<input type="hidden" name="article.kind" value="<%=ArticleKindEnum.TOPIC%>"/>
<input type="hidden" id="filePath" name="filePath" value=""/>
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td class="layertdleft100">专题标题：</td>
       <td class="layerright"><input name="article.title" type="text" class="inputauto" /></td>
    </tr>
    <tr>
    	<td class="layertdleft100">所属网站：</td>
		<td class="layerright">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			   <tr>
			     <td width="155"><label>
			       <input readonly="readonly" id="paramName" name="param.name" type="text" class="inputauto" onclick="selectParam();"/>
			       <input id="paramId" type="hidden" name="param.id" />
			     </label></td>
			     <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectParam()"/></td>
			     <td>&nbsp;</td>
			   </tr>
			 </table> 
		</td>
    </tr>
    <tr>
       <td class="layertdleft100">文章栏目：</td>
      <td class="layerright">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="155"><label>
	            <input readonly="readonly" id="typeName" name="article.articleType.text" type="text" class="inputauto" onclick="selectCatlog();"/>
	            <input id="typeId" type="hidden" name="article.typeId" />
	          </label></td>
	          <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCatlog();"/></td>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
      </td>
    </tr>
    <tr>
       <td class="layertdleft100">上传专题：</td>
       <td class="layerright">
			<div id="topic">
				<input id="fileUpload" name="uploadify" type="file"/>
				<div class="attrdown">
					<!-- 上传的专题文件列表 -->
					<div id="topicList" style="display:block;">
					</div>
				</div>
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
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
