<%@page import="com.wiiy.pb.preferences.enums.MeterKindEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.wiiy.commons.preferences.enums.TitleEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>web/style/ps.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/easyslider1.7/css/slider.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/easyslider1.7/js/easySlider1.7.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		 initTip();
		 initList();
		 
	});
	
	function deleteMeterLabel(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>selfMeterLabel!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		setTimeout("parent.fb.end();window.parent.location.reload();", 2000);
	        	}
			});
		}
	}
	var lastsel3;
	function initList(){
		var height = getTabContentHeight()-107;
		var width = window.parent.document.documentElement.clientWidth-365;
		$("#list").jqGrid({
	    	url:'<%=basePath%>selfLabelRecord!list.action?labelId=${result.value.id}',
			colModel: [
				{label:'表编号', width:50,name:'meterOrderNo', align:"center"}, 
				{label:'表类型', width:30,name:'meterType.title', align:"center"}, 
				{label:'倍数', width:30,name:'meterFactor', align:"center"}, 
				{label:'上期读数(度)',width:70, name:'preReading',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"},
			    {label:'上期抄表时间',width:70, name:'preDate', align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d'}}, 
				{label:'本期读数(度)',width:70, name:'curReading',align:"center",editable:true, edittype:'custom', editoptions:{custom_element: myelem, custom_value:myvalue},formatter: curR,classes:'pointSpan'},
			    {label:'本期抄表时间',width:70, name:'curDate', align:"center", editable:true, edittype:'custom', editoptions:{custom_element: myelem, custom_value:myvalue},formatter: curD,classes:'pointSpan'},
			    {label:'水电表Id',width:60, name:'meterId', align:"center",hidden:true}, 
			    {label:'管理',width:30, name:'manager', align:"center", resizable:false}
			],
			height: height,
			width: width,
			pager: "#page",
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				$("#recordIds").val(ids);
				//获取某一列的所有值
				var col= jQuery("#list").jqGrid('getCol','meterId',false);
				$("#ids").val(col);
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			},
			onSelectRow: function(id){
				if(id && id!==lastsel3){
					jQuery('#list').jqGrid('restoreRow',lastsel3);
					jQuery('#list').jqGrid('editRow',id,true,pickdates);
					lastsel3=id;
				}
			},
			postData:{filters:generateSearchFilters("labelId","eq",'${result.value.id}',"long")}
		}).navGrid('#page',{add: false, edit: false, del: false, search: false});
	}
	
	function myelem (value, options) {
        var el = document.createElement("input");
        el.setAttribute("class", "meterInput");
        el.type="text";
        el.value = value;
        return el;
      }
       
      //获取值
      function myvalue(elem) {
        return $(elem).val();
      }
	
	function curR(value){
		//return "<span class='pointSpan'>"+value+"</span>";
		if(value==null){
			value="";
		}else{
			
		}
		return value;

	}
	
	function curD(value){
		if(value!=null){
			value = value.substring(0,10);
		}else{
			value="";
		}
		//return "<span class='pointSpan'>"+value+"</span>";
		return value;
	}
	
	function pickdates(id){
	    var readingDateVal = $("#"+id+"_curDate").val();
		readingDateVal = readingDateVal.substring(0,10);
		var date;
		var curReading;
		$("#"+id+"_curDate").val(readingDateVal);
		$("#"+id+"_curDate").click(function(){
			showCalendar(this.id);
		}).blur(function(){
			date = this.value;
			if(date==readingDateVal){
				return;
			}
			if(/^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(date)){
				$.post('<%=basePath%>selfLabelRecord!update.action?id='+id+"&curReading="+curReading+"&date="+date,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("#list").trigger("reloadGrid");
		        	}
				});
			}else{
				showTip("时间格式错误",2000);
				return;
			}
		});
		
		var curReadingVal = $("#"+id+"_curReading").val();
		$("#"+id+"_curReading").css("width","90%");
		$("#"+id+"_curReading").blur(function(){
			curReading = this.value;
			if(curReadingVal==curReading){
				return;
			}
			if(/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(curReading)){
				$.post('<%=basePath%>selfLabelRecord!update.action?id='+id+"&curReading="+curReading+"&date="+date,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("#list").trigger("reloadGrid");
		        	}
				});
			}else{
				showTip("请正确填写上期读数",2000);
				return;
			}
		});
			
	}
	
	
	
	
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>selfLabelRecord!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids==''){
			showTip("请选择表",2000);
			return;
		}
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>selfLabelRecord!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function recordRefresh(){
		$("#list").trigger("reloadGrid");
	}

	function setSelectedMeters(meters){
		var ids = "";
		for(var i = 0; i < meters.length; i++){
			ids += meters[i].id+",";
		}
		ids = deleteLastCharWhenMatching(ids,",");
		$.post("<%=basePath%>selfLabelRecord!addMeter.action?ids="+ids+"&labelId=${result.value.id}&existIds="+$("#ids").val(),function(data){		
			showTip(data.result.msg,2000);
			if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
</script>
</head>

<body>
<div id="container">
<input id="ids" type="hidden"/>
<input id="recordIds" type="hidden"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" valign="top">
				<div class="apptab" id="tableid">
					<ul>
						<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">基本信息</li>
						<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">抄表记录</li>
						<c:if test="${result.value.checkOut eq 'YES'}">
							<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">收费报表</li>
						</c:if>
					</ul>
				</div>
				<div class="pm_msglist tabswitch" id="textname">
				<div class="emailtop">
					<div class="leftemail">
						<ul>
							<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('编辑自用表抄表','<%=basePath%>selfMeterLabel!edit.action?id='+${result.value.id},400,360);"><span><img src="core/common/images/edit.gif" /></span>编辑</li>
				            <li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteMeterLabel(${result.value.id})"><span><img src="core/common/images/emaildel.png" /></span>删除报表</li>
						</ul>
					</div>
				</div>
				<div class="" style="padding:1px 1px 0; border-bottom:1px solid #ddd;">
				    <table width="100%" border="0" cellspacing="0" cellpadding="0">
				      <tr>
				        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
				            <tr>
				            	<td width="100" class="layertdleft100">报表名：</td>
				            	<td class="layerright">${result.value.name}</td>
				           	</tr>
				            <tr>
				            	<td class="layertdleft100">报表类型：</td>
				            	<td class="layerright">${result.value.type.title}</td>
				            </tr>
				            <tr>
				            	<td class="layertdleft100">制表日期：</td>
				            	<td class="layerright"><fmt:formatDate value="${result.value.date}" pattern="yyyy-MM-dd"/></td>
				            </tr>
				            <tr>
				            	<td class="layertdleft100">制表人：</td>
				            	<td class="layerright">${result.value.reader}</td>
				            </tr>
				            <tr>
				          	    <td class="layertdleft100">所在楼宇：</td>
				                <td class="layerright">
					                 <div style=" vertical-align:middle;height:40px;width:450px; overflow-x:hidden; overflow-y:auto;word-break:break-all; word-wrap:break-word;">
					                	${buildingNames}
				                	</div>	
				                </td>
				            </tr>
				            <tr>
				                <td class="layertdleft100" style="height:50px;"> 备注 </td>
				                <td class="layerright">
				                 <div style=" vertical-align:middle;height:40px; overflow-x:hidden; overflow-y:auto;word-break:break-all; word-wrap:break-word;">
				                	${result.value.memo}
				                	</div>
				                </td>
				            </tr>
				          </table>
				        </td>
				      </tr>
				    </table>
 				 </div>	
				</div>
				<div class="pm_msglist tabswitch" style="display: none;">
					<div class="emailtop">
						<div class="leftemail">
							<ul>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="window.open('<%=basePath%>selfLabelRecord!print.action?labelId=${result.value.id}&lableType=${result.value.type}')"><span><img src="core/common/images/print_btn.gif" /></span>打印</li>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('水电表','<%=basePath%>meter!select.action?ids='+$('#ids').val()+'&kind=<%=MeterKindEnum.SELF%>',520,420);"><span><img src="core/common/images/billadd.gif" /></span>追加表</li>
					            <li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected();"><span><img src="core/common/images/emaildel.png" /></span>删除表</li>
					            <li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/bill_05.gif" /></span>生成费用报表</li>
					            <li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="recordRefresh();"><span><img src="core/common/images/refresh2.gif" /></span>刷新</li>
							</ul>
						</div>
					</div>
					<table id="list"><tr><td></td></tr></table>
					<div id="page"></div>
				</div>
				<div class="pm_msglist tabswitch" style="display: none;">
					<div class="emailtop">
						<div class="leftemail">
							<ul>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/emailadd.gif"/></span>审核出账</li>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/edit.gif"/></span>重新生成</li>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/print_btn.gif"/></span>打印</li>
							</ul>
						</div>
					</div>
					<table id="feeList"><tr><td></td></tr></table>
					<div id="feePage"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
