<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.pb.activator.PbActivator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String url = BaseAction.rootLocation+"/";
Long userId = PbActivator.getSessionUser().getId();
pageContext.setAttribute("userId", userId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
	});

	function save(type){
		if('opinion1'== type){
			var opinion = $("#opinion1Txt").html();
			if(opinion == ""){
				alert("请填写意见");
			}else{
				var id=$("#id").val();
				var url="<%=basePath%>tenementCenterContact!approval.action?approvalType=opinion1&id="+id;
				$.post(url,{opinion:opinion},function(data){
					if(data.result.success){
						showTip(data.result.msg,2000);
						setTimeout(function(){
							location.reload();
						},2000);
					}
					
					
				});
			}
		}
	}
	var approvalType;
</script>
 
 
<style> 
html { overflow:auto;}
h1 { font:bold 16px/32px ''; height:32px; text-align:center;}
</style>
 
</head>
<body>
 
<form action="" method="post" enctype="multipart/form-data" name="form1" id="form1" >
<!--basediv-->
<div class="basediv" style="overflow-x:hidden; overflow-y:scroll; height:300px;margin-bottom:8px;">
 
<h1>浙江大学国家大学科技园物业客户服务中心联系单(退房)</h1>
 
<div class="overflowAuto" id="overflowAuto">
                  
<style type="text/css"> 
<!--
table.tsy1{margin:0 10px; font-weight:bold; }
table.tsy3{margin:0 10px 0 10px; border:1px solid #000000; border-top:none; border-left:none; }
table.tsy3 td{border:1px solid #000; border-right:none; border-bottom:none;  padding:8px 10px; }
table.tsy4{margin:0 10px 0 10px; border:1px solid #000000; border-top:none; border-left:none; }
table.tsy4 td{border:1px solid #000; border-right:none; border-bottom:none;  padding:8px 10px; }
 
.tsy-h80{height:80px; vertical-align:top; }
-->
</style>
<table width="96%" border="0" cellspacing="0" cellpadding="0"  class="tsy1">
      <tr>
        <td width="80">编号：</td>
        <td >&nbsp;</td>
        <td width="80">填表日期：</td>
        <td >&nbsp;&nbsp;&nbsp;&nbsp;年   &nbsp;&nbsp;&nbsp;&nbsp;月  &nbsp;&nbsp;&nbsp;&nbsp; 日</td>
        </tr>
</table>
<table width="96%" border="0" cellspacing="0" cellpadding="0" class="tsy4">
<input type="hidden" id="id" value="${result.value.id }"/>
<input type="hidden" id="customerId" value="${result.value.customerId }"/>
<input type="hidden" id="roomId" value="${result.value.roomId }"/>
     <tr>
        <td colspan="2" width="10%">租赁客户名称</td>
        <td colspan="7">${result.value.customer }</td>
        </tr>
      <tr>
        <td colspan="2">原租赁房屋 房号/面积</td>
        <td colspan="7">${result.value.room.building.name }${result.value.room.name} ${result.value.room.buildingArea }平方米</td>
      </tr>
      <tr>
        <td colspan="2">联系内容</td>
        <td colspan="7">${result.value.content}</td>
      </tr>
    </table>
 <div class="hqxx" style="padding:5px 0 0;">
	<div class="titlebg">会签信息：</div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:2px 0;">
      <tr>
        <td class="layertdleft100"><span class="tsy-h80">物业部门意见：</span></td>
        <td class="layerright" style="padding-top:4px;" colspan="3"><textarea name="textarea"  class="textareaauto" <c:if test="${result.value.opinion1Id ne userId || result.value.opinion1 ne null}">readonly="readonly"</c:if> id="opinion1Txt" style="height:50px;">${result.value.opinion1 }</textarea></td>
        <td width="6%"><input type="hidden" id="opinion1Id" value="${result.value.opinion1Id }" /><label>
	        <c:if test="${result.value.opinion1Id eq userId && result.value.opinion1 eq null }">
	        	<input name="Submit" type="button" onclick="save('opinion1');" class="savebtn1" value="保存" />
	        </c:if>
        </label></td>
      </tr>
    </table>
 </div>
    
<!--[if lte ie 8]> </div><![endif]-->
</div>
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value=" " /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value=" " onclick="parent.fb.end();"/></label>
  </div>-->
</form>
 
 
 
</body>
</html>