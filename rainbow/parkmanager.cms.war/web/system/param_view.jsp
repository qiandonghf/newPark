<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initUploadify("fileUpload");
	//initResourceList();
	//alert($(".textname2").width());
	var html = $("#copyright div").html();
	$("#copyright").html(html);
});


function initUploadify(id){
	var root = '<%=BaseAction.rootLocation %>/';
	$("#"+id).uploadify( {
		'auto'				: true, //是否自动开始 默认true
		'multi'				: false, //是否支持多文件上传 默认true
		'formData'			: {'module':'core','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
		'uploader'			: root+"core/upload.action",
		'swf'				: uploadify.swf,//上传组件swf
		'width'				: "80",//按钮图片的长度
		'height'			: uploadify.height,//按钮图片的高度
		'buttonText'		: "上传水印图片",
		'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
		'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
		'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
		'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
		'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
		'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
	});
}
function onUploadSuccess(file, data, response) {
	$("#user_imagery_img").attr("src", "core/resources/"+$.parseJSON(data).path);
	$("#imgPath").val($.parseJSON(data).path);
}

function startUpload(id){
	$("#"+id).uploadify("upload");
}

function removeImagery() {
	var userImagery = $("#user_imagery_img").attr("src");
	$("#user_imagery_img").attr("src", userImagery + "-d");
	$("#imgPath").val("");
	$("#user_imagery_img").attr("src", "core/common/images/topxiao.gif");
}

<%-- function initList(){
	var id = $("#param").val();
	var height = 107;
	var width = $(".textname").width();
	$("#linksList").jqGrid({
    	url:'<%=basePath%>links!list.action?id='+id,
		colModel: [
			{label:'链接名称', name:'linkName',align:"center",width:120}, 
			{label:'链接地址', name:'linkURL',align:"center",width:120}, 
			{label:'启用', width:80,name:'display.title', align:"center"},
			{label:'启用时间',width:80,name:'openedTime',align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
			{label:'排列顺序',width:80,name:'displayOrder',align:"center"},
		    {label:'管理',width:80, name:'manager', align:"center", sortable:false, resizable:false}
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
				Map<String, ResourceDto> resourceMap = CmsActivator.getHttpSessionService().getResourceMap();
				//boolean add = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_links_add");
				boolean view = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_links_view");
				//boolean edit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_links_edit");
				//boolean delete = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_links_delete");
				%>
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
				<%if(edit){%>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
				<%} %>
				<%if(delete){%>
				content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
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
} --%>

<%-- function initResourceList(){
	var height = 80;
	var width = $(".textname").width();
	$("#resourceList").jqGrid({
    	url:'<%=basePath%>resource!list.action?id=0',
		colModel: [
			{label:'资源名称', name:'name',align:"center",width:120}, 
			{label:'资源类型', name:'type.title',align:"center",width:120}, 
			{label:'资源位置', width:80,name:'position',hidden:true, align:"center"},
			{label:'资源宽度', width:80,name:'width', align:"center"},
			{label:'资源高度', width:80,name:'height', align:"center"},
			{label:'是否启用', width:80,name:'enable.title', align:"center"},
		    {label:'管理',width:80, name:'manager', align:"center", sortable:false, resizable:false}
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
				boolean resAdd = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_add");
				boolean resDel = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_delete");
				boolean resedit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_edit");
				%>
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('resource','"+id+"');\"  /> ";
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
}	 --%>

//广告列表
<%-- function initAdvertisementList(){
	var height = 80;
	var width = $(".textname").width();
	$("#advertisementList").jqGrid({
    	url:'<%=basePath%>resource!list.action?id=0',
		colModel: [
			{label:'资源名称', name:'name',align:"center",width:120}, 
			{label:'资源类型', name:'type.title',align:"center",width:120}, 
			{label:'资源位置', width:80,name:'position',hidden:true, align:"center"},
			{label:'资源宽度', width:80,name:'width', align:"center"},
			{label:'资源高度', width:80,name:'height', align:"center"},
			{label:'是否启用', width:80,name:'enable.title', align:"center"},
		    {label:'管理',width:80, name:'manager', align:"center", sortable:false, resizable:false}
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
				boolean resAdd = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_add");
				boolean resDel = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_delete");
				boolean resedit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_edit");
				%>
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('resource','"+id+"');\"  /> ";
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
}	 --%>


<%-- function viewById(id){
	fbStart('查看','<%=basePath%>links!view.action?id='+id,700,151);
}	

function editById(id){
	fbStart('编辑','<%=basePath%>links!edit.action?id='+id,700,151);
}

function reloadList(){
	$("#linksList").trigger("reloadGrid");
}
function reloadInitList(){
	$("#linksList").trigger("reloadGrid");
}

function deleteById(id){
	if(confirm("确定删除链接")){
		$.post("<%=basePath%>links!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		reloadList();
        	}
		});
	}
}

function deleteSelected(){
	var ids = $("#linksList").jqGrid("getGridParam","selarrrow");
	if(ids=="" || ids == undefined){
		showTip('请先选择链接',2000);	
	}else if(confirm("确定要删除这些链接")){
		$.post("<%=basePath%>links!delete.action?ids="+ids,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		reloadList();
        	}
		});
	}
}
 --%>
</script>
<style>
	.layerright{
		word-break:break-all;
		width:32%;
	}
	.layertdleft100{
		white-space:nowrap;
		width:18%;
	}
	</style>
</head>

<body style="">
<form id="form1" name="form1" method="post" action="<%=basePath%>param!save.action">
	<input id="param" type="hidden" name="param.id" value="${result.value.id}"/>
	 <input id="imgPath" name="imgPath" type="hidden"/>
	<div class="basediv">
		<!-- <div class="titlebg">网站基本信息</div> -->
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred"></span>网站名称：</td>
					<td width="29%" class="layerright">${result.value.name }</td>
					<td width="40%" class="layertdleft100"><span class="psred"></span>文档HTML默认保存位置：</td>
					<td width="29%" class="layerright">${result.value.htmlPath}</td>
				</tr>
				<tr>
					<td class="layertdleft100">有效期：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.validPeriodStart }" pattern="yyyy-MM-dd" /> <c:if test="${ not empty result.value.validPeriodStart }"> 至 </c:if><fmt:formatDate pattern="yyyy-MM-dd" value="${result.value.validPeriodEnd }" /></td>
					<td class="layertdleft100">网站域名：</td>
					<td class="layerright">${result.value.domainName }</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>备案号：</td>
					<td class="layerright">${result.value.icp }</td>
					<td class="layertdleft100"><span class="psred"></span>图片/上传达文件默认路径：</td>
					<td class="layerright">${result.value.uploadPath }</td>
				</tr>
				<tr>
					<td class="layertdleft100">网站模版：</td>
					<td class="layerright">
						${result.value.templete.dataValue }
					</td>
					<td class="layerright" colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td class="layertdleft100">关键字：</td>
					<td colspan="3" class="layerright" style="padding-bottom:2px;">
						<div style="height:40px;overflow-y:scroll;">${result.value.keyWord }</div>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">描述：</td>
					<td colspan="3" class="layerright" style="padding-bottom:2px;">
						<div style="height:40px;overflow-y:scroll;">${result.value.description }</div>
					</td>
				</tr>
				 <tr>
			        <td class="layertdleft100">版权信息：</td>
					<td colspan="3" class="layerright" style="padding-bottom:2px;">
						<div id="copyright" style="height:60px;overflow-y:scroll;">${result.value.copyright }</div>
					</td>
			      </tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div style="height:160px;overflow:hidden;margin-bottom:5px;">
		<div class="apptab" id="tableid">
			<ul>
				<!-- <li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">广告管理</li> -->
				<!-- <li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">网站资源</li> -->
				<li class="apptabliover tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">联系方式</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">图片水印</li>
			</ul>
		</div>
		<div style="margin-top:0px;">
			<!-- 友情链接 -->
			<!-- <div class="basediv tabswitch textname" style="margin-top:0px;">
				<table id="advertisementList"><tr><td></td></tr></table>
			</div> -->
			
			<!-- 网站资源 -->
			<!-- <div class="basediv tabswitch textname" style="height:132px;margin-top:0px;height:132px;display:none;">
				<table id="resourceList"><tr><td></td></tr></table>
			</div> -->
			
			<!-- 联系方式 -->
			<div class="basediv tabswitch textname textname2" style="height:126px;margin:0px 4px;overflow-y:scroll; overflow-x:none;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="top">
					<div class="divlays">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
					      <tr>
					        <td class="layertdleft100">公司名称：</td>
					        <td class="layerright">${contactInfo.name }</td>
					        <td class="layertdleft100">联系人：</td>
					        <td class="layerright">${contactInfo.contact }</td>
					      </tr>
					      <tr>
					        <td class="layertdleft100">电话：</td>
					        <td class="layerright">${contactInfo.phone }</td>
					        <td class="layertdleft100">手机：</td>
					        <td class="layerright">${contactInfo.telephone }</td>
					      </tr>
					      <tr>
					        <td class="layertdleft100">传真：</td>
					        <td class="layerright">${contactInfo.fax}</td>
					        <td class="layertdleft100">E-mail：</td>
					        <td class="layerright">${contactInfo.email}</td>
					      </tr>
					      <tr>
					        <td class="layertdleft100">邮政编码：</td>
					        <td class="layerright">${contactInfo.postCode}</td>
					        <td class="layerright" colspan="2">&nbsp;</td>
					      </tr>
					      <tr>
					        <td class="layertdleftauto">地址：</td>
					        <td colspan="3" class="layerright" style="padding-bottom:2px;">
								<textarea name="contactInfo.address"  class="inputauto" readonly="readonly"  style="padding-left:0px;color:#666;border:0px;height:40px;resize: none;">${contactInfo.address}</textarea>
					        </td>
					      </tr>
					    </table>
					</div>
					</td>
				  </tr>
				</table>
			</div>
			
			<!-- 图片水印 -->
			<div class="basediv tabswitch textname" style="height:132px;margin-top:0px;display:none;overflow-y:scroll; overflow-x:none;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="top">
					<div class="divlays">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
					      <tr>
					        <td class="layertdleft100">是否启用图片水印： </td>
					        <td class="layerright" width="32%">
						        <label>
						        	<enum:radio name="waterMark.opened" checked="waterMark.opened" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
						        </label>
					        </td>
					        <td class="layertdleft100">水印的图片大小：</td>
					        <td class="layerright" width="32%"><label>
						        &nbsp; 宽:<input name="waterMark.width" type="text" value="${waterMark.width}" class="input60" />
						        &nbsp; 高：<input name="waterMark.height" type="text" value="${waterMark.height}" class="input60" />
					        </label></td>
					      </tr>
					      <tr>
					      	<td class="layertdleft100">上传水印图片：</td>
					        <td colspan="3" class="layerright">
					        	<table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
									<tr>
						              <td width="96">
						              	<img id="user_imagery_img" src="core/common/images/topxiao.gif" width="107" height="110" class="touxian" />
						              </td>
						              <td width="15" align="center" valign="bottom"><img src="core/common/images/xtopico3.png" width="13" height="13" onclick="removeImagery()" /></td>
						              <td valign="top" style="padding-top:12px;">
										<input type="file" name="upload" id="fileUpload" />
								      </td>
						            </tr>
						          </table>
						  	</td>
					      </tr>
					      <tr>
					      	<td class="layertdleft100">水印图片文字：</td>
					        <td class="layerright"><input name="waterMark.marktext" type="text" value="${waterMark.marktext}" class="inputauto" /></td>
					        <td class="layertdleft100">水印图片文字颜色：</td>
					        <td class="layerright"><input name="waterMark.color" type="text" value="${waterMark.color}" class="inputauto" />
					        </td>
					      </tr>
					      <tr>
					        <td class="layertdleft100">水印位置：</td>
					        <td colspan="3"  class="layerright">
						        <label><enum:radio name="waterMark.position" 
						        	type="com.wiiy.cms.preferences.enums.PositionEnum" 
						        	checked="waterMark.position"/>
						        </label>
						    </td>
					      </tr>
					    </table>
					</div>
					</td>
				  </tr>
				</table>
			</div>
			
		</div>
	</div>
	<div class="" style="height:5px;">
	</div>
</form>
</body>
</html>
