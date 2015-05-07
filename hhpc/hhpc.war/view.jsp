<%@page import="com.wiiy.cms.entity.Article"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<%
	String path = request.getContextPath().replaceAll("\\/", "");
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=InitListener.webParam.getName() %></title>

<!---样式---->
	<jsp:include page="style.jsp"></jsp:include>
	<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
<!---样式结束----> 
<script type="text/javascript">
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function downAttr(path,name){
	location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
}
</script>
<style>
	.fujian{
		positon:relative;
		overflow:hidden;
	}
	#businessPlan-button{
		position:absolute;
		top:0px;
		left:0px;
	}
	#atts{
		height:50px;
		overflow-y:auto;
		
	}
	#atts li{
		width:110px;
		float:left;
		background-color:#f7f7f7;
		padding:0px;
		margin-right:5px;
		margin-bottom:5px;
		line-height:20px;
	}
	#atts li span{
		padding-right:0px;
		text-align:left;
	}
	#atts li em img{
		margin-top:5px;
		margin-left:5px;
		display:block;
		float:left;
		cursor:pointer;
	}
	.popbox .mainlist li.but{
		line-height:40px;
		height:40px;
	}
	.popbox .mainlist li.but input{
		background: #fff url("images/but_ljfs.png");
	}
	#image{
		text-indent: 0em;
		margin-bottom:10px;
	}
	#image img{
		margin:0px;
		margin-left:28px;
		margin-right:5px;
		border:0px;
		text-indent: 0em;
		float:left;
	}
	#image a{
		text-indent: 0em;
		float:left;
	}
</style>
</head>
<body>

<!---顶部开始---->
	<jsp:include page="header.jsp"></jsp:include>
<!---顶部结束----> 

<!---导航开始---->
	<jsp:include page="navi.jsp"></jsp:include>
<!---导航结束----> 

<!---焦点图开始---->
	<jsp:include page="view_photo.jsp"></jsp:include>
<!---焦点图结束----> 

