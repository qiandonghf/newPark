<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${rootLocation}"/>
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
  var selectedUser={id:"${user.id}", name:"${user.realName}",realName:"${user.realName}"};
  $(document).ready(function() {
	  initTip();
	  initOrgTree();
	  initList();
	  showSelectedUser();
  });

  function showSelectedUser() {
	  $("#selectedUserDiv").text(selectedUser.name);
  }

  function initOrgTree() {
		$.ajax({
		  "url" : "${contextLocation}org!treeOrgs.action",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				"data" : data,
				onClick : function(node) {
					$("#list").setGridParam({url:'${contextLocation}user!loadUsersByOrgId.action?id='+node.id}).trigger('reloadGrid');
					//$("#list").jqGrid('setGridParam',{page:1,postData:{filters:"{\"rules\":[{\"field\":\"org.id\",\"op\":\"eq\",\"data\":\""+node.id+"\",\"dataType\":\"long\"}]}"}}).trigger('reloadGrid');
				}
			});
		  }
		});
  }
  
  function initList(){
		$("#list").jqGrid({
	    	url:'${contextLocation}user!listSelf.action',
			datatype: 'json',
			prmNames: {search: "search"},
			jsonReader: {root:"root",repeatitems: false},
			colModel: [
				{label:'&nbsp;', sortable: false, width:20, name:'MY_ID', index:'MY_ID', align:"center"}, 
				{label:'序列', width:30, name:'id', index:'id', align:"center"}, 
			    {label:'姓名', width:100, name:'realName', index:'realName', align:"center"}, 
			    {label:'所属机构', name:'orgName', index:'org', align:"center"}
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
				if (selectedUser.id != "") {
					$("#list").find('#'+selectedUser.id+' input').prop('checked',true); 
				}
				
				$("#list").find("input").click(function (e){
					setTimeout(checkSelectedUser, 100);
				})

				$("#list").find("tr").click(function (e){
					setTimeout(checkSelectedUser, 100);
				})
			},
			gridview: true
		});
	}
	function checkSelectedUser() {
		var ids = $("#list").jqGrid("getDataIDs");
		$(ids).each(function (index, id) {
			if ($("#list").find('#'+id+' input').prop('checked')) {
				var rowData = $("#list").jqGrid("getRowData", id);
				selectedUser = {id : id, name : rowData.realName, realName : rowData.realName};
			}
		});
		showSelectedUser();
	}  
	function searchByUsername() {
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:getSearchFilters()}}).trigger('reloadGrid');
	}
	
	function submitSelectedUser() {
		if (selectedUser.id == "") {
			showTip("未选择用户", 1000);
			return;
		}
		getOpener().setSelectedUser(selectedUser);
		fb.end();
	}
</script>
</head>

<body>
<div class="basediv">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td valign="top"><!--userleft-->
<div class="userleftcontact">
<div class="titlebg">组织机构</div>
<!--treeviewdiv-->
	<div style="overflow:auto; width:140px; height:316px;">
		<ul id="tt">
		</ul>
	</div>
<!--//treeviewdiv-->
</div>
<!--//userleft-->
<!--userright--><!--userright--></td>
    <td valign="top">
	<div class="userrightcontact" style="height:312px;">
      <div class="titlebg">用户列表</div>
      <!--searchdiv-->
      <div class="searchdiv">
        <form id="form2" name="form2" method="post" action="">
          <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="185"><label>
                <search:input id="realName" dataType="string" field="realName" op="bw" inputClass="inputauto"/>
              </label></td>
              <td><label> &nbsp;
                    <input name="Submit3" type="button" class="search_cx" value="" onclick="searchByUsername()"/>
              </label></td>
            </tr>
          </table>
        </form>
      </div>
      <!--//searchdiv-->
      <!--userrightdiv-->
      <div class="userrightdivC" style="height:230px;">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
      </div>
      <!--userrightdiv-->
    </div>
    <div id="selectedUserDiv" style=" background:#ffffe1; position:relative; left:3px; height:20px; line-height:20px; overflow-x:hidden; overflow-y:auto; border:1px solid #ccc;width:343px; margin:1px 6px 5px; padding:2px;">
	  	
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
