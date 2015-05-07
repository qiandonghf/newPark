<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.wiiy.core.entity.User"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String urlPath = BaseAction.rootLocation+"/";
Date now = new Date();
SimpleDateFormat format = new SimpleDateFormat();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<!-- <meta http-equiv="X-UA-Compatible" content="IE=8" />
<meta http-equiv="X-UA-Compatible" content="IE=5" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
 --><title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/oawork.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/web/panel/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/web/panel/themes/icon.css"/>
<style type="text/css">
		.onlyOne {
			padding:0 19px 0 5px; 
			overflow:hidden; 
			color:#333; 
			text-decoration:none; 
			line-height:22px; 
			cursor:pointer;
			background:url(core/common/images/btn_bg.png);
		}
</style>
<script type="text/javascript" src="core/web/panel/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/web/panel/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initWorkbenchTip();
		initWorkArrangeToSign();
		if($("#desktopGL")!=null){
			changeGL();
		}else if($("#desktopGL")!=null){
			changeGL();
		}
		var height = window.parent.parent.document.documentElement.clientHeight-(window.screenTop-window.parent.parent.screenTop)-60;
		$(".console").css("height",height);
		$('.user_btn .btn .btn-pnt').click(function(){
			$('.user_btn .oaworklist').slideUp();
			$(this).next().stop(true, false).slideDown();
			return false;
		});
	});
	
	function initCount(obj) {
		if(obj.document.getElementById('noticeList')!=null){
			 $.post("<%=BaseAction.rootLocation%>/parkmanager.oa/notice!countNotice.action",function(data){
				 if(data.totalCount==0){
					 obj.document.getElementById('notice').className = "";
				 }else{
					 obj.document.getElementById('notice').innerHTML = data.totalCount;
				 }
			});
		}
		if(obj.document.getElementById('feeTypeList')!=null){
			 $.post("<%=BaseAction.rootLocation%>/parkmanager.pb/bill!countCheckout.action",function(data){
				 if(data.totalCount==0){
					 obj.document.getElementById("feeTypeList").className = "";
				 }else{
					 obj.document.getElementById("feeTypeList").innerHTML = data.totalCount;
				 }		
			});
		} 
		 if(obj.document.getElementById('billList')!=null){
			 $.post("<%=BaseAction.rootLocation%>/parkmanager.pb/bill!settleAccounts.action",function(data){
				 if(data.settleAccounts==0){
					 obj.document.getElementById("billList").className = "";
				 }else{
					 obj.document.getElementById("billList").innerHTML = data.settleAccounts;
				 }
			});
		 }
		 if(obj.document.getElementById('contactList')!=null){
			 $.post("<%=BaseAction.rootLocation %>/parkmanager.pb/customerService!initCustomerView.action",function(data){
				 if(data.yetCustomerServiceCount==0){
					 obj.document.getElementById("contactList").className = "";
				 }else{
					 obj.document.getElementById("contactList").innerHTML = data.yetCustomerServiceCount;
				 }
			});
		 }
		 if(obj.document.getElementById('pm_propertyRepairslist')!=null){
			 $.post("<%=BaseAction.rootLocation %>/parkmanager.pb/propertyFix!countRepairs.action",function(data){
				 if(data.countPropertyRepairs==0){
					 obj.document.getElementById("pm_propertyRepairslist").className = "";
				 }else{
					 obj.document.getElementById("pm_propertyRepairslist").innerHTML = data.countPropertyRepairs;
				 }	
			});
		 }
		 if(obj.document.getElementById('contractCounts')!=null){
			 $.post("<%=BaseAction.rootLocation %>/parkmanager.pb/contract!countDueRemind.action",function(data){
				 if(data.countDueRemind==0){
					 obj.document.getElementById("contractCounts").className = "";
				 }else{
					 obj.document.getElementById("contractCounts").innerHTML =data.countDueRemind;
				 }
			});
		 }
		 if(obj.document.getElementById('archivesCounts')!=null){
			 $.post("<%=BaseAction.rootLocation %>/parkmanager.oa/archives!countExpire.action",function(data){
				 if(data.countExpire==0){
					 obj.document.getElementById("archivesCounts").className = "";
				 }else{
					 obj.document.getElementById("archivesCounts").innerHTML = data.countExpire;
				 }
			});
		 }
		<%--  if(obj.document.getElementById('reportCounts')!=null){
		 	$.post("<%=BaseAction.rootLocation %>/parkmanager.edi/report!loadReportCount.action",function(data){
		 		if(data.result!=null && data.result.success){
		 			if(data.result.value==0){
			 			obj.document.getElementById("reportCounts").className = "";
		 			}else{
			 			obj.document.getElementById("reportCounts").innerHTML = data.result.value;
		 			}
		 		}else{
		 			obj.document.getElementById("reportCounts").className = "";
		 			showTip("数据上报远程调用失败",2000);
		 		}
		 	});
		 } --%>
		 if(document.getElementById('deviceReportCounts')!=null){
			 	$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/deviceManagement!loadDeviceCount.action",function(data){
			 		if(data.totalCount==0){
			 			obj.document.getElementById("deviceReportCounts").className = "";
			 		}else{
			 			obj.document.getElementById("deviceReportCounts").innerHTML = data.totalCount;
			 		}
			 	});
			 }
	}
	function initWorkbenchTip(){
		$(".dataUrl").each(function(){
			var _this = $(this);
			$.post(_this.val(),function(data){
				if(data.result!=null){
					if(data.result.success){
						_this.next().find("span").text(data.result.value);
					}
				}
			});
		});
	}
	
	function initWorkArrangeToSign(){
		$(".workArrangeUrl").each(function(){
			var _this = $(this);
			$.post(_this.val(),function(data){
				var rest = data.result.value.rest;
				var workClassList = data.result.value.workClassList;
				if(rest==null && workClassList==null){
					$(".btn-pnt").attr("class","onlyOne");//去掉下拉箭头的样式
					$("#signin").click(function(){
						showTip('没有设置缺省班制或者没有排班',2000);
					});
					$("#signout").click(function(){
						showTip('没有设置缺省班制或者没有排班',2000);
					});
				}else{
					var signInWorkClassList = "";
					var signOutWorkClassList = "";
					if(rest==null){
						if(data.result.value.workClassList.length==2){
							//如果只有一个班次，则不显示，直接签到或者签退
							$(".btn-pnt").attr("class","onlyOne");//去掉下拉箭头的样式
							var workClassId = workClassList[0].id;
							var workClassName = workClassList[0].name;
							
							$("#signin").click(function(){
								signInWorkClass(workClassId,workClassName);
							});
							$("#signout").click(function(){
								signOutWorkClass(workClassId,workClassName);
							});
						}else{
							$("#sign2").append("<ul id='signLi2'></ul>");
							$("#sign1").append("<ul id='signLi1'></ul>");
							for(var i=0;i<workClassList.length;i++){
								var workClassId = workClassList[i].id;
								var workClassName = workClassList[i].name;
								var flag = workClassList[i].isSign;
								var type = workClassList[i].type.title;
								if(type=='签到'){
									if(flag){
										signInWorkClassList += "<li class='on'><a href='javascript:void(0)' onclick='signInWorkClass("+workClassId+",\""+workClassName+"\");'>"+workClassName+"</a></li>";
									}else{
										signInWorkClassList += "<li><a href='javascript:void(0)' onclick='signInWorkClass("+workClassId+",\""+workClassName+"\");'>"+workClassName+"</a></li>";
									}
								}	
								if(type=='签退'){
									if(flag){
										signOutWorkClassList += "<li class='on'><a href='javascript:void(0)' onclick='signOutWorkClass("+workClassId+",\""+workClassName+"\");'>"+workClassName+"</a></li>";
									}else{
										signOutWorkClassList += "<li><a href='javascript:void(0)' onclick='signOutWorkClass("+workClassId+",\""+workClassName+"\");'>"+workClassName+"</a></li>";
									}
								}
							}
							$("#signLi1").append(signInWorkClassList);
							$("#signLi2").append(signOutWorkClassList);
						}
					}else{
						$(".btn-pnt").attr("class","onlyOne");//去掉下拉箭头的样式
						$("#signin").click(function(){
							showTip('今天休息，不需要签到',2000);
						});
						$("#signout").click(function(){
							showTip('今天休息，不需要签退',2000);
						});
					}
				}
			});
		});
	}
	
	function signInWorkClass(workClassId,workClassName){
		if(confirm("班次为"+workClassName+",确定要签到吗？")){
			$.post("<%=BaseAction.rootLocation %>/parkmanager.oa/userSign!signIn.action?workClassId="+workClassId,function(data){
	        	if(data.result.success){
	        		showTip('签到成功',2000);
	        	}else{
	        		showTip(data.result.msg,2000);
	        	}
			});
		}
	}
	function signOutWorkClass(workClassId,workClassName){
		if(confirm("班次为"+workClassName+",确定要签退吗？")){
			$.post("<%=BaseAction.rootLocation %>/parkmanager.oa/userSign!signOut.action?workClassId="+workClassId,function(data){
	        	if(data.result.success){
	        		showTip('签退成功',2000);
	        	}else{
	        		showTip(data.result.msg,2000);
	        	}
			});
		}
	}
	function myAddTab(topWindow,plugin,url,iconUrl){
		var tabs = topWindow.$('#tt');
		if (tabs.tabs('exists',plugin)){
			tabs.tabs('select', plugin);
			var tab = tabs.tabs('getSelected');
			tabs.tabs('update', {
				tab: tab,
				options: {
					content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>'
				}
			});
			var span = tabs.find("span:contains('"+plugin+"')");
			span.addClass("tabs-with-icon");
		} else {
			var icon = topWindow.$(".tt:contains('"+plugin+"')").prev().find("img").attr("src");
			if(typeof(icon) == "undefined"){
				icon = iconUrl;
			}
			tabs.tabs('add',{
				title:plugin,
				iconCls:'icon-reload',
				content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>',
				closable:true
			});
			var span = tabs.find("span:contains('"+plugin+"')");
			span.next().css("background","url('"+icon+"') no-repeat");
		}
	}
	
	function changeSrc(idValue,obj){
		if("notice"==idValue){
			noticeList();
		}
		if("bill_out"==idValue){
			feeTypeList();
		}
		if("bill_out_list"==idValue){
			billOutList();
		}
		if("contact"==idValue){
			contactList();
		}
		if("report"==idValue){
			propertyFixList();
		}
		if("log"==idValue){
			logList();
		}
		if("contractCounts"==idValue){
			contractList();
		}
		if("enter"==idValue){
			enterList();
		}
		if("staffExpire"==idValue){
			staffExpireList();
		}
		/* if("report"==idValue){
			reportList();
		} */
		//设备提报
		if("deviceReport"==idValue){
			deviceReportList();
		}
		var $div_li = $("#console-menu li");
		$(obj).addClass("on").siblings().removeClass("on");
		var index = $div_li.index(obj);
		$("#console-cont-list .li").eq(index).show().siblings().hide();
	}
	
	
	function generateDate(time){
		var year = time.substr(0,4);
		var month = time.substr(5,2)-1;
		var day = time.substr(8,2);
		return new Date(year,month,day);
	}
	
	function nowDate(){
		var y = new Date().getFullYear();
		var m = new Date().getMonth();
		var d = new Date().getDate();
		return new Date(y,m,d);
	}
	
	//设备提报
	function deviceReportList(){
		$("#deviceList").empty();
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/deviceManagement!listDesktop.action",function(data){
			var deviceList = data.deviceList;
			var typeList = data.checkType;
			if(deviceList!=null){
				var deviceLi = "";
				for(var i=0;i<deviceList.length;i++){
					var device = deviceList[i];
					var type = typeList[i];
					var li = "<li>";
					var a = '';
					var span = '';
					if('巡检' == type){
						var patrolTime = device.patrolTime;
						if(patrolTime == null)
							patrolTime = device.lastPatrolTime;
						a ="<a href=\"javascript:void(0)\" onclick=\"fbStart('编辑设备'+type,'<%=BaseAction.rootLocation %>/parkmanager.pb/deviceManagement!edit.action?id="+device.id+"',770,498);\">【"+device.name+"】需在"+patrolTime.substr(0,10)+" 进行巡检</a>&nbsp;";
						if(generateDate(patrolTime) < nowDate())
							span = "<span style=\"color:#f00;\">巡检日期已过期</span>"
						else
							span = "<span class=\"cor_999\">巡检日期未过期</span>"
					}else if('年检' == type){
						a ="<a href=\"javascript:void(0)\" onclick=\"fbStart('编辑设备'+type,'<%=BaseAction.rootLocation %>/parkmanager.pb/deviceManagement!edit.action?id="+device.id+"',770,498);\">【"+device.name+"】需在"+device.yearlyTime.substr(0,10)+" 进行年检</a>&nbsp;";
						if(generateDate(device.yearlyTime) < nowDate())
							span = "<span style=\"color:#f00;\">年检日期已过期</span>"
						else
							span = "<span class=\"cor_999\" sytle=\"color:red;\">年检日期未过期</span>"
					}
					li += a+span+"</li>";
					deviceLi+=li;
				}
				$("#deviceList").append(deviceLi);
			}
		});
	}
	
	function reportList(){
		$("#reportList").empty();
		$("#reportListMore").empty();
		showTip("数据上报加载中...",200000);
		$.post("<%=BaseAction.rootLocation %>/parkmanager.edi/report!list.action",function(data){
			if(data.result!=null && data.result.success){
				var url = data.url; 
				var reportList = data.result.value;
				var reportLi = "";
				for(var i = 0;i<reportList.length;i++){
					var li = "";
					var id = reportList[i].id;
					var name = reportList[i].name;
					var yearNo = reportList[i].yearNo;
					var endTime = reportList[i].endTime;
					var type = reportList[i].type._name;
					var expired = reportList[i].expired;
					li = "<li>"+yearNo+"年&nbsp;";
					if(expired=='3'){
						li += "<a href='javascript:void(0)' onclick='alert(\"报表已过期\");'>";
					}else{
						li += "<a href='<%=urlPath%>parkmanager.edi/report!reportById.action?id="+id+"&&type="+type+"' target=\"_blank\">";
					}
					li += "<font color='blue'>"+name+"</font></a>&nbsp;";
					if(endTime!=null && endTime!=''){
						li += "截止日期："+endTime+"&nbsp;";
					}
					if(expired=='2'){
						li += "<span style='color:#9B30FF;'>即将过期</span>"
					}else if(expired=='3'){
						li += "<span style='color:red;'>已过期</span>"
					}
					li +="</li>";
					reportLi+=li;
				}
				showTip("数据上报远程调用成功",2000);
				$("#reportList").append(reportLi);
				var a = "<a href='"+url+"' target=\"_blank\" title='' >查看更多&gt;&gt;</a>";
				$("#reportListMore").append(a);
			}else{
				showTip("数据上报远程调用失败",2000);
				$("#reportList").append("<span style='color:red'>数据上报远程调用失败</span>");
			}
		});
	}
	
	function noticeList(){
		$("#noticeList").empty();
		$.post("<%=BaseAction.rootLocation %>/parkmanager.oa/notice!listDesktop.action",function(data){
			 if(data.undList!=null){
				var noteList = data.undList;
				var noteLi = "";
				for(var i = 0;i<noteList.length;i++){
					var li = "";
					var id = noteList[i].id;
					var time = noteList[i].issueTime.substring(0,10);
					var name = noteList[i].name;
					var date = (new Date).format("yyyy-MM-dd");
					var userView = noteList[i].userView;
					if(userView=="YES"){
						li = "<li><a href='<%=urlPath%>parkmanager.oa/notice!view.action?id="+id+"' target=\"_blank\" ><font color='blue'>"+name+"</font></a>&nbsp;<span class='cor_999'>"+time+"</span>";
					}else{
						li = "<li><a href='<%=urlPath%>parkmanager.oa/notice!view.action?id="+id+"' target=\"_blank\" ><font color='black'>"+name+"</font></a>&nbsp;<span class='cor_999'>"+time+"</span>";
					}
					/* if(date==time){
						li = li+"<img src='core/common/images/5-120601152050-51.gif'>";
					} */
					li = li+"</li>";
					noteLi+=li;
				}
				$("#noticeList").append(noteLi);
			 }
		});
	}
	function feeTypeList(){
		$.post("<%=BaseAction.rootLocation%>/parkmanager.pb/bill!checkout2.action",function(data){
			 $("#rentDay").text(data.rentDay+"天");
			 $("#depositDay").text(data.depositDay+"天");
			 $("#facilityDay").text(data.facilityDay+"天");
			 if(data.deposit!=null){
				 $("#deposit").text(data.deposit);
			 }
			 if(data.facilitySum!=null){
				 $("#facilitySum").text(data.facilitySum);
			 }
			 var feeTypeMap = data.feeTypeMap;
			 $("#manage").text(0);
			 $("#rent").text(0);
			 $("#energy").text(0);
			 if(feeTypeMap!=null){
				 if(feeTypeMap["MANAGE"]!=null){
					 $("#manage").text(feeTypeMap["MANAGE"]);
				 }
				 if(feeTypeMap["RENT"]!=null){
					 $("#rent").text(feeTypeMap["RENT"]);
				 }
				 if(feeTypeMap["ENERGY"]!=null){
					 $("#energy").text(feeTypeMap["ENERGY"]);
				 }
			 }
			 var map = data.facilityMap;
			 $("#feeDeList").empty();
			 var feeLi = "";
			 if(map!=null){
				for(var key in map){
					var li = "<li>"+key+"<strong class=\"cor_f00\">"+map[key]+"</strong>条</li>";
					feeLi += li;
				}
			 }
			 $("#feeDeList").append(feeLi);
		});
	}
	function billOutList(){
		$.post("<%=BaseAction.rootLocation%>/parkmanager.pb/bill!listBillOnDesktop.action",function(data){
			$("#billCountIn").text(data.billCountIn);
			$("#receiveCount").empty();
			var receiveCount = "￥"+data.receiveCount.toFixed(2);
			$("#receiveCount").append(receiveCount);
			$("#billCountOut").text(data.billCountOut);
			$("#payCount").empty();
			var payCount = "￥"+data.payCount.toFixed(2);
			$("#payCount").append(payCount);
			var inList = data.inDtoList;
			var outList = data.outDtoList;
			$("#billInList").empty();
			$("#billOutList").empty();
			if(inList!=null){
				var inLi = "";
				for(var i = 0;i<inList.length;i++){
					var time = "";
					if(inList[i].createTime!=null){
						time = inList[i].createTime.substring(0,10);
					}
					var a = "<a href=\"javascript:void(0)\" onclick=\"parent.addTab(parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action?id="+inList[i].billId+"')\">"+inList[i].billType+"（"+time+"）</a>&nbsp;";
					var span = "<span class=\"cor_f00\">￥"+inList[i].moneyPerBill.toFixed(2)+"</span>&nbsp;<span class=\"cor_999\">"+inList[i].customerName+"</span>";
					var li = "<li>"+a+span+"</li>";
					inLi+=li;
				}
				$("#billInList").append(inLi);;
			}
			if(outList!=null){
				var outLi = "";
				for(var i = 0;i<outList.length;i++){
					var time = "";
					if(outList[i].createTime!=null){
						time = outList[i].createTime.substring(0,10);
					}
					var a = "<a href=\"javascript:void(0)\" onclick=\"parent.addTab(parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action?id="+outList[i].billId+"')\">"+outList[i].billType+"（"+time+"）</a>&nbsp;";
					var span = "<span class=\"cor_f00\">￥"+outList[i].moneyPerBill.toFixed(2)+"</span>&nbsp;<span class=\"cor_999\">"+outList[i].customerName+"</span>";
					var li = "<li>"+a+span+"</li>";
					outLi+=li;
				}
				$("#billOutList").append(outLi);
			}
		});
	}
	function contactList(){
		$("#customerServiceList").empty();
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/customerService!initCustomerService.action",function(data){
			var list = data.result.value; 
			if(list!=null){
				var serviceLi = "";
				for(var i = 0;i<list.length;i++){
					var li = "";
					if(list[i].status._name=='ACCEPT'){
						li+="<li class=\"sign_04\">";
					}
					if(list[i].status._name=='PENDING'){
						li+="<li class=\"sign_02\">";
					}
					if(list[i].status._name=='CLOSE'){
						li+="<li class=\"sign_01\">";
					}
					var span = "<span class=\"cor_999\">["+list[i].type.moduleName+"]</span>";
					var a = "<a href=\"javascript:void(0)\" class=\" margin_left_10\" onclick=\"fbStart('联系单查看','<%=BaseAction.rootLocation %>/parkmanager.pb/customerService!view2.action?id="+list[i].id+"',700,400)\">"+list[i].customer.name+"</a>";
					var res = "";
					if(list[i].result._name=='SOLVED'){
						res = "已完成";
					}
					if(list[i].result._name=='UNSOLVE'){
						res = "未完成";
					}
					if(list[i].result._name=='PartSOLVED'){
						res = "部分完成";
					}
					var span2 = "<span class=\"cor_999 margin_left_10\">"+res+"</span>&nbsp;";
					var span3 = "<span class=\"cor_999 margin_left_10\">"+list[i].createTime.substring(0,10)+"</span>";
					li += span+a+span2+span3+"</li>";
					serviceLi += li;
				}
				$("#customerServiceList").append(serviceLi);
			}
		});
	}
	function propertyFixList(){
		$("#propertyFixList").empty();
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/propertyFix!workBenchPropertyFixList.action",function(data){
			var list = data.propertyFixList; 
			if(list!=null){
				var propertyFixLi = "";
				for(var i=0;i<list.length;i++){
					var pf = list[i];
					var li = "";
					if(pf.status._name=="HANGUP"){
						li+="<li class='sign_02'>";
					}
					if(pf.status._name=="HANGIN"){
						li+="<li class='sign_04'>";
					}
					if(pf.status._name=="FINISHED"){
						li+="<li class='sign_01'>";
					}
					if(pf.status._name=="UNSTART"){
						li+="<li class='sign_03'>";
					}
					var reportReason = pf.reportReason.substring(0,10);
					var a = "<a href=\"javascript:void(0);\" onclick=\"fbStart('查看物业保修单','<%=BaseAction.rootLocation %>/parkmanager.pb/propertyFix!handleDesktop.action?id="+pf.id+"',800,230)\">"+reportReason+"</a>";
					var reporter = "";
					if(pf.reporter!=null){
						reporter = pf.reporter;
					}
					var span = "<span class=\"cor_999\">("+reporter+")</span>";
					var span2 = "<span class=\"cor_999 margin_left_10\">"+pf.reportTime.substring(0,10)+"</span>";
					li += a+span+span2+"</li>";
					propertyFixLi += li;
				}
				$("#propertyFixList").append(propertyFixLi);
			}
		});
	}
	function logList(){
		$("#parkLogList").empty();
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/dataReport!getParkLog.action",function(data){
			var parkLogList = data.parkLogList;
			if(parkLogList!=null){
				var parkLogLi = "";
				for(var i=0;i<parkLogList.length;i++){
					var parkLog = parkLogList[i];
					var li = "<li>【"+parkLog.logType+"】";
					var a = "";
					var span = "";
					var logData ="";
					if(logData.length>12){
						logData = parkLog.logData.substring(0,12)+"...";
					}else{
						logData = parkLog.logData;
					}
					if(parkLog.logType=='数据填报'){
						a = "<a onclick=\"fbStart('填报数据','<%=BaseAction.rootLocation %>/parkmanager.pb/dataReportToCustomer!editLog.action?id="+parkLog.id+"',620,440,false)\" href=\"javascript:void(0)\" >"+logData+"</a>&nbsp;";
					}
					if(parkLog.logType=='招商跟进'){
						a = "<a onclick=\"fbStart('招商跟进','<%=BaseAction.rootLocation %>/parkmanager.pb/investmentLog!editLog.action?id="+parkLog.id+"',500,295)\" href=\"javascript:void(0)\" >"+logData+"</a>&nbsp;";
					}
					if(parkLog.logType=='客户信息更新变化'){
						a = "<a onclick=\"fbStart('客户信息更新变化','<%=BaseAction.rootLocation %>/parkmanager.pb/customerModifyLog!editLog.action?id="+parkLog.id+"',500,150)\" href=\"javascript:void(0)\" >"+logData+"</a>&nbsp;";
						
					}
					var logCustomer = "";
					if(parkLog.logCustormer!=null){
						logCustomer = parkLog.logCustormer;
					}
					span = "<span class=\"cor_999\">"+logCustomer+"</span>&nbsp;<span class=\"cor_999\">"+parkLog.logTime.substring(0,10)+"</span>";
					li += a+span+"</li>";
					parkLogLi+=li;
				}
				$("#parkLogList").append(parkLogLi);
			}
		});
	}
	function contractList(){
		$("#contractList").empty();
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/contract!dueRemind.action",function(data){
			var contractList = data.contractList;
			if(contractList!=null){
				var contractLi = "";
				for(var i=0;i<contractList.length;i++){
					var contract = contractList[i];
					var li = "<li>";
					var a ="<a href=\"javascript:void(0)\" onclick=\"fbStart('查看合同','<%=BaseAction.rootLocation %>/parkmanager.pb/contract!view.action?id="+contract.id+"',765,467);\">【"+contract.item.title+"】"+contract.endDate.substring(0,10)+" 到期</a>&nbsp;";
					var name = "";
					if(contract.customer.shortName>0){
						name = contract.customer.shortName;
					}else{
						name = contract.customer.name;
					}
					var span = "<span class=\"cor_999\">"+name+"</span>";
					li += a+span+"</li>";
					contractLi+=li;
				}
				$("#contractList").append(contractLi);
			}
		});
	}
	function enterList(){
		$("#customerList").empty();
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/customer!workBenchCustomerList.action",function(data){
			var customerList = data.result.value;
			if(customerList!=null){
				var customerLi = "";
				for(var i=0;i<customerList.length;i++){
					var customer = customerList[i];
					var li = "<li>";
					var title = "<strong>";
					if("INPARK"==customer.parkStatus._name){
						title += "入驻企业：</strong>";
					}
					if("OUTPARK"==customer.parkStatus._name){
						title += "迁出企业：</strong>";
					}
					var a = "<a href=\"javascript:void(0)\" onclick=\"fbStart('查看企业档案','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!view.action?id="+customer.id+"',890,460);\">"+customer.name+"</a>&nbsp;";
					li += title+a+"</li>";
					customerLi+=li;
				}
				$("#customerList").append(customerLi);
			}
		});
	}
	function staffExpireList(){
		$("#staffExpireList").empty();
		$.post("<%=BaseAction.rootLocation %>/parkmanager.oa/archives!listDesktop.action",function(data){
			var staffExpireList = data.list;
			if(staffExpireList!=null){
				var staffExpireLi = "";
				for(var i=0;i<staffExpireList.length;i++){
					var archives = staffExpireList[i];
					var li = "<li>";
					var a = "<a href=\"javascript:void(0)\" onclick=\"fbStart('查看员工档案','<%=BaseAction.rootLocation %>/parkmanager.oa/archives!view.action?id="+archives.id+"',710,483);\">"+archives.name+"</a>&nbsp;";
					var span = "<span class=\"cor_999\">"+archives.endTime.substring(0,10)+"</span>";
					li += a+span+"</li>";
					staffExpireLi+=li;
				}
				$("#staffExpireList").append(staffExpireLi);
			}
		});
	}
	function initWorkBench(obj){
		if(obj.document.getElementById("noticeList")!=null){
			noticeList();
			
			return;
		}
		if(obj.document.getElementById("feeDeList")!=null){
			feeTypeList();
			
			return;
		}
		if(obj.document.getElementById("billInList")!=null){
			billOutList();
			
			return;
		}
		if(obj.document.getElementById("customerServiceList")!=null){
			contactList();
			
			return;
		}
		if(obj.document.getElementById("propertyFixList")!=null){
			propertyFixList();
			
			return;
		}
		if(obj.document.getElementById("parkLogList")!=null){
			logList();
			
			return;
		}
		if(obj.document.getElementById("contractList")!=null){
			contractList();
			
			return;
		}
		if(obj.document.getElementById("customerList")!=null){
			enterList();
			
			return;
		}
		if(obj.document.getElementById("staffExpireList")!=null){
			staffExpireList();
			
			return;
		}
		if(obj.document.getElementById("deviceReportList")!=null){
			deviceReportList();
			return;
		}
	}
	
	//desktopGK
	function initViewCustomer(){
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/customer!initRZKH.action",function(data){
			if(data.result.success){
				if(data.result.value!=null){
					var length = data.result.value.length;
					if(length>=6){
					 for(var i=0;i<6;i++){
						$("#list_2>li:eq("+i+")>a").html(data.result.value[i][1]);
						var id =data.result.value[i][0];
						$("#list_2>li:eq("+i+")>a").attr("id",id);
						var time = data.result.value[i][2];
						if(time!=null){
							time = time.replace(/-/g,"/");
							time = time.replace("T"," ");
							var date = new Date(time);
							date = date.format('yyyy/MM/dd');
							$("#list_2>li:eq("+i+")>span").html(date);
							} 
						}
					}else{
						 for(var i=0;i<length;i++){
								$("#list_2>li:eq("+i+")>a").html(data.result.value[i][1]);
								var id =data.result.value[i][0];
								$("#list_2>li:eq("+i+")>a").attr("id",id);
								var time = data.result.value[i][2];
								if(time!=null){
									time = time.replace(/-/g,"/");
									time = time.replace("T"," ");
									var date = new Date(time);
									date = date.format('yyyy/MM/dd');
									$("#list_2>li:eq("+i+")>span").html(date);
								}
							} 
						for(var j=5;j>length-1;j--){
							$("#list_2>li:eq("+j+")").attr("style","display:none");
						}
						
					}
				}
			}
		});
	}
	function initViewInvestment(){
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/investment!initZSXM.action",function(data){
			if(data.result.success){
				var length = data.result.value.length;
				if(length>=6){
				 for(var i=0;i<6;i++){
					$("#list_1>li:eq("+i+")>a").html(data.result.value[i][1]);
					var id =data.result.value[i][0];
					$("#list_1>li:eq("+i+")>a").attr("id",id);
					var time = data.result.value[i][2];
					time = time.replace(/-/g,"/");
					time = time.replace("T"," ");
					var date = new Date(time);
					date = date.format('yyyy/MM/dd');
					$("#list_1>li:eq("+i+")>span").html(date);
					} 
				}else{
					for(var i=0;i<length;i++){
						$("#list_1>li:eq("+i+")>a").html(data.result.value[i][1]);
						var id =data.result.value[i][0];
						$("#list_1>li:eq("+i+")>a").attr("id",id);
						var time = data.result.value[i][2];
						if(time!=null){
							time = time.replace(/-/g,"/");
							time = time.replace("T"," ");
							var date = new Date(time);
							date = date.format('yyyy/MM/dd');
							$("#list_1>li:eq("+i+")>span").html(date);
						}
						
					} 
					for(var j=5;j>length-1;j--){
						$("#list_1>li:eq("+j+")").attr("style","display:none");
					}
				}
			}
		});
	}
	
	function openInvestment(obj){
		var id = $(obj).attr("id");
		fbStart('查看项目','<%=BaseAction.rootLocation %>/parkmanager.pb/investment!view.action?id='+id,800,470);
	}
	function openCustomer(obj){
		var id = $(obj).attr("id");
		fbStart('查看企业','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!view.action?id='+id+'& desktop =true',890,460);
	}

	function initParkSituationData(){
		$(".generalSituationOfParkUrl").each(function(){
			var _this = $(this);
			$.post(_this.val(),function(data){
				 var parkSituationDtoList = data.result.value;
				 if(parkSituationDtoList.length>0){
					 var parkSituations = "";
					 for(var i=0;i<parkSituationDtoList.length;i++){
					    var buildingId = parkSituationDtoList[i].buildingId;//楼宇id
						var parkBuildingName  = parkSituationDtoList[i].parkBuildingName;//楼宇园区名称
						var buildingPhotos = parkSituationDtoList[i].photos;//楼宇图片
						var usageRates  = parkSituationDtoList[i].usageRates;//使用率
						var occupancy  = parkSituationDtoList[i].occupancy;//出租率
						var customerNumber  = parkSituationDtoList[i].customerNumber;//入驻企业数
						var customerIds = parkSituationDtoList[i].customerIds;//入驻企业的Ids
						var dueNumber = parkSituationDtoList[i].dueNumber;//即将到期数
						var contractIds = parkSituationDtoList[i].contractIds;//到期的和逾期的合同Ids
						var billIds = parkSituationDtoList[i].billIds; //逾期未缴的账单Ids
						var arrearsNumber  = parkSituationDtoList[i].arrearsNumber;//欠费数
						var customerNumberInParkUrlClick = "myAddTab(parent.parent.parent,'企业信息','<%=BaseAction.rootLocation %>/parkmanager.pb/web/client/customer_list_onDesktop.jsp?customerIds="+customerIds+"','parkmanager.pb/web/images/icon/client_01_min.png')";
						var dueNumberUrlClick = "myAddTab(parent.parent.parent,'合同信息','<%=BaseAction.rootLocation %>/parkmanager.pb/web/contract/contract_list_ondesktop.jsp?contractIds="+contractIds+"','parkmanager.pb/web/images/icon/contract_03_min.png')";
						var arrearsNumberUrlClick = "myAddTab(parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action?billIds="+billIds+"','parkmanager.pb/web/images/icon/account_02_min.png')";
						var buildingViewClick =  "myAddTab(parent.parent.parent,'楼宇信息','<%=BaseAction.rootLocation %>/parkmanager.pb/building!view.action?id="+buildingId+"','parkmanager.pb/web/images/icon/building_01_min.png')";
						parkSituations+="<li class='feeLi'><img src="+buildingPhotos+" class='img' onclick="+buildingViewClick+"><dl class='buildingDetail'><dt>"+parkBuildingName+"</dt>"
										 +"<dd class='about'><div class='li'><p>使用率：</p><div class='sche'><div style='width:"+usageRates+"%;'></div></div></div><div class='li'>"
										 +"<p>出租率：</p><div class='sche'><div style='width:"+occupancy+"%;'></div></div></div></dd>"
										 +"<dd class='feeResult'>入驻企业（<a href='javascript:void(0)' title='' onclick="+customerNumberInParkUrlClick+">"+customerNumber+"</a>）&nbsp;&nbsp;&nbsp;&nbsp;"
										 +"即将到期（<a href='javascript:void(0)' title='' onclick="+dueNumberUrlClick+">"+dueNumber+"</a>）&nbsp;&nbsp;&nbsp;&nbsp;"
										 +"欠费账单（<a href='javascript:void(0)' title='' onclick="+arrearsNumberUrlClick+">"+arrearsNumber+"</a>）</dd></dl></li>";
					 }
					 $("#parkSituations").append(parkSituations);
				 }
			});
		});
	}
		function countCollection(){
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/customerService!initCustomerView.action",function(data){
				$("#console-menu>li:eq(2)").find("i").html(data.yetCustomerServiceCount);
			
		});
	}
	
	function countRepairs(){
		$.post("<%=BaseAction.rootLocation %>/parkmanager.pb/propertyFix!countRepairs.action",function(data){
			$("#console-menu>li:eq(3)").find("i").html(data.countPropertyRepairs);
		
	});
	}
	function changeGK(){
		var tabclass = "gWel-main-recommand-nav-a-on";
		if(!$("#desktopGK").hasClass(tabclass)){
			$("#desktopGK").addClass(tabclass).siblings().removeClass(tabclass);;
		}
		$("#pGL").panel("close");
		$("#pGK").panel("open");
		$("#pGK").panel({
			href:'<%=basePath%>index!desktopGK.action',
			onLoad:function(){
				initParkSituationData($('#pGK')[0]);
				initViewCustomer();
				initViewInvestment();
				countCollection();
				countRepairs();
		    }
		});
	}
	function changeGL(){
		var tabclass = "gWel-main-recommand-nav-a-on";
		if(!$("#desktopGL").hasClass(tabclass)){
			$("#desktopGL").addClass(tabclass).siblings().removeClass(tabclass);;
		}
		$("#pGK").panel("close");
		$("#pGL").panel("open");
		$('#pGL').panel({
		    href:'<%=basePath%>index!desktopGL.action',
		    onLoad:function(){
		    	initCount($('#pGL')[0]);
		    	initWorkBench($('#pGL')[0]);
		    }
		});
	}
