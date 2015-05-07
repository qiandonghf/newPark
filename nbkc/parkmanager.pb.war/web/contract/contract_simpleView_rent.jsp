<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
	<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
	<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
	<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
	<script type="text/javascript">
	$(function(){
		initTip();
		init();
	});
	function setSelectedContect(contect){
		$("#contectName").val(contect.name);
		$("#contectId").val(contect.id);
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
	function selectContect(){
		if($("#customerId").val()!=''){
			fbStart('选择负责人','<%=basePath %>contect!select.action?id='+$("#customerId").val(),360,400);
		} else {
			showTip("请先选择企业");
		}
	}
	function generateCode(){
		$.post("<%=basePath%>contract!generateCode.action",function(data){
			if(data.result.success){
				$("#contractNo").val(data.result.value);
			}
		});
	}
	function reloadSubjectRentList(){
		$("#subjectRentList").trigger("reloadGrid");
	}
	function slide(className){
		$("."+className).toggle();
	}
	function approval(id){
		$.post("<%=basePath%>contract!approval.action?id="+id,function(data){
			if(data.result.success){
				location.reload();
			}
		});
	}
	function executeContract(id){
		$.post("<%=basePath%>contract!executeContract.action?id="+id,function(data){
			if(data.result.success){
				location.reload();
			}
		});
	}
	function closeContract(id){
		$.post("<%=basePath%>contract!closeContract.action?id="+id,function(data){
			if(data.result.success){
				location.reload();
			}
		});
	}
	</script>
</head>
<body>
	<div style="padding-bottom: 5px;">
		<input type="hidden" value="${result.value.id}" id="contractId" name="contract.id"/>
		<div class="basediv">
			<div class="divlays">
				<jsp:include page="contract_view_common.jsp"></jsp:include>
				<div style="height: 230px;">
					<div id="bottom">
						<jsp:include page="contract_bottom_navigation_rent2.jsp"></jsp:include>
						<jsp:include page="contract_bottom_common_simpleview_rent.jsp"></jsp:include>
						<jsp:include page="contract_bottom_common_simpleview.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
