<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Long userId = OaActivator.getSessionUser(request).getId();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
		$(function(){
			initTip();
			initLogList();
		});
		function initLogList(){
			$("#logList").jqGrid({
		    	url:'<%=basePath%>taskLog!list.action?id='+$("#taskId").val(),
				colModel: [
					{label:'ID', name:'id', align:"center",hidden:true}, 
					{label:'执行人', name:'executeUserName', align:"center",width:35}, 
					{label:'执行时间', name:'executeTime', align:"center",width:35,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
					{label:'内容', name:'memo', align:"center"}, 
				    {label:'管理', name:'manager', align:"center",width:35, resizable:false,sortable:false}
				],
				height: 240,
				width: 628,
				gridComplete: function(){
					var ids = $(this).jqGrid('getDataIDs');
					for(var i = 0 ; i < ids.length; i++){
						var id = ids[i];
						var content = "";
						content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
						<%
							String creator = (String)request.getAttribute("creator");
							if(OaActivator.getSessionUser(request).getRealName().equals(creator)){%>
							content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
							content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
						<%}%>
						$(this).jqGrid('setRowData',id,{manager:content});
					}
				}
			});
			
			$("#appointList").jqGrid({
				url:'<%=basePath%>taskLog!list2.action?id='+$("#taskId").val(),
				colModel: [
					{label:'执行人', name:'executeUserName', align:"center",width:35}, 
					{label:'执行时间', name:'modifyTime', align:"center",width:35,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				    {label:'状态', name:'memo', align:"center",width:35, resizable:false,sortable:false,formatter:statusFormat}
				],
				height: 230,
				width: 350,
				multiselect: false,
				gridComplete: function(){
					var ids = $(this).jqGrid('getDataIDs');
					for(var i = 0 ; i < ids.length; i++){
						var id = ids[i];
						var content = "";
						content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" alt=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" alt=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" alt=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
						$(this).jqGrid('setRowData',id,{manager:content});
					}
				}
			});
		}
		
		
		function statusFormat(value,row,table){
			var newValue1 = "未签收";
			var newValue2 = "已签收";
			var newValue3 = "已拒绝";
			var newValue4 = "已完成";
			var newValue5 = "已中止";
			if(value=='任务未签收')return "<span style='color:#f60'>"+newValue1+"</span>";
			if(value=='任务已签收')return "<span style=''>"+newValue2+"</span>";
			if(value=='任务已拒绝')return "<span style=''>"+newValue3+"</span>";
			if(value=='任务已完成')return "<span style=''>"+newValue4+"</span>";
			if(value=='任务已中止')return "<span style='color:#f00'>"+newValue5+"</span>";
			return value;
		}
		function reloadTaskLogList(){
			$("#logList").trigger("reloadGrid");
		}
		function editById(id){
			fbStart('编辑',"<%=basePath%>taskLog!edit.action?id="+id,500,284);
		}
		function viewById(id){
			fbStart('查看',"<%=basePath%>taskLog!view.action?id="+id,500,284);
		}
		function deleteById(id){
			if(confirm("您确定要删除")){
				$.post("<%=basePath%>taskLog!delete.action?id="+id,function(data){
					showTip(data.result.msg,2000);
					$("#logList").trigger("reloadGrid");
				});
			}
		}
		function deleteSelected(){
			var ids = $("#logList").jqGrid("getGridParam","selarrrow");
			if(ids!='' && confirm("确定要删吗")){
				$.post("<%=basePath%>taskLog!delete.action?ids="+ids,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("#logList").trigger("reloadGrid");
						$("#appointList").trigger("reloadGrid");
		        	}
				});
			}
		}
		$(function(){
			$('#works').click(function(){
			if($('#meterlayer').is(':hidden')){
				$('#meterlayer').show();
			}else{
				$('#meterlayer').hide();
				}
			return false;
			});
			$('#workzz').click(function(){
			if($('#meterlayers').is(':hidden')){
				$('#meterlayers').show();
			}else{
				$('#meterlayers').hide();
				}
			return false;
			});
		    
		});
		$(document).click(function(){
			$('#meterlayer').hide();
			$('#meterlayers').hide();
		});
		function signed(){
			$.post("<%=basePath%>task!signed.action?id="+$("#taskId").val(),function(data){
				showTip(data.result.msg,2000);
				$("#logList").trigger("reloadGrid");
				$("#appointList").trigger("reloadGrid");
			});
		}
		function refused(){
			$.post("<%=basePath%>task!refused.action?id="+$("#taskId").val(),function(data){
				showTip(data.result.msg,2000);
				$("#logList").trigger("reloadGrid");
				$("#appointList").trigger("reloadGrid");
			});
		}
		function finished(){
			if($("#creatorId").val()==<%=userId%> && confirm("是否关闭该工作")){
				$.post("<%=basePath%>task!finished.action?id="+$("#taskId").val(),function(data){
					showTip(data.result.msg,2000);
					$("#logList").trigger("reloadGrid");
					$("#appointList").trigger("reloadGrid");
				});
			}
		}
		function aborted(){
			$.post("<%=basePath%>task!aborted.action?id="+$("#taskId").val(),function(data){
				showTip(data.result.msg,2000);
				$("#logList").trigger("reloadGrid");
				$("#appointList").trigger("reloadGrid");
			});
		}
	</script>
