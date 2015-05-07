<%@page import="com.wiiy.crm.dto.AnalyseDto"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script><script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>

<script type="text/javascript">
  
  
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight()-85);
		$("#msglist").css("height",getTabContentHeight()-75);
		$("#treeviewdiv").css("height",getTabContentHeight()-100);
		initTree();
		
		 <c:if test="${dto!=null}">
			 selectDataProperty2();
			 isChecked();
			 tabSwitch('apptabli','apptabliover','tabswitch',1);
		 </c:if>
		 <c:if test="${dto==null}">
			 initParent();
		 </c:if>
		 
		});
	function initTree(){
		$("#browser").tree({
			animate: true,
			url: "<%=basePath%>dataReport!loadGroup.action",
			onBeforeExpand: function(node){
				$("#browser").tree("options").url="<%=basePath%>dataReport!loadReportByGroupId.action";
			},
			onClick: function(node){
				$(this).tree('toggle', node.target);
				if($(this).tree("isLeaf",node.target)){
					var p ="";
					p = node.id+","+$("#p").val();
					$("#msglist").attr("src","<%=basePath%>dataReport!viewByCustomerId.action?ids="+p+"&cId=${param.id}");
				}
			},
			onLoadSuccess: function(node, data){
				var nodes = $(this).tree("getRoots");
				for( var i = 0; i < nodes.length; i++){
					var node = nodes[i];
					if(!$(this).tree("isLeaf",node.target)){
						var children = $(this).tree("getChildren",node.target);
						for( var j = 0; j < children.length; j++){
							var child = children[j];
						}
					}
				}
			}
		});
	}
	function loadDataReportByGroupId(groupId){
		if($("#groupLi"+groupId).hasClass("expandable")){
			$.post("<%=basePath%>dataReport!loadDataReportByGroupId.action?id="+groupId,function(data){
				if(data.result.success){
					$("#groupUl"+groupId).empty();
					for(var i = 0; i < data.result.value.length; i++){
						var building = data.result.value[i];
						var span = $("<span class=\"file\"></span>").append(building.name).append($("<input />",{type:"hidden",value:building.id}));
						span.smartMenu(dataReportMenu,{name:'dataReportMenu'});
						span.bind("click",function(){
							$("#msglist").attr("src","<%=basePath%>dataReport!viewByCustomerId.action?id="+$(this).find('input').val()+"&cId=${param.id}");
						});
						$("#groupUl"+groupId).append($("<li></li>").append($("<a href=\"javascript:void(0)\"></a>").append(span)));
					}
				}
			});
		}
	}
	function setSelectedCustomers(customers){
		var customerIds = "";
		for(var i = 0 ; i < customers.length; i++){
			customerIds += customers[i].id+",";
		}
		customerIds = deleteLastCharWhenMatching(customerIds,",");
		window.frames[0].setSelectedCustomers(customerIds);
	}
	function reloadIframe(id,groupId){
		$("#msglist").attr("src","<%=basePath%>dataReport!viewByCustomerId.action?id="+id+"&cId=${param.id}");
		initTree();
		setTimeout(function(){
			var tree = $('#browser');
			var group = tree.tree('find',groupId);
			tree.tree('expand',group.target);
			setTimeout(function(){
				var children = tree.tree('getChildren',group.target);
				for(var i = 0; i < children.length; i++){
					if(children[i].id == id) tree.tree('select',children[i].target);
				}
			}, 1000);
		}, 1000);
	}
	function reloadList(){
		window.frames[0].reloadList();
	}
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
	}

	function selectDataProperty2(){
		var templateId = "${dto.templateId}";
		var propertyName = "${dto.propertyName}";
		var propertyId = "${dto.propertyId}";
		$('#propertyName').val(propertyName);
		$('#propertyId').val(propertyId);
		$('#cc').combotree({
		    url: '<%=basePath%>analyse!loadPropertyByTemplate.action?templateId='+templateId,
		    onSelect : function(node) {
		    	$('#propertyId').val(node.id);
		    	$('#propertyName').val(node.text);
		    },
		    panelHeight:55
		}); 
		if(propertyName==null) {
			$('#cc').combotree("setValue","----请选择----");
		} else {
			$('#cc').combotree("setValue",propertyName);
		}
	}	
	 function count(){
		  var ids = "";
		  var propertyId = $("#propertyId").val();
		  var templateId = $("#templateId").val();
		  var propertyName = $("#propertyName").val();
		  var sYear = $("#sYear").val();
		  var sMonth = $("#sMonth").val();
		  var eYear = $("#eYear").val();
		  var eMonth = $("#eMonth").val();
		  var p = $("#p").val();
		  var service = $("#service").val();
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
		  if(propertyName==""){
			  showTip("请选择数据类型",2000);
			  return;
		  }
		 
		  location ="<%=basePath%>analyse!customerCount.action?ids="+ids+"&time="+time+"&propertyId="+propertyId+"&templateId="+templateId+"&propertyName="+propertyName+"&id="+p+"&service="+service;
	  }	
  
