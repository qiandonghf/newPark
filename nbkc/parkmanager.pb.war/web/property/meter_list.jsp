<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.commons.preferences.enums.TitleEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

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
		$("#resizable").css("height",getTabContentHeight()-28);
		$("#waterList").css("height",getTabContentHeight()-28);
		$("#iframe").css("height",getTabContentHeight()-28);
	});
	
	function iframeSwitch(url,li){
		$(li).removeClass().addClass("apptabliover");
		$(li).siblings().removeClass().addClass("apptabli");
		$("#iframe").attr("src",url);
	}
	
	function deleteSelected(){
		var ids = window.frames[0].$("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>meter!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		window.frames[0].$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
</script>

</head>
<body >
		<div class="emailtop">
			<!--leftemail-->
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_waterMeter_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="$('#meterlayer').toggle();" style="position:relative; z-index:99999;"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建<em class="em"><img src="core/common/images/arrow.png" /></em>					
						<div class="meterlayer" id="meterlayer" style="display:none; position:absolute; left:5px;" >
							<dl>
								<dt><a href="javascript:void(0)" onclick="fbStart('新建水表','<%=basePath %>meter!addWaterMeter.action',600,248);">新建水表</a></dt>
								<dt><a href="javascript:void(0)" onclick="fbStart('新建电表','<%=basePath %>meter!addEleMeter.action',600,248);">新建电表</a></dt>
								<%-- <dt><a href="javascript:void(0)" onclick="fbStart('新建气表','<%=basePath %>meter!addGasMeter.action',600,248);">新建气表</a></dt> --%>
							</dl>
						</div>
					</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_waterMeter_delete")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
				<%} %>
					<!-- <li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/searchico.gif"/></span>搜索</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/meter.gif"/></span>临时抄表</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/meter.gif"/></span>归零管理</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/meter.gif"/></span>转表管理</li> -->
				</ul>
			</div>
			<!--//leftemail-->
		</div>
		<div class="apptab" id="tableid">
			<ul>
				<li class="apptabliover" onclick="iframeSwitch('<%=basePath %>web/property/waterMeter_list.jsp',this)">水表管理</li>
				<li class="apptabli" onclick="iframeSwitch('<%=basePath %>web/property/eleMeter_list.jsp',this)">电表管理</li>
				<%-- <li class="apptabli" onclick="iframeSwitch('<%=basePath %>web/property/gasMeter_list.jsp',this)">气表管理</li> --%>
			</ul>
		</div>
		<iframe id="iframe" scrolling="no" frameborder="0" src="<%=basePath %>web/property/waterMeter_list.jsp" name="room" width="100%" height="100%"></iframe>
</body>
</html>
