<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
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
<title>无标题文档</title>

<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>


<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
	});
	
	function openStatus(id){
		if(confirm("您确定要开启项目吗")){
			$.post("<%=basePath%>taskProject!openProject.action?id="+id,function(data){
	        	if(data.result.success){
	        		location.reload();
	        	}
			});
		}
	}
	
	function closeStatus(id){
		if(confirm("您确定要关闭项目吗")){
			$.post("<%=basePath%>taskProject!closeProject.action?id="+id,function(data){
	        	if(data.result.success){
	        		location.reload();
	        	}
			});
		}
	}
	
	function editById(id){
		fbStart('编辑项目','<%=basePath%>taskProject!edit.action?id='+id,300,80);
	}
	
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>taskProject!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		location.reload();
	        	}
			});
		}
	}
	
	function jumpPage(page){
		var url = "<%=basePath%>taskProject!list.action";
		url += "?page="+page+'&id=${id}';
		url = encodeURI(url);
		location.href=url;
	}
</script>
</head>
<body>
	<%
		Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
		boolean add = OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_addProject");
		boolean edit = OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_editProject");
		boolean delete = OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_delProject");
	%>
			<div class="basediv" style="height: 300px;">
				<div class="emailtop">
					<div class="leftemail">
						<ul>
							<%if(add){%>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建项目','<%=basePath%>web/task/taskProject_add.jsp',300,80);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
							<%} %>
						</ul>
					</div>
				</div>
				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="35" class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">序号</td>
                      <td class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">项目名称</td>
                      <td width="80" class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">操作</td>
                    </tr>
                    <c:forEach items="${taskProjectList}" var="list" varStatus="status">
                    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
                      <td class="centertd">${status.index+1}</td>
                      <td class="centertd">${list.name}</td>
                      <td class="centertd">
                      		<c:if test="${list.status eq 'NORMAL'}">
                      			<a href="javascript:void(0)" title="关闭项目"><img src="parkmanager.oa/web/images/projectopen.png" onclick="closeStatus(${list.id})"/></a>
                      		</c:if>
                      		<c:if test="${list.status eq 'CLOSED'}">
                      			<a href="javascript:void(0)" title="开启项目"><img src="parkmanager.oa/web/images/projectclose.png" onclick="openStatus(${list.id})"/></a>
                      		</c:if>
                      		<%if(edit){%>
                      			<a href="javascript:void(0)" title="重命名"><img src="core/common/images/edit.gif" onclick="editById(${list.id})"/></a>
                      		<%} %>
                      		<%if(edit){%>
                      			<a href="javascript:void(0)" title="删除"><img src="core/common/images/del.gif" width="14" height="14" onclick="deleteById(${list.id})"/></a> 
                      		<%} %>
                      </td>
                    </tr>
                    </c:forEach>
               </table>
             </div>
                   <div style="width: 100%;padding-left: 70px;">
	                  <%-- <%@include file="../pager.jsp" %> --%>
	                  <div class="page" style="border-top:none;height:29px; line-height:29px; border-bottom:2px solid #ccc; background:#f2f2f2; padding-right:125px;">
						<ul>
							<li>
								<c:if test="${pager.total==0}" var="nodata">无数据显示</c:if>
								<c:if test="${!nodata}">
								<c:if test="${pager.page>1}" var="firstPage">
								<span class="first" onclick="jumpPage(1)"></span><span class="pre" onclick="jumpPage(${pager.page-1})"></span>
								</c:if>
								<c:if test="${!firstPage}">
								<span class="first"></span><span class="pre"></span>
								</c:if>
								<c:if test="${pager.page==pager.total}" var="total">
								<span>显示&nbsp;${pager.rows*(pager.page-1)+1}&nbsp;-&nbsp;${pager.records}</span>
								</c:if>
								<c:if test="${!total}">
								<span>显示&nbsp;${pager.rows*(pager.page-1)+1}&nbsp;-&nbsp;${pager.rows*pager.page}</span>
								</c:if>
								<c:if test="${pager.page<pager.total}" var="lastPage">
								<span class="next" onclick="jumpPage(${pager.page+1})"></span><span class="last" onclick="jumpPage(${pager.total})"></span>
								</c:if>
								<c:if test="${!lastPage}">
								<span class="next"></span><span class="last"></span>
								</c:if>
								共&nbsp;${pager.records}&nbsp;条
								</c:if>
							</li>
						</ul>
					</div>
                  </div>
                  
</body>
</html>
