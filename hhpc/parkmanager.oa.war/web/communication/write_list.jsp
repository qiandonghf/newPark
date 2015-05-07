<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight()-28);
		var id = $("#mailID").val();
		var folder = $("#folder").val();
		var frame = "<iframe src=\"<%=basePath %>mail!mail.action?id="+id+"&folder="+folder+"\" frameborder=\"0\" id=\"msglist\" width=\"100%\"></iframe>";
		$("#frame").append(frame);
		$("#MID").val(id);
		$("#msglist").css("height",getTabContentHeight());
	});
	
	function mailInfo(mail,id){
		var folder = $("#folder").val();
		$(mail).find(".readed").remove();
		var cssText = "font-weight: normal;cursor:pointer;";
		mail.style.cssText = cssText;
		$("#msglist").attr("src","<%=basePath %>mail!mail.action?id="+id+"&folder="+folder+"");
		$("#MID").val(id);
	}
	
	function deleteMsg(){
		var folder = $("#folder").val();
		var mailID = $("#MID").val();
		if(confirm("确定要删吗")){
			$.post(
				"<%=basePath %>mail!delete.action?id="+mailID+"&folder="+folder,
				function(data){
					showTip(data.result.msg,2000);
					if(data.result.success){
						setTimeout(function(){
							location.reload();
						},2000);
					}
				}
			);
		}
	}
	
	function delayReload(time){
		setTimeout(function(){
			location.reload();
		},time);
	}
	
	function sendMail(type){
		var mailID = $("#MID").val();
		var folder = $("#folder").val();
		if(folder==3 && !mailID){
			showTip("无邮件可发送",2000);
			return false;
		}else{
			window.open('<%=basePath %>mail!sendMail.action?id='+mailID+'&type='+type+'&folder='+folder,'新建邮件','height=500,width=700,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
		}
	}
	
	function checkForm(){
		if(!$("#content").val() && !$("#subject").val()) return false;
		$("#searchForm").submit();
	}
	
	function relay(type){
		var mailID = $("#MID").val();
		var folder = $("#folder").val();
		window.open('<%=basePath %>mail!mailRelay.action?id='+mailID+'&type='+type+'&folder='+folder,'新建邮件','height=500,width=700,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
	}
	function highlight(el){
		$(el).addClass("highlight");
		$(el).siblings().removeClass("highlight").css("background","#fff");
	}
	function keepHighlight(el){
		if($(el).hasClass("highlight")){
			$(el).css("background","#f4f4f4");
		}
	}
	function refreshDiv(){
		$("#resizable").load('<%=basePath %>mail!list.action' + ' #resizable>*');
		var id = $("#mailID").val();
		/* alert(id); */
		var folder = $("#folder").val();
		$("#msglist").attr("src","<%=basePath %>mail!mail.action?id="+id+"&folder="+folder+"");
		$("#MID").val(id);
	}
	
</script>
</head>

<body>
<input type="hidden" id="folder" value="${folder }"/>
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
		<ul>
		<%String value = "";%>
		<c:if test="${folder == 1 }"><%value="list";%></c:if>
		<c:if test="${folder == 2 }"><%value="sendList";%></c:if>
		<c:if test="${folder == 3 }"><%value="draftList";%></c:if>
			<c:if test = "${folder == 3 }">
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="sendMail(5);"><span><img src="core/common/images/emailadd.gif" /></span>发送</li>
				<li class="line">|</li>
				<c:if test="${fn:length(mailList) > 0 }">
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteMsg();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
					<li class="line">|</li>
				</c:if>
			</c:if>
			<c:if test = "${folder !=3 }">
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="sendMail(1);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
					<li class="line">|</li>
					<c:if test="${fn:length(mailList) > 0 }">
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteMsg();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
						<li class="line">|</li>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="sendMail(2);"><span><img src="core/common/images/emailhf.gif" /></span>答复</li>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="sendMail(3);"><span><img src="core/common/images/emailhf.gif" /></span>全部答复</li>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="relay(4);"><span><img src="core/common/images/emailzf.png" width="22" height="13" /></span>转发</li>
						<li class="line">|</li>
					</c:if>
			</c:if>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="refreshDiv();"><span><img src="core/common/images/refresh3.png"/></span>刷新</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('邮件查询','<%=basePath %>web/communication/mail_search.jsp?folder=${folder }',750,457);"><span><img src="core/common/images/searchico.gif"/></span>查询</li>
			<li class="line">|</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''"  <c:if test="${page-1 ge 1}">onclick="location='<%=basePath%>mail!<%=value%>.action?page=1'"</c:if>><span><img src="core/common/images/control_start_blue.png" /></span>最前页</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''"  <c:if test="${page-1 ge 1}">onclick="location='<%=basePath%>mail!<%=value%>.action?page=${page-1}'"</c:if>><span><img src="core/common/images/control_rewind_blue.png" /></span>上一页</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" <c:if test="${page+1 le maxPage}">onclick="location='<%=basePath%>mail!<%=value%>.action?page=${page+1}'"</c:if>><span><img src="core/common/images/control_fastforward_blue.png" /></span>下一页</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" <c:if test="${page+1 le maxPage}">onclick="location='<%=basePath%>mail!<%=value%>.action?page=${maxPage}'"</c:if>><span><img src="core/common/images/control_end_blue.png" /></span>最后页</li>
		</ul>	
	</div>
</div>
<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="350" valign="top" id="fee_lefts">
	  <div id="resizable" class="write_list" style="overflow-x: hidden;overflow-y:hidden;">
        <!--merter_fee-->
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <!-- <td width="17" class="tdleftc"><label><img src="core/common/images/gth.png" width="4" height="10" /></label></td>
                <td width="18" class="tdleftc"><img src="core/common/images/email.gif" width="14" height="10" /></td> -->
                <td width="20" class="tdleftc"><img src="core/common/images/uploadfj.gif" width="7" height="12" /></td>
                <td class="tdcenterL" width="100">发件人</td>
                <td class="tdleftc">主题</td>
                <c:if test="${folder == 2 }"><td width="60" class="tdleftc">发送时间</td></c:if>
                <c:if test="${folder != 2 }"><td width="60" class="tdleftc">接收时间</td></c:if>
                <!-- <td width="20" class="tdrightc"><img src="core/common/images/redflag.gif" width="9" height="10" /></td> -->
              </tr>
             </table>
             <div style="height:368px;overflow-y:auto;">
	             <table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <c:if test="${fn:length(mailList) > 0 }">
		              <c:forEach items="${result.value }" var="mail" varStatus="status">
		              	<c:if test="${status.index == 0}"><input type="hidden" id="mailID" value="${mail.id }"/></c:if>
		              	<tr onmouseover="this.style.background='#f4f4f4';" onmouseout="this.style.background='#fff';keepHighlight(this)" style="cursor:pointer; <c:if test="${!mail.readed && status.index != 0}">font-weight: bold;</c:if>" onclick="mailInfo(this,${mail.id});highlight(this);" >
			                <%-- <td class="centertd"><label><c:if test="${mail.level lt 3 }">&nbsp;  <img src="core/common/images/gth.png" width="4" title="紧急" height="10" /></c:if></label></td>
			                <td class="centertd"><c:if test="${!mail.readed && status.index != 0 && folder == 1}">&nbsp;<img class="readed" src="core/common/images/email.gif" title="未读" width="14" height="10" /></c:if></td> --%>
			                <td class="centertd" style="padding-left: 2px;"><c:if test="${mail.containAttach }">&nbsp;<img src="core/common/images/uploadfj.gif" width="7" height="12" /></c:if></td>
			                <td class="lefttd" style="padding-left: 20px;">${fn:substring(mail.sender,0,8)}<c:if test="${fn:length(mail.sender) > 8 }">...</c:if></td>
			                <td class="centertd">${fn:substring(mail.subject,0,10)}<c:if test="${fn:length(mail.subject) > 10 }">...</c:if></td>
			                <td class="centertd"><fmt:formatDate value="${mail.sendDate }" pattern="MM-dd" />&nbsp;</td>
		              	</tr>
		              </c:forEach>
	              </c:if>
	              <c:if test="${fn:length(mailList) == 0 }"><td class="centertd" colspan="6" align="center">无邮件...</td></c:if>
	            </table>
            </div>
		  </div>
 	  </td>
 	  <td valign="top">
 	  	<c:if test="${fn:length(mailList) > 0 }">
			<div id="frame">
				<input type="hidden" id="MID"/>
			</div>
		</c:if>
	  </td>
    </tr>
  </table>
</div>
 <!--//container-->
</body>

</html>
