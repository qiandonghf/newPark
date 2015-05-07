<%@page import="org.apache.taglibs.standard.tei.ForEachTEI"%>
<%@page import="com.wiiy.crm.dto.RentPredictionDto"%>
<%@page import="com.wiiy.crm.preferences.enums.BillPlanStatusEnum"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
		initTip();
	});
  function rentList(topWindow,plugin,year){
	  var title = "租赁合同资金列表";
	  url = "<%=basePath %>web/contract/billPlanRent_list.jsp?status="+plugin+"&year="+year;	  
	  var tabs = topWindow.$('#tt');
	  if (tabs.tabs('exists',title)){
			tabs.tabs('close', title);
			tabs.tabs('add',{
				title:title,
				iconCls:'icon-reload',
				content: '<iframe src="'+url+'" frameborder="0" height="'+(window.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>',
				closable:true
			});
		} else{
			tabs.tabs('add',{
				title:title,
				iconCls:'icon-reload',
				content: '<iframe src="'+url+'" frameborder="0" height="'+(window.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>',
				closable:true
			});
		}
	  	icon = "/parkmanager.pb/web/images/billPlanRent_min.png";
	  	var span = tabs.find("span:contains('"+title+"')");
		span.next().css("background","url('"+icon+"') no-repeat");
  }
</script>
</head>
<body>
	<div class="titlebg">房租预测</div>
		<div  id="container">
			<div class="table_layout">
				<p class="" style="text-align:right; padding:0px 0 5px;">单位（元）</p>
               	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1">
					<thead>
						<tr>
                        	<th width="10%">&nbsp;</th>
                        	<c:forEach items="${years}" var="year">
                        		<th width="">${year}</th>
                        	</c:forEach>
                        </tr>
                   </thead>
                   <tbody>
                   <%
                  	 	Result<Map<String,Map<String,RentPredictionDto>>> result = (Result<Map<String,Map<String,RentPredictionDto>>>)request.getAttribute("result");
                   		Map<String,Map<String,RentPredictionDto>> map = result.getValue();
                   		List<String> years = (List<String>)request.getAttribute("years");
                   %>
						<tr>
                   			<td align="center"><strong>应收</strong></td>
                   <%
                   				for(String year : years){
                   					if(map.get("应收")!=null && map.get("应收").get(year)!=null){
                   %>
                   			<td align="center">&nbsp;<a style=" color:#666;text-decoration: none;" href="javascript:void(0)" onclick="rentList(parent.parent,'YS','<%=year %>');"><fmt:formatNumber value="<%=map.get("应收").get(year).getFee() %>" pattern=".##"/></a></td>
                   <%					
                   					}else{
      			   %>
                   			<td align="center">&nbsp;</td>
                   <%									
                   					}
                   				}
                   %>
	                    </tr>
						<tr>
                   			<td align="center"><strong>未收</strong></td>
                   <%
                   				for(String year : years){
                   					if(map.get("未收")!=null && map.get("未收").get(year)!=null){
                   %>
                   			<td align="center">&nbsp;<a style=" color:#666;text-decoration: none;" href="javascript:void(0)" onclick="rentList(parent.parent,'WS','<%=year %>');"><fmt:formatNumber value="<%=map.get("未收").get(year).getFee() %>" pattern=".##"/></a></td>
                   <%					
                   					}else{
      			   %>
                   			<td align="center">&nbsp;</td>
                   <%									
                   					}
                   				}
                   %>
	                    </tr>
                  </tbody>
                  <tfoot>
                  	<tr>
                    	<th align="center">实收</th>
                    	<%
                    		for(String year : years){
                    			if(map.get("实收")!=null && map.get("实收").get(year) !=null ){
                        %>
                        			<td align="center">&nbsp;<a style=" color:#666;text-decoration: none;" href="javascript:void(0)" onclick="rentList(parent.parent,'SS','<%=year %>');"><fmt:formatNumber value="<%=map.get("实收").get(year).getFee() %>" pattern=".##"/></a></td>
                        <%			
                        		}else{
                 		%>
                        			<td align="center">&nbsp;</td>
                        <%				
                        		}
                    		}
                    	%>
                    </tr>
                  </tfoot>
			</table>
		</div>
	</div>
</body>
</html>
