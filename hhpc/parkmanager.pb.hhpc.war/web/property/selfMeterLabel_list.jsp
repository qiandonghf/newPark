<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.commons.preferences.enums.TitleEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<style type="text/css">
			.highlight {
				background: #f4f4f4
			}
</style>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#resizable').css('height',getTabContentHeight()-58);
		$('#pm_msglist').css('height',getTabContentHeight()-28);
		$('#materLabelDiv').css('height',getTabContentHeight()-85);
	});
	function highlight(el){
		$(el).addClass("highlight");
		$(el).siblings().removeClass("highlight").css("background","#fff");
	}
	function keepHighlight(el){
		if($(el).hasClass("highlight")){
			$(el).css("background","#f4f4f4");
		}
	}
	
	function openRight(id){
		$("#pm_msglist").attr("src","<%=basePath%>selfMeterLabel!view.action?id="+id);
	}
	
	function doSearch(){
		jumpPage(1);
	}
	function jumpPage(page){
		var url = "<%=basePath%>selfMeterLabel!list.action";
		url += "?page="+page;
		if($("#type").val()){
			url += "&type="+$("#type").val();
		}
		url = encodeURI(url);
		location.href=url;
	}
	
	function setSelectedMeters(meters){
		 window.frames[0].setSelectedMeters(meters); 
	}

</script>
</head>

<body >
<div class="emailtop">
			<!--leftemail-->
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建自用表抄表','<%=basePath%>web/property/selfMeterLabel_add.jsp',400,360);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
				</ul>
			</div>
			<!--//leftemail-->
		</div>


<!--container-->
 <!--水表管理-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="355" valign="top" id="fee_lefts">
	  <div class="write_list" style="border-right:1px solid #ddd; width:355px;" id="resizable">
	  	<div class="searchdiv">
          <form id="form2" name="form2" method="post" action="">
            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="65">报表类型： </td>
                <td width="100">
                	<enum:select type="com.wiiy.pb.preferences.enums.MeterTypeEnum" id="type"/>
                </td>
                <td width="80" align="center"><label>
                  <input name="Submit" type="button" class="search_cx" value="" onclick="doSearch();"/>
                </label></td>
                <td>&nbsp;</td>
                </tr>
            </table>
          </form>
	  	  </div>
        <!--merter_fee-->
        <div id="materLabelDiv" style="overflow-x: hidden;overflow-y:auto;">
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="lsittable">
              <tr>
                <td class="tdcenterL">报表名称</td>
                <td class="tdleftc">制表日期</td>
                <td width="20" class="tdrightc"><img src="core/common/images/rightgray.png" width="7" height="7" title="状态" alt="状态" /></td>
              </tr>
              <c:forEach items="${selfMeterLabelList}" var="meterLabel">
	             <tr onmouseover="this.style.background='#f4f4f4';" onmouseout="this.style.background='#fff';keepHighlight(this)" class="investmenttr" style="cursor: pointer;" onclick="openRight(${meterLabel.id});highlight(this);">
	                <td class="lefttd">
	                <c:if test="${fn:length(meterLabel.name) > 25}">
	                	${fn:substring(meterLabel.name,0,24)}......
	                </c:if>
	                <c:if test="${fn:length(meterLabel.name) < 25}">
	                	${meterLabel.name}
	                </c:if>
	                </td>
	                <td class="centertd"><fmt:formatDate value="${meterLabel.date}" pattern="yyyy-MM-dd"/></td>
	                <td class="centertd">
	                	<c:if test="${meterLabel.checkOut eq 'YES'}">
		                	<img src="core/common/images/rightgreen.png" width="7" alt="已生成费用报表" title="已生成费用报表" height="7" />
	                	</c:if>
	                	<c:if test="${meterLabel.checkOut eq 'NO'}">
		                	<img src="core/common/images/rightgray.png" width="7" alt="未生成费用报表" title="未生成费用报表" height="7" />
	                	</c:if>
	                </td>
	              </tr>
              </c:forEach>
             
            </table>
            </div>
			<!--分页开始-->
			<div class="page" style="border-top:none;">
				<%@include file="../pager.jsp" %>
			</div>
			<!--分页结束-->
	    </div>
 	  </td>
      <td valign="top">
	  	<!--table切换开始-->
			<%-- <div class="apptab" id="tableid">
				<ul>
					<li class="apptabliover"><a href="<%=basePath%>web/property/meterLabel_info.jsp" target="app">基本信息</a></li>
					<li class="apptabli" ><a href="<%=basePath%>web/property/meterLabel_record.jsp" target="app">抄表记录</a></li>
				</ul>
			</div> --%>
			<!--//table切换开始-->
			<div class="pm_msglist">
			<iframe src="<%=basePath %>web/investment/investment_index.jsp" scrolling="no" frameborder="0" id="pm_msglist" width="100%" name="app"></iframe>
			</div>
	  </td>
    </tr>
  </table>
</div>
<!--//水表管理-->
<!--//container-->
</body>
</html>
