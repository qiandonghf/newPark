<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
      <td class="layerright">${result.value.customer.name }
          </td>
    </tr>
	<tr>
      <td class="layertdleft100">项目名称：</td>
      <td class="layerright">
     ${result.value.name }
     </td>
    </tr>
      <tr>
      <td class="layertdleft100">产品：</td>
      <td class="layerright">
      ${result.value.product.name }
   </td>
    </tr>
      <tr>
      <td class="layertdleft100">申报年度：</td>
      <td class="layerright">${result.value.applyYear}</td>
    </tr>
     <tr>
      <td class="layertdleft100">申报类型：</td>
      <td class="layerright">
		${result.value.applyType.dataValue}
	</td>
    </tr>
    <tr>
      <td class="layertdleft100">申报状态：</td>
      <td class="layerright">
      ${result.value.applyState.title }
	</td>
    </tr>
    
    <tr>
      <td class="layertdleft100">是否验收：</td>
      <td class="layerright">
      ${result.value.checked.title }
		</td>
    </tr>
      <tr>
      <td class="layertdleft100">发布到网站：</td>
      <td class="layerright">
	   ${result.value.pub.title }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">验收时间：</td>
      <td class="layerright"><table width="205" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <fmt:formatDate value="${result.value.checkTime }" pattern="yyyy-MM-dd"/>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">申请金额：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr>
          <td width="180"><fmt:formatNumber value="${result.value.amount}" pattern="#0.00"/></td>
          <td>&nbsp;万元</td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">备注：</td>
      <td class="layerright"><div style="height:50px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">
        ${result.value.memo }
      </div></td>
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
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div style="height: 5px;"></div>
</body>
</html>
