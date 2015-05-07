<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>

<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initList();
		jqGridResizeRegister("list");
	});
	function initList(){
		$("#list").jqGrid({
	    	url:'<%=basePath%>contect!list.action',
			colModel: [
				{label:'企业', name:'customer.name', align:"center"}, 
				{label:'姓名', name:'name', align:"center",width:80}, 
			    {label:'手机', name:'mobile', align:"center",width:100}, 
			    {label:'固定电话', name:'phone', align:"center",width:90},
			    {label:'主要联系人', name:'main.title', align:"center",width:60},
			    {label:'职位', name:'position', align:"center", hidden:true},
			    {label:'Email', name:'email', align:"center", hidden:true},
			    {label:'电话', name:'phone', align:"center", hidden:true},
			    {label:'MSN', name:'msn', align:"center", hidden:true},
			    {label:'QQ', name:'qq', align:"center", hidden:true},
			    {label:'传真', name:'fax', align:"center", hidden:true},
			    {label:'邮编', name:'zipcode', align:"center", hidden:true},
			    {label:'家庭地址', name:'homeAddr', align:"center", hidden:true},
			    {label:'家庭电话', name:'homePhone', align:"center", hidden:true},
			    {label:'生日', name:'birthDay', align:"center", hidden:true,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'爱好', name:'favorite', align:"center", hidden:true},
			    {label:'管理', name:'manager', align:"center", width:60 ,resizable:false,sortable:false}
			],
			postData:{filters:generateSearchFilters("customerId","eq",'${param.id}',"long")},
			height: 302,
			width: 697,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
		    caption : "列选择",
		    title : "选择要显示的列",
		    onClickButton : function(){
		        $(this).jqGrid('columnChooser');
		    }
		});
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");;
	}
	
	function viewById(id){
		fbStart('查看联系人','<%=basePath%>contect!view.action?id='+id,550,370);
	}
	function editById(id){
		fbStart('编辑联系人','<%=basePath%>contect!edit.action?id='+id,550,370);
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>contect!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>contect!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
</script>

</head>
<body>
		<div class="basediv">
			<!--divlay-->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="140" valign="top">
						<jsp:include page="../customer_view_common.jsp">
							<jsp:param value="1" name="index" />
							<jsp:param value="<%=request.getParameter("applyId")%>" name="gardenApplyId"/>
							<jsp:param value="<%=request.getParameter("id")%>" name="customerId" />
						</jsp:include>
					</td>
					<td valign="top" style="background:#eaeced ">
						<div class="pm_view_right" style="width:700px;height: 432px;">
							<div class="basediv" style="margin: 0px;">
								<div class="titlebg">联系人</div>
								<div class="emailtop">
									<div class="leftemail">
										<ul>
											<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建联系人','<%=basePath %>contect!addByCustomerId.action?id=${param.id}',550,370);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
										</ul>
									</div>
								</div>
								<table id="list" width="100%">
									<tr>
										<td />
									</tr>
								</table>
								<div id="pager"></div>
								<div class="hackbox"></div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
</body>
</html>