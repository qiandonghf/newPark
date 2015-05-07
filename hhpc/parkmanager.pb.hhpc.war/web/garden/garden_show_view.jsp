<%@page import="com.wiiy.core.entity.User"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.Investment"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>

<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		$('#investRight_height').css('height',getTabContentHeight());
		$('#investRight_height2').css('height',getTabContentHeight());
		$('.investRight_height3').css('height',getTabContentHeight()-33);
		$("table").css("border-top","0px");
		initTab();
		$(".app_td").css("border-right","0px");
		initMemoList();
	});
	
	function initTab(){
		tabSwitch('apptabli','apptabliover','tabswitch',parent.currentIndex);
	}
	
	function edit(id){
		window.open('<%=basePath%>garden!applyEdit.action?id='+id,'编辑申请','scrollbars=yes,resizable=no,width=730,height=620')
	}
	
	function rename(id,name){
		if(canDeal("重命名"+name))
			fbSearch('重命名','<%=basePath %>garden!attEdit.action?id='+id,333,67);
	}
	
	function viewById(id){
		fbStart("查看评审明细","<%=basePath%>garden!evalViewById.action?id="+id,700,495);
	}
	
	function downAttr(path,name){
		location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
	}
	
	function initMemoList(){
		var height = 280;
		var width = $(".pm_msglist").width();
		$("#memoList").jqGrid({
	    	url:'<%=basePath%>gardenApplyLog!listByApplyId.action?id=${result.value.id}',
			colModel: [
				{label:'创建时间',width:120,name:'createTime',align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				{label:'创建人',width:120,name:'creator',align:"center"}, 
				{label:'备注内容', name:'content',align:"center"}, 
			    {label:'管理',name:'manager', align:"center", sortable:false, resizable:false}
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
					<%
					boolean add = PbActivator.getHttpSessionService().
							isInResourceMap("pb_gardenManager_list_addLog")||
							PbActivator.getHttpSessionService().
							isInResourceMap("pb_service_serviceWindow_addLog");
					boolean edit = PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_editLog")||
							PbActivator.getHttpSessionService().
							isInResourceMap("pb_service_serviceWindow_editLog");
					boolean delete = PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_deleteLog")||
							PbActivator.getHttpSessionService().
							isInResourceMap("pb_service_serviceWindow_deleteLog");
					%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewLog("+id+");\"  /> ";
					<%if(edit){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editLog("+id+");\"  /> ";
					<%} %>
					<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteLog("+id+");\"  /> ";
					<%} %>
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
	
	function addLog(){
		<%if(add){%>
		fbStart('新建备注信息2','<%=basePath %>garden!applyLogAdd.action?applyId=${result.value.id}',550,158);
		<%}%>
	}
	
	function viewLog(id){
		fbStart('查看备注信息','<%=basePath %>garden!applyLogView.action?id='+id,550,134);
	}
	function editLog(id){
		<%if(edit){%>
		fbStart('编辑备注信息','<%=basePath %>garden!applyLogEdit.action?id='+id,550,154);
		<%}%>
	}
	
	function deleteLog(id){
		<%if(delete){%>
		if(confirm("确定删除")){
			$.post("<%=basePath%>garden!applyLogDelete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		reloadMemoList();
	        	}
			});
		}
		<%}%>
	}

</script>
<style>
	table{
		table-layout:fixed;
	}
	td{
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}
	
</style>
</head>

<body style="padding-bottom: 2px;background-color:#fff;">
	<div class="basediv" id="investRight_height" style="border:0px;margin:0px;">
	<div class="divlays" id="investRight_height2" style="margin:0px;padding:0px;">
	<div class="apptab" id="tableid">
		<ul>
			<li class="apptabliover" onclick="parent.currentIndex=0;tabSwitch('apptabli','apptabliover','tabswitch',0)">申请信息</li>
			<li class="apptabli" onclick="parent.currentIndex=1;tabSwitch('apptabli','apptabliover','tabswitch',1)">创业计划书</li>
			<li class="apptabli" onclick="parent.currentIndex=2;tabSwitch('apptabli','apptabliover','tabswitch',2)">附件材料</li>
			<li class="apptabli" onclick="parent.currentIndex=3;tabSwitch('apptabli','apptabliover','tabswitch',3)">评审信息</li>
			<li class="apptabli" onclick="parent.currentIndex=4;tabSwitch('apptabli','apptabliover','tabswitch',4)">备注信息</li>
		</ul>
	</div>
    <div class="pm_msglist apptable tabswitch investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		<div>
			<div class="emailtop">
				<!--leftemail-->
				<div class="leftemail">
					<ul>
						<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_edit") ||
								PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_edit")){
		               	%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="edit(${result.value.id })"><span><img src="core/common/images/edit.gif" /></span>编辑</li>
						<%} %>
					</ul>
				</div>
				<!--//leftemail-->
			</div>
			<div class="apptable" style="border-top:none; border-left:none;">
	        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
	        		<td class="tdleft" width="80" align="center" valign="middle">申请人信息</td>
	        		<td>
	        			<table width="100%" border="0" cellspacing="0" cellpadding="0">
	     					<tr>
						        <td class="tdleft" width="100">申请人</td>
						        <td class="app_td" width="150"> ${result.value.applyer }</td>
						        <td width="100" class="tdleft">申请日期 </td>
						        <td class="app_td"><fmt:formatDate value="${result.value.applyTime }" pattern="yyyy-MM-dd"/></td>
				      		</tr>
	    				</table>
	        		</td>
	        	</tr>
				<tr>
					<td class="tdleft" width="80" align="center" valign="middle">项目名称</td>
					<td class="app_td">${result.value.projectName }</td>
				</tr>
				<tr>
					<td  class="tdleft" align="center" valign="middle">项目来源</td>
					<td>
						<table  width="100%" border="0" cellspacing="0" cellpadding="0">
						  <tr>
						    <td class="app_td">
					    		<label>${result.value.projectSource.title } </label>
						    	<c:if test="${result.value.projectSource eq 'OTHER' }">
						    		<label>${result.value.sourceDetail } </label>
						    	</c:if>
						    </td>
						  </tr>
						</table>
					</td>
				</tr>
	  			<tr>
				    <td class="tdleft" align="center" valign="middle">项目类型</td>
				    <td>
				    	<table  width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
		    					<td class="app_td">
		    						<label>${result.value.projectType.title } </label>
							    	<c:if test="${result.value.projectType eq 'OTHER' }">
							    		<label>${result.value.projectTypeDetail } </label>
							    	</c:if>
		    					</td>
							</tr>
						</table>
					</td>
	  			</tr>
	  			<tr>
	  				<td class="tdleft" align="center" valign="middle">是否融资</td>
	  				<td class="app_td"><label>${result.value.financing.title } </label></td>
	  			</tr>
	  			<tr>
	  				<td class="tdleft" align="center" valign="middle">是否发布到网站</td>
	  				<td class="app_td"><label>${result.value.pub.title } </label></td>
	  			</tr>
	  			<tr>
	  				<td class="tdleft" align="center" valign="middle">项目去向</td>
	  				<td class="app_td"><label>${result.value.applyDirection.title } </label></td>
	  			</tr>
	 			<tr>
				    <td class="tdleft" align="center" valign="middle">项目负责人联系方式</td>
				    <td>
				    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	     					<tr>
						        <td class="tdleft" width="100">姓名</td>
						        <td class="app_td" width="150">${result.value.leaderName }</td>
						        <td width="100" class="tdleft">手机 </td>
						        <td class="app_td">${result.value.leaderMobile }</td>
				      		</tr>
				      		<tr>
						        <td class="tdleft">E-mail </td>
						        <td class="app_td">${result.value.leaderEmail }</td>
						        <td class="tdleft">QQ</td>
						        <td class="app_td">${result.value.leaderQQ }</td>
				      		</tr>
							<tr>
							  <td class="tdleft">学校</td>
							  <td class="app_td">${result.value.leaderSchool }</td>
							  <td class="tdleft">院系年级</td>
							  <td class="app_td">${result.value.leaderCollege }</td>
							</tr>
							<tr>
								<td class="tdleft" colspan="2">紧急联络方式(不要重复手机)</td>
								<td class="app_td" colspan="2">${result.value.leaderPhone }</td>
							</tr>
	    				</table>
	    			</td>
	  			</tr>
	  			<tr>
				    <td class="tdleft" align="center" valign="middle">项目简介</td>
				    <td class="app_td">
				    	<label for="textarea">
				    	<textarea id="textarea" readonly="readonly" style="width:100%;resize:none;margin:2px 0px 1px;border:0px;height:60px;">${result.value.introduction }</textarea>
				    	</label>
				    </td>
	  			</tr>
	  			<tr>
			      	<td class="tdleft" align="center" valign="middle">项目成员图片</td>
			      	<td class="app_td">
			      		<div class="divlays teamPicSrc" style="float:left;width:85%;">
							<div class="emaildown" style="padding:0px;margin:0px;height:47px;border:0px;background-color:#fff;">
								<div id="teamPicSrc" style="display:block;">
									<c:if test="${not empty result.value.oldName }">
									<div class="downlist"> 
										<img src="core/common/images/downloadico.png" />
								        <ul>
								          <li>${result.value.oldName }</li>
								          <li>
								          	<a href="javascript:void(0)" onclick="downAttr('${result.value.photo }','${result.value.oldName }')">下载</a>
								         </li>
								        </ul>
								    </div>
									</c:if>
									<c:if test="$ empty result.value.oldName }">&nbsp;</c:if>
								</div>
								<div class="hackbox"></div>
							</div>
						</div>
			        </td>
			    </tr>
	  			<tr>
	    			<td class="tdleft" align="center" valign="middle">项目信息</td>
	    			<td>
	    				<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      					<tr>
						        <td width="220" align="center" class="tdleft">曾经参加比赛</td>
						        <td class="app_td">${result.value.competition }</td>
	      					</tr>
	      					<tr>
						        <td width="220" align="center" class="tdleft">曾获奖励/专利</td>
						        <td class="app_td">${result.value.reward }</td>
	     					</tr>
	      					<tr>
						        <td width="220" align="center" class="tdleft">指导老师</td>
						        <td class="app_td">${result.value.teacher }</td>
	      					</tr>
	    				</table>
	    			</td>
	  			</tr>
	  			<tr>
	    			<td class="tdleft" align="center" valign="middle">项目成员</td>
	    			<td>
		   				<table width="100%" border="0" cellspacing="0" cellpadding="0">
		     					<tr>
						        <td class="tdleft" align="center">姓名</td>
						        <td class="tdleft" align="center">专业</td>
						        <td class="tdleft" align="center">联系方式</td>
						        <td class="tdleft" align="center" style="border-right:0px;">在项目中的职能</td>
		     					</tr>
		     					<tr>
						        <td class="app_td" align="center">${result.value.memberName1 }</td>
						        <td class="app_td" align="center">${result.value.memberMajor1 }</td>
						        <td class="app_td" align="center">${result.value.memberPhone1 }</td>
						        <td class="app_td" align="center">${result.value.memberRole1 }</td>
		     					</tr>
		     					<tr>
						        <td class="app_td" align="center">${result.value.memberName2 }</td>
						        <td class="app_td" align="center">${result.value.memberMajor2 }</td>
						        <td class="app_td" align="center">${result.value.memberPhone2 }</td>
						        <td class="app_td" align="center">${result.value.memberRole2 }</td>
		     					</tr>
		     					<tr>
						        <td class="app_td" align="center">${result.value.memberName3 }</td>
						        <td class="app_td" align="center">${result.value.memberMajor3 }</td>
						        <td class="app_td" align="center">${result.value.memberPhone3 }</td>
						        <td class="app_td" align="center">${result.value.memberRole3 }</td>
		     					</tr>
		     					<tr>
						        <td class="app_td" align="center">${result.value.memberName4 }</td>
						        <td class="app_td" align="center">${result.value.memberMajor4 }</td>
						        <td class="app_td" align="center">${result.value.memberPhone4 }</td>
						        <td class="app_td" align="center">${result.value.memberRole4 }</td>
		     					</tr>
		     					<tr>
						        <td class="app_td" align="center">${result.value.memberName5 }</td>
						        <td class="app_td" align="center">${result.value.memberMajor5 }</td>
						        <td class="app_td" align="center">${result.value.memberPhone5 }</td>
						        <td class="app_td" align="center">${result.value.memberRole5 }</td>
		     					</tr>
		   				</table>
		    		</td>
		  		</tr>
			 	<tr>
			    	<td class="tdleft" align="center" valign="middle">入驻要求</td>
			    	<td>
		   				<table width="100%" border="0" cellspacing="0" cellpadding="0">
		   					<tr>
						        <td class="tdleft" colspan="2" align="center">需用工位数</td>
						        <td class="tdleft" colspan="2" align="left" style="text-align:left;background-color: #fff;border-right:0px;">${result.value.tableCnt }</td>
		   					</tr>
		   				</table>
	    			</td>
			  </tr>
			</table>
			</div>
		</div>
	</div>
		
		
    <div class="pm_msglist apptable tabswitch investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		<div>	
	        <div class="divlays applyRight_height3" style="padding:2px 5px 0px 5px;">
			    <div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
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
		</div>
	  </div>
	  
    <div class="pm_msglist apptable tabswitch investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		<div>
	        <div class="divlays applyRight_height3" style="padding:2px 5px 0px 5px;">
			    <div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
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
		</div>
  	</div>
	  	
  	<!-- 评审 -->
    <div class="pm_msglist apptable tabswitch investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		<div>
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
				        <td class="tdleft" align="center" style="background-color:#fff;">${result.value.applyer }</td>
				        <td class="tdleft" align="center" style="background-color:#fff;">${eval.evalUser.realName }</td>
				        <td class="tdleft" align="center" style="background-color:#fff;">${eval.finished.title }</td>
				        <td class="tdleft" align="center" style="background-color:#fff;"><fmt:formatDate value="${eval.createTime }" pattern="yyyy-MM-dd" /></td>
				        <td class="tdleft" align="center" style="background-color:#fff;">${eval.totalScore.title }</td>
	        			<td class="app_td" align="center">
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
  </div>
  
  <div class="pm_msglist apptable tabswitch investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
	<div>	
		<%if(add){%>
		<div class="emailtop">
			<!--leftemail-->
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addLog();"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
				</ul>
			</div>
			<!--//leftemail-->
		</div>
		<%}%>
        <table id="memoList" width="100%"><tr><td/></tr></table>
	</div>
  </div>
  
  
</div>
</div>
</body>
</html>