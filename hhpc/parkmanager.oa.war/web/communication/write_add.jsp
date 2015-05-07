<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initUploadify("fileUpload");
		$("#basediv").css("height",getTabContentHeight());
	});
	
	function initUploadify(){
		$("#file").uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'oa','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: '<%=uploadPath %>core/upload.action',//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: "所有文件",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.*",//可上传上的文件类型
			'onUploadSuccess'	: uploadSuccess
		});
	}
	
	function uploadSuccess(file, data, response){
		$("#attList").append($("<li></li>").append("<label></label>").append($.parseJSON(data).originalName).append("<input type='hidden' value='"+$.parseJSON(data).originalName+"' class='attName' /><input type='hidden' value='"+$.parseJSON(data).path+"' class='attPath' />").append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
			$.post("core/resources/"+$.parseJSON(data).path+"-d");
			$(this).parent().remove();
		}})));
	}
	
	function deleteAtt(obj){
		var path = $(obj).prev().val();
		$.post("core/resources/"+path+"-d");
		$(obj).parent().remove();
	}
	
	function initCkedit(){
		for (instance in CKEDITOR.instances) {
			CKEDITOR.instances[instance].updateElement();
		}
	}
	
	function draft(){
		initCkedit();
		var att  = "";
		var path = "";
		var name = "";
		$(".attPath").each(function(){
			path = $(this).attr("value");
			name = $(this).prev(".attName").attr("value");
			att += path+","+name+";";
		});
		var folder = $("#folder").val();
		$('#form1').ajaxSubmit({ 
	        dataType: 'json',
	        data: {attAddress:att,draft:1 },
	        success: function(data){
        		showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		if(folder == 3){
	        			window.opener.delayReload(2000);
	        		}
	        		setTimeout("self.close();", 1000);
	        	}
	        } 
	    });
	}
	
	function toSubmit(){
		if(notNull("mailTo","收件人")&&notNull("subject","主题")){
			initCkedit();
			var att  = "";
			var path = "";
			var name = "";
			$(".attPath").each(function(){
				path = $(this).attr("value");
				name = $(this).prev(".attName").attr("value");
				att += path+","+name+";";
			});
			var folder = $("#folder").val();
			$('#form1').ajaxSubmit({ 
		        dataType: 'json',
		        data: {attAddress:att },
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		if(folder == 2){
		        			window.opener.delayReload(2000);
		        		}
		        		setTimeout("self.close();", 1000);
		        	}
		        } 
		    });
		}
	}
	
	function setSelectedContacts(users){
		var emails = [];
		var a = 0;
		for(var i = 0; i < users.length; i++){
			if(users[i].email!=null && trim(users[i].email) != ''){
				emails[a++]= users[i].email;
			}
		}
		var mailTos = "";
		if($("#mailTo").html().length>0){
			mailTos = ($("#mailTo").html()).split(";");
		}
		var emailTo = "";
		for(var i = 0; i<emails.length;i++){
			for(var j = 0; j<mailTos.length;j++){
				if(trim(emails[i])==trim(mailTos[j])){
					mailTos[j] = null;
				}
			}
		}
		for(var i=0;i<mailTos.length;i++){
			if(mailTos[i]!=null){
				emailTo += mailTos[i]+";";
			}
		}
		for(var i = 0; i <emails.length; i++){
			emailTo += emails[i]+";";
		}
		emailTo = deleteLastCharWhenMatching(emailTo,";");
		$("#mailTo").html(emailTo);
	}
	
	function textheight(){
		if($("#mailTo").text()==''){
			activeobj.style.height=activeobj.scrollHeight;
		}else{
			activeobj.style.height=activeobj.scrollHeight-4;
		}
	}
	
