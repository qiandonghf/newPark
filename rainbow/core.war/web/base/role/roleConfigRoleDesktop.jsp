<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
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
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>

<script type="text/javascript">
	$(function(){
		initTip();
	});
	function toSubmit(){
		var postData = {id:${id},ids:'',orders:''};
		var ids = "";
		$("#down").find(".selected").each(function(){
			ids += $(this).attr("id")+",";
		});
		ids = deleteLastCharWhenMatching(ids,',');
		var orders = "";
		$(".order").each(function(){
			orders += $(this).val()+",";
		});
		orders = deleteLastCharWhenMatching(orders,',');
		postData.ids = ids;;
		postData.orders = orders;
		$.post("<%=basePath%>role!submitConfigRoleDesktop.action",postData,function(data){
			showTip(data.result.msg,2000);
			if(data.result.success){
				setTimeout("parent.fb.end()", 1000);
			}
		});
	}
	//var upOperation = $("<input type='button' class='upBtn' onclick='moveRoleItem(\"up\",\"down\",this)' value='添加'/>"); ;
	var upOperation = $("<img src=\"core/common/images/workadd.png\" class=\"upBtn\" width=\"14\" height=\"14\" title=\"添加\" onclick=\"moveRoleItem('up','down',this);\"/>"); ;
	var downOperation = $("<span></span>")
			.append($("<img src=\"core/common/images/up.png\" class=\"downBtn\" width=\"14\" height=\"14\" title=\"上移\" onclick=\"moveItem('up',this)\"/>"))
			.append($("<img src=\"core/common/images/down.png\" class=\"downBtn\" width=\"14\" height=\"14\" title=\"下移\" onclick=\"moveItem('down',this)\"/>"))
			.append($("<img src=\"core/common/images/del.gif\" class=\"downBtn\" width=\"14\" height=\"14\" title=\"移除\" onclick=\"moveRoleItem('down','up',this)\"/>")
		); 
	function moveRoleItem(from,to,t){
		var tr = $(t).parents("tr");
		if(from=='up'){
			var order = 1;
			if($("#"+to).find(".order").size()>0){
				order = parseInt($("#"+to).find(".order").last().val())+1;
			}
			tr.children().last().append($("<input class='order' type='hidden' value='"+order+"'/>"));
			tr.find(".upBtn").remove();
			tr.children().last().append(downOperation.clone());
		} else {
			tr.find(".order").remove();
			tr.find(".downBtn").remove();
			tr.children().last().append(upOperation.clone());
		}
		$("#"+to).append(tr);
		$("#"+from).remove(tr);
	}
	function moveItem(to,t){
		var move = $(t).parents(".selected");
		var target;
		if(to=='up'){
			target = move.prev();
		} else {
			target = move.next();
		}
		if(target){
			var moveOrder = move.find(".order").val();
			var targetOrder = target.find(".order").val();
			if(targetOrder==undefined){
				return;
			}
			move.find(".order").val(targetOrder);
			target.find(".order").val(moveOrder);
			if(to=='up'){
				target.before(move);
			} else {
				target.after(move);
			}
		}
	}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>roleDesktop!saveRoleDesktopConfig.action">
  <!--basediv-->
  <div class="basediv" style=" margin-bottom:8px;">
    <!--//btndiv-->
    <div class="divlays" style="height:400px; overflow-y:auto;">
      <!--table切换开始-->
      <div class="apptab" id="tableid">
        <ul>
	        <li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">已配置</li>
	        <li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">未配置</li>
        </ul>
      </div>
	  <div style=" height:205px;">
<div class="basediv tabswitch" style="margin-top:0px; display:block" id="textname" name="textname">
        <table id="down" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="parentTr">
            <td class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">功能</td>
            <td width="120" class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">操作</td>
          </tr>
         <c:forEach items="${roleDesktopList}" var="roleDesktop">
		  <tr id="${roleDesktop.desktopItem.id}" class="selected" onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
		    <td class="lefttd">${roleDesktop.desktopItem.title}</td>
		    <td class="centertd">
		    	<img src="core/common/images/up.png" class="downBtn" width="14" height="14" title="上移" onclick="moveItem('up',this)"/>
		    	<img src="core/common/images/down.png" class="downBtn" width="14" height="14" title="下移" onclick="moveItem('down',this)"/>
		    	<img src="core/common/images/del.gif" class="downBtn" width="14" height="14" title="移除" onclick="moveRoleItem('down','up',this)"/>
		    	<input type="hidden" class="order" value="${roleDesktop.displayOrder}"/>
		    </td>
		    </tr>
		 </c:forEach>
        </table>
  </div>
<div class="basediv tabswitch" style="margin-top:0px; display:none;" id="textname" name="textname">
		<table id="up" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr class="parentTr">
            <td class="tdcenter"  onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">功能</td>
            <td width="120" class="tdrightc"  onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">操作</td>
          </tr>
          <c:forEach items="${desktopItemList}" var="desktopItem">
          <tr id="${desktopItem.id}" class="selected" onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
            <td class="lefttd">${desktopItem.title}</td>
            <td class="centertd">
            	<img src="core/common/images/workadd.png" class="upBtn" width="14" height="14" title="添加" onclick="moveRoleItem('up','down',this);"/>
           	</td>
          </tr>
         </c:forEach>
        </table>
</div>
      <div class="hackbox"></div>
    </div>
	</div>
  </div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="toSubmit();"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
</div>
</form>
</body>
</html>