<!---主体内容开始---->
<div id="main" style="padding-top:25px;"> 
  
  <!---主体内容左侧开始---->
 	<jsp:include page="main_left.jsp">
 		<jsp:param value="${category.id }" name="currentId"/>
 	</jsp:include>
  <!---主体内容左侧结束----> 
  
  <!---主体内容右侧开始---->
  <div id="mainright2"> 
    <!---左侧标题开始---->
    <h1 class="Title5">
      <p>
      	      当前位置：<a href="index.action">首页</a>&nbsp;&nbsp;》
	      <c:if test="${not empty category && not empty category.parentType}"> 
	      	<c:if test="${category.parentType.typeName != '网站首页' }">
				<c:if test="${category.kind=='SINGLE'}">
					<a href="javascript:;">${category.parentType.typeName}</a>&nbsp;&nbsp;》
				</c:if>
				<c:if test="${category.kind=='LIST'}">
					<a href="javascript:;">${category.parentType.typeName}</a>&nbsp;&nbsp;》
				</c:if>
			</c:if>
	      </c:if>
	      <c:if test="${not empty category}">
			<c:if test="${category.kind=='SINGLE'}">
				<a href="javascript:;">${category.typeName}</a>
			</c:if>
			<c:if test="${category.kind=='LIST'}">
				<c:if test="${not empty category.url}">
					<c:if test="${not empty category.url}">
      				<c:if test="${fn:indexOf(category.url, '?') != -1}">
						<a href="${category.url}&id=${category.id}">${category.typeName}</a>
	         		</c:if>
	         		<c:if test="${fn:indexOf(category.url, '?') == -1}">
						<a href="${category.url}?id=${category.id}">${category.typeName}</a>
	         		</c:if>
				</c:if>
				</c:if>
				<c:if test="${empty category.url}">
					<a href="list.action?id=${category.id}">${category.typeName}</a>
				</c:if>	
			</c:if>		      	
	      </c:if>
      </p>
    </h1>
    <!---左侧标题结束---->  
    
    <!---企业介绍具体内容开始---->
    <div class="parkinfo">
        <h1>${article.title }</h1>
        <c:if test="${category.kind != 'SINGLE' }">
		<h2>
			<c:if test="${not empty article.pubTime }">
				<fmt:formatDate value="${article.pubTime }" pattern="yyyy/MM/dd HH:mm"/>
			</c:if>
			<c:if test="${empty article.pubTime }">
				<fmt:formatDate value="${article.createTime }" pattern="yyyy/MM/dd HH:mm"/>
			</c:if>
		   	来源：
		   	<c:if test="${not empty article.source }">${article.source }</c:if>
			<c:if test="${empty article.source }">
				<%=InitListener.webParam.getName() %>
			</c:if>
	    </h2>
        </c:if>
		<ul>
			<li>
			<p>${article.content }</p>
			</li>
			<li>
			<c:if test="${fn:length(article.articleAtts) > 0 }">
			<p> 附件：  </p>
			</c:if>
		     <c:forEach items="${article.articleAtts }" var="att">
		     <c:set value="${att.newName }" var="suffix"></c:set>
		     <%
		     String suffix = pageContext.getAttribute("suffix").toString();
		     String image = "";
		     if(suffix != null){
		   	  if(suffix.endsWith("jpg") || suffix.endsWith("gif")
		   			  || suffix.endsWith(".png")){
		   		  image = "downloadico.png";
		   	  }else if(suffix.endsWith("zip") || suffix.endsWith("rar")
		   			  || suffix.endsWith("7z")|| suffix.endsWith("war")){
		   		  image = "downloadico.png";
		   	  }else if(suffix.endsWith("doc") || suffix.endsWith("txt")
		   			  || suffix.endsWith("docx")){
		   		  image = "doc.gif";
		   	  }else if(suffix.endsWith("ppt")){
		   		  image = "ppt.png";
		   	  }else if(suffix.endsWith("xls")){
		   		  image = "xls.png";
		   	  }else{
		   		  image = "oa_icon3.gif";
		   	  }
		     }
		     %>
		     <p id="image"><img src="images/<%=image %>" width="18" height="18" /><a href="javascript:;" title="点击下载" onclick="downAttr('${att.newName }','${att.oldName }');" class="blue">${att.oldName }</a></p>
		     
		     </c:forEach>
		    <!---附件结束----> 
			</li>
	    </ul>
    </div>
    <!---企业介绍具体内容结束----> 
    
    <c:if test="${category.id eq noticeId }">
    	<!--回执内容开始-->
    <!--<div style="height:200px;">  <p align="center" style="font-size:18px;font-family:微软雅黑;"> <a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image16','','hhpc/images/huizhi2.png',1)" class="popbox-link"><img src="hhpc/images/huizhi.png" name="Image16" width="160" height="160" border="0" id="Image16" /></a></p>

    </div>-->
    <div style="height:50px;"> <p align="center" style="font-size:18px;font-family:微软雅黑;"> <a href="#" onmouseout="MM_swapImgRestore()" class="popbox-link"> <img src="images/huizhi.png" width="40" height="42" /></a></p>       
    </div>
    <div id="screen"></div>
    <!--screen end-->
    
    <div class="popbox">
      <form id="receipt" action="<%=basePath %>save.action?type=receipt" method="post">
      	  <input type="hidden" name="receipt.articleId" value="${article.id }" />
      	  <input type="hidden" name="uploadFileName" value="" />
	      <h2>回执 <span><a class="close-btn" href="javascript:;">关闭</a></span></h2>
	      <div class="mainlist">
	        <ul>
	          <li><span>企业名称：</span>
	          <input name="receipt.customerName" type="text" />         
	          </li>
	          <li><span>姓名：</span>
	          <input name="receipt.name" type="text" />         
	          </li>
	          <li><span>职务：</span>
	          <input name="receipt.position" type="text" />         
	          </li>
	          <li><span>联系电话：</span>
	          <input name="receipt.phone" type="text" />        
	          </li>
	          <li><span>回执内容：</span>
	            <textarea name="receipt.content" cols="60" rows="10"></textarea>
	          </li>
	          <li><span style="dispaly:block;float:left;line-height:22px;">上传附件：</span>
	            <div class="fujian">
					<ul>
						<li><input id="businessPlan" type="file"/></span></li>
					</ul>
					<div id="atts" >
						<ul>
						</ul>
					</div>
				</div>
	          </li> 
	          <li class="but">
	            <input name="" type="button" onclick="saveReceipt('receipt')" class="but_ljfs" />
	          </li>
	        </ul>
	      </div>
      </form>
    </div>
    <div class="hackbox"></div>
    <!--popbox end--> 
    
    <script type="text/javascript">
    function initUploadify(id,name,width,isBusiness){
		var root = '<%=BaseAction.rootLocation %>/';
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'pb','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: root+"upload.action",
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: width,//按钮图片的长度
			'height'			: "20",//按钮图片的高度
			'buttonText'		: '<span class="uploadify-button-text" style="text-align:center;padding-right:0px;">上传</span>',
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: "*.*",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.*",//可上传上的文件类型
			'onUploadSuccess'	: function(file, data, response){
				onUploadSuccess(file, data, response,isBusiness);
			}
		});
	}
    
    function saveReceipt(id){
    	$("input[name='uploadFileName']").val(getAttsList());
    	$("#"+id).ajaxSubmit({
    		dataType: 'json',		        
	        success: function(data){
        		alert(data.result.msg,2000);
	        	if(data.result.success){
	        		$('.popbox').fadeOut(function(){ $('#screen').hide(); });
	        	}
	        } 
    	});
    	return;
    }
    
    function getAttsList(){
		var topicPaths = '[';
		var obj = $("#atts").children().eq(0).children();
		$(obj).each(function (i){
			var oldName = $(this).children().eq(1).attr("title");
			oldName = encodeURIComponent(oldName);
			oldName = encodeURIComponent(oldName);
			var str = "{\"filePath\" : \""+$(this).children().eq(0).val()+"\",";
			str += "\"fileName\" : \""+oldName+"\"}";
			topicPaths += str+",";
		})
		if(topicPaths.lastIndexOf(",") == topicPaths.length-1)
			topicPaths = topicPaths.substr(0,topicPaths.length-1);
		return topicPaths+"]";
	}
    
    function onUploadSuccess(file, data, response,isBusiness) {
		var info = $.parseJSON(data);
		var path = info.path;
		var oldName = decodeURI(info.originalName);
		var size = info.size;
		var obj = $("#atts").children().eq(0);
		$(obj).html($(obj).html()+setText(path,oldName));

	}
    
    function setText(path,oldName){
    	var str = "";
    	if(oldName.length > 10){
    		str = oldName.substring(0,10);
    		str += "...";
    	}else{
    		str = oldName;
    	}
		var htmlText = "";
		htmlText += "<li>";
		htmlText +="<input type=\'hidden\' value=\'"+path+"\'/>";
		htmlText +="<span title=\'"+oldName+"\'>"+str+"</span>";
		htmlText +="<em><img  onclick=\'removeAttr(this);\' src=\'images/xtopico3.png\' /></em>";
		htmlText +="</li>";
		return htmlText;
	}
    
    function removeAttr(obj){
    	if(confirm("确定要删除吗")){
    		$(obj).parent().parent().remove();
    	}
    }
    
	$(document).ready(function(){
		initTip();
		initUploadify("businessPlan","上传","90",true);
		$('.close-btn').click(function(){
			$('.popbox').fadeOut(function(){ $('#screen').hide(); });
			return false;
		});
		
		$('.popbox-link').click(function(){
			var h = $(document).height();
			$('#screen').css({ 'height': h });	
			$('#screen').show();
			$('.popbox').center();
			$('.popbox').fadeIn();
			return false;
		});
		
	});

	jQuery.fn.center = function(loaded) {
		var obj = this;
		body_width = parseInt($(window).width());
		body_height = parseInt($(window).height());
		block_width = parseInt(obj.width());
		block_height = parseInt(obj.height());
		
		left_position = parseInt((body_width/2) - (block_width/2)  + $(window).scrollLeft());
		if (body_width<block_width) { left_position = 0 + $(window).scrollLeft(); };
		
		top_position = parseInt((body_height/2) - (block_height/2) + $(window).scrollTop());
		if (body_height<block_height) { top_position = 0 + $(window).scrollTop(); };
		
		if(!loaded) {
			
			obj.css({'position': 'absolute'});
			obj.css({ 'top': top_position, 'left': left_position });
			$(window).bind('resize', function() { 
				obj.center(!loaded);
			});
			$(window).bind('scroll', function() { 
				obj.center(!loaded);
			});
			
		} else {
			obj.stop();
			obj.css({'position': 'absolute'});
			obj.animate({ 'top': top_position }, 200, 'linear');
		}
	}
	</script> 
    <!--回执内容结束--> 
    </c:if>
    
    <c:if test="${not empty articleMap }">
    	<%
    	HashMap<Integer,Article> map = (HashMap<Integer,Article>)request.getAttribute("articleMap");
    	Article lastArticle = map.get(1);
    	Article nextArticle = map.get(2);
    	%>
	    <!---nextpage---->
	    <div class="nextpage">
	      <p><span>上一篇：
	      	  <%if(lastArticle != null){ %>
	      	  <% String content = lastArticle.getTitle();
		      	if(content.length() > 21){
		    		content = content.substring(0,20);
		    		content += "...";
		        }
		       %>
		      <a title="<%=lastArticle.getTitle() %>" href="view.action?id=<%=lastArticle.getId() %>&pos=<%=lastArticle.getRecord() %>"><%=content %></a>
		      <%}else{%>
		      <a href="javascript:;">没有了</a>
		       <%}%>
	      </span>下一篇：
	          <%if(nextArticle != null){ %>
	          <% String content = nextArticle.getTitle();
		      	if(content.length() > 21){
		    		content = content.substring(0,20);
		    		content += "...";
		        }
		       %>
		      <a title="<%=nextArticle.getTitle() %>" href="view.action?id=<%=nextArticle.getId() %>&pos=<%=nextArticle.getRecord() %>"><%=content %></a>
	      	  <%} else{%>
		      <a href="javascript:;">没有了</a>
		       <%}%>
	      </p>
	    </div>
	    <!---nextpage---->
    </c:if>
    
    <div class="hackbox"></div>
  </div>
  <!---主体内容右侧结束---->
  
  <div class="hackbox"></div>
</div>
<!---主体内结束----> 

<!---底部开始---->
	<jsp:include page="footer.jsp"></jsp:include>
<!---底部结束---->
</body>
</html>