</script>
</head>
<body>
<form action="<%=basePath %>mail!send.action" method="post" name="form1" id="form1">
<input type="hidden" id="type" value="${type}"/>
<input type="hidden" id="folder" value="${folder}"/>
<input type="hidden" id="mailID" value="${result.value.id}"/>
<!--basediv-->
<div class="basediv" style="overflow-x:hidden; overflow-y:auto;">
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail" <c:if test="${type == 5 }">style="display: none;"</c:if>>
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="toSubmit();" ><span><img src="core/common/images/email_go.png" /></span>发送</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="draft()"><span><img src="core/common/images/emailadd.gif"/></span>存草稿</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="parent.fb.end();" ><span><img src="core/common/images/close.png" /></span>取消</li>
		</ul>
	</div>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed;">
      <tr>
        <td class="layertdleft100"><div style="cursor:pointer;" class="mail-select" onclick="fbStart('选择收件人','<%=BaseAction.rootLocation %>/parkmanager.oa/card!selectCard.action?type=1',520,400);">收件人...</div></td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top: 2px;">
          <tr>
          	<td>
          		<!-- onfocus="window.activeobj=this;this.clock=setInterval(function(){textheight();},100);" -->
				<textarea id="mailTo" name="mailDto.to" onblur="clearInterval(this.clock);"  style="overflow-x:hidden; overflow-y:auto; border: 1px solid #e0e0e0; width:98%;padding:4px;height:20px;"><c:if test="${type == 2 || type == 3 || type ==5}">${receivers }</c:if></textarea>
				<p style="color:#999;">注意：收件人之间须用";"号隔开</p>
			</td>
          	<%--<td><input id = "mailTo" name="mailDto.to" <c:if test="${type == 2 || type == 3 || type ==5}">value="${receivers }"</c:if> type="text" class="inputauto" /></td>--%>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">主题：</td>
        <td class="layerright"><input id="subject" name="mailDto.subject" <c:if test="${type == 4 || type == 5}">value="${result.value.subject }"</c:if> type="text" class="inputauto" /></td>
      </tr>
      <tr>
		<td class="layertdleft100">添加附件：</td>
		<td class="layerright">
		<table border="0" cellspacing="0" cellpadding="0">
	      <tr>
	      <td  width="100"> 
	      	<input id="att" name="mailDto.mailAttDto.name" type="hidden" class="inputauto" />
			<input id="size" type="hidden" class="inputauto" />
	      	<input type="file" id="file" /> <div id="fileQueue"></div> </td>
	      	<td>
				<p style="color:#999;">注意：附件上传大小最大不超过500M</p>
		 	</td>
	      </tr>
      	</table>
      	</td>
	  </tr>
   		
	  <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
	    <tr>
	    <td class="layertdleft100">附件：</td>
	    <td class="layerright">
	      <table border="0" cellspacing="0" cellpadding="0" style="white-space:nowrap;">
	      	<tr><td style="padding-left:5px;width:300px;">
	      		<div id="attList" style="height: 40px;overflow-x:hidden;overflow-y: auto; ">
			      	<c:if test="${type == 4 || type == 5}">
			      		<c:forEach items="${result.value.emailAttDtoList }" var="att">
				      			<li>
				      				<label>${att.name }<input type="hidden" value="${att.name }" class="attName" /><input type="hidden" value="${att.newName }" class="attPath"/><img src="core/common/images/locking.jpg" onclick="deleteAtt(this);"/></label>
				      			</li>
			      		</c:forEach>
			      	</c:if>
		      	</div>
		      	</td>
		      </tr>
	      </table>
	     </td>
	    </tr>
   	</table>
   	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layerright"><label>
          <textarea id="content" name="mailDto.content" rows="15" class="textareaauto"><c:if test="${type != 1}">
          <br/>
          <br/>
          <br/>
          <br/>
          <br/>
          <br/>
		  <hr/>      
          <tr><font size='4'><td >From: </td></font><td>${result.value.sender }</td></tr><br/>
          <tr><font size='4'><td >Sent: </td></font><td><fmt:formatDate value="${result.value.sendDate }" pattern="yyyy年MM月dd日 (E)" /></td></tr><br/>
          <tr><font size='4'><td >To: </td></font><td>${mailTo }</td></tr><br/>
          <tr><font size='4'><td >Subject: </td></font><td>${result.value.subject }</td></tr><br/>
          <br/>
          ${result.value.content }</c:if></textarea>
          <script type="text/javascript">CKEDITOR.replace('content',{height:getTabContentHeight()-250});
          	var re;
	      	window.onresize = function() {
	      		clearTimeout(re);
	      		re = setTimeout(resize,500);//延迟触发		
	      	};
	
	      	function resize(){
	      		CKEDITOR.instances.content.resize( '100%', getTabContentHeight()-250 ,true);
	      	}
          </script>
        </label></td>
      </tr>
      </table>
    </table>
	<div class="hackbox"></div>
</div>
<!--//basediv-->
</form>
</body>
</html>
