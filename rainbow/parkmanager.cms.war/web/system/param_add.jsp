<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

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
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initForm();
	initUploadify("fileUpload");
	//alert($(".textname2").width());
});


function getCalendarScrollTop(){
	return $("#scrollDiv").scrollTop();
}

function initForm(){
	$("#form1").validate({
		rules: {
			"param.name":"required",
			"param.htmlPath":"required",
			"param.uploadPath":"required"
		},
		messages: {
			"param.name":"请填写网站名称",
			"param.htmlPath":"请填写文档HTML默认保存位置",
			"param.uploadPath":"请填写图片/上传达文件默认路径"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			$(form).ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("getOpener().refreshTree();", 2000);
		        		$("#links").show();
		        		$(".tabheader").show();
		        		$("#param").val(data.param.id);
		        		$("#water").val(data.waterMark.id);
		        		$("#contact").val(data.contactInfo.id);
		        	}
		        } 
		    });
		}
	});
}

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
	var height = 80;
	var width = $(".textname").width();
	$("#linksList").jqGrid({
    	url:'<%=basePath%>links!list.action?id=0',
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
				boolean add = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_links_add");
				boolean view = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_links_view");
				boolean edit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_links_edit");
				boolean delete = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_links_delete");
				%>
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('links','"+id+"');\"  /> ";
				<%if(edit){%>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('links','"+id+"');\"  /> ";
				<%} %>
				<%if(delete){%>
				content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('links','links','"+id+"');\"  /> ";
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

function initResourceList(){
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
				boolean resView = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_view");
				boolean resDel = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_delete");
				boolean resedit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_resource_edit");
				%>
				<%if(resView){%>
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('resource','"+id+"');\"  /> ";
				<%} %>
				<%if(resedit){%>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('resource','"+id+"');\"  /> ";
				<%} %>
				<%if(resDel){%>
				content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('resource','resource','"+id+"');\"  /> ";
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

function viewById(actionName,id){
	fbStart('查看','<%=basePath%>'+actionName+'!view.action?id='+id,700,151);
}	

function editById(actionName,id){
	fbStart('编辑','<%=basePath%>'+actionName+'!edit.action?id='+id,700,151);
}

function reloadList(cssId,actionName){
	var id = $("#param").val();
	$("#"+cssId+"List").setGridParam({url:'<%=basePath%>'+actionName+'!list.action?id='+id}).trigger('reloadGrid');
}

function reloadInitList(cssId,actionName){
	var id = $("#param").val();
	$("#"+cssId+"List").setGridParam({url:'<%=basePath%>'+actionName+'!list.action?id='+id}).trigger('reloadGrid');
}

function deleteById(cssId,actionName,id){
	if(confirm("确定删除")){
		$.post("<%=basePath%>"+actionName+"!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		reloadList(cssId,actionName);
        	}
		});
	}
}

function deleteSelected(cssId,actionName){
	var ids = $("#"+actionName+"List").jqGrid("getGridParam","selarrrow");
	if(ids=="" || ids == undefined){
		showTip('请先选择删除项',2000);	
	}else if(confirm("确定要删除这些选中项")){
		$.post("<%=basePath%>"+actionName+"!delete.action?ids="+ids,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		reloadList(cssId,actionName);
        	}
		});
	}
} --%>

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

<body style="height:568px;">
<form id="form1" name="form1" method="post" action="<%=basePath%>param!saveOrUpdate.action">
	<input id="param" type="hidden" name="param.id" value=""/>
	<input id="water" type="hidden" name="waterMark.id"/>
	<input id="contact" type="hidden" name="contactInfo.id"/>
	<input id="imgPath" name="imgPath" type="hidden"/>
	<div class="basediv">
		<!-- <div class="titlebg">网站基本信息</div> -->
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>网站名称：</td>
					<td width="29%" class="layerright"><input id="name" name="param.name" type="text" class="inputauto" /></td>
					<td width="40%" class="layertdleft100"><span class="psred">*</span>文档HTML默认保存位置：</td>
					<td width="29%" class="layerright"><input id="code" name="param.htmlPath" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100">有效期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="start" name="param.validPeriodStart" onclick="showCalendar('start');" readonly="readonly" class="inputauto" /></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('start');"/></td>
								<td style="padding-right:2px;padding-left:2px;">-</td>
								<td><input id="end" name="param.validPeriodEnd" onclick="showCalendar('end');" readonly="readonly" class="inputauto" /></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('end');"/></td>							</tr>
						</table>  
					</td>
					<td class="layertdleft100">网站域名：</td>
					<td class="layerright"><input id="name" name="param.domainName" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>备案号：</td>
					<td class="layerright"><input id="code" name="param.icp" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred">*</span>图片/上传达文件默认路径：</td>
					<td class="layerright"><input id="name" name="param.uploadPath" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>网站模版：</td>
					<td class="layerright">
						<select name="param.templeteId">
							<option>----请选择----</option>
							<c:forEach items="${templetes}" var="dataDict">
							<option value="${dataDict.id }">${dataDict.dataValue }</option>
							</c:forEach>
						</select>
					</td>
					<td class="layerright" colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td class="layertdleft100">关键字：</td>
					<td colspan="3" class="layerright" style="padding-bottom:2px;">
						<textarea name="param.keyWord" class="inputauto"  style="height:40px;resize: none;"></textarea>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">描述：</td>
					<td colspan="3" class="layerright" style="padding-bottom:2px;">
						<textarea name="param.description"  class="inputauto"  style="height:40px;resize: none;"></textarea>
					</td>
				</tr>
				 <tr>
			        <td class="layertdleft100">版权信息：</td>
					<td colspan="3" class="layerright" style="padding-bottom:2px;">
						<textarea id="copyright" name="param.copyright"  class="inputauto"  style="height:40px;resize: none;"></textarea>
						<script type="text/javascript">CKEDITOR.replace( 'copyright',{height:80});</script>
					</td>
			      </tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div style="overflow:hidden;">
		<div class="apptab" id="tableid">
			<ul>
				<!-- <li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">友情链接</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)" style="display:none;">网站资源</li> -->
				<li class="apptabliover tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">联系方式</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">图片水印</li>
			</ul>
		</div>
		<div style="margin-top:0px;">
			<!-- 友情链接 -->
			<%-- <div class="basediv tabswitch textname" style="margin-top:0px;">
				<div class="emailtop">
					<div id="links" class="leftemail" style="display:none;">
						<ul>
							<% if(add){ %>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" 
							onclick="fbStart('新建链接','<%=basePath %>web/system/links_list_add.jsp?paramId='+$('#param').val(),700,151);">
							<span><img src="core/common/images/emailadd.gif"/></span>添加</li>
							<%} %>
							<% if(delete){ %>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
							<%} %>
						</ul>
					</div>
				</div>
				<table id="linksList"><tr><td></td></tr></table>
			</div> --%>
			
			<!-- 网站资源 -->
			<%-- <div class="basediv tabswitch textname" style="margin-top:0px;height:132px;display:none;">
				<div class="emailtop">
					<div id="links" class="leftemail">
						<ul>
							<% if(resAdd){ %>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" 
								onclick="fbStart('新建链接','<%=basePath %>resource!add.action?id='+$('#param').val(),700,225);">
							<span><img src="core/common/images/emailadd.gif"/></span>添加</li>
							<%} %>
							<% if(resDel){ %>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
							<%} %>
						</ul>
					</div>
				</div>
				<table id="resourceList"><tr><td></td></tr></table>
			</div> --%>
			
			<!-- 联系方式 -->
			<div class="basediv tabswitch textname textname2" style="height:132px;margin-top:0px;overflow-y:scroll; overflow-x:none;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="top">
					<div class="divlays">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
					      <tr>
					        <td class="layertdleft100">公司名称：</td>
					        <td class="layerright">
					       		<input id="name" name="contactInfo.name" type="text" class="inputauto" />
					        </td>
					        <td class="layertdleft100">联系人：</td>
					        <td class="layerright"><input name="contactInfo.contact" type="text" class="inputauto"/></td>
					      </tr>
					      <tr>
					        <td class="layertdleft100">电话：</td>
					        <td class="layerright"><input name="contactInfo.phone" type="text" class="inputauto"/></td>
					        <td class="layertdleft100">手机：</td>
					        <td class="layerright"><input name="contactInfo.telephone" type="text" class="inputauto"/></td>
					      </tr>
					      <tr>
					        <td class="layertdleft100">传真：</td>
					        <td class="layerright"><input name="contactInfo.fax" type="text" class="inputauto" /></td>
					        <td class="layertdleft100">E-mail：</td>
					        <td class="layerright"><input name="contactInfo.email" type="text" class="inputauto"/></td>
					      </tr>
					      <tr>
					        <td class="layertdleft100">邮政编码：</td>
					        <td class="layerright"><input name="contactInfo.postCode" type="text" class="inputauto" /></td>
					        <td class="layerright" colspan="2">&nbsp;</td>
					      </tr>
					      <tr>
					        <td class="layertdleftauto">地址：</td>
					        <td colspan="3" class="layerright" style="padding-bottom:2px;">
								<textarea name="contactInfo.address"  class="inputauto"  style="height:40px;resize: none;"></textarea>
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
						        	<enum:radio name="waterMark.opened" checked="result.value.opened" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
						        </label>
					        </td>
					        <td class="layertdleft100">水印的图片大小：</td>
					        <td class="layerright" width="32%"><label>
						        &nbsp; 宽:<input name="waterMark.width" type="text" value="${result.value.width}" class="input60" />
						        &nbsp; 高：<input name="waterMark.height" type="text" value="${result.value.height}" class="input60" />
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
					        <td class="layerright"><input name="waterMark.marktext" type="text" value="${result.value.marktext}" class="inputauto" /></td>
					        <td class="layertdleft100">水印图片文字颜色：</td>
					        <td class="layerright">
					        	<input name="waterMark.color" type="text" value="" class="input60" />
					        	<span style="color:#ccc">(如:#FF44AA)</span>
					        </td>
					      </tr>
					      <tr>
					        <td class="layertdleft100">水印位置：</td>
					        <td colspan="3"  class="layerright">
						        <label><enum:radio name="waterMark.position" 
						        	type="com.wiiy.cms.preferences.enums.PositionEnum" 
						        	checked="result.value.position"/>
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
	<div class="buttondiv" style="margin-bottom:2px;">
		<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();" /></label>
	</div>
</form>
</body>
</html>