</script>
</head>

<body>
<div class="basediv">
<input type="hidden" value="${param.id}" id="p"/>
<input type="hidden" value="${service }" id="service"/>
    <!--divlay-->
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="140" valign="top">
            <c:choose>
	            <c:when test="${service}">
					<jsp:include page="../customer_view_common2.jsp">
						<jsp:param value="8" name="index"/>
						
						<jsp:param value="<%=request.getParameter("id") %>" name="customerId"/>
					</jsp:include>
				</c:when>
				<c:otherwise>
					<jsp:include page="../customer_view_common.jsp">
						<jsp:param value="8" name="index"/>
						<jsp:param value="<%=request.getParameter("applyId")%>" name="gardenApplyId"/>
						<jsp:param value="<%=request.getParameter("id") %>" name="customerId"/>
					</jsp:include>
				</c:otherwise>
			</c:choose>
			</td>
            <td valign="top" style="background:#eaeced ">
				<div class="pm_view_right" style="width:700px;height: 432px;">
				<!--table切换开始-->
					<div class="apptab" id="tableid">
					<ul>
						<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">报表</li>
						<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">图表</li>
					</ul>
				</div>
			<!--//table切换开始-->
			<div class="basediv tabswitch" style="margin:0px;" id="textname">
				<div id="container">	
  					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
				        	<td width="150" valign="top">
								<div class="agency" id="resizable">
									<div class="titlebg">数据填报</div>
									<div class="treeviewdiv" style="overflow-Y:auto;padding-left: 0px" id="treeviewdiv" >
										<ul id="browser" class="filetree"></ul>
						          	</div>
								</div>		
							</td>
							<td width="100%" valign="top">
								<iframe src="<%=basePath %>web/client/dataReport_index.jsp" frameborder="0" id="msglist" width="100%"></iframe>
							</td>
						</tr>
					</table>
				</div>
			</div>	
			<div class="basediv tabswitch" style="margin:0px;display:none" id="textname">
				<div id="container">
  					<div class="msglist" style="background:#fff; border-top:1px solid #c3c3c3; height:353px;">
            
                            <!--titlebg-->
                            <div class="titlebg">企业数据填报图表</div>
                            <!--//titlebg-->
                            		<div style="padding:20px;">       
                                        <div style=" margin-bottom:20px;" id="chartdiv">
                                        <input type="hidden" id="time"/>
										 <c:if test="${dto!=null}">
										 	<input type="hidden" id="tId" value="${dto.templateId}"/>
										 	 <img src="" style="width:100%; height:140px;"/>
										 </c:if>
                                        <c:if test="${dto==null}">
										 	<input type="hidden" id="ids"/>
										 	 <img src="" style="width:100%; height:140px;"/>
										 </c:if>
                                        
                                        </div>
                                        <script type="text/javascript">
                                        <%
									 	AnalyseDto dto = (AnalyseDto)request.getAttribute("dto");
                                        if(dto!=null){
									 		String time = dto.getsYear()+":"+dto.getsMonth()+":"+dto.geteYear()+":"+dto.geteMonth();
									    %>
										var chart = new FusionCharts('<%=BaseAction.rootLocation%>/core/common/FusionChartsFree/Charts/FCF_Column2D.swf', "ChartId", "650", "140");
										chart.setDataURL(escape("<%=basePath%>analyse!dataXML2.action?ids=${dto.ids}&propertyId=${dto.propertyId}&time=<%=time%>&id=${id}"));	
										chart.render("chartdiv");
										<%}%>
										</script>
                                        <div >
                                           <dl class="dl-sy">
                                            <dt>数据分析选项</dt>
                                            <dd><span class="name">请选择数据模板：</span>
                                            	   <select  id="templateId"  name="dataTemplateId" class="select" onchange="selectDataProperty();">
								               		  <option value="">----请选择----</option>
								                	  <c:forEach items="${dataTemplateList}" var="dataTemplate">
								                	  	 <c:if test="${dto!=null}">
								                	 	 <option value="${dataTemplate.id}"  <c:if test="${dto.templateId eq dataTemplate.id}">selected="selected"</c:if>  >${dataTemplate.name}</option>
								                	 	 </c:if>
								                	  	 <c:if test="${dto==null}">
								                	 	 <option value="${dataTemplate.id}">${dataTemplate.name}</option>
								                	 	 </c:if>
								                	  </c:forEach>
								                    </select>
                                            </dd>
                                            <dd><span class="name">请选择分析时间：</span>
                                            	<select id="sYear">
								               		<c:forEach items="${yearList}" var="year">
								               			<c:if test="${dto==null}">
								               			<option value="${year}">${year}</option>
								               			</c:if>
								               			<c:if test="${dto!=null}">
								               			<option value="${year}" <c:if test="${dto.sYear eq year}">selected="selected"</c:if> >${year}</option>
								               			</c:if>
								               		</c:forEach>
								               		</select>年&nbsp;&nbsp;
								               		<select id="sMonth">
								               		<c:forEach items="${monthList}" var="month">
								               			<c:if test="${dto==null}">
								               			<option value="${month}">${month}</option>
								               			</c:if>
								               			<c:if test="${dto!=null}">
								               			<option value="${month}" <c:if test="${dto.sMonth eq month}">selected="selected"</c:if> >${month}</option>
								               			</c:if>
								               		</c:forEach>
								               		</select>月&nbsp;&nbsp;至&nbsp;&nbsp;
								               		<select id="eYear">
								               		<c:forEach items="${yearList}" var="year">
								               			<c:if test="${dto==null}">
								               			<option value="${year}" <c:if test="${year eq cYear}">selected="selected"</c:if> >${year}</option>
								               			</c:if>
								               			<c:if test="${dto!=null}">
								               			<option value="${year}" <c:if test="${dto.eYear eq year}">selected="selected"</c:if> >${year}</option>
								               			</c:if>
								               		</c:forEach>
								               		</select>年&nbsp;&nbsp;
								               		<select id="eMonth">
								               		<c:forEach items="${monthList}" var="month">
								               			<c:if test="${dto==null}">
								               			<option value="${month}">${month}</option>
								               			</c:if>
								               			<c:if test="${dto!=null}">
								               			<option value="${month}" <c:if test="${dto.eMonth eq month}">selected="selected"</c:if> >${month}</option>
								               			</c:if>
								               		</c:forEach>
								               		</select>月									
                                            </dd>
                                            <dd><span class="name">请选择数据类型：</span>
                                                 <c:if test="${dto==null}">
								                	<input id="cc" name="typeId" style="width:150px;" value="----请选择----"/>
								                </c:if>
								                <c:if test="${dto!=null}">	
								               		<input id="cc" name="typeId" style="width:150px;" value="${dto.propertyName}"/>
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
                            </div>
				</div>
			</div>			
		</div>
		</td>
		</tr>
		</table>
</div>
</body>
</html>
