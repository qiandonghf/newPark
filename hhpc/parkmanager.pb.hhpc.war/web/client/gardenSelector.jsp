<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.wiiy.commons.action.BaseAction"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery.treeview.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>

<script type="text/javascript">
  var name = "${param.name}";
  name = decodeURI(name);
  var selectedGarden={id:"${param.id}", name:name};
  $(document).ready(function() {
	  initTip();
	  initList();
	  showSelectedGarden();
  });

  function showSelectedGarden() {
	  $("#selectedGardenDiv").text(selectedGarden.name);
  }

  function initList(){
	var url = "${contextLocation}parkmanager.pb/garden!list.action";
	$("#list").jqGrid({
    	url:url,
		datatype: 'json',
		prmNames: {search: "search"},
		jsonReader: {root:"root",repeatitems: false},
		colModel: [
			{label:'&nbsp;', sortable: false, width:10, name:'MY_ID', index:'MY_ID', align:"center"}, 
			{label:'序列', width:30, name:'id', index:'id', align:"center"}, 
		    {label:'苗圃项目名称', name:'projectName', index:'projectName', align:"center"}
		    ],
		height: 204,
		rowNum: 10,//设置表格中显示的记录数如果服务器返回记录数大于此值则只显示rowNum条 -1不检查此项
		rowList: [],//用来调整表格显示的记录数
		recordtext: "共 {2} 条",	// 共字前是全角空格
		autowidth: true,//宽度自动
		multiselect: false,//是否可以多选
		multiboxonly: false,
		viewrecords: true,//是否显示总记录数
		rownumbers: false,//显示行顺序号，从1开始递增。此列名为'rn'
		loadui: 'block',//当执行ajax请求时 启用Loading提示，但是阻止其他操作
		pager: '#pager',//指定分页栏对象
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
                   var radioId = "<input id='"+id+"' type='radio' name='myname' value='" + id + "'/>";
				$(this).jqGrid('setRowData',id,{MY_ID:radioId});
			}
		},
		onSelectRow: function(id) {
               $($(this)).find("input[value="+id+"]").prop('checked',true);
           },
		loadComplete: function() {
			if (selectedGarden.id != "") {
				$("#list").find('#'+selectedGarden.id+' input').prop('checked',true); 
			}
			
			$("#list").find("input").click(function (e){
				setTimeout(checkSelectedGarden, 100);
			})

			$("#list").find("tr").click(function (e){
				setTimeout(checkSelectedGarden, 100);
			})
		},
		gridview: true
	});
	}
	function checkSelectedGarden() {
		var ids = $("#list").jqGrid("getDataIDs");
		$(ids).each(function (index, id) {
			if ($("#list").find('#'+id+' input').prop('checked')) {
				var rowData = $("#list").jqGrid("getRowData", id);
				selectedGarden = {id : id, name : rowData.projectName};
			}
		});
		showSelectedGarden();
	}  
	function searchByUsername() {
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:getSearchFilters()}}).trigger('reloadGrid');
	}
	
	function submitSelectedUser() {
		if (selectedGarden.id == "") {
			showTip("请先选择一个苗圃项目", 1000);
			return;
		}
		getOpener().setSelectedGarden(selectedGarden);
		fb.end();
	}
</script>
</head>

<body>
<div class="basediv">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td valign="top">
		<div class="" style="">
	      <div class="titlebg">苗圃项目列表</div>
			<!--userrightdiv-->
			<div class="userrightdivC" style="">
				<table id="list" class="jqGridList"><tr><td/></tr></table>
			<div id="pager"></div>
			</div>
			<!--userrightdiv-->
	    </div>
	    <div id="selectedGardenDiv" style=" background:#ffffe1; height:20px; line-height:20px; overflow-x:hidden; overflow-y:auto; border:1px solid #ccc;margin:5px 3px; padding:2px;">
	    </div>
    </td>
  </tr>
</table>

<div class="hackbox"></div>
</div>
	<div class="buttondiv">
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="submitSelectedUser()"><span><img src="core/common/images/accept.png">确认</span></a>
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="fb.end();"><span><img src="core/common/images/close.png">取消</span></a>
	</div>
</body>
</html>
