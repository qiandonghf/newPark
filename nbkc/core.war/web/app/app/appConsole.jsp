<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link href="core/common/style/ui.jqgrid.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
 <script>
$(document).ready(function() {
	initTip();
	$('#appParamForm').submit(function() {
        $(this).ajaxSubmit({
			success:function(result, statusText) {
				showTip(result.msg);
            }
        });
        return false;
    });
	/* //$("#resizable").resizable(); */
	$("#resizable").css("height",window.parent.document.documentElement.clientHeight-158);
	$("#appParamList").css("height",window.parent.document.documentElement.clientHeight-257);
	//右击菜单
	var imageMenuData = [
	    [{
	        text: "加载",
			classname: "smarty_menu_ico0",
	        func: function(e) {
	            if (confirm("您确定要加载")) {
	            	sendRequest("load", $(this).attr("bundleId"));
	            }
	        }
	    }, {
	        text: "卸载",
			classname: "smarty_menu_ico2",
	        func: function(e) {
				if (confirm("您确定要卸载")) {
					sendRequest("unload", $(this).attr("bundleId"));
				}
	        }
	    }]
	];
	
/* 	$("#appul li").smartMenu(imageMenuData);
 */
 <%
 	Map<String, ResourceDto> resourceMap = CoreActivator.getHttpSessionService().getResourceMap();
 	boolean applicationMessage = CoreActivator.getHttpSessionService().isInResourceMap("core_application_message");
 	boolean applicationParameter = CoreActivator.getHttpSessionService().isInResourceMap("core_application_parameter");
 	boolean datadic = CoreActivator.getHttpSessionService().isInResourceMap("core_datadic");
 	if(applicationMessage){
 %>
 		loadApplicationMessage($(".appli2").attr("bundleId"));
 <%	
 	}
 	if(applicationParameter){
 %>
	loadApplicationParameter($(".appli2").attr("bundleId"));
 <%
 	}
 	if(datadic){
 %>
	$("#filter_data").val($(".appli2").attr("simpleName"));
	loadDatadic($(".appli2").attr("bundleId"));
 <%	
 	}
 %>
	$("#appul li").click(function(){
		$(this).attr("class", "appli2");
		$(this).siblings().attr("class", "appli1");
		$("#bundleId").val($(this).attr("bundleId"));
		<%	
		 	if(applicationMessage){
		%>
			loadApplicationMessage($(this).attr("bundleId"));
		<%
		 	}
		 	if(applicationParameter){
		%>
			loadApplicationParameter($(this).attr("bundleId"));
		<%
		 	}
		 	if(datadic){
		%>
		 	$("#filter_data").val($(this).attr("simpleName"));
			$("#list").setGridParam({page:1, postData:{"ids":$("#filter_data").val()}}).trigger('reloadGrid');
	 	<%	
	 	 	}
	 	%>
	});
});

