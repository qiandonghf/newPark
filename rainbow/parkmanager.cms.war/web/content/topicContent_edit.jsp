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
	var isNew = false;
	var oldId = '${result.value.param.id}';
	$(document).ready(function() {
		initTip();
		initForm();
		initUploadify("fileUpload");
		$(".hide").hide();
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
				$(form).ajaxSubmit({
			        dataType: 'json',	
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
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
			'buttonText'		: "专题上传", //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: "支持格式:zip",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.zip",//可上传上的文件类型
			'removeCompleted'	: true,
			'onUploadSuccess'	: onUploadSuccess
		});
		$("#fileUpload-queue").css("margin","0px");
		$("#fileUpload").css("margin","0px");
		$("#fileUpload").css("padding-bottom","12px");
		$(".attrdown").css("padding","0px 5px");
	}
	function onUploadSuccess(file, data, response) {
		var data = $.parseJSON(data);
		var path = data.path;
		var oldName = data.originalName;
		setText(path,oldName);
		isNew = true;
	}
	
	function uploadstart(){
    }

	//成功上传文件后显示上传的文件
	function setText(path,oldName){
		var htmlText = $(".attrdown").html();
		htmlText += '<div class="downlist">';
		htmlText +='<img src="core/common/images/downloadico.png" />';
		htmlText +='<input name="articleAtt.newName" type="hidden" value="'+path+'"></input>';
		htmlText +='<ul>';
		htmlText +='<li><input readonly name="articleAtt.oldName" title="'+oldName+'" value="'+oldName+'" onblur="loseFocus(this)"/>';
		htmlText +='</li><li>';
		//htmlText +='<a href="javascript:void(0)" onclick="">下载</a>';
		htmlText +='<a href="javascript:void(0)" onclick="rename(this)">重命名</a>';
		htmlText +='<a href="javascript:void(0)" onclick="deleteAttr(this)">删除</a>';
		htmlText +='</li>';
		htmlText +='</ul>';
		htmlText +='</div>';
		$(".attrdown").html(htmlText);
		$("#filePath").val(path);
		if($(".downlist").size() >= 1){
			$("#fileUpload").empty();
			$("#fileUpload").hide();
			removeQueue();
		}
	}
	
	function removeQueue(){
		$("#fileUpload-queue").hide(2000);
		$(".attrdown").css("padding","15px 5px");
	}
	
	//删除上传的文件
	function deleteAttr(obj) {
		var obj = $(obj).parent().parent().parent();
		var path = $(obj).children().eq(1).val();
		if($(".hide").hide()){
			$(".hide").show();
		}
		if(isNew){
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
			$("#filePath").val();
		}else{
			$("#filePath").val(path+".-d");
			showTip("删除文件成功!",2000);
		}
		$(obj).remove();
		initUploadify("fileUpload");
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
	
	function exportTopic(filePath,fileName){
		var url = "<%=basePath%>article!export.action?filePath="+filePath+"&fileName="+fileName;
		$("#downLoad").attr("src",url);
	}
	
	function selectParam(){
  		var name = $("#paramName").val();
  		name = encodeURI(name);
  		name = encodeURI(name);
  		fbStart('选择所属网站','<%=basePath %>web/content/singleParamSelector.jsp?memo=article&kind=${result.value.kind}&name='+name+"&id="+$("#paramId").val(),400,352);
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
  		fbStart('选择文章栏目','<%=basePath %>web/content/catlog_select.jsp?paramId='+pId+'&kind=LIST',550,400);
  	}
</script>
<style type="text/css">
	#topic{
		margin-bottom:2px;
		height:92px;
	}
	.attrdown{
		padding-left:5px;
		border:1px solid #e4e4e4;
		height:60px;
		overflow:hidden;
	}
	.downlist{
		padding:10px 0px;
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
	.downlist a:visited{
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
<iframe id="downLoad" src="about:blank" style="display:none" width="0px" height="0px"></iframe>
<form action="<%=basePath %>article!topicUpdate.action" method="post" name="form1" id="form1">
<input type="hidden" name="article.kind" value="<%=ArticleKindEnum.TOPIC%>"/>
<input type="hidden" name="article.id" value="${result.value.id}"/>
<input type="hidden" name="articleAtt.id" value="${articleAtt.id}"/>
<input type="hidden" id="filePath" name="filePath" value=""/>
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td class="layertdleft100">专题标题：</td>
       <td class="layerright"><input name="article.title" value="${result.value.title}" type="text" class="inputauto" /></td>
    </tr>
    <tr>
		<td class="layertdleft100">所属网站：</td>
		<td class="layerright" width="220">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			   <tr>
			     <td width="230"><label>
			       <input readonly="readonly" id="paramName" name="param.name" value="${result.value.param.name}" type="text" class="inputauto" onclick="selectParam();"/>
			       <input id="paramId" type="hidden" name="param.id" value="${result.value.param.id}" />
			     </label></td>
			     <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectParam()"/></td>
			     <td>&nbsp;</td>
			   </tr>
			 </table> 
		</td>
    </tr>
    <tr>
       <td class="layertdleft100">文章栏目：</td>
       <td class="layerright" width="220">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="230" id="catTd"><label>
	            <input readonly="readonly" id="typeName" name="article.articleType.text" type="text" class="inputauto" value="${result.value.articleType.typeName}" onclick="selectCatlog()"/>
	            <input id="typeId" type="hidden" name="article.typeId" value="${result.value.typeId}"/>
	          </label></td>
	          <td width="20"><img id="catLog" src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCatlog()"/></td>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
      </td>
    </tr>
    <tr>
       <td class="layertdleft100">上传专题：</td>
       <td class="layerright">
			<div id="topic">
				<c:choose>
					<c:when test="${null == articleAtt}">
						<input id="fileUpload" name="uploadify" type="file"/>
					</c:when>
					<c:otherwise>
						<div class="hide">
							<input class="hide" id="fileUpload" name="uploadify" type="file"/>
							<script>
								$(function(){
									$(".attrdown").css("padding","15px 5px");
								});
							</script>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="attrdown">
					<!-- 上传的专题文件列表 -->
					<c:if test="${null != articleAtt}">
						<div class="downlist">
							<img src="core/common/images/downloadico.png" />
							<input name="articleAtt.newName" type="hidden" value="${articleAtt.newName}"/>
							<ul>
								<li>
									<input name="articleAtt.oldName" readonly title="${articleAtt.oldName}" value="${articleAtt.oldName}" onblur="loseFocus(this)"/>
								</li>
								<li>
									<a href="javascript:void(0)" onclick="rename(this)">重命名</a>
									<a href="javascript:void(0)" onclick="exportTopic('${articleAtt.newName}','${articleAtt.oldName}');">下载</a>
									<a href="javascript:void(0)" onclick="deleteAttr(this)">删除</a>
								</li>
							</ul>
						</div>
					</c:if>
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
