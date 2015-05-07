<%@page import="com.wiiy.commons.util.CalendarUtil"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ page import="com.wiiy.oa.preferences.enums.*"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page import="com.wiiy.commons.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Integer dayNo = Integer.parseInt(DateUtil.format(new Date(), "dd"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>员工日报</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<style>
	.selectTd{
		margin-top: 12px;
	}
</style>
<script type="text/javascript" >
	$(document).ready(function() {
		initTip();
	});
	
  	function toSubmit(form1){
  		var receiver = $("#receiver").val();
  		if(receiver==undefined){
  			showTip("请先设置报送人",2000);
  			return;
  		}
  		var names = document.getElementsByName("content");
  		var len = names.length;
  		if (len > 0) {
  			var j = 0;
  		    for (var i = 0; i < len; i++){
  		    	if(names[i].value==""){
  		    		j++;
  		    	}
  		    }   
  		    if(j==len){
  		    	showTip("请填写内容",2000);
  	  			return;
  		    }
  		 }  
		form1.submit();
        window.opener.location.reload(); 
        self.close(); 
	} 
  	
	function deleteTr(obj){
  		$(obj).parent().parent().parent().parent().parent().parent().remove();
  	}
  	
</script>
</head>

<body style="background:#fff;">

<form action="<%=basePath%>workDayReport!update.action" method="post"  name="form1" id="form1">
<input type="hidden" id="status" name="workDayReport.status"/>
<input type="hidden" id="id" name="workDayReport.id" value="${workDayReport.id}"/>
<!--basediv-->
<div class="basediv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="4" class="layertdleftblack" style=" border-right:none; background:#cbcbcb; color:#003877;">
		<h2 style="text-align:center; padding-top:5px">员工日报</h2>
		</td>
      </tr>
      <tr>
        <td class="layertdleftblack">日期：</td>
        <td colspan="3" class="layerrightblack"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
              	 <fmt:formatDate value="${workDayReport.curDate}"  pattern="yyyy-MM-dd" var="d2"/>
           		${d2}
            </td>
          </tr>
        </table></td>
      </tr>
	  </table>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      	<td class="layertdleftblack">致：</td>
      	<td width="35%" class="layerrightblack" >
     	 <c:if test="${workReportConfigList ne null}">
		 	<c:forEach items="${workReportConfigList}" var="workReportConfig">
     		 	${workReportConfig.receiver.realName} 
     		 	<input type="hidden" id="receiver" name="workDayReport.receiver" value="${workReportConfig.receiver.realName}"/>
     		</c:forEach> 
      	</c:if>
      	<c:if test="${workReportConfigList==null}">
			<input type="hidden" id="receiver" name="workDayReport.receiver"/>      	
      	</c:if>	
		</td>
      	<td class="layertdleftblack" style=" width:70px; border-left:1px solid #c3c3c3;">汇报人：</td>
      	<td class="layerrightblack" >
			${workDayReport.reporter.realName}
		</td>
      </tr>
	 </table>
	  <table  width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td class="layertdleftblack" style=" width:45px; text-align:center;">当日<br />工作</td>
      	<td >
      	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table">
          <c:forEach items="${workDayDtoList}" var="task" varStatus="s">
          <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;">工作${s.index+1}</td>
            <td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
            	<table border="0" width="100%;">
                	<tr>
                    	<td width="70%">
                    	  	<div style="border:1px solid #ddd; padding:2px;"><textarea rows="2" class="textareaauto2" name="content">${task.title}</textarea></div>
              			</td>
                    	<td>
                   			<enum:select type="com.wiiy.oa.preferences.enums.ReportStatusEnum" name="process" styleClass="selectTd" checked="task.status"/>&nbsp;&nbsp;
                   			<span id="deleteBtn" style="cursor:pointer; color:#06c;" onclick="deleteTr(this)">- 删除工作</span>
                    	</td>
                    </tr>
                    
                </table>
            </td>
          </tr>
          </c:forEach>
           <tr>
            <td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;">工作<input type="hidden" value="${s.index+1}" id="report${s.index+1}"/></td>
            <td style="padding-top:2px;padding-bottom:2px;" class="layerrightblack" >
            	<table border="0" width="100%;">
                	<tr>
                    	<td width="70%">
                    		<div style="border:1px solid #ddd; padding:2px;"><textarea rows="2" class="textareaauto2" name="content"></textarea></div>
                    	</td>
                    	<td>
                   			<enum:select type="com.wiiy.oa.preferences.enums.ReportStatusEnum" name="process" styleClass="selectTd"/>&nbsp;&nbsp;
                   			<span id="deleteBtn" style="cursor:pointer; color:#06c;" onclick="deleteTr(this)">- 删除工作</span>
                    	</td>
                    </tr>
                </table>
            </td>
          </tr>
           <tr id="addTr">
             <td class="layertdleftblack" style="width:54px;height:40px;text-align:center; padding:0px;" colspan="2">
            	<span id="addBtn" style="cursor:pointer; color:#06c;">+ 添加工作</span>
			</td>
          </tr>
		</table>
		</td>
      </tr>
	  </table>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="tempallbtn" value="暂存"  onclick="$('#status').val('TEMPORARY');toSubmit(form1)"/> </label>
  <label><input name="Submit" type="button" class="allbtn" value="提交" onclick="$('#status').val('REPORTED');toSubmit(form1)"/> </label>
  </div>
</form>




<script>

var tr = '<tr>'+
            '<td class="layertdleftblack" style=" width:54px;text-align:center; padding:0px;">工作</td>'	+
           ' <td class="layerrightblack" style="padding-top:2px;padding-bottom:2px;" ><table border="0" width="100%">'+
             ' <tr> '+
               ' <td width="70%">'+
                  '<div style="border:1px solid #ddd; padding:2px;"><textarea rows="2" class="textareaauto2" name="content"></textarea></div>'+
               ' </td>'+
               	'<td><enum:select type="com.wiiy.oa.preferences.enums.ReportStatusEnum" name="process" styleClass="selectTd"/>&nbsp;&nbsp;'+
               	'<span id="deleteBtn" style="cursor:pointer; color:#06c;" onclick="deleteTr(this)"> - 删除工作</span></td> '+
           	   '</tr>'+
             '</table></td>'+
           '</tr>';

$('#addBtn').click(function(){
	$('#addTr').before(tr);
});




</script>
</body>
</html>
