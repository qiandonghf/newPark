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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>

<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript" >
	var oldId = '';
	var name = null;
	var lastPic = ["","",""];
	$(document).ready(function() {
		$("#newsType").children().eq(0).remove();
		initTip();
		initForm();
		initTime();
		$("#resourceList").hide();
		initUploadify("fileUpload2","*.*;",uploadify.directory.attachments,"上传附件");
		$("#newsType").change(typeChange);
		typeChange();
		if("${result.value.newsType}" != '<%=NewsTypeEnum.WORDS %>'){
			if("${result.value.photo}" != ''){
				setText("${result.value.photo}","${result.value.oldName}","${result.value.newName}");
				$("#resourceList").show();
			}
		}
	});
	function typeChange (){
		var text = $("#newsType").val();
		var type;
		var directory = "photo";
		var fun = "onUploadSuccess";
		$(".pic").hide();
		if(text == 'PHOTO'){
			name = "上传图片";
			type = uploadify.images.fileTypeExts;
		}else if(text == 'VIDEO'){
			name = "上传视频";
			type = "*.flv;";
		}
		initUploadify("fileUpload",type,directory,name);
		if(text != '<%=NewsTypeEnum.WORDS %>'){
			$("#resourceList").show();
		}
		else{
			$("#resourceList").hide();
		}
	}
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"article.title":"required",
				"param.name":"required",
				"article.articleType.text":"required"
			},
			messages: {
				"article.title":"请填写文章标题",
				"param.name":"请选择所属网站",
				"article.articleType.text":"请选择文章栏目"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				setTime();
				if(checkCK){
					$("#attsPath").val(getAttsList());
					$("#contentText").val(CKEDITOR.instances.content.document.getBody().getText());
					$("#content").val(CKEDITOR.instances.content.getData());
					checkTag();
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
	
	function checkTag(){
		var child = $("#checked").children();
		$(child).each(function(i){
			if(!!$(this).attr("checked"))
				$(this).val('YES');
			else
				$(this).val('NO');
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
			setText(path,oldName);
		}else{
			setAttsText(path,oldName,newName);
		}
	}
	
	function deleteAttr(obj,type) {
		var name =  $(obj).parent().parent().children().eq(0).children().val();
		var obj = $(obj).parent().parent().parent();
		if(confirm("您确定要删除 \""+name+"\"")){
			showTip("删除成功",2000);
			if(type == 'type'){
				setText('','');				
			}
			$(obj).remove();
		}
	}
	
	function closeFrame(){
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
			htmlText +='<input type="hidden" name="article.photo" value=""></input>';
			htmlText +='<input type="hidden" name="article.oldName" value=""></input>';
		}else{
			htmlText += '<div class="downlist">';
			htmlText +='<img src="core/common/images/downloadico.png" />';
			htmlText +='<input id="oldName" type="hidden" name="article.photo" value="'+path+'"></input>';
			htmlText +='<ul>';
			htmlText +='<li><input readonly name="article.oldName" value="'+oldName+'" onblur="loseFocus(this)"/>';
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
	
	function setTime(){
		var start = $("#start").val().replace(/(^\s*)|(\s*$)/g, "");
		if(start != ''){
			var hour = $("#startHour").val();
			var min = $("#startMinute").val();
			var time = start+" "+hour+":"+min+":00";
			$("#pubTime").val(time);
		}
	}
	
	function initTime(){
		var time = "${result.value.pubTime}";
		time = time.replace(/(^\s*)|(\s*$)/g, "");
		if(time != ''){
			var start = time.substring(0,10);
			var hour = time.substring(11,13);
			var min = time.substring(14,16);
			$("#start").val(start);
			$("#startHour").val(hour);
			$("#startMinute").val(min);
		}
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
  		fbStart('选择文章栏目','<%=basePath %>web/content/catlog_select.jsp?paramId='+pId+"&kind=${result.value.kind}&memo=article",550,400);
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
	#contentTable{
		table-layout:fixed;
	}
	
</style>
</head>

<body>
<form action="<%=basePath %>article!update.action" method="post" name="form1" id="form1">
<input type="hidden" name="article.id" value="${result.value.id }"/>
<input type="hidden" name="article.contentText" id="contentText"/>
<input type="hidden" name="article.kind" value="<%=ArticleKindEnum.LIST%>"/>
<input type="hidden" id="filePath" name="filePath" value=""/>
<input type="hidden" id="pubTime" name="article.pubTime" value="${result.value.pubTime}"/>
<input type="hidden" id="attsPath" name="attsPath" value=""/>
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" id="contentTable">
    <tr>
       <td class="layertdleft100">文章标题：</td>
       <td class="layerright"><input name="article.title" value="${result.value.title }" type="text" class="inputauto" /></td>
       <td class="layertdleft100">文章副标题：</td>
       <td class="layerright"><input name="article.subtitle" value="${result.value.subtitle }" type="text" class="inputauto" /></td>
    </tr>
    <tr>
	   <td class="layertdleft100">发布时间：</td>
       <td class="layerright">
      	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="100"><input id="start" onclick="showCalendar('start');" readonly="readonly" class="inputauto" /></td>
				<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('start');"/></td>
				<td style="padding-left:5px;">
					<select id="startHour">
					<c:forEach begin="0" end="23" var="s">
						<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
					</c:forEach>
					</select>&nbsp;时
				</td>
				<td>
					<select id="startMinute">
						<c:forEach begin="0" end="59" var="s">
							<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
						</c:forEach>
					</select>&nbsp;分
				</td>
			</tr>
		</table> 
       </td>
	   <td class="layertdleft100">自定义属性：</td>
       <td class="layerright" id="checked">
          <input type="checkbox" name="article.toped" value="${result.value.toped }" <c:if test="${result.value.toped eq 'YES'}">checked</c:if> /> 置顶
          <input type="checkbox" name="article.recommend" value="${result.value.recommend }" <c:if test="${result.value.recommend eq 'YES'}">checked</c:if> /> 首页推荐
		  <input type="checkbox" name="article.bold" value="${result.value.bold }" <c:if test="${result.value.bold eq 'YES'}">checked</c:if> /> 加粗
	   </td>
    </tr>
    <tr>
       <td class="layertdleft100">TAG标签：</td>
       <td class="layerright"><input name="article.tags" value="${result.value.tags }" type="text" class="inputauto" /></td>
       <td class="layertdleft100">文章来源：</td>
       <td class="layerright"><input name="article.source" value="${result.value.source }" type="text" class="inputauto" /></td>
    </tr>
    <tr>
		<td class="layertdleft100">所属网站：</td>
		<td class="layerright" width="220">
			<c:choose>
				<c:when test="${result.value.kind eq 'SINGLE' }">
					<input readonly="readonly" name="param.name" value="${result.value.param.name }" type="text" class="inputauto"/>
				</c:when>
				<c:otherwise>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					   <tr>
					     <td width="230"><label>
					       <input readonly="readonly" id="paramName" name="param.name" value="${result.value.param.name }" type="text" class="inputauto" onclick="selectParam();"/>
					       <input id="paramId" type="hidden" name="param.id" value="${result.value.param.id }" />
					     </label></td>
					     <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectParam()"/></td>
					     <td>&nbsp;</td>
					   </tr>
					 </table> 
				</c:otherwise>
			</c:choose>
		</td>
       <td class="layertdleft100">文章栏目：</td>
       <td class="layerright" width="220">
       	  <c:choose>
       	  	<c:when test="${result.value.kind eq 'SINGLE' }">
       	  		<input readonly="readonly" name="article.articleType.text" value="${result.value.articleType.typeName }" type="text" class="inputauto"/>
       	  	</c:when>
       	  	<c:otherwise>
		      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		          <td width="230" id="catTd"><label>
		            <input readonly="readonly" id="typeName" name="article.articleType.text" value="${result.value.articleType.typeName }" type="text" class="inputauto" onclick="selectCatlog()"/>
		            <input id="typeId" type="hidden" name="article.typeId" value="${result.value.typeId }" />
		          </label></td>
		          <td width="20"><img id="catLog" src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCatlog()"/></td>
		          <td>&nbsp;</td>
		        </tr>
		      </table>
	      	</c:otherwise>
	      </c:choose>
      </td>
    </tr>
    <tr>
       <td class="layertdleft100">关键字：</td>
       <td class="layerright"><textarea name="article.keyWord" class="inputauto" style="height:40px;margin-top:2px;margin-bottom:2px;resize:none;">${result.value.keyWord }</textarea></td>
       <td class="layertdleft100">内容摘要：</td>
       <td class="layerright"><textarea name="article.summery" class="inputauto" style="height:40px;margin-top:2px;margin-bottom:2px;resize:none;">${result.value.summery }</textarea></td>
    </tr>
    <tr>
    	<td class="layertdleft100">新闻类别：</td>
    	<td class="layerright"><enum:select id="newsType" name="article.newsType" checked="result.value.newsType" type="com.wiiy.cms.preferences.enums.NewsTypeEnum"/></td>
    	<td colspan="2" class="height60">
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
   <!--  <tr>
       <td class="layertdleft100">分页方式：</td>
       <td>
          &nbsp;<input type="radio" name="article." value="radiobutton" />&nbsp;是
       	  &nbsp;<input type="radio" name="article." value="radiobutton" />&nbsp;否 (分页符为：       #p#分页、#e#标题)
       </td>
    </tr> -->
    <tr>
       <td class="layertdleft100">文章内容：</td>
       <td class="layerright" colspan="3" style="padding-top:1px;">
     		<textarea id=content name="article.content" style="height:200px;margin-top:2px;" class="textareaauto">${result.value.content }</textarea>
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
						<c:forEach items="${result.value.articleAtts }" var="att">
							<div class="downlist2">
								<img src="core/common/images/downloadico.png" />
								<input type="hidden" value="${att.newName }" />
								<ul>
									<li>
										<input readonly class="oldName" title="${att.oldName }" value="${att.oldName }" />
									</li>
									<li>
										<a href="javascript:void(0)" onclick="deleteAttr(this)">删除</a>
									</li>
								</ul>
							</div>
						</c:forEach>
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