function loadApplicationMessage(bundleId){
	$.post("${contextLocation}appConsole!detail.action",{"bundleId":bundleId},function(r){
		if (r.success) {
        	$("#app_name").text(r.value.name);
        	$("#app_version").text(r.value.version);
        	$("#app_isPlugin").text(r.value.isPlugin.title);
        	$("#app_status").text(r.value.status.title);
        	$("#app_lastChangeStatus").text(r.value.lastChangeStatus);
        	$("#app_msg").html("<pre>"+r.value.msg+"</pre>");
        } else {
        	showTip(r.msg);
        }
	});
}
function loadApplicationParameter(bundleId){
	$.post("${contextLocation}appParam!configDetail.action",{"bundleId":bundleId},function(r){
		if (r.success) {
        	$("#configContainer").empty();
        	$("#appParamBundleId").val(bundleId);
        	if (!r.value || !r.value.configList) return;
        	$(r.value.configList).each(function(configIndex, config){
        		if (configIndex == 0) {
            		$("#configContainer").append("<tr><td colspan=\"2\" class=\"titlebg\">"+config.label+"</td></tr>");
            	} else {
            		$("#configContainer").append("<tr><td colspan=\"2\" class=\"titlebg\" style=\"border-top:1px solid #c9c9c9\">"+config.label+"</td></tr>");
        		}
        		$(config.parameterList).each(function (parameterIndex, parameter) {
        			var parameterHtml = "<tr><td class=\"layertdleft100\">"+parameter.entry.label+"：</td><td>";
        			switch (parameter.render) {
        			case "ckedit":
        				parameterHtml += "<label><textarea id=\"ck_content["+configIndex+"]\" name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" rows=\"8\" cols=\"120\">"+parameter.value+"</textarea></label></td></tr>";
        				break;
        			case "radio" :
        				parameterHtml += "<label>";
        				$(parameter.choices).each(function(index, choice){
        					if (parameter.value==choice.value) {
            					parameterHtml += "<input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"radio\" value=\""+choice.value+"\" checked=\"checked\"/>&nbsp;"+choice.label + "&nbsp;&nbsp;&nbsp;&nbsp;";
        					} else {
            					parameterHtml += "<input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"radio\" value=\""+choice.value+"\"/>&nbsp;"+choice.label + "&nbsp;&nbsp;&nbsp;&nbsp;";
        					}
        				});
        				parameterHtml += "</label></td></tr>";
        				break;
        			case "checkbox" :
        				parameterHtml += "<label>";
        				$(parameter.choices).each(function(index, choice){
        					if (_contained(parameter.splitValues, choice.value)) {//split parameter value to match
            					parameterHtml += "<input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"checkbox\" value=\""+choice.value+"\" checked=\"checked\"/>&nbsp;"+choice.label + "&nbsp;&nbsp;&nbsp;&nbsp;";
        					} else {
            					parameterHtml += "<input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"checkbox\" value=\""+choice.value+"\"/>&nbsp;"+choice.label + "&nbsp;&nbsp;&nbsp;&nbsp;";
        					}
        				});
        				parameterHtml += "</label></td></tr>";
        				break;
        			case "select" :
        				parameterHtml += "<label><select name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" value=\""+parameter.value+"\">";
        				$(parameter.choices).each(function(index, choice){
        					parameterHtml += "<option value=\""+choice.value+"\">"+choice.label+"</option>";
        				});
        				parameterHtml += "</label></td></tr>";
        				break;
        			case "select_user" :
        				parameterHtml += "<table><tr><td width=\"200\">";
        				parameterHtml += "<input id=\"config"+configIndex+"_"+parameterIndex+"\" name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"text\" value=\""+parameter.value+"\" class=\"input200\"/>";
        				parameterHtml += "</td><td width=\"20\">";
        				parameterHtml += "<img width=\"20\" height=\"22\" style=\"left: -2px; position: relative;\" onclick=\"selectUser('config"+configIndex+"_"+parameterIndex+"')\" src=\"core/common/images/outdiv.gif\"/>";
        				parameterHtml += "</td><td>&nbsp;";
        				parameterHtml += "</td></tr></table></td></tr>";
        				break;
        			case "textarea" :
        				parameterHtml += "<label><textarea name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" rows=\"8\" cols=\"120\">"+parameter.value+"</textarea></label></td></tr>";
        				break;
        			case "text" :
        			default :
        				parameterHtml += "<label><input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"text\" value=\""+parameter.value+"\" class=\"input200\"/></label></td></tr>";
        			}
        			$("#configContainer").append(parameterHtml);
        			var ckId = "ck_content["+configIndex+"]";
		        	if(parameterHtml.indexOf(ckId)>0){
		        		CKEDITOR.replace(ckId,{height:125}); 
		        	}
        		});
        	});
        } else {
        	showTip(r.msg);
        }
	});
}
function selectUser(id){
	$("#selectUserId").val(id);
	fbStart('选择用户','core/user!select.action?id='+$("#"+id).val(),520,400);
}
function setSelectedUser(user){
	$("#"+$("#selectUserId").val()).val(user.id);
}
function _contained(valueArray, value) {
	if (!valueArray || !valueArray.length) return false;
	for (var i = 0; i < valueArray.length; i ++) {
		if (value == valueArray[i]) return true;
	}
	return false;
}
function loadDatadic(bundleId){
	var height = window.parent.document.documentElement.clientHeight-259;
	$("#list").jqGrid({
    	url:'${contextLocation}dataDict!list.action',
    	postData : {"ids":$("#filter_data").val()},
		datatype: 'json',
		prmNames: {search: "search"},
		jsonReader: {root:"root",repeatitems: false},
		colModel: [
			{label:'类型名称(英文)', name:'dataName', index:'dataName', width:240, align:"center"}, 
			{label:'类型名称(中文)', name:'dataValue', index:'dataValue', width:280, align:"center"}, 
		    {label:'管理', name:'manager', index:'manager', title:false, width:80, align:"center", sortable:false, search:false, fixed:true}, 
	],
		shrinkToFit: false,
		height: height,
		width:960,
		rowNum: 20,//设置表格中显示的记录数如果服务器返回记录数大于此值则只显示rowNum条 -1不检查此项
		rowList: [10,20,30],//用来调整表格显示的记录数
		autowidth: false,//宽度自动
		multiselect: true,//是否可以多选
		viewrecords: true,//是否显示总记录数
		rownumbers: true,//显示行顺序号，从1开始递增。此列名为'rn'
		loadui: 'block',//当执行ajax请求时 启用Loading提示，但是阻止其他操作
		pager: '#pager',//指定分页栏对象
		gridComplete: function(){
			var rowDatas = $(this).jqGrid("getRowData");
 			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < rowDatas.length; i++){
				var id = ids[i];
				var content = "";
				content += "<img src=\"core/common/images/edit.gif\" alt=\"编辑\" title=\"编辑\" onclick=\"editById('"+id+"');\"/>"; 
				$(this).jqGrid('setRowData',id,{manager:content});
			}
 		},
		gridview: true
	}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
}
function editById(id){
	fbStart('编辑数据','${contextLocation}dataDict!edit.action?id='+id,400,210);
}
function refreshDataTables() {
	$("#list").jqGrid('setGridParam',{page:1,postData:{"ids":$("#filter_data").val()}}).trigger('reloadGrid');
} 
function hideAppMsg(){
	$("#app_msg").css("display","none");
}
function showAppMsg(){
	$("#app_msg").css("display","block");
}
</script>
</head>

