<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initMemoList();
	});
	
	function initMemoList(){
		var height = 200;
		var width = $(".textname").width();
		$("#memoList").jqGrid({
	    	url:'<%=basePath%>gardenApplyLog!listByApplyId.action?id=${result.value.id}',
			colModel: [
				{label:'备注信息', name:'creator',align:"center",width:120}, 
				{label:'创建时间',width:120,name:'createTime',align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				{label:'创建人',width:120,name:'creator',align:"center"}, 
			    {label:'管理',width:200, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			multiselect: true,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewLog("+id+");\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
		    caption : "列选择",
		    title : "选择要显示的列",
		    onClickButton : function(){
		        $(this).jqGrid('columnChooser');
		    }
		});
	}	
	
	function viewLog(id){
		fbStart('查看备注信息','<%=basePath %>garden!applyLogView.action?id='+id,550,129);
	}
	
	function viewById(id){
		fbStart("查看评审明细","<%=basePath%>garden!evalViewById.action?id="+id,700,495);
	}
	
	function downAttr(path,name){
		location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
	}
	
	
</script>
<style>
	.apptable .tdleft{
		border-right:1px solid #fff;
		border-bottom:1px solid #fff;
	}
	.apptable .app_td{
		border-right:1px solid #fff;
		border-bottom:1px solid #eee;
		color:#666;
	}
</style>
</head>
<body>
<div class="basediv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="140" valign="top">
				<jsp:include page="../customer_view_common.jsp">
					<jsp:param value="9" name="index"/>
					<jsp:param value="${result.value.customerId}" name="customerId"/>
					<jsp:param value="${result.value.id}" name="gardenApplyId"/>
					<jsp:param value="${desktop }" name="desktop"/>
				</jsp:include>
			</td>
			<td valign="top">
				<div class="pm_view_right" style="height: 432px;">
					<div class="basediv" style="margin:0px;">
						<div class="titlebg">基本信息</div>
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">申请人：</td>
									<td class="layerright">${result.value.applyer}</td>
									<td class="layertdleft100">申请日期：</td>
									<td width="35%" class="layerright"><fmt:formatDate value="${result.value.applyTime}" pattern="yyyy-MM-dd" /></td>
								</tr>
								<tr>
									<td class="layertdleft100">项目名称：</td>
									<td class="layerright">${result.value.projectName}</td>
									<td class="layertdleft100">项目来源：</td>
									<td class="layerright">
										${result.value.projectSource.title }
										<c:if test="${result.value.projectSource eq 'OTHER' }">
								    		<label>${result.value.sourceDetail } </label>
								    	</c:if>
									</td>
								</tr>
								<tr>
									<td class="layertdleft100">评审状态：</td>
									<td class="layerright">${result.value.applyState.title}</td>
									<td class="layertdleft100">项目类型：</td>
								    <td class="layerright">
			    						<label>${result.value.projectType.title } </label>
								    	<c:if test="${result.value.projectType eq 'OTHER' }">
								    		<label>${result.value.projectTypeDetail } </label>
								    	</c:if>
									</td>
								</tr>
								<tr>
									<td class="layertdleft100">项目状态：</td>
									<td class="layerright">${result.value.projectState.title}</td>
									<td class="layertdleft100">申请方式：</td>
									<td class="layerright">${result.value.applySource.title}</td>
								</tr>
								<tr>
								    <td class="layertdleft100">是否融资：</td>
								    <td class="layerright">${result.value.financing.title }</td>
					  				<td class="layertdleft100">需用工位数：</td>
									<td class="layerright">${result.value.tableCnt}</td>
					  			</tr>
							</table>
						</div>
						<div class="hackbox"></div>
					</div>
					
					<div class="apptab" id="tableid">
						<ul>
							<li class="apptabliover" onclick="parent.currentIndex=0;tabSwitch('apptabli','apptabliover','tabswitch',0)">项目负责人</li>
							<li class="apptabli" onclick="parent.currentIndex=1;tabSwitch('apptabli','apptabliover','tabswitch',1)">项目信息</li>
							<li class="apptabli" onclick="parent.currentIndex=2;tabSwitch('apptabli','apptabliover','tabswitch',2)">项目成员</li>
							<li class="apptabli" onclick="parent.currentIndex=3;tabSwitch('apptabli','apptabliover','tabswitch',3)">项目计划书</li>
							<li class="apptabli" onclick="parent.currentIndex=4;tabSwitch('apptabli','apptabliover','tabswitch',4)">项目附件</li>
							<li class="apptabli" onclick="parent.currentIndex=5;tabSwitch('apptabli','apptabliover','tabswitch',5)">评审信息</li>
							<li class="apptabli" onclick="parent.currentIndex=6;tabSwitch('apptabli','apptabliover','tabswitch',6)">备注信息</li>
						</ul>
					</div>
					
					<div class="basediv tabswitch" style="margin:0px;" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">姓名：</td>
									<td class="layerright">${result.value.leaderName }</td>
									<td class="layertdleft100">手机：</td>
									<td width="35%" class="layerright">${result.value.leaderMobile }</td>
								</tr>
								<tr>
									<td class="layertdleft100">E-mail：</td>
									<td class="layerright">${result.value.leaderEmail}</td>
									<td class="layertdleft100">QQ：</td>
									<td class="layerright">${result.value.leaderQQ }</td>
								</tr>
								<tr>
									<td class="layertdleft100">学校：</td>
									<td class="layerright">${result.value.leaderSchool}</td>
									<td class="layertdleft100">院系年级：</td>
									<td class="layerright">${result.value.leaderCollege }</td>
								</tr>
								<tr>
									<td class="layertdleft100">紧急联络方式：</td>
									<td class="layerright">${result.value.leaderPhone}</td>
								</tr>
							</table>
						</div>
					</div>
						
					<div class="basediv tabswitch" style="margin:0px;display:none;" id="textname">
						<div class="divlays" style="margin:0px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
									    <td class="layertdleft100">曾经参加比赛：</td>
									    <td class="layerright" colspan="3">${result.value.competition }</td>
						  			</tr>
						  			<tr>
									    <td class="layertdleft100">曾获奖励/专利：</td>
									    <td class="layerright" colspan="3">${result.value.reward }</td>
						  			</tr>
						  			<tr>
									    <td class="layertdleft100">指导老师：</td>
									    <td class="layerright" colspan="3">${result.value.teacher }</td>
						  			</tr>
						  			<tr>
									    <td class="layertdleft100">项目简介：</td>
									    <td class="layerright" colspan="3">
			    					    	<textarea id="textarea" readonly="readonly" style="color:#666;width:100%;resize:none;margin:2px 0px 1px;border:0px;height:60px;">${result.value.introduction }</textarea>
									    </td>
						  			</tr>
								</table>
							</div>
						</div>
						
						<div class="basediv tabswitch" style="margin:0px;display:none;" id="textname">
						<div class="divlays apptable" style="margin:0px;border:0px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
					        			<td class="tdleft" align="center">姓名</td>
								        <td class="tdleft" align="center">专业</td>
								        <td class="tdleft" align="center">联系方式</td>
								        <td class="tdleft" align="center">在项目中的职能</td>
					        		</tr>
						  			<tr>
								        <td class="app_td" align="center">${result.value.memberName1 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberMajor1 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberPhone1 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberRole1 }&nbsp;</td>
			     					</tr>
						  			<tr>
									    <td class="app_td" align="center">${result.value.memberName2 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberMajor2 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberPhone2 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberRole2 }&nbsp;</td>
						  			</tr>
						  			<tr>
									    <td class="app_td" align="center">${result.value.memberName3 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberMajor3 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberPhone3 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberRole3 }&nbsp;</td>
						  			</tr>
						  			<tr>
									    <td class="app_td" align="center">${result.value.memberName4 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberMajor4 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberPhone4 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberRole4 }&nbsp;</td>
						  			</tr>
						  			<tr>
									    <td class="app_td" align="center">${result.value.memberName5 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberMajor5 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberPhone5 }&nbsp;</td>
								        <td class="app_td" align="center">${result.value.memberRole5 }&nbsp;</td>
						  			</tr>
								</table>
							</div>
						</div>
						
						
						<div class="basediv tabswitch" style="height:228px;margin:0px;overflow:hidden;overflow-y:auto;display:none;" id="textname">
							<div class="emaildown" style="margin:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
						      <h1>创业计划书${fn:length(result.value.gardenApplyAtts)}个</h1>
						      <c:if test="${fn:length(result.value.gardenApplyAtts) >= 1}">
						      <c:forEach items="${result.value.gardenApplyAtts }" var="att">
						      	  <c:set var="num" value="${att.size/1024 }" />
							      <div class="downlist"> <img src="core/common/images/downloadico.png" />
							        <ul>
							          <li>${att.name }<span>(<fmt:formatNumber value="${num + 0.1}"  pattern="#,###,###,###" />KB)</span></li>
							          <li>
							          	<a href="javascript:void(0)" onclick="downAttr('${att.newName }','${att.name }')">下载</a>
							         </li>
							        </ul>
							      </div>
						      </c:forEach>
						      </c:if>
						    </div>
						</div>
						
						
						<div class="basediv tabswitch" style="height:228px;margin:0px;overflow:hidden;overflow-y:auto;display:none;" id="textname">
							<div class="emaildown" style="margin:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
						      <h1>附件${fn:length(result.value.applyAtts)}个</h1>
						      <c:if test="${fn:length(result.value.applyAtts) >= 1}">
						      <c:forEach items="${result.value.applyAtts }" var="att">
						      	  <c:set var="num" value="${att.size/1024 }" />
							      <div class="downlist"> <img src="core/common/images/downloadico.png" />
							        <ul>
							          <li>${att.name }<span>(<fmt:formatNumber value="${num + 0.1}"  pattern="#,###,###,###" />KB)</span></li>
							          <li>
							          	<a href="javascript:void(0)" onclick="downAttr('${att.newName }','${att.name }')">下载</a>
							         </li>
							        </ul>
							      </div>
						      </c:forEach>
						      </c:if>
						    </div>
						</div>
						
						<div class="basediv tabswitch" style="height:228px;margin:0px;overflow:hidden;overflow-y:auto;display:none;" id="textname">
							<div class="apptable" style="border-top:none; border-left:none;">
					        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					        		<tr>
					        			<td class="tdleft" align="center">申请人</td>
								        <td class="tdleft" align="center">创业导师</td>
								        <td class="tdleft" align="center">是否已评审</td>
								        <td class="tdleft" align="center">分配时间</td>
								        <td class="tdleft" align="center">项目总评</td>
								        <td class="tdleft" align="center" style="border-right:0px;">操作</td>
					        		</tr>
						        	<c:forEach items="${result.value.gardenApplyEvals }" var="eval">
					        		<tr class="eval" uid="${eval.evalUserId }">
								        <td class="app_td" align="center">${result.value.applyer }</td>
								        <td class="app_td" align="center">${eval.evalUser.realName }</td>
								        <td class="app_td" align="center">${eval.finished.title }</td>
								        <td class="app_td" align="center"><fmt:formatDate value="${eval.createTime }" pattern="yyyy-MM-dd" /></td>
								        <td class="app_td" align="center">${eval.totalScore.title }</td>
					        			<td class="app_td" align="center" style="border-right:0px;">
					        				<table>
					        					<tr>
					        						<td><img src="core/common/images/viewbtn.gif" width="14" height="14" title="查看" onclick="viewById(${eval.id });"/></td>
					        					</tr>
					        				</table>
					        			</td>
					        		</tr>
						        	</c:forEach>
				        		</table>
							</div>
						</div>
						
						<div class="basediv tabswitch" style="margin:0px;display:none;" id="textname">
							<table id="memoList" width="100%"><tr><td/></tr></table>
						</div>
					
					<div class="hackbox"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
<div style="height: 5px;"></div>






</body>
</html>