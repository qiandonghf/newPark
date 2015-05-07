<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var arr = {};
		arr = $("#photos").val().substring(0,$("#photos").val().length-1).split(";");
		$.each(arr,function(i){
			$("#imageList").append($("<td width='60'></td>").append("<img src='"+arr[i]+"' width='50' height='50' class='productimg' />"));
		});
	});
</script>
</head>

<body>
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">企业名称：</td>
      <td class="layerright">${result.value.customer.name } </td>       
    </tr>
    <tr>
      <td class="layertdleft100">产品名称：</td>
      <td class="layerright">${result.value.name }</td>
    </tr>
    <tr>
      <td class="layertdleft100">技术领域：</td>
      <td class="layerright">${result.value.technic.dataValue }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">产品阶段：</td>
      <td class="layerright">${result.value.stage.dataValue }
	</td>
    </tr>
     <tr>
      <td class="layertdleft100">图片预览：</td>
      <td class="layerright">
      	<div style="width:370px; overflow-x:scroll; overflow-y:hidden; height:80px; margin-bottom:2px;">
      	  <table>
	        <tr id="imageList">
	        <td>     
	        <input  type="hidden" id="photos" name="product.photos" value="${result.value.photos }"/>
	        </td>
	        </tr>
      	  </table>
	      </div>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">发布到网站：</td>
      <td class="layerright">
	      ${result.value.pub.title }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">产品简介：</td>
      <td class="layerright"><div style="height:80px;overflow-y:auto; overflow-x:hidden;word-break:break-all; word-wrap:break-word; ">${result.value.introduction}</div>
      </td>
    </tr>
    <%-- <tr>
      <td class="layertdleft100">创建人：</td>
      <td class="layerright">${result.value.creator }</td>
    </tr>
    <tr>
      <td class="layertdleft100">创建时间：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.createTime }" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改人：</td>
      <td class="layerright">${result.value.modifier }</td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改时间：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.modifyTime }" pattern="yyyy-MM-dd"/></td>
    </tr> --%>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