</head>

<body>
<form action="<%=basePath %>task!update.action" method="post" name="form1" id="form1">
	 <input type="hidden" name="task.promotDetail" id="promotDetail"/>
	 <input type="hidden" id="taskId" name="task.id" value="${result.value.id}"/>
	 <input type="hidden" id="creatorId" value="${result.value.creatorId}"/>
	<div class="basediv">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="parent.fb.end()"><span><img src="core/common/images/closebtnicon.gif"/></span>关闭</li>
					<li class="eline"></li>
				</ul>
			</div>
		</div>
		<div class="apptab" id="tableid">
			<ul>
				<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','divlays',0)">任务</li>
				<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','divlays',1)">详细信息</li>
				<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','divlays',2)">工作轨迹</li>
			</ul>
		</div>
		<div class="pm_msglist" style="margin:0 5px 5px 5px;">
		<div class="divlays">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">主题：</td>
					<td colspan="3" class="layerright">${result.value.title}</td>
				</tr>
				<tr>
					<td class="layertdleft100">截止时间：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="135">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120"><fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd"/></td>
											<td width="30" align="center"></td>
											<td>&nbsp; </td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100">状态：</td>
					<td class="layerright" width="165">${result.value.status.title}</td>
				</tr>
				<tr id="endtime">
					<td class="layertdleft100">开始时间：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="135">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120"><fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd"/></td>
											<td width="30" align="center"></td>
											<td>&nbsp; </td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100">优先级：</td>
					<td class="layerright" width="165">${result.value.priority.title }</td>
				</tr>
				<tr>
					<td class="layertdleft100">所属部门：</td>
					<td class="layerright">
						<c:forEach items="${newDepList}" var="depName">
							${depName}&nbsp;
						</c:forEach>
					</td>
					<td class="layertdleft100">所属项目：</td>
					<td class="layerright">
						${projectName}
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">提醒时间：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="80">${result.value.promot.title}</td>
								<%
									Result<Task> result = (Result<Task>)request.getAttribute("result");
									Task task = result.getValue();
									String str = task.getPromotDetail();
									String ms = "";
									if(str.length()>12){
										ms = str.substring(11, str.length());
									}else{
									}
									boolean noPromot = false;
									boolean mtime = false;
									boolean specialday = false;
									if(task.getPromot()!=null)
									switch(task.getPromot()){
									case NOPROMOT:
									case NOW:
										noPromot = true;
										break;
									case SPECIALDAY:
										specialday = true;
										break;
									case LASTDAY:
										mtime = true;
										break;	
									case CURRENTDAY:
										mtime = true;
										break;	
									}
									else noPromot = true;
								%>
								<td width="135" id="SPECIALDAY"  class="layerright" <%if(!specialday){ %><% }%>>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120">
												<%if(!noPromot){%>
													${fn:substring(result.value.promotDetail,0,fn:indexOf(result.value.promotDetail,' '))} <%=ms %>:00
												<%}else if(mtime){ %>	
													<%=str%>:00
												<%}%>
											</td>
											
										</tr>
									</table>
								</td>
								<td>
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">提醒方式：</td>
					<td colspan="3" class="layerright">
						<table border=0 cellspacing=0 cellpadding=0 width="100%">
							<tbody>
								<tr>
									<td width=20><label><input value="<%=BooleanEnum.YES %>" type="checkbox" disabled="disabled" name="task.sms" <c:if test="${result.value.sms eq 'YES'}">checked="checked"</c:if>/></label></td>
									<td width=30>短信 </td>
									<%-- <td width=20><input value="<%=BooleanEnum.YES %>" type="checkbox" disabled="disabled" name="task.defaultEmail" di <c:if test="${result.value.defaultEmail eq 'YES'}">checked="checked"</c:if>/></td>
									<td width=50>内部邮件</td> --%>
									<td width=20><input value="<%=BooleanEnum.YES %>" type="checkbox" disabled="disabled" name="task.email" <c:if test="${result.value.email eq 'YES'}">checked="checked"</c:if>/></td>
									<td>邮件</td>
									<td>&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">任务描述：</td>
					<td colspan="3" class="layerright" style="padding-bottom:2px;">
						<div style=" vertical-align:middle; height:100px; width:500px; padding:5px; overflow-x:auto; overflow-y:auto;">
							${result.value.memo}
						</div>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">附件列表：</td>
					<td class="layerright">
					<table border=0 cellspacing=0 cellpadding=0 width="100%"><tr><td style="padding-left:5px;">
						<div id="attList" style="height: 40px;overflow-x:hidden;overflow-y: auto; ">
						<c:forEach items="${result.value.atts}" var="att">
						<li id="li${att.id}" style="text-align: center;"><label><a href="core/resources/${att.newName}?name=${att.name}" style="text-decoration: underline;">${att.name}</a><input type="hidden" value="${att.newName}" class="att"/></label></li>
						</c:forEach>
						</div>
					</td></tr></table>
					</td>
				</tr>
			</table>
		</div>
		 <div class="divlays" name="textname" id="textname" style="display:none">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">创建人：</td>
					<td>&nbsp;${creator}</td>
				</tr>
				<tr id="endtime">
					<td class="layertdleft100">完成时间：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="135">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120"><fmt:formatDate value="${result.value.finishTime}" pattern="yyyy-MM-dd"/></td>
											<td>&nbsp; </td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<%-- <tr>
					<td class="layertdleft100">所属部门：</td>
					<td class="layerright">
						<c:forEach items="${newDepList}" var="depName">
							${depName}&nbsp;
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">所属项目：</td>
					<td class="layerright">
						${projectName}
					</td>
				</tr> --%>
				<%-- <tr>
					<td class="layertdleft100">重复方式：</td>
					<td class="layerright"><enum:select checked="result.value.repeatType" type="com.wiiy.oa.preferences.enums.RepeatEnum" name="task.repeatType"/></td>
				</tr> --%>
				<tr>	
					<c:if test="${taskLogList!=null}">
					<c:if test="${creator ne result.value.creator}">
				   	<td class="layertdleft100">执行人&nbsp;&nbsp;&nbsp;<br/>完成情况：</td>
				   	<td class="layerright">
				   		<table width="350" border="0" cellspacing="0" cellpadding="0" class="task_border">
				   			<tr>
								<td class="tdcenter">执行人</td>
								<td class="tdcenter">时间</td>
								<td style="border-right:1px solid #e1e1e1;" class="tdrightc">完成状态</td>
							</tr>
							
							<c:forEach items="${taskLogList}" var="log">
								<tr>
									<td class="task_td">${log.executeUserName}</td>
									<td class="task_td"><fmt:formatDate value="${log.executeTime}" pattern="yyyy-MM-dd"/></td>
									<c:if test="${log.memo eq '工作已签收'}">
										<td class="task_td">已签收</td>
									</c:if>
									<c:if test="${log.memo eq '中止工作'}">
										<td class="task_td_red">中止</td>
									</c:if>
									<c:if test="${log.memo eq '完成工作'}">
										<td class="task_td">已完成</td>
									</c:if>
								</tr>
							</c:forEach>  
				   		</table>
					</td>
					</c:if>	
					</c:if>
					<c:if test="${taskLogList==null}">
						<td class="layertdleft100">执行人：</td>
						<td class="layerright">${executor}</td>
					</c:if>	
					<c:if test="${creator eq result.value.creator}">
					<c:if test="${taskLogList!=null}">
						<td class="layertdleft100">执行人：</td>
						<td class="layerright">${creator}</td>
					</c:if>
					</c:if>
			   	</tr>
			</table>
		</div>
		<div class="divlays" style="margin:-2px -2px 0px -2px;display:none;">
			<div class="emailtop">
				<div class="leftemail">
					<ul>
						<c:if test="${isSelf}">
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('添加工作轨迹','<%=basePath %>web/task/taskLog_add.jsp?taskId=${result.value.id}',500,205);"><span><img src="core/common/images/emailadd.gif"/></span>添加</li>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
						</c:if>
					</ul>
				</div>
			</div>
			<table id="logList" width="100%"><tr><td></td></tr></table>
		</div>
	</div>
</div> 
</form>
<div style="height: 5px;"></div>
</body>
</html>

