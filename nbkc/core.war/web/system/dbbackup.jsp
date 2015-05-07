<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>备份管理</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<link href="core/common/tree/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/tree/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".tree").tree({
			animate: true,
			lines: true,
			checkbox: true
		});
		$(parent.window).resize(function(){
			var height = $(parent.window).height();
			$("body").css("height",height);
			$("#pageDiv").css("top",height-175);
		});
	});
	function checkradio(){ 
		var item = $(":checked")
		var len=item.length; 
		if(len>0){ 
		 if($(":radio:checked").val()==2){
		 	$("#times").css({display:"block"});
		 }else{
		 	$("#times").css({display:"none"});
		 }
		} 
	} 

	function jumpPage(page){
		var url = "<%=basePath%>db!list.action";
		url += "?page="+page;
		
		url = encodeURI(url);
		location.href=url;
	}

</script>
<style type="text/css">
	#pageDiv{
		position:absolute;
		width:100%;
		bottom:0px;
	}
</style>
</head>

<body>
<!--container-->
<div id="container">
	<div class="emailtop">
		<!--leftemail-->
		<div class="leftemail">
			<ul>
				<li onclick="showTip('正在清理,请稍候...',60000);document.location.href='<%=basePath %>db!delete.action'" onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/emaildel.png"/></span>清理30天前数据</li>
				<li onclick="showTip('正在备份,请稍候...',60000);document.location.href='<%=basePath %>db!doBackup.action'" onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/backup.png"/></span>立即备份</li>
			
			</ul>
		</div>
		<!--//leftemail-->
	</div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="35" class="tdleftc"><label>
          序号
        </label></td>
        <td width="150" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">备份日期</td>
        <td  class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">备份文件</td>
        <td width="120" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">大小</td>
        <td width="80" class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">操作</td>
      </tr>
      <c:forEach var="dbfile" items="${dbBackupList}" varStatus="rowStatus">
      <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
        <td class="centertd"><label>
          ${rowStatus.index+(pager.page-1)*pager.rows +1}
        </label></td>
        <td class="centertd"><fmt:formatDate pattern="yyyy-MM-dd" value="${dbfile.createTime}"/></td>
        <td class="lefttd">${dbfile.name}</td>
        <td class="centertd">${dbfile.sizeStr}</td>
        <td class="centertd"><a href="<%=basePath%>db!download.action?fileName=${dbfile.name}" target="_blank"><img src="core/common/images/download.png" width="14" height="14" title="下载"/></a></td>
      </tr> 
      </c:forEach>
      
    </table>
</div>
<!--分页开始-->
<div id="pageDiv">
	<%@include file="../pager.jsp" %>
</div>
<!--分页结束-->
 <!--//container-->
 <script type="text/javascript">
 initTip();

 var msg='${msg}';

 if(msg!=''){
 	showTip(msg,3000);
 	
 }
 	
 </script>
</body>
</html>
