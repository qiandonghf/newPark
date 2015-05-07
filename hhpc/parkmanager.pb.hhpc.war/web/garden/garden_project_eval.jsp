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
	initTip();
	initForm();
	initTab();
})

function initTab(){
	tabSwitch('apptabli','apptabliover','tabswitch',getOpener().currentIndex);
}

function initForm(){
	$("#form1").validate({
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			$(form).ajaxSubmit({
		        dataType: 'json',
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("getOpener().location.reload();parent.fb.end();", 2000);
		        	}
		        } 
		    });
		}
	});
}

function downAttr(path,name){
	location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
}
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
	<div class="apptab" id="tableid">
		<ul>
			<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">申请信息</li>
			<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">创业计划书</li>
			<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">附件材料</li>
			<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',3)">评审信息</li>
		</ul>
	</div>
	
	<div class="basediv tabswitch" style="margin-top:0px;" name="textname" id="textname">
		<div class="divlays" style="margin:0px; height:567px;">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	    	<tr>
        		<td class="layertdleft100">申请人信息</td>
        		<td class="layerright" colspan="3">
        			<table width="100%" border="0" cellspacing="0" cellpadding="0">
     					<tr>
					        <td class="layertdleft120">申请人：</td>
					        <td class="layerright" style="width:150px;"> ${result.value.gardenApply.applyer }&nbsp;</td>
					        <td class="layertdleft120">申请日期： </td>
					        <td class="layerright" style="width:150px;"><fmt:formatDate value="${result.value.gardenApply.applyTime }" pattern="yyyy-MM-dd"/>&nbsp;</td>
			      		</tr>
    				</table>
        		</td>
        	</tr>
        	<tr>
				<td class="layertdleft100">项目名：</td>
				<td class="layerright" colspan="3">${result.value.gardenApply.projectName }</td>
			</tr>
			<tr>
				<td class="layertdleft100">项目来源</td>
				<td class="layerright" colspan="3">
					<label>${result.value.gardenApply.projectSource.title } </label>
					<c:if test="${result.value.gardenApply.projectSource eq 'OTHER' }">
			    		<label>${result.value.gardenApply.sourceDetail } </label>
			    	</c:if>
				</td>
			</tr>
			<tr>
			    <td class="layertdleft100">项目类型</td>
			    <td class="layerright" colspan="3">
			    	<label>${result.value.gardenApply.projectType.title } </label>
			    	<c:if test="${result.value.gardenApply.projectType eq 'OTHER' }">
			    		<label>${result.value.gardenApply.projectTypeDetail } </label>
			    	</c:if>
				</td>
  			</tr>
			<tr>
  				<td class="layertdleft100">是否融资</td>
  				<td class="layerright" colspan="3"><label>${result.value.gardenApply.financing.title }&nbsp; </label></td>
  			</tr>
  			<tr>
			    <td class="layertdleft100">项目负责人<br/>联系方式</td>
			    <td class="layerright" colspan="3">
			    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
     					<tr>
					        <td class="layertdleft120">姓名：</td>
					        <td class="layerright" style="width:150px;">${result.value.gardenApply.leaderName }&nbsp;</td>
					        <td class="layertdleft120">手机： </td>
					        <td class="layerright" style="width:150px;">${result.value.gardenApply.leaderMobile }&nbsp;</td>
			      		</tr>
			      		<tr>
					        <td class="layertdleft120">E-mail： </td>
					        <td class="layerright">${result.value.gardenApply.leaderEmail }</td>
					        <td class="layertdleft120">QQ：</td>
					        <td class="layerright">${result.value.gardenApply.leaderQQ }</td>
			      		</tr>
						<tr>
						  <td class="layertdleft120">学校：</td>
						  <td class="layerright">${result.value.gardenApply.leaderSchool }</td>
						  <td class="layertdleft120">院系年级：</td>
						  <td class="layerright">${result.value.gardenApply.leaderCollege }</td>
						</tr>
						<tr>
							<td class="layertdleft120" colspan="2">紧急联络方式(不要重复手机)：</td>
							<td class="layerright" colspan="2">${result.value.gardenApply.leaderPhone }</td>
						</tr>
    				</table>
    			</td>
  			</tr>
  			<tr>
			    <td class="layertdleft120">项目简介</td>
			    <td class="layerright">
			    	<label for="textarea">
			    	<textarea id="textarea" readonly="readonly" style="width:100%;resize:none;margin:2px 0px 1px;border:0px;height:60px;">${result.value.gardenApply.introduction }</textarea>
			    	</label>
			    </td>
  			</tr>
  			<tr>
    			<td class="layertdleft120">项目信息</td>
    			<td class="layerright">
    				<table width="100%" border="0" cellspacing="0" cellpadding="0">
      					<tr>
					        <td class="layertdleft120">曾经参加比赛：</td>
					        <td class="layerright" style="width:450px;">${result.value.gardenApply.competition }</td>
      					</tr>
      					<tr>
					        <td class="layertdleft120">曾获奖励/专利：</td>
					        <td class="layerright" style="width:450px;">${result.value.gardenApply.reward }</td>
     					</tr>
      					<tr>
					        <td class="layertdleft120">指导老师：</td>
					        <td class="layerright" style="width:450px;">${result.value.gardenApply.teacher }</td>
      					</tr>
    				</table>
    			</td>
  			</tr>
  			<tr>
    			<td class="layertdleft120">项目成员</td>
    			<td class="layerright">
	   				<table width="100%" border="0" cellspacing="0" cellpadding="0">
     					<tr>
					        <td class="layertdleft120 borderLeft">姓名</td>
					        <td class="layertdleft120 borderLeft">专业</td>
					        <td class="layertdleft120 borderLeft">联系方式</td>
					        <td class="layertdleft120 borderLeft">在项目中的职能</td>
     					</tr>
     					<tr>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberName1 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberMajor1 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberPhone1 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberRole1 }</td>
     					</tr>
     					<tr>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberName2 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberMajor2 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberPhone2 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberRole2 }</td>
     					</tr>
     					<tr>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberName3 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberMajor3 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberPhone3 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberRole3 }</td>
     					</tr>
     					<tr>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberName4 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberMajor4 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberPhone4 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberRole4 }</td>
     					</tr>
     					<tr>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberName5 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberMajor5 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberPhone5 }</td>
					        <td class="layertdleft120 borderLeft">${result.value.gardenApply.memberRole5 }</td>
     					</tr>
	   				</table>
	    		</td>
	  		</tr>
	  		<tr>
			    <td class="layertdleft120">入驻要求</td>
			    <td class="layerright">
			    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
			      		<tr>
					        <td class="layertdleft120" colspan="3" >需用工位数</td>
					        <td class="layertdleft120" style="width:128px;background-color:#fff;text-align:left;padding-left:5px;">
						          <label>${result.value.gardenApply.tableCnt }</label>
					        </td>
				      </tr>
			    	</table>
			    </td>
		  </tr>
		</table>
		</div>
		</div>
		
		<div class="basediv tabswitch" style="margin-top:0px;display:none;" name="textname" id="textname">
	        <div class="divlays" style="margin:0px;height:567px;">
			    <div class="emaildown" style="margin-top:0px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
			      <h1>创业计划书${fn:length(result.value.gardenApply.gardenApplyAtts)}个</h1>
			      <c:if test="${fn:length(result.value.gardenApply.gardenApplyAtts) >= 1}">
			      <c:forEach items="${result.value.gardenApply.gardenApplyAtts }" var="att">
			      	  <c:set var="num" value="${att.size/1024 }" />
				      <div class="downlist"> <img src="core/common/images/downloadico.png" />
				        <ul>
				          <li>${att.name }<span>(<fmt:formatNumber value="${num + 0.1}"  pattern="#,###,###,###" />KB)</span></li>
				          <li>
				          	<a href="javascript:void(0)" onclick="downAttr(${att.id })">下载</a>
				         </li>
				        </ul>
				      </div>
			      </c:forEach>
			      </c:if>
			    </div>
			</div>
	  </div>
	  
	  <div class="basediv tabswitch" style="margin-top:0px;display:none;" name="textname" id="textname">
        <div class="divlays" style="margin:0px;height:567px;">
			<div class="emaildown" style="margin-top:0px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
		      <h1>附件${fn:length(result.value.gardenApply.applyAtts)}个</h1>
		      <c:if test="${fn:length(result.value.gardenApply.applyAtts) >= 1}">
		      <c:forEach items="${result.value.gardenApply.applyAtts }" var="att">
		      	  <c:set var="num" value="${att.size/1024 }" />
			      <div class="downlist"> <img src="core/common/images/downloadico.png" />
			        <ul>
			          <li>${att.name }<span>(<fmt:formatNumber value="${num + 0.1}"  pattern="#,###,###,###" />KB)</span></li>
			          <li>
			          	<a href="javascript:void(0)" onclick="downAttr(${att.id })">下载</a>
			         </li>
			        </ul>
			      </div>
		      </c:forEach>
		      </c:if>
		    </div>
		</div>
  	</div>
	  	
  	<!-- 评审 -->
	<div class="basediv tabswitch" style="margin-top:0px;display:none;" name="textname" id="textname">
        <div class="divlays" style="margin:0px;height:567px;">
			<form id="form1" name="form1" action="<%=basePath %>garden!evalUpdate.action" method="post">
				<input type="hidden" name="gardenApplyEval.evalTime" value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>'/>
				<input type="hidden" name="gardenApplyEval.id" value="${result.value.id}" />
			    <table width="100%" border="0" cellspacing="0" cellpadding="0">
			      <tr>
			      	<td valign="middle" class="layertdleft" style="border-top:1px solid #eee;">项目名称</td>
			      	<td class="layerright" colspan="7" style="border-top:1px solid #eee;">${result.value.gardenApply.projectName}&nbsp;</td>
			      	<td valign="middle" class="layertdleft" style="border-top:1px solid #eee;">申请人</td>
			      	<td class="layerright" colspan="2" style="border-top:1px solid #eee;border-right:1px solid #eee;">${result.value.gardenApply.applyer}&nbsp;</td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">序号</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">内容</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">依据</td>
			        <td valign="middle" class="layertdleft borderLeft">优秀</td>
			        <td valign="middle" class="layertdleft borderLeft">良好</td>
			        <td valign="middle" class="layertdleft borderLeft">一般</td>
			        <td valign="middle" class="layertdleft borderRight">较差</td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">1</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">产品（服务）是否符合<br/>高订报区产业导向</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">高新区产业导向目录</td>
			        <td valign="middle" class="layertdleft borderRight bgcf" colspan="4" style="padding:0px;">
				        <table  width="100%" border="0" cellspacing="0" cellpadding="0">
				          <tr>
				            <td class="app_td" style="border-right:0px;padding:0px;padding-right:5px;"><label>是
				                <input  class="app_td_checkbox" name="gardenApplyEval.meetDevelop" checked="checked" value="YES" type="radio"/>
				            </label></td>
				          </tr>
				          <tr>
				            <td class="app_td" style="border-right:0px;padding:0px;padding-right:5px;"><label>否
								<input class="app_td_checkbox" name="gardenApplyEval.meetDevelop" value="NO" type="radio"/>
				            </label></td>
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
			        <td valign="middle" class="layertdleft borderRight bgcf">
			        	<label>
			                <input  class="app_td_checkbox" name="gardenApplyEval.qualification" checked="checked" value="<%=GardenProjectEvalEnum.EXCELLENT %>" type="radio"/>
			            </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.qualification" value="<%=GardenProjectEvalEnum.GOOD %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.qualification" value="<%=GardenProjectEvalEnum.NORMAL %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.qualification" value="<%=GardenProjectEvalEnum.BAD %>" type="radio"/>
			          </label>
			        </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">3</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">团队情况</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">申请人经验与技能或团队互补性</td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.team" checked="checked" value="<%=GardenProjectEvalEnum.EXCELLENT %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.team" value="<%=GardenProjectEvalEnum.GOOD %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.team" value="<%=GardenProjectEvalEnum.NORMAL %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.team" value="<%=GardenProjectEvalEnum.BAD %>" type="radio"/>
			          </label>
			        </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">4</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">产品或服务创新性</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">与传统产品或服务的比较</td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.innovation" checked="checked" value="<%=GardenProjectEvalEnum.EXCELLENT %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.innovation" value="<%=GardenProjectEvalEnum.GOOD %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.innovation" value="<%=GardenProjectEvalEnum.NORMAL %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.innovation" value="<%=GardenProjectEvalEnum.BAD %>" type="radio"/>
			          </label>
			        </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">5</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">商业模式</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">盈利方式与市场推广</td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.businessModel" checked="checked" value="<%=GardenProjectEvalEnum.EXCELLENT %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.businessModel" value="<%=GardenProjectEvalEnum.GOOD %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.businessModel" value="<%=GardenProjectEvalEnum.NORMAL %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.businessModel" value="<%=GardenProjectEvalEnum.BAD %>" type="radio"/>
			          </label>
			        </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">6</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">创业计划</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">合理性与可操作性</td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.businessPlan" checked="checked" value="<%=GardenProjectEvalEnum.EXCELLENT %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.businessPlan" value="<%=GardenProjectEvalEnum.GOOD %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.businessPlan" value="<%=GardenProjectEvalEnum.NORMAL %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.businessPlan" value="<%=GardenProjectEvalEnum.BAD %>" type="radio"/>
			          </label>
			        </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">7</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">技术优势</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">技术创新</td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.technicalSuperiority" checked="checked" value="<%=GardenProjectEvalEnum.EXCELLENT %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.technicalSuperiority" value="<%=GardenProjectEvalEnum.GOOD %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.technicalSuperiority" value="<%=GardenProjectEvalEnum.NORMAL %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.technicalSuperiority" value="<%=GardenProjectEvalEnum.BAD %>" type="radio"/>
			          </label>
			        </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">8</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">智力成果</td>
			        <td valign="middle" class="layertdleft borderLeft" colspan="3">知识产权</td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.intellectualProperty" checked="checked" value="<%=GardenProjectEvalEnum.EXCELLENT %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.intellectualProperty" value="<%=GardenProjectEvalEnum.GOOD %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.intellectualProperty" value="<%=GardenProjectEvalEnum.NORMAL %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.intellectualProperty" value="<%=GardenProjectEvalEnum.BAD %>" type="radio"/>
			          </label>
			        </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft" colspan="7">总评</td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.totalScore" checked="checked" value="<%=GardenProjectEvalEnum.EXCELLENT %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.totalScore" value="<%=GardenProjectEvalEnum.GOOD %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.totalScore" value="<%=GardenProjectEvalEnum.NORMAL %>" type="radio"/>
			          </label>
			        </td>
			        <td valign="middle" class="layertdleft borderRight bgcf">
			          <label>
			               <input  class="app_td_checkbox" name="gardenApplyEval.totalScore" value="<%=GardenProjectEvalEnum.BAD %>" type="radio"/>
			          </label>
			        </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft borderLeft">综<br/>合<br/>评<br/>价</td>
			        <td valign="middle" class="layertdleft borderRight bgcf" colspan="10">
			          <textarea class="textareaauto" name="gardenApplyEval.evalDetail" style="height:80px;resize:none;overflow:hidden;overflow-y:scroll;"></textarea>
			       </td>
			      </tr>
			      <tr>
			        <td valign="middle" class="layertdleft120" colspan="9">是否同意该项目入驻创业苗圃：
			        </td>
			         <td valign="middle" class="layertdleft borderRight bgcf" colspan="2">
			        	<label>是 <input type="radio" name="gardenApplyEval.agree" checked="checked" value="YES" /></label>&nbsp;&nbsp;<label>否 <input type="radio" name="gardenApplyEval.agree" value="NO" /></label>
			        </td>
			      </tr>
			       <tr>
			        <td valign="middle" class="layertdleft120" style="border-bottom:1px solid #eee;" colspan="5">评审人：</td>
			      	<td valign="middle" class="layertdleft borderRight bgcf" style="border-bottom:1px solid #eee;" colspan="2"><%=PbActivator.getSessionUser(request).getRealName() %></td>
			     	<td valign="middle" class="layertdleft120" colspan="2" style="border-bottom:1px solid #eee;">评审时间：</td>
			      	<td valign="middle" class="layertdleft borderRight bgcf" style="border-bottom:1px solid #eee;" colspan="2"><fmt:formatDate value="${now }" pattern="yyyy-M-d"/></td>
			      </tr>
			    </table>
			    
				<div class="buttondiv PT10" style="margin-top:10px;">
				   <label><input name="Submit" type="submit" class="allbtn" value="提交" /></label>
				  <label><input name="Submit2" type="button" class="cancelbtn" value=" " onclick="parent.fb.end();"/></label>
				</div>
			</form>
		</div>
  	</div>
</div>
</body>
</html>

