<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.crm.dto.AnalyseDto"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.util.DateUtil" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />

  
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
<script type="text/javascript"> 
$(document).ready(function() {
	initTip();
	 <c:if test="${result.value!=null}">
		 selectDataProperty2();
		 isChecked();
	 </c:if>
	 <c:if test="${result.value==null}">
		 initParent();
	 </c:if>
});

function isChecked(){
	 var names = document.getElementsByName("dataName");   
	 var len = names.length;   
	 var k = 0;
	 if (len > 0) {   
	 	var i = 0;   
	    for (i = 0; i < len; i++){
		   if(names[i].checked){
			 k++;
		   }   
	    }   
	    if(k==len){
	    	$("#ckall").attr("checked","checked");
	    }
	 }   
}

function initParent(){
	$('#cc').combotree({
	    url: '<%=basePath%>dataProperty!loadParentProperty.action',
	    onSelect : function(node) {
	    	$('#propertyId').val(node.id);
	    	$('#propertyName').val(node.text);
	    }
	}); 
}
function selectDataProperty(){
	var templateId = $("#templateId").val();
	$('#cc').combotree({
	    url: '<%=basePath%>analyse!loadPropertyByTemplate.action?templateId='+templateId,
	    onSelect : function(node) {
	    	$('#propertyId').val(node.id);
	    	$('#propertyName').val(node.text);
	    }

	}); 
	$("#tt").empty();
	$.ajax({
		  "url" : '<%=basePath%>analyse!loadDataReportById.action?templateId='+templateId,
		  type:"POST",
		  success: function(data){
				var list = data.result.value;
				for(var i=0;i<list.length;i++){
					$("#tt").append("<li></li>");
					$("#tt").append("<li><span class=\"name\" style=\"text-align:left;\">"+list[i].groupName+"</span></li>");
					for(var j=0;j<list[i].dataReportList.length;j++){
						var dataId = (list[i].dataReportList)[j].id;
						var dataName = (list[i].dataReportList)[j].name;
						$("#tt").append("<li><input type=\"checkbox\" name=\"dataName\" value=\""+dataId+"\" /><label>"+dataName+"</label></li>");
					}
					$("#tt").append("<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>");
				}
			  }
			});
}

function selectDataProperty2(){
	var templateId = "${result.value.templateId}";
	var propertyName = "${result.value.propertyName}";
	var propertyId = "${result.value.propertyId}";
	$('#propertyName').val(propertyName);
	$('#propertyId').val(propertyId);
	$('#cc').combotree({
	    url: '<%=basePath%>analyse!loadPropertyByTemplate.action?templateId='+templateId,
	    onSelect : function(node) {
	    	$('#propertyId').val(node.id);
	    	$('#propertyName').val(node.text);
	    }
	}); 
	if(propertyName==null) {
		$('#cc').combotree("setValue","----请选择----");
	} else {
		$('#cc').combotree("setValue",propertyName);
	}
	$("#tt").empty();
	$.ajax({
		  "url" : '<%=basePath%>analyse!loadDataReportById.action?templateId='+templateId,
		  type:"POST",
		  success: function(data){
			var list = data.result.value;
			for(var i=0;i<list.length;i++){
				var reportIds = "${result.value.ids}";
				$("#tt").append("<li></li>");
				$("#tt").append("<li><span class=\"name\" style=\"text-align:left;\">"+list[i].groupName+"</span></li>");
				for(var j=0;j<list[i].dataReportList.length;j++){
					var k = 0;
					var dataId = (list[i].dataReportList)[j].id;
					var dataName = (list[i].dataReportList)[j].name;
					for(var t=0;t<reportIds.split(",").length;t++){
						if(reportIds.split(",")[t]==dataId){
							k = 1;
						}
					}
					if(k==1){
						$("#tt").append("<li><input type=\"checkbox\" name=\"dataName\" value=\""+dataId+"\" checked=\"checked\" /><label>"+dataName+"</label></li>");
					}else{
						$("#tt").append("<li><input type=\"checkbox\" name=\"dataName\" value=\""+dataId+"\" /><label>"+dataName+"</label></li>");
					}
				}
				$("#tt").append("<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>");
			}
		  }
		});
}

