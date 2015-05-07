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
<title>招商项目审批联系单</title>
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
		if('departmentOpinion'== type){
			var opinion = $("#departmentTxt").html();
			if(opinion == ""){
				alert("请填写意见");
			}else{
				var id=$("#id").val();
				var url="<%=basePath%>investmentContact!approval.action?approvalType=departmentOpinion&id="+id;
				$.post(url,{opinion:opinion},function(data){
					if(data.result.success){
						showTip(data.result.msg,2000);
						setTimeout(function(){
							location.reload();
						},2000);
					}
					
					
				});
			}
		}else if('headOpinion' == type){
			var opinion = $("#headTxt").html();
			if(opinion == ""){
				alert("请填写意见");
			}else{
				var id=$("#id").val();
				var url="<%=basePath%>investmentContact!approval.action?approvalType=headOpinion&id="+id;
				$.post(url,{opinion:opinion},function(data){
					if(data.result.success){
						showTip(data.result.msg,2000);
						setTimeout(function(){
							location.reload();
						},2000);
					}
					
				});
			}
		}else if('attractOpinion' == type){
			var opinion = $("#attractTxt").html();
			if(opinion == ""){
				alert("请填写意见");
			}else{
				var id=$("#id").val();
				var url="<%=basePath%>investmentContact!approval.action?approvalType=attractOpinion&id="+id;
				$.post(url,{opinion:opinion},function(data){
					if(data.result.success){
						showTip(data.result.msg,2000);
						setTimeout(function(){
							location.reload();
						},2000);
					}
					
				});
			}
		}else if('handleOpinion' == type){
			var opinion = $("#handleTxt").html();
			if(opinion == ""){
				alert("请填写意见");
			}else{
				var id=$("#id").val();
				var url="<%=basePath%>investmentContact!approval.action?approvalType=handleOpinion&id="+id;
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
</script>
 
 
<style> 
html { overflow:auto;}
h1 { font:bold 16px/32px ''; height:32px; text-align:center;}
</style>
 
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
</head>
<body>
 
<form action="" method="post" enctype="multipart/form-data" name="form1" id="form1" >
<!--basediv-->
<%--zhf--%>
<div class="basediv" style="margin-bottom:8px;">
 
<h1>浙江大学国家大学科技园宁波分园注册审批表</h1>
 
<div class="overflowAuto" id="overflowAuto">
                  
<table width="96%" border="0" cellspacing="0" cellpadding="0"  class="tsy1">
      <tr>
        <td width="80">编号：</td>
        <td >&nbsp;</td>
        <td width="80">填表日期：</td>
        <td >&nbsp;&nbsp;&nbsp;&nbsp;年   &nbsp;&nbsp;&nbsp;&nbsp;月  &nbsp;&nbsp;&nbsp;&nbsp; 日</td>
        </tr>
</table>
<input type="hidden" id="id" value="${result.value.id }"/>
<table width="96%" border="0" cellspacing="0" cellpadding="0" class="tsy4">
      <tr>
        <td colspan="2"   width="10%">项目名称</td>
        <td colspan="7">${result.value.investmentName }</td>
        </tr>
      <tr>
        <td colspan="2">经营范围</td>
        <td colspan="7">${result.value.businessScope }</td>
        </tr>
      <tr>
        <td colspan="2">注册资本</td>
        <td>${result.value.regCapital }万元</td>
        <td width="10%">企业人数</td>
        <td>${result.value.staff }人</td>
        <td width="10%">申请用房面积</td>
        <td colspan="3">${result.value.officeArea }㎡</td>
      </tr>
      <tr>
        <td colspan="2" >计划总投资</td>
        <td>${result.value.investCapital }万元</td>
        <td>预计年产值</td>
        <td colspan="5">${result.value.outputValue }万元</td>
        </tr>
      <tr>
        <td rowspan="3"  width="10">联<br/>
          系<br/>
          人<br/></td>
        <td>姓名</td>
        <td>${linkman.name }</td>
        <td>性别</td>
        <td>${linkman.gender.title }</td>
        <td>出生年月</td>
        <td><fmt:formatDate value="${linkman.birthDay }" pattern="yyyy-MM-dd"/></td>
      </tr>
      <tr>
        <td>邮箱</td>
        <td>${linkman.email }</td>
        <td>手机</td>
        <td>${linkman.mobile }</td>
        <td>座机</td>
        <td colspan="3">${linkman.phone}</td>
      </tr>
    </table>
<table width="96%" border="0" cellspacing="0" cellpadding="0" class="tsy3">
  <tr>
    <td colspan="8" style="padding:0;"></td>
    </tr>
  <tr>
    <td>投资方 </td>
    <td>出资比例</td>
    <td>出资方式(货币、技术、设备) </td>
    <td>出生年月 </td>
    <td>毕业年份</td>
    <td >学历</td>
    <td>职称</td>
    <td>毕业院校</td>
  </tr>
  <c:forEach items="${investorList }" var="investor">
  <tr>
    <td>${investor.name }</td>
    <td>${investor.rate }</td>
    <td>${investor.capital.dataValue }</td>
    <td><fmt:formatDate value="${investor.birthDay }" pattern="yyyy-MM-dd"/></td>
    <td>${investor.graduateYear }</td>
    <td>${investor.degree.dataValue }</td>
    <td>${investor.profession }</td>
    <td>${investor.school }</td>
  </tr>
  </c:forEach>
  <tr>
    <td colspan="8" class="tsy-h80">成果转化或开发项目情况（先进性、预期规模及拥有知识产权情况）：<br/>
    ${result.value.description }
    </td>
  </tr>
      <tbody>
      </tbody>
</table>
    
   	<div class="hqxx" style="padding:5px 0 0;">
	<div class="titlebg">会签信息：</div>
                     	
   <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:2px 0;">
 	  <tr>
        <td class="layertdleft100"><span class="tsy-h80">经办人员意见：</span></td>
        <td class="layerright" style="padding:2px;" colspan="3"><textarea name="textarea"  <c:if test="${result.value.handleOpinionId ne userId || result.value.handleOpinion ne null}">readonly="readonly"</c:if> id="handleTxt" class="inputauto" style="height:60px;resize: none;width:99%">${result.value.handleOpinion }</textarea></td>
        <td width="6%"><input type="hidden" id="handleOpinionId" value="${result.value.handleOpinionId }" /><label id="handleLab">
	        <c:if test="${result.value.handleOpinionId eq userId && result.value.handleOpinion eq null }">
	        	<input name="Submit" type="button" onclick="save('handleOpinion');" class="savebtn1" value="保存" />
	        </c:if>
	        <%-- <c:if test="${result.value.handleOpinionId eq null && result.value.handleOpinion eq null }">
	        	<input name="Submit" type="button" onclick="send('handleOpinion');" class="allbtn" value="发送" />
	        </c:if> --%>
        </label></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="tsy-h80">招商人员意见：</span></td>
        <td class="layerright" style="padding:2px;" colspan="3"><textarea name="textarea" <c:if test="${result.value.attractOpinionId ne userId || result.value.attractOpinion ne null}">readonly="readonly"</c:if> id="attractTxt" class="inputauto" style="height:60px;resize: none;width:99%">${result.value.attractOpinion }</textarea></td>
        <td width="6%"><input type="hidden" id="attractOpinionId" value="${result.value.attractOpinionId }" /><label id="attractLab">
	        <c:if test="${result.value.attractOpinionId eq userId && result.value.attractOpinion eq null }">
	        	<input name="Submit" type="button" onclick="save('attractOpinion');" class="savebtn1" value="保存" />
	        </c:if>
	       <%--  <c:if test="${result.value.attractOpinionId eq null && result.value.attractOpinion eq null }">
	        	<input name="Submit" type="button" onclick="send('attractOpinion');" class="allbtn" value="发送" />
	        </c:if> --%>
        </label></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="tsy-h80">投资促进部意见：</span></td>
        <td class="layerright" style="padding:2px;" colspan="3"><textarea name="textarea"  <c:if test="${result.value.departmentOpinionId ne userId || result.value.departmentOpinion ne null}">readonly="readonly"</c:if> id="departmentTxt" class="inputauto" style="height:60px;resize: none;width:99%">${result.value.departmentOpinion }</textarea></td>
        <td width="6%"><input type="hidden" id="departmentOpinionId" value="${result.value.departmentOpinionId }" /><label id="departmentLab">
	        <c:if test="${result.value.departmentOpinionId eq userId && result.value.departmentOpinion eq null }">
	        	<input name="Submit" type="button" onclick="save('departmentOpinion');" class="savebtn1" value="保存" />
	        </c:if>
        </label></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="tsy-h80">主任会议室意见：</span></td>
        <td class="layerright" style="padding:2px;" colspan="3"><textarea name="textarea" id="headTxt" <c:if test="${result.value.headOpinionId ne userId || result.value.headOpinion ne null}">readonly="readonly"</c:if> class="inputauto" style="height:60px;resize: none;width:99%">${result.value.headOpinion }</textarea></td>
        <td width="6%"><input type="hidden" id="headOpinionId" value="${result.value.headOpinionId }" /><label id="headLab">
	        <c:if test="${result.value.headOpinionId eq userId && result.value.headOpinion eq null }">
	        	<input name="Submit" type="button" onclick="save('headOpinion');" class="savebtn1" value="保存" />
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