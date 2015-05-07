<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initForm();
		initList();
	});
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"salaryDefine.serialNo":"required",
				"salaryDefine.name":"required"
			},
			messages: {
				"salaryDefine.serialNo":"请填标准编号",
				"salaryDefine.name":"请填写标准名称"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
		        		setTimeout("getOpener().reloadList();", 2000);
		        	} 
			    });
			}
		});
	}
	function initList(){
		//alert($("#sid").val());
		var height = getTabContentHeight()-75;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-400;
		$("#list").jqGrid({
	    	url:'<%=basePath%>salaryDefineCfg!list.action?salaryDefineId='+$("#sid").val(),
			colModel: [
				{label:'薪资项名称',width:310,name:'salaryItem.name',align:"center"}, 
				{label:'缺省值',width:140,name:'salaryItem.defaultVal',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"}, 
			    {label:'操作',width:60, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			multiselect: true, 
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
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
	
	function editById(id){
		fbStart('薪资项编辑','<%=basePath%>salaryDefineCfg!edit.action?id='+id,360,160);
	}
		
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>salaryDefineCfg!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
	        	}
			});
		}
	}
		
	function deleteSelected(){
		if(confirm("确定要删吗")){
			var ids = $("#list").jqGrid("getGridParam","selarrrow");
			$.post("<%=basePath%>salaryDefineCfg!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
	        	}
			});
		}
	}
	
	function reloadSalaryDefineCfgList(sid){
		/* //级联页面刷新，重新修改URL请求参数,会将salaryDefineId当中参数附在url后
		 $("#list").jqGrid('setGridParam',   
          {
			 postData:{'salaryDefineId':sid}   
           }).trigger('reloadGrid'); */
        $("#sid").val(sid);
        $("#list").trigger("reloadGrid");
		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);		
	}
	
	function generateCode(){
		$.post("<%=basePath%>salaryDefine!generateCode.action",function(data){
        	if(data.result.success){
				$("#serialNo").val(data.result.value);
        	}
		});
	}
</script>
</head>

<body >
<form id="form1" name="form1" method="post" action="<%=basePath%>salaryDefine!update.action">
<!--basediv-->
<div class="basediv">
<!--titlebg-->
	<div class="layertitle">薪酬信息</div>
    <!--//titlebg-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>标准编号：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="820">
            	<input id="sid" name="salaryDefine.id" type="hidden" value="${result.value.id}"/>
            	<input id="serialNo" name="salaryDefine.serialNo"  type="text" class="inputauto" value="${result.value.serialNo}"/>
            </td>
            <td width="80"><img src="core/common/images/auto.gif" width="75" height="22" style="cursor:pointer;" onclick="generateCode()"/></td>
          </tr>
        </table></td>
        </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>标准名称：</td>
        <td class="layerright"><label>
          <input name="salaryDefine.name"  type="text" class="inputauto" value="${result.value.name}"/>
        </label></td>
        </tr>
      <tr>
        <td class="layertdleft100">备注：</td>
        <td class="layerright"><textarea name="salaryDefine.memo" rows="8" class="textareaauto">${result.value.memo}</textarea></td>
        </tr>
    </table></td>  
  </tr>
</table>
</div>
<!--//basediv-->
<div class="buttondiv">
<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
</div>
</form>
 
<!--container-->
<div class="basediv" >
<!--titlebg-->
	<div class="layertitle">薪酬项目金额设置</div>
<!--//titlebg-->
<!--btndiv-->
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('薪酬项目列表','<%=basePath%>salaryDefine!config.action?id='+${result.value.id},589,247);"><span><img src="core/common/images/emailadd.gif"/></span>设置</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		</ul>
	</div>
</div>
<!--//btndiv-->
<!--container-->
<div id="container">
	<div class="msglist" id="msglist">
	  <table id="list" class="jqGridList"><tr><td/></tr></table>
	  <div id="pager"></div>
	</div>
</div>
<!--//container-->
</body>
</html>