/* 
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

function selectAll(){
	var roots = $("#tt").tree("getRoots");
	for(var i = 0; i < roots.length; i++){
		if(roots[i].checked==false){
			$("#tt").tree("check",roots[i].target);
		}else{
			$("#tt").tree("uncheck",roots[i].target);
		}
	}
}

function reserveChild(node){
	if(node.checked==false){
		$("#tt").tree("check",node.target);
	}else{
		$("#tt").tree("uncheck",node.target);
	}
	
}

function reserveSelected(){
	var roots = $("#tt").tree("getRoots");
	for(var i = 0; i < roots.length; i++){
		var nodes = $("#tt").tree("getChildren",roots[i].target);
		for(var i = 0; i < nodes.length; i++){
			reserveChild(nodes[i]);
		}
	}
} */
  
  function count(){
	  var names = document.getElementsByName("dataName");   
	  var ids = "";
	  var len = names.length;   
		 if (len > 0) {   
		 	var i = 0;   
		    for (i = 0; i < len; i++){
			   if(names[i].checked){
				   var id = names[i].value;
				   ids += id+",";
			   }
		    }   
		 } 
	  ids = deleteLastCharWhenMatching(ids,",");
	  var propertyId = $("#propertyId").val();
	  var templateId = $("#templateId").val();
	  var propertyName = $("#propertyName").val();
	  var sYear = $("#sYear").val();
	  var sMonth = $("#sMonth").val();
	  var eYear = $("#eYear").val();
	  var eMonth = $("#eMonth").val();
	  var time = sYear+":"+sMonth+":"+eYear+":"+eMonth;
	  $("#time").val(time);
	  if(templateId==""){
		  showTip("请选择数据模板",2000);
		  return;
	  }
	  if(sYear>eYear){
		  showTip("开始时间必须小于结束时间",2000);
		  return;
	  }
	  if(sYear==eYear && sMonth>=eMonth){
		  showTip("开始时间必须小于结束时间",2000);
		  return;
	  }
	  if(ids==""){
		  showTip("请选择经营数据",2000);
		  return;
	  }
	  if(propertyName==""){
		  showTip("请选择数据类型",2000);
		  return;
	  }
	 
	  location ="<%=basePath%>analyse!count.action?ids="+ids+"&time="+time+"&propertyId="+propertyId+"&templateId="+templateId+"&propertyName="+propertyName;
  }
  
function checkEvent(name,id){
 var allCk = document.getElementById(id);   
    if (allCk.checked == true) checkAll(name);   
    else checkAllNo(name);   
}
  
function checkAll(name){
	 var names = document.getElementsByName(name);   
	 var len = names.length;   
	 if (len > 0) {   
	 	var i = 0;   
	    for (i = 0; i < len; i++){
		   names[i].checked = true;   
	    }   
	 }   
}
	
function checkAllNo(name){
	 var names = document.getElementsByName(name);   
	 var len = names.length;   
	 if (len > 0) {   
	   var i = 0;   
	   for (i = 0; i < len; i++){   
	    names[i].checked = false;   
	   }  
	 }
}

function reserveCheck(name){
	 var names = document.getElementsByName(name);   
	 var len = names.length;   
	 if (len > 0) {   
	   var i = 0;   
	   for (i = 0; i < len; i++) {   
		   if (names[i].checked){
			   names[i].checked = false;
		   }else{
			   names[i].checked = true;   
		   }
	   }   
     }  
}
</script>
</head>
<body>
<div class="titlebg">数据分析</div>
<div class="overflowAuto" id="overflowAuto" style="height:390px;overflow-y:auto; overflow-x:hidden;">
<input type="hidden" id="time"/>
 <c:if test="${result.value!=null}">
 	<input type="hidden" id="ids" value="${result.value.ids}"/>
 	<input type="hidden" id="tId" value="${result.value.templateId}"/>
 </c:if>
 <c:if test="${result.value==null}">
 	<input type="hidden" id="ids"/>
 </c:if>
 
<div style="padding:40px 20px 0; float:left;" id="chartdiv">
	<c:if test="${result.value!=null}">
		<img src="core/common/images/countpic.jpg" style="width:400px; height:300px;" />
	</c:if>
	<c:if test="${result.value==null}">
		<img src="" style="width:400px; height:300px;" />
	</c:if>
</div>
<c:if test="${result.value!=null}">
 <script type="text/javascript">
 <%
 	Result result = (Result)request.getAttribute("result");
 	AnalyseDto dto = (AnalyseDto)result.getValue();
 	String time = dto.getsYear()+":"+dto.getsMonth()+":"+dto.geteYear()+":"+dto.geteMonth();
 %>
	var chart = new FusionCharts('<%=BaseAction.rootLocation%>/core/common/FusionChartsFree/Charts/FCF_Column2D.swf', "ChartId", "400", "300");
	chart.setDataURL(escape("<%=basePath%>analyse!dataXML.action?ids=${result.value.ids}&propertyId=${result.value.propertyId}&time=<%=time%>"));	
	chart.render("chartdiv");