</script>
</head>

<body>
	
<div class="console" style="overflow-y:auto; overflow-x:hidden">
	<div class="consoleRt">
    	<jsp:include page="tj.jsp" />
    </div>
	<div class="consoleLt">
    	<jsp:include page="top.jsp" />
       <div class="gWel-main-recommand" style="width: 95%;margin: 0px;">
       		<div id="bigDiv" class="consoleLt" style="overflow-y:auto; overflow-x:hidden;width: 100%;padding: 0px">
				<div class="gWel-main-recommand">
					<div class="gWel-main-recommand-nav">
			       		<div class="gWel-main-recommand-nav-borderBottom"></div>
			            <%int flag = 0; %>
			            <c:if test="${not empty accessibleModuleMenuIds['park_info']}">
			            	<%flag=1; %>
				            <div id="desktopGL" class="gWel-main-recommand-nav-a gWel-main-recommand-nav-a-on" onclick="changeGL();">
				            	<div class="gWel-main-recommand-nav-aText" >园区管理</div>
				            </div>
			            </c:if>
			            <c:if test="${not empty accessibleModuleMenuIds['park_profile']}">
				        	<div id="desktopGK" class="gWel-main-recommand-nav-a <%if(flag==0){ %>gWel-main-recommand-nav-a-on<%} %>" onclick="changeGK();">
				            	<div class="gWel-main-recommand-nav-aText" >园区概况</div>
				            </div>
			            </c:if>
			        </div>
			        <div id="pGL" class="easyui-panel" style="border: 0px;">
		        	</div>
		        	<div id="pGK" class="easyui-panel" style="border: 0px;"></div>
				</div>
			</div>
       </div>
    </div>
</div>
</body>
</html>
