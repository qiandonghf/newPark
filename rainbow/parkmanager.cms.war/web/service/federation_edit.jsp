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
	var oldId = '';
	var oldAtt = null;
	$(document).ready(function() {
		initTip();
		initForm();
		
		initUploadify("fileUpload2","*.*;",uploadify.directory.attachments,"上传附件");
		initUploadify("fileUpload",uploadify.images.fileTypeExts,"photo","上传图片");
		if("${result.value.photo}" != ''){
			setText("${result.value.photo}","${result.value.oldName}");
		}
	});
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"federation.name":"required",
				"param.name":"required",
				"type.typeName":"required"
			},
			messages: {
				"federation.name":"请填写名称",
				"param.name":"请选择所属网站",
				"type.typeName":"请选择文章栏目"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(checkCK){
					$("#attsPath").val(getAttsList());
					$("#contentText").val(CKEDITOR.instances.content.document.getBody().getText());
					$("#content").val(CKEDITOR.instances.content.getData());
					var old= $("#oldName").val();
					old = encodeURIComponent(old);
					old = encodeURIComponent(old);
					$("#oldName").val(old);
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
			}
		});
	}
	
	function getAttsList(){
		var topicPaths = '[';
		var obj = $("#topicList2").children();
		$(obj).each(function (i){
			var child = $(this).children();
			var oldName = $(child).eq(2).children().eq(0).children().val();
			oldName = encodeURIComponent(oldName);
			oldName = encodeURIComponent(oldName);
			var str = "{\"filePath\" : \""+$(child).eq(1).val()+"\",";
			str += "\"fileName\" : \""+oldName+"\"}";
			topicPaths += str+",";
		})
		if(topicPaths.lastIndexOf(",") == topicPaths.length-1)
			topicPaths = topicPaths.substr(0,topicPaths.length-1);
		return topicPaths+"]";
	}
	
	function initUploadify(id,type,directory,name){
		var root = '<%=BaseAction.rootLocation %>/';
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'cms','directory':directory},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: root+"core/upload.action",
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: "80",//按钮图片的长度
			'height'			: "18",//按钮图片的高度
			'buttonText'		: name,
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: type,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: type,//可上传上的文件类型
			'onUploadSuccess'	: function(file, data, response){
				if(name == '上传附件')
					onUploadSuccess(file, data, response,false);
				else
					onUploadSuccess(file, data, response,true);
			}
		});
	}
	
	function onUploadSuccess(file, data, response,isDel) {
		showTip("文件读取成功!",2000);
		var data = $.parseJSON(data);
		var path = data.path;
		var newName = data.name;
		var oldName = data.originalName;
		if(isDel){
			if(oldAtt == null){
				oldAtt = path;
				setText(path,oldName);
			}else{
				deleteAtt(oldAtt,path,oldName,newName);
				oldAtt = path;
			}
		}else{
			setAttsText(path,oldName,newName);
		}
	}
	
	function deleteAtt(old,path,oldName,newName){
		$.ajax({
			type:"POST",
			 url: "<%=basePath %>federation!deleteByFilePath.action",
			data:"filePath="+old,
			success: function(msg){
			     if(msg.result.success){
			    	 $("#topicList").children().eq(0).remove();
			    	 setText(path,oldName);
			    	 showTip("文件读取成功!",2000);
			     }
			}
		});
	}
	
	function deleteAttr(obj) {
		var obj = $(obj).parent().parent().parent();
		$.ajax({
			type:"POST",
			 url: "<%=basePath %>federation!deleteByFilePath.action",
			data:"filePath="+$("#filePath").val(),
			success: function(msg){
			     showTip(msg.result.msg,2000);
			     if(msg.result.success){
			    	 $(obj).remove();
			    	 oldAtt = null;
			     }
			}
		});
	}
	
	function closeFrame(){
		var isTrue = $("#filePath").val() == '';
		if(!isTrue){
			$.ajax({
				type:"POST",
				 url: "<%=basePath %>federation!deleteByFilePath.action",
				data:"filePath="+$("#filePath").val(),
				success: function(msg){
				     showTip(msg.result.msg,2000);
				     if(msg.result.success){
				    	 parent.fb.end();
				     }
				}
			});
		}
		parent.fb.end();
	}
	
	function setAttsText(path,oldName,newName){
		var htmlText = $("#topicList2").html();
		htmlText += "<div class='downlist2'>";
		htmlText +="<img src='core/common/images/downloadico.png' />";
		htmlText +="<input type='hidden' value=\'"+path+"\'/>";
		htmlText +="<ul>";
		htmlText +="<li><input readonly title=\'"+oldName+"\' value=\'"+oldName+"\' />";
		htmlText +="</li><li>";
		//htmlText +='<a href="javascript:void(0)" onclick="">下载</a>';
		//htmlText +='<a href="javascript:void(0)" onclick="rename(this)">重命名</a>';
		htmlText +="<a href=\'javascript:void(0)\' onclick=\'deleteAttr(this)\'>删除</a>";
		htmlText +="</li>";
		htmlText +="</ul>";
		htmlText +="</div>";
		$("#topicList2").html(htmlText);
	}
	
	function setText(path,oldName){
		$("#filePath").val(path);
		var htmlText = '';
		if(path == ''){
			htmlText +='<input type="hidden" name="federation.photo" value=""></input>';
			htmlText +='<input type="hidden" name="federation.oldName" value=""></input>';
		}else{
			htmlText += '<div class="downlist">';
			htmlText +='<img src="core/common/images/downloadico.png" />';
			htmlText +='<ul>';
			htmlText +='<li><input readonly name="federation.oldName" value="'+oldName+'" onblur="loseFocus(this)"/>';
			htmlText +='</li><li>';
			//htmlText +='<a href="javascript:void(0)" onclick="">下载</a>';
			//htmlText +='<a href="javascript:void(0)" onclick="rename(this)">重命名</a>';
			htmlText +='<a href="javascript:void(0)" onclick="deleteAttr(this,\'type\')">删除</a>';
			htmlText +='</li>';
			htmlText +='</ul>';
			htmlText +='</div>';
		}
		$("#topicList").html(htmlText);
	}
	
	function initUploadify2(id){
		var root = '<%=BaseAction.rootLocation %>/';
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'cms','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: root+"core/upload.action",
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: "80",//按钮图片的长度
			'height'			: "18",//按钮图片的高度
			'buttonText'		: "上传附件",
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
		});
	}
	
  	function checkCK(){
		for (instance in CKEDITOR.instances) {
			CKEDITOR.instances[instance].updateElement();
		}
		if(isNull("content","文章内容")){
			showTip("请输入文章内容",2000);
			return false;
		}else{
			return true;
		}
	} 
  	
  	function setSelectedCatlog(catlog) {
  	 	$("#typeId").val(catlog.id);
  	 	$("#typeName").val(catlog.name);
  	 }
  	
  	function selectParam(){
  		var name = $("#paramName").val();
  		name = encodeURI(name);
  		name = encodeURI(name);
  		fbStart('选择所属网站','<%=basePath %>web/content/singleParamSelector.jsp?memo=article&kind=LIST&name='+name+"&id="+$("#paramId").val(),400,352);
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
<form action="<%=basePath %>federation!update.action" method="post" name="form1" id="form1">
<input type="hidden" name="federation.contentText" id="contentText"/>
<input type="hidden" name="federation.id" value="${result.value.id }"/>
<input type="hidden" name="federation.kind" value="<%=ArticleKindEnum.LIST%>"/>
<input type="hidden" id="filePath" name="filePath" value="${result.value.photo }"/>
<input type="hidden" id="attsPath" name="attsPath" value=""/>
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td class="layertdleft100"><span class="psred">*</span>联盟名称：</td>
       <td class="layerright"><input name="federation.name" value="${result.value.name }" type="text" class="inputauto" /></td>
       <td class="layertdleft100">联盟标题：</td>
       <td class="layerright"><input name="federation.title" value="${result.value.title }" type="text" class="inputauto" /></td>
    </tr>
    <tr>
       <td class="layertdleft100"><span class="psred"></span>网址域名：</td>
       <td class="layerright"><input name="federation.website" value="${result.value.website }" type="text" class="inputauto" /></td>
	   <td class="layertdleft100">自定义属性：</td>
       <td class="layerright">
		  <input type="checkbox" name="federation.toped" value="<%=BooleanEnum.YES%>" <c:if test="${result.value.toped eq 'YES' }">checked="checked"</c:if> /> 置顶
          <input type="checkbox" name="federation.recommend" value="<%=BooleanEnum.YES%>" <c:if test="${result.value.recommend eq 'YES' }">checked="checked"</c:if> /> 首页推荐
		  <input type="checkbox" name="federation.bold" value="<%=BooleanEnum.YES%>" <c:if test="${result.value.bold eq 'YES' }">checked="checked"</c:if> /> 加粗
	   </td>
    </tr>
    <tr>
	   <td class="layertdleft100">联系电话：</td>
       <td class="layerright"><input name="federation.phone" value="${result.value.phone }" type="text" class="inputauto" /></td>
       <td class="layertdleft100"><span class="psred"></span>Email：</td>
       <td class="layerright"><input name="federation.email" value="${result.value.email }" type="text" class="inputauto" /></td>
    </tr>
    <tr>
		<td class="layertdleft100"><span class="psred">*</span>所属网站：</td>
		<td class="layerright" width="220">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			   <tr>
			     <td width="230"><label>
			       <input readonly="readonly" id="paramName" value="${result.value.param.name }" name="param.name" type="text" class="inputauto" onclick="selectParam();"/>
			       <input id="paramId" type="hidden" name="param.id" value="${result.value.param.id }" />
			     </label></td>
			     <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectParam()"/></td>
			     <td>&nbsp;</td>
			   </tr>
			 </table> 
		</td>
       <td class="layertdleft100"><span class="psred">*</span>文章栏目：</td>
       <td class="layerright" width="220">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="230" id="catTd"><label>
	            <input readonly="readonly" id="typeName" name="type.typeName" value="${result.value.articleType.typeName }" type="text" class="inputauto" onclick="selectCatlog()"/>
	            <input id="typeId" type="hidden" name="type.id" value="${result.value.articleType.id }" />
	          </label></td>
	          <td width="20"><img id="catLog" src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCatlog()"/></td>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
      </td>
    </tr>
    <tr>
    	<td class="layertdleft100">联盟logo：</td>
    	<td colspan="3" class="height60">
    		<div id="resourceList" style="margin-left:2px;float:left;">
				<table>
					<tr>
				        <td>
				        	<table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
								<tr>
					              <td valign="top" style="padding:6px 0px;">
									<input type="file" name="upload" id="fileUpload" />
							      </td>
							      <td id="topicList" colspan="3"></td>
					            </tr>
					          </table>
					  	</td>
					</tr>
				</table>
			</div>
    	</td>
    </tr>
    <tr>
       <td class="layertdleft100">文章内容：</td>
       <td class="layerright" colspan="3" style="padding-top:1px;">
     		<textarea id=content name="federation.content" style="height:200px;margin-top:2px;" class="textareaauto">${result.value.content }</textarea>
			<script type="text/javascript">
				CKEDITOR.replace( 'content',{height:125});
			</script>
       </td>
    </tr>
    <tr>
       <td class="layertdleft100">附件上传：</td>
       <td class="layerright" colspan="3" style="padding-top:1px;">
       		<div id="topic">
				<input id="fileUpload2" name="uploadify" type="file"/>
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
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="closeFrame();"/></label>
  </div>
</form>
</body>
</html>
