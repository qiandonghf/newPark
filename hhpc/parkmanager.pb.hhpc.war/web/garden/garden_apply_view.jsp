<%@page import="com.wiiy.core.dto.ResourceDto"%>
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
		initUploadify("businessPlan","创业计划书上传","105",false);
		initUploadify("otherAtt","附件上传","80",true);
		initUploadify("teamPic","上传图片","80");
		initUpload();
		initTab();
		initMemoList();
	});
	
	function initTab(){
		tabSwitch('apptabli','apptabliover','tabswitch',parent.currentIndex);
	}
	
	function initUploadify(id,name,width){
		var root = '<%=BaseAction.rootLocation %>/';
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'disable'			: true,
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'pb','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: root+"core/upload.action",
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: width,//按钮图片的长度
			'height'			: "18",//按钮图片的高度
			'buttonText'		: '<span style="top:5px;"><img src="core/common/images/emailadd.gif" /></span>'+name,
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: "*.*",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.*",//可上传上的文件类型
			'onUploadSuccess'	: function(file, data, response){
				if(name == '附件上传')
					onUploadSuccess(file, data, response,false);
				else{
					onUploadSuccess(file, data, response,true);
				}
			}
		});
	}
	
	function initUpload(){
		$(".deal").each(function(i){
			var projectState = "${result.value.projectState}";
			var applyState = "${result.value.applyState}";
			if(projectState != 'APPLYING' || applyState != 'EVAL'){
				if(i%2 != 0)
					$(this).click(function(){
						showTip("当前状态不能执行『上传』操作",2000);
					});
			}else if(projectState == 'APPLYING' && applyState == 'EVAL'){
				if(i%2 == 0)
					$(this).show();
				else
					$(this).hide();
			}
		});
	}
	
	function showPhoto(){
		var url = "${result.value.photo }";
		fbShow(url);
	}
	
	function rename(id,name){
		if(canDeal("重命名"+name))
			fbSearch('重命名','<%=basePath %>garden!attEdit.action?id='+id,333,67);
	}
	
	function onUploadSuccess(file, data, response,isBusiness) {
		showTip("文件读取成功!",2000);
		var info = $.parseJSON(data);
		var path = info.path;
		var oldName = info.originalName;
		var size = info.size;
		var type = "";
		if(isBusiness)
			type = "BUSINESSPLAN";
		else
			type = "OTHER";
		var postData = {"gardenApplyAtt.applyId":"${result.value.id}","gardenApplyAtt.name":oldName,"gardenApplyAtt.newName":path,"gardenApplyAtt.size":size,"gardenApplyAtt.type":type};
		$.ajax({
			type:"post",
			data:postData,
			url :"<%=basePath%>garden!attSave.action",
			success:function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					setTimeout("window.location.reload();", 2000);
				}
			}
		});
	}
	
	function delAttById(id,name){
		if(canDeal("删除"+name))
			if(confirm("确定要删除吗")){
				$.post("<%=basePath%>garden!attDelete.action?id="+id,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("window.location.reload();", 2000);
		        	}
				});
			}
	}
	
	function delApply(id,uid){
		if(canDeal("删除")){
			var cid = '<%=PbActivator.getSessionUser().getId() %>';
			if(cid != uid){
				showTip("只能删除本人创建的申请单",2000);
				return;
			}
			if(confirm("确定要删除吗")){
				$.post("<%=basePath%>garden!applyDelete.action?id="+id,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("parent.location.reload();", 2000);
		        	}
				});
			}
		}
	}
	
	function canDeal(txt){
		var projectState = "${result.value.projectState}";
		var applyState = "${result.value.applyState}";
		if(projectState != 'APPLYING' || applyState != 'EVAL'){
			showTip("当前状态不能执行『"+txt+"』操作",2000);
			return false;
		}
		return true;
	}
	
	function edit(id){
			window.open('<%=basePath%>garden!applyEdit.action?id='+id,'编辑申请','scrollbars=yes,resizable=no,width=730,height=620')
	}
	function selectUser(){
		if(canDeal("分配")){
			parent.applyId = "${result.value.id}";
			fbStart('选择创业导师','<%=BaseAction.rootLocation %>/core/user!select2.action',520,400);
		}
	}
	
	function suggestion(b){
		var t = "";
		if(b == 'YES')
			t = "同意";
		else
			t = "拒绝";
		if(canDeal(t+"入圃"))
			if(confirm("确定"+t+"此项目入圃")){
				if(b == 'YES')
					fbStart("填写工位信息","<%=basePath%>web/garden/garden_apply_info.jsp?applyId=${result.value.id}",400,101);
				else
					$.post("<%=basePath%>garden!agreement.action?id=${result.value.id}&isAgree=NO",function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.location.reload();", 2000);
			        	}
					});
			}
	}
	
	
	function deleteById(id){
		if(canDeal("删除评审信息"))
			if(confirm("确定要删除吗")){
				$.post("<%=basePath%>garden!evalDelete.action?id="+id,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("location.reload();", 2000);
		        	}
				});
			}
	}
	
	function viewById(id){
		fbStart("查看评审明细","<%=basePath%>garden!evalViewById.action?id="+id,700,500);
	}
	
	function downAttr(path,name){
		location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
	}
	
	function reloadMemoList(){
		$("#memoList").trigger("reloadGrid");
	}
	function initMemoList(){
		var height = 280;
		var width = $(".textname").width();
		$("#memoList").jqGrid({
	    	url:'<%=basePath%>gardenApplyLog!listByApplyId.action?id=${result.value.id}',
			colModel: [
				{label:'创建人',width:120,name:'creator',align:"center"}, 
				{label:'创建时间',width:120,name:'createTime',align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				{label:'备注内容', name:'content',align:"center",width:120}, 
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
					<%
					Map<String, ResourceDto> resourceMap = PbActivator.getHttpSessionService().getResourceMap();
					boolean add = PbActivator.getHttpSessionService().
							isInResourceMap("pb_gardenManager_list_addLog")||
							PbActivator.getHttpSessionService().
							isInResourceMap("pb_service_serviceWindow_addLog");
					boolean view = PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_viewLog")||
							PbActivator.getHttpSessionService().
							isInResourceMap("pb_service_serviceWindow_viewLog");
					boolean edit = PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_editLog")||
							PbActivator.getHttpSessionService().
							isInResourceMap("pb_service_serviceWindow_editLog");
					boolean delete = PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_deleteLog")||
							PbActivator.getHttpSessionService().
							isInResourceMap("pb_service_serviceWindow_deleteLog");
					%>
					<%if(view){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewLog("+id+");\"  /> ";
					<%} %>
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
		fbStart('新建备注信息','<%=basePath %>garden!applyLogAdd.action?applyId=${result.value.id}',550,158);
		<%}%>
	}
	
	function viewLog(id){
		<%if(view){%>
		fbStart('查看备注信息','<%=basePath %>garden!applyLogView.action?id='+id,550,134);
		<%}%>
	}
	function editLog(id){
		<%if(edit){%>
		fbStart('编辑备注信息','<%=basePath %>garden!applyLogEdit.action?id='+id,550,153);
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
	.uploadify-button {
		background: #f0f0f0 /* url("../core/common/images/emailadd.gif") */;
		background-position: left center;
		background-repeat: no-repeat;
		border: 1px solid #f0f0f0;;
		color: #333;
		font: 12px Arial, Helvetica, sans-serif;
		/* padding-left:5px; */
		position: relative;
		text-align: center;
		top: 0px;
		width: 100%;
	}
	
	.emailtop .email ul li span {
		display: inline;
		float: left;
		height: 26px;
		line-height: 26px;
		padding-right: 3px;
		position: relative;
		top: -1px;
	}
	
	.uploadify:hover .uploadify-button {
		background-color: #e4f3ff;
		color: #333;
		background-position: left center;
	}
	.del_icon{
		overflow:hidden;
		background: url(core/common/images/layerdiv.png) -2px -53px;
		background-repeat: no-repeat;
		width: 15px;
		display: inline-block;
		float: left;
	}
	table{
		table-layout:fixed;
	}
	td{
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}
	.showPhoto{
		position:absolute;
		top:20px;
		left:30px;
		z-index:10;
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
						<li onmouseover="this.className='libg'" 
						onmouseout="this.className=''" 
						onclick="edit(${result.value.id })">
						<span><img src="core/common/images/edit.gif" /></span>编辑</li>
						<%} %>
						<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_delete") ||
								PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_delete")){
		               	%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="delApply(${result.value.id },${result.value.creatorId })"><span class="del_icon" style="top:2px;height:18px;"></span>删除</li>
						<%} %>
					</ul>
				</div>
				<!--//leftemail-->
			</div>
			<div class="apptable" style="border-top:none; border-left:none;">
	        <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
				    <td class="tdleft" align="center" valign="middle">项目负责人<br/>联系方式</td>
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
								<div id="teamPicSrc">
									<c:if test="${not empty result.value.oldName }">
									<div class="downlist"> 
										<img src="core/common/images/downloadico.png" />
								        <ul>
								          <li style="cursor:pointer;" onclick="showPhoto();">
								          	${result.value.oldName }
								          </li>
								          <li>
								          	<a href="javascript:void(0)" onclick="downAttr('${result.value.photo }','${result.value.oldName }')">下载</a>
								         </li>
								        </ul>
								    </div>
									</c:if>
									<c:if test="${empty result.value.oldName }">&nbsp;</c:if>
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
						        <td class="tdleft" align="center">在项目中的职能</td>
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
					        <td class="tdleft" colspan="2" align="left" style="text-align:left;background-color: #fff;">${result.value.tableCnt }</td>
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
			<div class="emailtop">
				<!--leftemail-->
				<div class="leftemail email">
					<ul>
						<li class="deal hide" onmouseover="this.className='libg'" onmouseout="this.className='deal'" ><input type="file" id="businessPlan"/></li>
						<li class="deal" onmouseover="this.className='libg'" onmouseout="this.className='deal'"><span style="top:5px;"><img src="core/common/images/emailadd.gif"/></span>计划书上传</li>					
					</ul>
				</div>
				<!--//leftemail-->
			</div>
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
				          	<!-- <a href="javascript:void(0)">打开</a> -->
				          	<a href="javascript:void(0)" onclick="rename(${att.id},'项目计划书')">重命名</a>
				          	<a href="javascript:void(0)" onclick="delAttById(${att.id },'项目计划书')">删除</a>
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
			<div class="emailtop">
				<!--leftemail-->
				<div class="leftemail email">
					<ul>
						<li class="deal hide" onmouseover="this.className='libg'" onmouseout="this.className='deal'" ><input type="file" id="otherAtt"/></li>
						<li class="deal" onmouseover="this.className='libg'" onmouseout="this.className='deal'"><span style="top:5px;"><img src="core/common/images/emailadd.gif"/></span>附件上传</li>					
					</ul>
				</div>
				<!--//leftemail-->
			</div>
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
				          	<!-- <a href="javascript:void(0)">打开</a> -->
				          	<a href="javascript:void(0)" onclick="rename(${att.id},'附件');">重命名</a>
				          	<a href="javascript:void(0)" onclick="delAttById(${att.id },'附件')">删除</a>
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
			<c:if test="${info  ne 'WINDOW' }">
			<div class="emailtop">
			<!--leftemail-->
			<div class="leftemail">
				<ul>
					<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_assign")){
				 	 %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="selectUser();"><span><img src="core/common/images/edit.gif" /></span>分配</li>
					<%}%>
				</ul>
			</div>
			</div>
			</c:if>
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
									<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_eval_view")||
											PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_eval_view")){
						 	         %>
	        						<td><img src="core/common/images/viewbtn.gif" width="14" height="14" title="查看" onclick="viewById(${eval.id });"/></td>
	        						<%}%>
									<c:if test="${info  ne 'WINDOW' }">
									<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_eval_delete")){
						 	         %>
	        						<td><img src="core/common/images/del.gif" width="14" height="14" title="删除" onclick="deleteById(${eval.id });" /></td>
	        						<%}%>
	        						</c:if>
	        					</tr>
	        				</table>
	        			</td>
	        		</tr>
		        	</c:forEach>
        		</table>
	        	<div class="buttondiv" style="margin-top:5px;">
	        		<c:if test="${info  ne 'WINDOW' }">
					<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_agreement")){
		 	         %>
					<label><input name="Submit" type="button" value="同意入圃" onclick="suggestion('YES');" /></label>
					<label><input name="Submit2" type="button" value="拒绝入圃" onclick="suggestion('NO');" /></label>
    				<%}%>
    				</c:if>
				</div>
			</div>
		</div>
  </div>
  
  <div class="pm_msglist apptable tabswitch investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		<div>	
			<div class="emailtop">
				<!--leftemail-->
				<div class="leftemail">
					<ul>
						<%if(add){%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addLog();"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
						<%}%>
					</ul>
				</div>
				<!--//leftemail-->
			</div>
	        <table id="memoList" width="100%"><tr><td/></tr></table>
		</div>
	  </div>
	</div>
</div>
</body>
</html>