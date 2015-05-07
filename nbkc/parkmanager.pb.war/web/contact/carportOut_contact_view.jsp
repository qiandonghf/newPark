<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
				var url="<%=basePath%>carportOutContact!approval.action?approvalType=opinion1&id="+id;
				$.post(url,{opinion:opinion},function(data){
					if(data.result.success){
						showTip(data.result.msg,2000);
						setTimeout(function(){
							location.reload();
						},2000);
					}
					
					
				});
			}
		}else if('opinion2'==type){
			var opinion = $("#opinion2Txt").html();
			if(opinion == ""){
				alert("请填写意见");
			}else{
				var id=$("#id").val();
				var url="<%=basePath%>carportOutContact!approval.action?approvalType=opinion2&id="+id;
				$.post(url,{opinion:opinion},function(data){
					if(data.result.success){
						showTip(data.result.msg,2000);
						setTimeout(function(){
							location.reload();
						},2000);
					}
					
					
				});
			}
		}else if('opinion3'==type){
			var opinion = $("#opinion3Txt").html();
			if(opinion == ""){
				alert("请填写意见");
			}else{
				var id=$("#id").val();
				var url="<%=basePath%>carportOutContact!approval.action?approvalType=opinion3&id="+id;
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
	function send(type){
		approvalType = type;
		fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!selectSelf.action',520,400);
	}
	function setSelectedUser(user){
		var id = $("#id").val();
		var url = "<%=basePath%>carportOutContact!send.action?id="+id+"&approvalType="+approvalType+"&receiveId="+user.id;
		$.post(url,function(data){
			var msg = data.result.msg;
			if(data.result.success){
				showTip(msg,2000);
				setTimeout(function(){
					location.reload();
				},2000);
			}
		});
	}
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
 
<h1>浙江大学国家大学科技园(一期) 车位退租确认单</h1>
 
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
     <tr>
        <td colspan="2" width="10%">退赁单位</td>
        <td colspan="7">${result.value.customer }</td>
      </tr>
      <tr>
        <td colspan="2">退租原因</td>
        <td colspan="7">${result.value.reason }</td>
      </tr>
      <tr>
        <td colspan="2">退租单位经办人</td>
        <td colspan="3">${result.value.responsible.realName }</td>
        <td colspan="2">联系电话</td>
        <td colspan="2">${result.value.responsible.mobile}</td>
      </tr>
      <tr>
        <td colspan="2">原租赁车位号</td>
        <td colspan="3">${result.value.carport }</td>
        <td colspan="2">车位个数</td>
        <td colspan="2">${result.value.number}</td>
      </tr>
      <tr>
        <td colspan="2">原租赁期限</td>
        <td colspan="7">${result.value.rentStart}至${result.value.rentEnd}</td>
      </tr>
      <tr>
        <td colspan="2">退赁时间核实</td>
        <td colspan="7">${result.value.rentOutStart}至${result.value.rentOutEnd}</td>
      </tr>
      <tr>
        <td colspan="2">退赁金额</td>
        <td colspan="7">${result.value.money}</td>
      </tr>
    </table>
 <div class="hqxx" style="padding:5px 0 0;">
	<div class="titlebg">会签信息：</div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:2px 0;">
      <tr>
        <td class="layertdleft100"><span class="tsy-h80">创业服务中心核实意见：</span></td>
        <td class="layerright" style="padding-top:4px;" colspan="3"><textarea name="textarea"  class="textareaauto" <c:if test="${result.value.opinion1Id ne userId || result.value.opinion1 ne null}">readonly="readonly"</c:if> id="opinion1Txt" style="height:50px;">${result.value.opinion1 }</textarea></td>
        <td width="6%"><input type="hidden" id="opinion1Id" value="${result.value.opinion1Id }" /><label>
	        <c:if test="${result.value.opinion1Id eq userId && result.value.opinion1 eq null }">
	        	<input name="Submit" type="button" onclick="save('opinion1');" class="savebtn1" value="保存" />
	        </c:if>
        </label></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="tsy-h80">科技园发展有限公司财务部审核：</span></td>
        <td class="layerright" style="padding-top:4px;" colspan="3"><textarea name="textarea"  class="textareaauto" <c:if test="${result.value.opinion2Id ne userId || result.value.opinion2 ne null}">readonly="readonly"</c:if> id="opinion2Txt" style="height:50px;">${result.value.opinion2 }</textarea></td>
        <td width="6%"><input type="hidden" id="opinion2Id" value="${result.value.opinion2Id }" /><label>
	        <c:if test="${result.value.opinion2Id eq userId && result.value.opinion2 eq null }">
	        	<input name="Submit" type="button" onclick="save('opinion2');" class="savebtn1" value="保存" />
	        </c:if>
        </label></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="tsy-h80">南都物业物管中心财务审核：</span></td>
        <td class="layerright" style="padding-top:4px;" colspan="3"><textarea name="textarea"  class="textareaauto" <c:if test="${result.value.opinion3Id ne userId || result.value.opinion3 ne null}">readonly="readonly"</c:if> id="opinion3Txt" style="height:50px;">${result.value.opinion3 }</textarea></td>
        <td width="6%"><input type="hidden" id="opinion3Id" value="${result.value.opinion3Id }" /><label>
	        <c:if test="${result.value.opinion3Id eq userId && result.value.opinion3 eq null }">
	        	<input name="Submit" type="button" onclick="save('opinion3');" class="savebtn1" value="保存" />
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