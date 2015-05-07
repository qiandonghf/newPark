<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.commons.preferences.enums.SendTimeTypeEnum"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" type="text/css" href="core/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.oa/web/style/cord_icon.css"/>

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#container").css("width",width);
		$("#tree").css("height",getTabContentHeight()-152);
		loadTree();
		initTip();
		SendSms();
		loadSmsTemplate();
		initDate(document.form1.select_year,document.form1.select_month,document.form1.select_day);
	});
	
	function initDate(year,month,day){
		//每个月的初始天数   
		MonDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];   
		//当前的年份   
		var y = new Date().getFullYear();   
		//当前的月份   
		var m = new Date().getMonth()+1; //javascript月份为0-11   
		//但前的天份   
		var d = new Date().getDate();   
		//以今年为准，向后2年，填充年份下拉框   
		for (var i = y; i < (y+3); i++){   
			year.options.add(new Option(i,i));   
        }   
        //选中今年   
        year.value=y;
        //填充月份下拉框   
		for (var i = 1; i <= 12; i++){   
            month.options.add(new Option(i,i));   
        }   
        //选中当月   
        month.value = m;  
		//获得当月的初始化天数   
        var n = MonDays[m-1];   
        //如果为2月，天数加1   
        if (m == 2 && isLeapYear(year.options[year.selectedIndex].value))   
          		n++;   
        	//填充日期下拉框   
            createDay(n,day);    
            //选中当日   
            day.value = new Date().getDate();   
		
	}
	
	function createDay(n,day){   
	 	//填充日期下拉框   
		//清空下拉框   
		clearOptions(day);   
		//几天，就写入几项   
		for(var i=1; i<=n; i++){   
		day.options.add(new Option(i,i));   
		}   
	}   
  	function clearOptions(ctl){   
  		//删除下拉框中的所有选项   
        for(var i=ctl.options.length-1; i>=0; i--){   
			ctl.remove(i);   
		}   
	}   
  	function isLeapYear(year){    
  		//判断是否闰年   
		return( year%4==0 || (year%100 ==0 && year%400 == 0));   
	}   
	
  	function change(year,month,day){   
		var y = year.options[year.selectedIndex].value;   
		var m = month.options[month.selectedIndex].value;   
		var n = MonDays[m - 1];   
		if ( m ==2 && isLeapYear(y)){   
			n++;   
		}
			createDay(n,day);   
		}
  	
	function SendSms(){
		var height = getTabContentHeight()-80;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-5;
		$("#notSendSms").jqGrid({
			url:'<%=basePath%>sms!list.action?type=notsend',
			colModel: [
			    {label:'发信人',width:110, name:'creator', align:"center"},
			    {label:'收信人',width:110, name:'receivers', align:"center",formatter:receivers}, 
			    {label:'时间',width:140, name:'sendTime',formatter:'date',formatoptions:{srcformat:'Y-m-d H:i',newformat:'Y-m-d H:i'}, align:"center"},
			    {label:'内容', name:'content', align:"left", formatter:subcontent,width:400},
			    {label:'管理',width:50, name:'manager', align:"center", sortable:false, resizable:false}
			],
			shrinkToFit: false,
			height: height,
			width: width,
			multiselect: false,
			pager: '#pager1',
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%
					Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
					boolean send = OaActivator.getHttpSessionService().isInResourceMap("oa_sendMessage_send");
					boolean delete = OaActivator.getHttpSessionService().isInResourceMap("oa_sendMessage_del");
					%>
					<%if(delete){%>
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"取消\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%}%>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager1',{add: false, edit: false, del: false, search: false});
		
		$("#SendSms").jqGrid({
			url:'<%=basePath%>sms!list.action?type=send',
			colModel: [
			    {label:'发信人',width:110, name:'creator', align:"center"},
			    {label:'收信人',width:110, name:'receivers', align:"center",formatter:receivers}, 
			    {label:'时间',width:140, name:'sendTime',formatter:'date',formatoptions:{srcformat:'Y-m-d H:i',newformat:'Y-m-d H:i'}, align:"center"},
			    {label:'内容', name:'content', align:"left", formatter:subcontent,width:400}
			],
			shrinkToFit: false,
			height: height,
			width: width,
			multiselect: false,
			pager: '#pager2'
		}).navGrid('#pager2',{add: false, edit: false, del: false, search: false});
	}
	
	function receivers(cellvalue, options, rowObject){
		if(cellvalue!=null){
			var names = cellvalue.split(";");
			if(names.length>1){
				var str = "收信人：";
				for(var i=0;i<names.length;i++){
					str += names[i]+" "; 	
				}
				var data = "<img src=\"core/common/images/users.png\" style=\"position:relative;top:2px;\" width=\"14\" height=\"14\" title=\""+str+"\" /> ";
				return names[0]+"&nbsp;"+data;
			}else{
				return cellvalue;
			}
		}
		return "";
	}
	
	function subcontent(cellvalue, options, rowObject){
		return "&nbsp;&nbsp;"+cellvalue;
	}
	
	function deleteById(id){
		if(confirm("您确定要取消")){
			$.post("<%=basePath%>sms!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				$("#notSendSms").trigger("reloadGrid");
			});
		}
	}
	function loadTree(){
		$.ajax({
			"url" : "<%=basePath%>sms!smsPage.action",
			type:"POST",
			success: function(data){
				$('#tt').tree({
					checkbox:true,
					animate: true,
					lines:true,
					"data" : data.cardCategoryList,
					onClick:function(node){
						$(this).tree('toggle', node.target);
					},
					onCheck:function(node,checked){
						if(node.state){
							var childrenNodes = $("#tt").tree("getChildren", node.target);
							for(var i=0;i<childrenNodes.length;i++){
								if(childrenNodes[i].state){
									var childs = $("#tt").tree("getChildren", childrenNodes[i].target);
									for(var j=0;j<childs.length;j++){
										addReceiver(childs[j],checked);
									}
								}else{
									addReceiver(childrenNodes[i],checked);
								}
							}
						}else{
							addReceiver(node,checked);
						}
					}
				});
			}
		});
	}
	
	function addReceiver(node,checked){
		var nodes = $('#tt').tree('getChecked'); 
		var str = $("#receiver").val();
		if(str!=""){
			if(str.substring(str.length-1,str.length)!=";"){
				$("#receiver").val(str+";");
			}	
		}
		var text = $(node.target).find("input").val().split(";");
		text[0] = trim(text[0]);
		if(text[0]=='null' || text[0]== " "){
			text[0] = "";
		}else{
			text[0] = trim(text[0]);
		}
		if((str).indexOf(text[1]+"<"+text[0]+">")==-1){
			if(checked){
				$("#receiver").append(text[1]+"<"+text[0]+">"+";");
				for(var i = 0 ; i < nodes.length; i++){   
					if(!nodes[i].state){
						var text = $(nodes[i].target).find("input").val().split(";");
						if(text[0]=='null'){
							text[0] = "";
						}
						var receiver = text[1]+"<"+text[0]+">"+";"; 
						if(($("#receiver").val()).indexOf(receiver)==-1){
							$("#receiver").append(receiver);
						}
					}
				}
			}
		}else{
			if(!checked){
				$("#receiver").val(str.replace(text[1]+"<"+text[0]+">"+";",""));
			}
		}
		$("#receiver").focus();
	}
	
	function searchCard(){
		var name = $("#cardSearch").val();
		if(trim(name)==""){
			loadTree();
			$("#searchBtn").removeClass("sms_btn_close").addClass("sms_btn");
		}else{
			$.ajax({
				"url" : "<%=basePath%>card!CardSearchByName.action?cardName="+name,
			 	type:"POST",
			 	success: function(data){
			 		if(data.cards.length>0){
			 			$("#tt").empty();
						$("#tt").tree({
							animate: true,
					  		checkbox: true,
							"data" : data.cards,
							onCheck:function(node,checked){
								addReceiver(node,checked);
							}
						});
			 		}else{
			 			$("#tt").empty();
			 			showTip("找不到相应的名片",2000);
			 		}
			  	}
			});
			$("#cardSearch").val("");
			$("#searchBtn").removeClass("sms_btn").addClass("sms_btn_close");
		}
	}
	
	function loadSmsTemplate(){
		$.post("<%=basePath%>smsTemplate!loadSmsTemplate.action",function(data){
			if(data.result.success){
				var list = data.result.value;
				var smsTemplateId = $("#smsTemplate");
				smsTemplateId.empty();
				smsTemplateId.append($("<option></option>",{value:""}).append("----请选择----"));
				for(var i = 0; i < list.length; i++){
					var smsTemplate = list[i];
					smsTemplateId.append($("<option></option>",{value:smsTemplate.content}).append(smsTemplate.name));
				}
			} else {
				showTip(data.result.msg,2000);
			}
		});
	}
	
	function templateContent(){
		if($("#smsTemplate").val()!=""){
			$("#content").empty();
			$("#content").val($("#smsTemplate").val());
		}
	}
	
	function checkForm(){
		if(notNull("receiver","收信人")&&notNull("content","短信内容")&&notNull("smsSign","落款")){
			$("#receiver").val($("#receiver").val().replace("；",";"));
			if(processDate()==false){
				return;
			}
			$('#form1').ajaxSubmit({ 
		        dataType: 'json',
		        success: function(data){
		       		showTip(data.result.msg,3000);
		       		if(data.result.success){
			       		setTimeout("document.form1.reset();");
			       		/* $("#notSendSms").trigger("reloadGrid");
			       		$("#SendSms").trigger("reloadGrid"); */
		       		}
		        } 
		    });
	 	}
	}
	function processDate(){
		if($("#timeType").val() == 'CUSTOMER'){
			var month = $("#month").val();
			var day = $("#day").val();
			if(month<10){
				month = "0"+month;
			}
			if(day<10){
				day = "0"+day;
			}
			$("#sendTime").val($("#year").val()+"-"+month+"-"+day+" "+$("#sendHour").val()+":"+$("#sendMinute").val()+":00");
			if($("#sendTime").val()<$("#nowTime").val()){
				showTip("发送时间不能小于当前时间");
				return false;
			}
		}
	}
			
	function checkradio(){ 
		var item = $(":checked")
		var len=item.length; 
		if(len>0){ 
		 if($(":radio:checked").val()==2){
		 	$("#times").css({display:"block"});
		 	$("#timeType").val('<%=SendTimeTypeEnum.CUSTOMER%>');
		 }else{
		 	$("#times").css({display:"none"});
		 	$("#timeType").val('<%=SendTimeTypeEnum.NOW%>');
		 }
		} 
	} 
	function textheight(){
		if($("#receiver").text()==''){
			activeobj.style.height=activeobj.scrollHeight;
		}else{
			activeobj.style.height=activeobj.scrollHeight-4;
		}
	}
	
	function keyHandle(event){
		if(event.keyCode==13){
			searchCard();
			event.returnValue=false;
		}
	}
</script>
</head>

<body>
<div id="container" class="contentDiv">
	<!--table切换开始-->
	<div class="apptab" id="tableid">
		<ul>
			<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">发送短信</li>
			<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">未发短信</li>
			<li class="apptabli"  onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">已发短信</li>
		</ul>
	</div>
	<!--//table切换开始-->
	<div class="smsborder">	
	<form action="<%=basePath %>smsReceiver!saveSms.action" method="post" name="form1" id="form1">
		<div class="tabswitch">
			<div class="emailtop">
			<!--leftemail-->
				<div class="leftemail">
					<ul>
						<%if(send){%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="checkForm();"><span><img src="core/common/images/sms.png" width="15" height="13" /></span>发送</li>
						<%} %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="document.form1.reset();refreshTree();"><span><img src="core/common/images/emaildel.png"/></span>取消</li>
					</ul>
				</div>
			<!--//leftemail-->
		</div>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="2" cellpadding="0">
					<tr>
						<td class="sms_tdleft"><span class="psred">*</span>收信人：</td>
						<td>
							<textarea id="receiver" name="smsReceiver.receiverName" onblur="clearInterval(this.clock);" onfocus="window.activeobj=this;this.clock=setInterval(function(){textheight();},100);"  style="overflow: hidden; border: 1px solid #e0e0e0; background:#FFFFE1; width:98%;padding:4px;height:22px;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="sms_tdleft"></td>
						<td style="color:#999;">注意：收信人之间须用";"号隔开</td>
					</tr>
					<tr>
						<td class="sms_tdleft">模板：</td>
						<td><label>
							<select id="smsTemplate" name="select" onchange="templateContent();">
								<option value="">----请选择----</option>
							</select>
						</label></td>
					</tr>
					<tr>
						<td class="sms_tdleft"><span class="psred">*</span>短信内容：</td>
						<td><label>
							<textarea id="content" name="sms.content" class="textareaauto" style="height:80px;"></textarea>
						</label></td>
					</tr>
					<tr>
						<td valign="top" class="sms_tdleft">&nbsp;</td>
						<td style="color:#999;">注意：短信内容必须使用署名【机构名称】结束，表示短信是由谁发出，如不加署名，将无法发送短信</td>
					</tr>
					<tr>
						<td class="sms_tdleft"><span class="psred">*</span>落款：</td>
						<td><lable>
							<input id="smsSign" name="smsSign" value="<%=OaActivator.getAppConfig().getConfig("SmsSign").getParameter("name") %>" class="inputauto" style="width: 170px;" ></input>
						</lable></td>
					</tr>
					<tr>
						<td valign="top" class="sms_tdleft">发送方式：</td>
						<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="80" height="25">
									<input name="ch" type="radio" style="padding-top:2px;"  onclick="checkradio()" value="1" checked="checked"/>立即发送
									<input id="timeType" name="sms.timeType" value="<%=SendTimeTypeEnum.NOW %>" type="hidden" />
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><input name="ch" type="radio" style="padding-top:2px;" onclick="checkradio()" value="2" />定时发送</td>
								<td></td>
							</tr>
						</table></td>
					</tr>
					<tr>
						<td valign="top" class="sms_tdleft">&nbsp;</td>
						<td>
							<div id="times" style="display:none; width:97%; border: 1px solid #ccc; padding: 5px; background: #ffffe1; color: #333; list-style:none;">
							发信时间：
										<input id="sendTime" name="sms.sendTime" type="hidden" value="<fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
										<input id="nowTime" type="hidden" value="<fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
									<label>
										<select id="year" name="select_year" onchange="change(this, document.form1.select_month, document.form1.select_day)">
										</select>
									</label>
									年
									<label>
										<select id="month" name="select_month"  onchange="change(document.form1.select_year, this,document.form1.select_day)">
										</select>
									</label>
									月
									<label>
										<select id="day" name="select_day">
										</select>
									</label>
									日
									<label>
										<select id="sendHour">
											<c:forEach begin="0" end="23" var="s">
												<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
											</c:forEach>
										</select>
									</label>
									时
									<label>
										<select id="sendMinute">
											<c:forEach begin="0" end="59" var="s" step="15">
												<option value="<c:if test="${s<10}">0</c:if>${s}"><c:if test="${s<10}">0</c:if>${s}</option>
											</c:forEach>
										</select>
									</label>
									分
							</div>				
						</td>
					</tr>
				</table></td>
				<td width="210">
					<div class="sms_contacts">
						<div class="sms_contacts_title">名片夹</div>
						<div class="sms_contacts_search">
							<ul>
								<li><input id="cardSearch" type="text" class="sms_inputs" onkeydown="keyHandle(event);"/></li>
								<li><input id="searchBtn" type="button" class="sms_btn" value="" onclick="searchCard();"/></li>
							</ul>
						</div>
						<div id="tree" style="overflow-x: hidden; overflow-y: auto; ">
				           	<ul id="tt" >
				           		<c:forEach items="${cardCategoryList }" var="cardCategory">
			           				<c:if test="${cardCategory.level == 0 }">
						           		<li state="closed" iconCls="${cardCategory.iconCls }">
					           				<span>${cardCategory.name }</span>
					           				<c:forEach items="${cardCategoryList }" var="cardCategory2">
					           					<c:if test="${cardCategory2.level == 1 && cardCategory2.parentId == cardCategory.id }">
								           			<ul>
								           				<li state="closed" iconCls="${cardCategory2.iconCls }">
															<span >${cardCategory2.name }</span>
							           						<c:forEach items="${cards }" var="card">
							           							<c:if test="${card.categoryId == cardCategory2.id }">
										           					<ul>
										           						<li iconCls="${card.iconCls }">
										           							<span >${card.text }</span>
																		</li>
									           						</ul>
								           						</c:if>
															</c:forEach>
								           				</li>
							           				</ul>
						           				</c:if>
						           			</c:forEach>
						           		</li>
					           		</c:if>
				           		</c:forEach>
							</ul>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<div class="emailtop" style="position:relative; border-bottom:none; border-top:1px solid #d9d9d9;">
			<!--leftemail-->
			<div class="leftemail">
				<ul>
					<%if(send){%>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="checkForm();"><span><img src="core/common/images/sms.png" width="15" height="13" /></span>发送</li>
					<%} %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="document.form1.reset();refreshTree();"><span><img src="core/common/images/emaildel.png"/></span>取消</li>
				</ul>
			</div>
			<!--//leftemail-->
		</div>
	</div>
	</form>
	<div class="tabswitch" style="margin:0px; display:none;background: #fff;" >
		<table id="notSendSms" width="100%" class="jqGridList"><tr><td/></tr></table>
		<div id="pager1"></div>
	</div>
	<div class="tabswitch" style="margin:0px; display:none;background: #fff;">
		<table id="SendSms" width="100%" class="jqGridList"><tr><td/></tr></table>
		<div id="pager2"></div>
	</div>
</div>
</div>
 <!--//container-->
</body>

</html>
