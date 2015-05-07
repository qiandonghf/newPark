<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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

<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript">
	var templateMenu=[[
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataTemplate_edit")){%>
 	{
		text:"重命名",
		classname:"smarty_menu_ico1",
		func:function(){
			fbStart('重命名','<%=basePath%>dataTemplate!edit.action?id='+$(this).find('input').val(),300,80);
		}
	}
 	<%}%>
 	],[
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataTemplate_delete")){%>
 	   {
		text:"删除",
		classname:"smarty_menu_ico2",
		func:function(){
			if(confirm("您确定要删除")){
				$.post("<%=basePath%>dataTemplate!delete.action?id="+$(this).find('input').val(),function(data){
					showTip(data.result.msg,1000);
					setTimeout("location.reload()", 1000);
				});
			}
		}
	}
 	  <%}%>
 	   ]];
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$(".templateLi").smartMenu(templateMenu,{name:"templateMenu"});
		$("#resizable").css("height",getTabContentHeight());
		$("#template").css("height",getTabContentHeight()-85);
	});
	function loadTree(values){
		$('#tt').tree({
		    url: '<%=basePath%>dataProperty!loadParentProperty.action?ids='+values,
		    onClick: function(node){
				$(this).tree('toggle', node.target);
		    },
		    onLoadSuccess: function(){
		    	expandAll();
		    },
		    checkbox:true
		});
		$('#tt').tree("",values);
	}
	function configTemplate(id){
		$("#msglist").show();
		$(".libg").removeClass("libg");
		$("#template"+id).addClass("libg");
		$("#templateName").html($(".libg").children().first().html()+"&nbsp;&nbsp;&nbsp;");
		$(".dataProperty:checked").attr("checked",false);
		$.post("<%=basePath%>dataTemplate!loadConfig.action?id="+id,function(data){
			if(data.result.success){
				loadTree(data.result.value);
			}
		});
	}
	function getTreeSelectedIds(tree){
		var roots = $("#"+tree).tree("getRoots");
		var propertyIds = "";
		for(var i = 0; i < roots.length; i++){
			if(roots[i].checked) {
				propertyIds += this.id +",";
			}
		}
	}
	function saveTemplateConfig(){
		var templateId = $(".libg").find("input").val();
		var propertyIds = "";
		var nodes = $("#tt").tree("getChecked");
		for(var i = 0; i < nodes.length; i++){
			propertyIds += nodes[i].id +",";
		}
		$.post("<%=basePath%>dataTemplate!saveConfig.action",{"id":templateId,"ids":propertyIds},function(data){
			if(data.result.success){
				showTip(data.result.msg,2000);
			}
		});
	}
	function preview(){
		var templateId = $(".libg").find("input").val();
		window.open("<%=basePath%>dataTemplate!preview.action?id="+templateId);
	}
	function expandChildren(node){
		if(node.state=="closed") {
			$("#tt").tree("expand",node.target);
			setTimeout(function(){
				var nodes = $("#tt").tree("getChildren",node.target);
				for(var i = 0; i < nodes.length; i++){
					expandChildren(nodes[i]);
				}
			}, 1000);
		}
	}
	function expandAll(){
		var roots = $("#tt").tree("getRoots");
		for(var i = 0; i < roots.length; i++){
			expandChildren(roots[i]);
		}
	}
	function collapseChildren(node){
		if(node.state=="open") {
			$("#tt").tree("collapse",node.target);
		}
	}
	function collapseAll(){
		var roots = $("#tt").tree("getRoots");
		for(var i = 0; i < roots.length; i++){
			collapseChildren(roots[i]);
		}
	}
</script>

</head>
<body>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="182" valign="top">
				<div class="agency" id="resizable" >
					<div class="titlebg">模板列表</div>
					<div class="agencybtn">
						<ul>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataTemplate_add")){ %>
							<li><a href="javascript:void(0)" onclick="fbStart('新建模板','<%=basePath %>web/client/dataTemplate_add.jsp',300,100);"><span class="icoadd"></span>新建模板</a></li>
						<%} %>
						</ul>
					</div>
					<div class="datalist">
						<ul>
							<c:forEach items="${result.value}" var="dataTemplate">
								<li class="templateLi"><a id="template${dataTemplate.id}" href="javascript:void(0)" onclick="configTemplate(${dataTemplate.id})"><label>${dataTemplate.name}</label><input type="hidden" value="${dataTemplate.id}"/></a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</td>
			<td width="100%" valign="top">
				<div class="msglist" id="msglist" style="display: none;">
					<div class="titlebg" id="templateHeader"><span id="templateName"></span><a href="javascript:void(0)" onclick="expandAll()">全部展开</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="collapseAll()">全部收起</a></div>
					<div class="datatemplate" id="template">
						<ul id="tt"></ul>
					</div>
					<div class="buttondiv" style="padding-top: 5px;">
						<a href="javascript:void(0)" title="" class="btn_bg" onclick="saveTemplateConfig()"><span><img src="core/common/images/savebtnicon.gif" />保存</span></a>
						<a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end()"><span><img src="core/common/images/closebtnicon.gif" />取消</span></a>
					<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataTemplate_view")){ %>
						<a href="javascript:void(0)" title="" class="btn_bg" onclick="preview()"><span><img src="core/common/images/viewbtn.png" />查看</span></a>
					<%} %> --%>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>