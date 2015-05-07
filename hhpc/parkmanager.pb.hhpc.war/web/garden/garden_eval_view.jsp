<%@page import="com.wiiy.pb.preferences.enums.GardenProjectEvalEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="now" class="java.util.Date" />
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>

<script>
$(function(){
})

</script>
<style type="text/css">
	.borderLeft{
		border-right:1px solid #fff;
		text-align:center;
		width:56px;
	}
	.borderRight{
		border-right:1px solid #eee;
		text-align:center;
		width:56px;
	}
	.layertdleft{
		width:56px;
	}
	.bgcf{
		background-color:#fff;
		border-top:1px solid #eee;
	}
</style>
</head>

<body style="background-color:#eee;">
<div class="divlays">
  	<!-- 评审 -->
	<div class="basediv" style="margin-top:4px;" id="textname">
        <div class="divlays" style="margin:0px;">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		      <tr>
		      	<td valign="middle" class="layertdleft" style="border-top:1px solid #eee;">项目名称</td>
		      	<td class="layerright" colspan="6" style="border-top:1px solid #eee;">${result.value.gardenApply.projectName}&nbsp;</td>
		      	<td valign="middle" class="layertdleft" style="border-top:1px solid #eee;">申请人</td>
		      	<td class="layerright" colspan="2" style="border-top:1px solid #eee;border-right:1px solid #eee;">${result.value.gardenApply.applyer}&nbsp;</td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">序号</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">内容</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">依据</td>
		        <td valign="middle" class="layertdleft borderRight" colspan="4">评审结果</td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">1</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">产品（服务）是否符合<br/>高订报区产业导向</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">高新区产业导向目录</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4" style="padding-right:0px;">
			        <table  width="100%" border="0" cellspacing="0" cellpadding="0">
			          <tr>
			            <td class="app_td" style="border-right:0px;padding:0px;padding-right:5px;">${result.value.meetDevelop.title }&nbsp;</td>
			          </tr>
			          <tr>
			            <td>注:本条标准为一票否决制</td>
			          </tr>
			        </table>
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">2</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">申请人资质</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">入驻标准</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4">
		        	${result.value.qualification.title }&nbsp;
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">3</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">团队情况</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">申请人经验与技能或团队互补性</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4">
		        	${result.value.team.title }&nbsp;
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">4</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">产品或服务创新性</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">与传统产品或服务的比较</td>
		       	<td valign="middle" class="layertdleft borderRight bgcf" colspan="4">
		        	${result.value.innovation.title }&nbsp;
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">5</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">商业模式</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">盈利方式与市场推广</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4">
		        	${result.value.businessModel.title }&nbsp;
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">6</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">创业计划</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">合理性与可操作性</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4">
		        	${result.value.businessPlan.title }&nbsp;
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">7</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">技术优势</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">技术创新</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4">
		        	${result.value.technicalSuperiority.title }&nbsp;
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">8</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">智力成果</td>
		        <td valign="middle" class="layertdleft borderLeft" colspan="3">知识产权</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4">
		        	${result.value.intellectualProperty.title }&nbsp;
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft" colspan="7">总评</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4">
		        	${result.value.totalScore.title }&nbsp;
		        </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft borderLeft">综<br/>合<br/>评<br/>价</td>
		        <td valign="middle" class="layertdleft borderRight bgcf" colspan="10">
		          <textarea class="textareaauto" name="gardenApplyEval.evalDetail" readonly="readonly" style="height:80px;resize:none;overflow:hidden;overflow-y:scroll;">${result.value.evalDetail }</textarea>
		       </td>
		      </tr>
		      <tr>
		        <td valign="middle" class="layertdleft120" colspan="9">是否同意该项目入驻创业苗圃：
		        </td>
		         <td valign="middle" class="layertdleft borderRight bgcf" colspan="2">
		        	${result.value.agree.title }&nbsp;
		        </td>
		      </tr>
		       <tr>
		        <td valign="middle" class="layertdleft120" style="border-bottom:1px solid #eee;" colspan="5">评审人：</td>
		      	<td valign="middle" class="layertdleft borderRight bgcf" style="border-bottom:1px solid #eee;" colspan="2">${result.value.evalUser.realName }&nbsp;</td>
		     	<td valign="middle" class="layertdleft120" colspan="2" style="border-bottom:1px solid #eee;">评审时间：</td>
		      	<td valign="middle" class="layertdleft borderRight bgcf" style="border-bottom:1px solid #eee;" colspan="2"><fmt:formatDate value="${result.value.evalTime }" pattern="yyyy-M-d"/></td>
		      </tr>
		    </table>
		</div>
  	</div>
</div>
</body>
</html>