</script>
</c:if>
<div style="padding:10px 20px 0; min-width:420px; overflow:hidden;">
            <dl class="dl-sy">
                <dt>数据分析选项</dt>
                <dd><span class="name">请选择数据模板：</span>
                <select  id="templateId"  name="dataTemplateId" class="select" onchange="selectDataProperty();">
               		  <option value="">----请选择----</option>
                	  <c:forEach items="${dataTemplateList}" var="dataTemplate">
                	  	 <c:if test="${result.value!=null}">
                	 	 <option value="${dataTemplate.id}"  <c:if test="${result.value.templateId eq dataTemplate.id}">selected="selected"</c:if>  >${dataTemplate.name}</option>
                	 	 </c:if>
                	  	 <c:if test="${result.value==null}">
                	 	 <option value="${dataTemplate.id}">${dataTemplate.name}</option>
                	 	 </c:if>
                	  </c:forEach>
                    </select>
                </dd>
                <dd><span class="name">请选择分析时间：</span>
               		<select id="sYear">
               		<c:forEach items="${yearList}" var="year">
               			<c:if test="${result.value==null}">
               			<option value="${year}">${year}</option>
               			</c:if>
               			<c:if test="${result.value!=null}">
               			<option value="${year}" <c:if test="${result.value.sYear eq year}">selected="selected"</c:if> >${year}</option>
               			</c:if>
               		</c:forEach>
               		</select>年&nbsp;&nbsp;
               		<select id="sMonth">
               		<c:forEach items="${monthList}" var="month">
               			<c:if test="${result.value==null}">
               			<option value="${month}">${month}</option>
               			</c:if>
               			<c:if test="${result.value!=null}">
               			<option value="${month}" <c:if test="${result.value.sMonth eq month}">selected="selected"</c:if> >${month}</option>
               			</c:if>
               		</c:forEach>
               		</select>月&nbsp;&nbsp;至&nbsp;&nbsp;
               		<select id="eYear">
               		<c:forEach items="${yearList}" var="year">
               			<c:if test="${result.value==null}">
               			<option value="${year}" <c:if test="${year eq cYear}">selected="selected"</c:if> >${year}</option>
               			</c:if>
               			<c:if test="${result.value!=null}">
               			<option value="${year}" <c:if test="${result.value.eYear eq year}">selected="selected"</c:if> >${year}</option>
               			</c:if>
               		</c:forEach>
               		</select>年&nbsp;&nbsp;
               		<select id="eMonth">
               		<c:forEach items="${monthList}" var="month">
               			<c:if test="${result.value==null}">
               			<option value="${month}">${month}</option>
               			</c:if>
               			<c:if test="${result.value!=null}">
               			<option value="${month}" <c:if test="${result.value.eMonth eq month}">selected="selected"</c:if> >${month}</option>
               			</c:if>
               		</c:forEach>
               		</select>月
                </dd>
                 <dd><span class="name">请选择经营数据：</span>
                	<div class="select-div">
                   		<ul style="padding:5px 10px; overflow:hidden; zoom:1; height:150px; overflow:auto;" id="tt" class="select-list">
                   			<c:forEach items="${dataReportList}" var="dataReport">
                   			<li><input type="checkbox" name="dataName" /><label>${dataReport.name}</label></li>
                   			</c:forEach>
                        </ul>
                        <div class="page">
                            <div class="floatrightdiv">
                             	<input id="ckall" type="checkbox" onclick="checkEvent('dataName','ckall');" /><label>&nbsp;全选</label>&nbsp;&nbsp;&nbsp;
                                <input id="ckReserve" type="checkbox" onclick="reserveCheck('dataName');"/><label>&nbsp;反选</label>
                            </div>
                      </div>
                    </div>
                </dd>
                <dd><span class="name">请选择数据类型：</span>
                <c:if test="${result.value==null}">
                	<input id="cc" name="typeId" style="width:180px;" value="----请选择----"/>
                </c:if>
                <c:if test="${result.value!=null}">	
               		<input id="cc" name="typeId" style="width:180px;" value="${result.value.propertyName}"/>
                </c:if>	
                	&nbsp;&nbsp;&nbsp;
                	<input type="hidden" id="propertyId"/>
                	<input type="hidden" id="propertyName"/>
                </dd>
                <dd>
                	<a href="javascript:void(0)" title="" class="btn_bg" onclick="count()"><span><img src="core/common/images/count.png"/>统计</span></a>
                </dd>
            </dl>
        </div>
</div>
</body>
</html>