<body>

<!--container-->
<div id="container">
<input type="hidden" id="selectUserId" />
<input type="hidden" name="bundleId" id="bundleId" value="${bundleId}" />
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="182" valign="top">
			<div class="agency" id="resizable" >
			<!--titlebg-->
			<div class="titlebg">应用列表</div>
			<!--//titlebg-->
			<!--applist-->
			<div class="applist">
				<ul id="appul">
					<c:forEach var="app" items="${appDtoList}" varStatus="rowStatus">
					<c:if test="${empty bundleId and rowStatus.first}">
						<li class="appli2" bundleId="${app.bundleId}" simpleName="${app.simpleName}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${not empty bundleId and app.bundleId eq bundleId}">
						<li class="appli2" bundleId="${app.bundleId}" simpleName="${app.simpleName}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${empty bundleId and not rowStatus.first}">
						<li class="appli1" bundleId="${app.bundleId}" simpleName="${app.simpleName}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${not empty bundleId and app.bundleId ne bundleId}">
						<li class="appli1" bundleId="${app.bundleId}" simpleName="${app.simpleName}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
			<!--//applist-->
            </div></td>
        <td width="100%" valign="top">
		<!--msglist-->
		<div class="msglist" id="msglist">
		<!--titlebg-->
			<div class="titlebg">应用信息</div>
		 <!--//titlebg-->
		<!--appmsglist-->
		<div class="appmsglist">
			<!--apptab-->
			<div class="apptab" id="tableid">
				<ul>
					<%	
						int flag = -1;
		 				if(applicationMessage){
		 					flag++;
					%>
						<li class="apptabli<%if(flag == 0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag %>);showAppMsg();"><%=resourceMap.get("core_application_message").getName() %></li>
					<%} 
		 				if(applicationParameter){
		 					flag++;
					%>
						<li class="apptabli<%if(flag == 0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag %>);hideAppMsg();"><%=resourceMap.get("core_application_parameter").getName() %></li>
					<%} 
		 				if(datadic){
		 					flag++;
					%>
						<li class="apptabli<%if(flag == 0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag %>);hideAppMsg();"><%=resourceMap.get("core_datadic").getName() %></li>
					<%} %>
				</ul>
			</div>
 			<!--//apptab-->
			<!--appname应用信息-->
			<%	int flag2=-1;
 				if(applicationMessage){flag2++;
			%>
			<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
			<div class="appname">
				<div class="divlays" style="margin:0px;">
				    <form id="form1" name="form1" method="post" action="">
				      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td class="layertdleft100">应用名称：</td>
	                      <td id="app_name">&nbsp;</td>
	                    </tr>
	                    <tr>
	                      <td class="layertdleft100">版本：</td>
	                      <td id="app_version">&nbsp;</td>
	                    </tr>
	                     <tr>
	                      <td class="layertdleft100">是否插件：</td>
	                      <td id="app_isPlugin">&nbsp;</td>
	                    </tr>
	                    <tr>
	                      <td class="layertdleft100">状态：</td>
	                      <td id="app_status">&nbsp;</td>
	                    </tr>
	                    <tr>
	                      <td class="layertdleft100">注册日期：</td>
	                      <td id="app_lastChangeStatus">&nbsp;</td>
	                    </tr>
	<!--                     <tr>
	                      <td class="layertdleft100">注册日志查看：</td>
	                      <td><input name="textfield4" type="text" class="input200" /></td>
	                    </tr>
	 -->
	                   </table>
	                </form>
		      	</div>
		      	</div>
		      
		    </div>
			<%} 
		 		if(applicationParameter){flag2++;
			%>
		    <div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
				<div class="divlays" style="margin:0px;">
					<form id="appParamForm" name="appParamForm" method="post" action="${contextLocation}appParam!update.action">
					    <input type="hidden" id="appParamBundleId" name="bundleId" value="-1" />
						<!--appname应用参数-->
						<div class="appname">
						  <div id="appParamList" style="height:400px;overflow-x: hidden;overflow-y: auto;">
						      <table width="100%" border="0" cellspacing="0" cellpadding="0" id="configContainer">
			                  </table>
					      </div>
						</div>
						<!--appname-->
						
						<!--buttondivpage-->
						<div class="buttondivpage">
						    <label>
						    <input name="Submit" type="submit" class="savebtn" value="" />
			                </label>
						</div>
		            </form>
				</div>
			</div>
			<%} 
 				if(datadic){flag2++;
			%>
			<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
				<input id="filter_name" class="field" type="hidden" value="id"/>
				<input id="filter_op" class="op" type="hidden" value="bw"/>
				<input id="filter_dataType" class="dataType" type="hidden" value="string"/>
				<input id="filter_data" type="hidden" class="data" value="noname"/>
				
				<input id="filter_name" class="field" type="hidden" value="parentId"/>
				<input id="filter_op" class="op" type="hidden" value="nl"/>
				<input id="filter_dataType" class="dataType" type="hidden" value="long"/>
				<input id="filter_data" type="hidden" class="data" value="-1"/>
				<div class="appname" style="border-bottom:none;">
					<table id="list" class="jqGridList"><tr><td/></tr></table>
					<div id="pager"></div>
				</div>
			</div>
			<%} %>
		</div>
		<!--//appmsglist-->
		<%	
			if(applicationMessage){
		%>
			<div id="app_msg" class="application">
			</div>
		<%} %>
        </div>
		<!--//msglist-->		
		</td>
      </tr>
  </table>
</div>
<!--//container-->
</body>
</html>
