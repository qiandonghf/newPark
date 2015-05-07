<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.Investment"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="parkmanager.pb/web/style/merchants.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript">
	var canopen = true;
	var currentIndex = 0;
	function pageheight(nameid1,height1,nameid2,height2){//获取屏幕高度
		var bodyh=window.parent.document.documentElement.clientHeight-height1;
		var bodyh1=window.parent.document.documentElement.clientHeight-height2;
		var bodyw=window.parent.document.documentElement.clientWidth-590;
		document.getElementById(nameid1).style.height=bodyh+"px";
		document.getElementById(nameid2).style.height=bodyh1+"px";
		//document.getElementById(nameid2).style.width=bodyw+"px";
	}
	$(document).ready(function() {

	});
	
	function evalById(id,applyId){
		canopen = false;
		currentIndex = 3;
		fbStart('项目评审','<%=basePath%>garden!evalEdit.action?id='+id+"&applyId="+applyId,700,612);
	}
	
	function viewById(id,applyId){
		canopen = false;
		currentIndex = 3;
		fbStart('查看项目','<%=basePath%>garden!evalView.action?id='+id+"&applyId="+applyId,700,612);
	}
	
	function showApply(id,applyId){
		if(canopen){
			currentIndex = 0;
			fbStart('项目评审','<%=basePath%>garden!evalView.action?id='+id+"&applyId="+applyId,700,612);
		}else
			canopen = true;
	}
	
</script>
<style type="text/css">
	table td{
	word-break: keep-all;
	white-space:nowrap;
	}
</style>
</head>

<body>

<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td  valign="top" id="fee_lefts">
	  <div class="write_list" style="width:100%;" id="resizable">
	  	<h3 style="padding-left:12px;line-height:40px;background-color: #f5f5f5;font-weight: bold;">项目列表</h3>
        <!--merter_fee-->
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="lsittable">
              <c:forEach items="${result.value }" var="eval">
              <c:set var="apply" value="${eval.gardenApply}"/>
              <tr onmouseover="this.style.background='#f4f4f4'" 
              	  onmouseout="this.style.background='#fff'"
              	  onclick="showApply(${apply.id},${eval.id})">
                <td colspan="4">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #e4e4e4;">
                    <tr>
                      <td width="22" height="22"><c:if test="${eval.finished eq 'NO' }"><img style="padding:0 5px 0px 12px;" src="core/common/images/gth.png" width="4" height="10" /></c:if></td>
                      <td>${apply.projectName }<span class="reivew_text" style="padding:0 0 0 10px;">
                      		<c:choose>
                      		<c:when test="${eval.finished eq 'YES' }">
                      		<fmt:formatDate value="${eval.evalTime }" pattern="yyyy/M/d" /> 评审
                      		</c:when>
                      		<c:otherwise>
                      		<fmt:formatDate value="${eval.createTime }" pattern="yyyy/M/d" /> 评审请求
                      		</c:otherwise>
                      		</c:choose>
                      		</span>
                      </td>
                      	<c:choose>
                   		<c:when test="${eval.finished eq 'NO' }">
	                    <td style="cursor:pointer;" width="80" rowspan="2" align="center" onclick="evalById(${apply.id},${eval.id})">
                   			<button>评审</button>
                   		</td>
                   		</c:when>
                   		<c:otherwise>
                      		<td style="cursor:pointer;" width="80" rowspan="2" align="center" onclick="viewById(${apply.id},${eval.id})">
                   		<button>查看</button>
                   		 </td>
                   		</c:otherwise>
                   		</c:choose>
                     
                    </tr>
                    <tr>
                      <td height="22">&nbsp;</td>
                      <td>
                      <div class="fl"><span class="reivew_text">项目来源：${apply.projectSource.title } </span> <span class="reivew_text">项目类型：${apply.projectType.title } </span></div>
                      <div class="fr"><span class="reivew_text">${apply.leaderSchool}</span> <c:if test="${not empty apply.leaderSchool}">|</c:if> <span class="reivew_text">${apply.leaderName}</span> <c:if test="${not empty apply.leaderName}">|</c:if> <span class="reivew_text">${apply.leaderMobile}</span></div>
                      </td>
                    </tr>
                </table>
                </td>
              </tr>
              </c:forEach>
            </table>
	    </div>
 	  </td>
    </tr>
  </table>
</div>
 <!--//container-->
</body>

</html>
