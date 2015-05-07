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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/cord_icon.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script>
	//园区菜单
	var parkMenu = [[{
	    text: "编辑",
		classname: "smarty_menu_ico1",
	    func: function() {
			fbStart('编辑','<%=basePath%>webInfo!edit.action?id='+$(this.parentNode).attr('node-id'),600,450);
	    }
	},{
	    text: "删除",
		classname: "smarty_menu_ico2",
	    func: function() {
			if(confirm("您确定要删除")){
				$.post("<%=basePath%>webInfo!delete.action?id="+$(this.parentNode).attr('node-id'),function(data){
					showTip(data.result.msg,1000);
					setTimeout("location.reload()", 1000);
				});
			}
	    }
	},{
		text: "新建频道",
			classname: "smarty_menu_ico0",
	        func: function(e) {
     	    fbStart('新建频道信息','<%=basePath%>webInfo!createChild.action?id='+$(this.parentNode).attr("node-id"),450,210);
	        }
	}]];
	
	$(document).ready(function() {
		initTip();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight());
		$("#treeviewdiv").css("height",getTabContentHeight()-120);
		refreshTree();
	});
	
	<%-- function refreshTree() {
			$('#tt').tree({
			    url: '<%=basePath%>column!smsPage.action',
			    onClick: function(node){
					$(this).tree('toggle', node.target);
					var id = node.id;
					$("#msglist").attr("src","<%=basePath%>webInfo!view.action?id="+id);
			    },
			    onLoadSuccess: function(){
			    	var nodes = $(this).tree("getRoots");
					for( var i = 0; i < nodes.length; i++){
						var node = nodes[i];
						$(node.target).find(".tree-title").smartMenu(parkMenu,{name:'parkMenu'});
					}
			    },
			});
	} --%>

	
	function refreshTree() {
		$.ajax({
		 url: '<%=basePath%>serviceInfor!getInformation.action',
		 type:"POST",
		  success: function(data){
			$("#tt").tree({
				lines:true,
				"checkbox" : true,
				onClick:function(node){
					$(this).tree('toggle', node.target);
				},
				"data" : data.columnList
			});
			
		  }
		});
	}
	function grantSelectedAuthorities() {
		var columnId = "" ;
		var webInfoId = "" ;
		//选中频道的数量
		var column_count = 0 ;
		//选中的栏目数量
		var webInfo_count = 0 ;
		var checkedNodes = $("#tt").tree("getChecked");
		for(var i = 0 ; i < checkedNodes.length;i++){
			if(checkedNodes[i].iconCls == "column"){
				//如果选中的频道有多个,则用-来拼接频道ID
				if(column_count>0) columnId = columnId+"-";
				columnId = columnId+checkedNodes[i].id;
				column_count++ ;
			}
			else if(checkedNodes[i].iconCls == "webInfo"){
				//如果选中的栏目有多个,则用-来拼接栏目ID
				if(webInfo_count > 0) webInfoId = webInfoId+"-"; 
				webInfoId = webInfoId +checkedNodes[i].id;
				webInfo_count++ ;
			}
		}
		//如果选中的节点大于0,则把选中的参数提交到后台操作
		//if(checkedNodes.length>0){
			$.ajax({ 
		         type: "post", 
		         data:{
		        	  "newsParam.columnId":columnId,
		        	  "newsParam.webInfoId":webInfoId
		        	  },
		         url: "<%=basePath %>newsParam!savaParmas.action", 
		         dataType: "json", 
		         success: function (data) { 
		        	 showTip(data.message,2000);
		        	 setTimeout("fb.end();parent.refresh();", 3000); 
		         }, 
		         error: function (XMLHttpRequest, textStatus, errorThrown) { 
		                 alert(textStatus); 
		         } 
		});
	//}
	}
</script> 
</head>

<body>
	<div class="basediv">
	
						<div class="treeviewdiv" style="overflow-Y:auto; text-align: left;" id="treeviewdiv">
						<input type="hidden" name="roleId" id="roleId" value="${id}" />
						<form action="" method="post">
							 	<ul id="tt">
		 						</ul>
		 			
		 				</form>		 				
			          	</div>
   	</div>
   	<div class="buttondiv">
			<a href="javascript:void(0)" title="" class="btn_bg" onclick="grantSelectedAuthorities()"><span><img src="core/common/images/accept.png">确认</span></a>
			<a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end();"><span><img src="core/common/images/close.png">取消</span></a>
	</div>
			          	
			 

				
</body>
</html>
