<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	function checkTime(){ 
		var objs = $(".times");
		var ids = "";
		for(var i = 0;i<objs.length;i++){
			if(objs.get(i).checked){
				ids += objs.get(i).value+",";
			}
		}
		var id = ids.split(",");
		if(id.length==3){
			$("#starttime").css({display:""});
			$("#starthour").css({display:"none"});
			$("#endtime").css({display:""});
			$("#endhour").css({display:"none"});
			$("#wholeDay").val("YES");
			$("#setEndTime").val("YES");
			fb.resize(); 
		}else if(id[0]==1){
			$("#endhour").css({display:"none"});
			$("#starthour").css({display:"none"});
			$("#endtime").css({display:"none"});
			$("#wholeDay").val("YES");
			$("#setEndTime").val("NO");
			fb.resize(); 
		}else if(id[0]==2){
			$("#starthour").css({display:""});
			$("#endtime").css({display:""});
			$("#endhour").css({display:""});
			$("#setEndTime").val("YES");
			$("#wholeDay").val("NO");
			fb.resize(); 
		}else {
			$("#starttime").css({display:""});
			$("#starthour").css({display:""});
			$("#endtime").css({display:"none"});
			$("#endhour").css({display:"none"});
			$("#wholeDay").val("NO");
			$("#setEndTime").val("NO");
		}
	} 

	$(document).ready(function() {
		initTip();
		initForm();
		$("#promot").change(function(){
			if($(this).val()=="SPECIALDAY"){
				$("#SPECIALDAY").show();
			} else {
				$("#SPECIALDAY").hide();
			}
			if($(this).val()=='' || $(this).val()=="NOPROMOT"||$(this).val()=="NOW"){
				$("#promottime").hide();
			} else {
				$("#promottime").show();
			}
		});
	});
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"schedule.title":"required",
				"startDate":"required"
			},
			messages: {
				"schedule.title":"请输入主题",
				"startDate":"请选择开始时间"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(!$("#endtime").is(":hidden")){
					if(notNull("endDate","结束日期") && notNull("startDate","开始日期")){
						if($("#endDate").val()<$("#startDate").val()){
							showTip("结束日期不能小于开始日期",3000);
							return;
						}
					}
				}
				if(processDate()==false){
					return;
				}
				$(form).ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.refresh();fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	
	Date.prototype.format = function(format)
	{
	 var o = {
	 "M+" : this.getMonth()+1, //month
	 "d+" : this.getDate(),    //day
	 "h+" : this.getHours(),   //hour
	 "m+" : this.getMinutes(), //minute
	 "s+" : this.getSeconds(), //second
	 "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
	 "S" : this.getMilliseconds() //millisecond
	 }
	 if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
	 (this.getFullYear()+"").substr(4 - RegExp.$1.length));
	 for(var k in o)if(new RegExp("("+ k +")").test(format))
	 format = format.replace(RegExp.$1,
	 RegExp.$1.length==1 ? o[k] :
	 ("00"+ o[k]).substr((""+ o[k]).length));
	 return format;
	}
	
	function processDate(){
		if($("#SPECIALDAY").is(":hidden")){
			$("#promotDetail").val($("#promotTime").val());
			if(!$("#promottime").is(":hidden")){
				var now = $("#startDate").val()+" 00:00:00";
      			now =  now.replace(/-/g,"/");
   				var date = new Date(now);
				if($("#promot").val()=='LASTDAY'){
	   				var newDate = new Date(date.setDate(date.getDate()-1));
					$("#proTime").val(newDate.format('yyyy-MM-dd')+" "+$("#promotTime").val()+":00:00");
				}else{
					$("#proTime").val(date.format('yyyy-MM-dd')+" "+$("#promotTime").val()+":00:00");
				}
			}
		} else {
			if($("#promotDetailDate").val()==""){
				showTip("指定时间不能为空",2000);
				return false;
			}
			$("#promotDetail").val($("#promotDetailDate").val()+" "+$("#promotTime").val());
			$("#proTime").val($("#promotDetailDate").val()+" "+$("#promotTime").val()+":00:00");
		}
		
		if($("#starthour").is(":hidden")){
			$("#StartTime").val($("#startDate").val());
		}else{
			$("#StartTime").val($("#startDate").val()+" "+$("#startHour").val()+":00:00");
		}
		if($("#endhour").is(":hidden")){
			$("#EndTime").val($("#endDate").val());
		}else{
			if(($("#endDate").val()==$("#startDate").val())){
				if($("#endHour").val()<$("#startHour").val()){
					showTip("结束时间不能小于开始时间",2000);
					return false;
				}
			}
			$("#EndTime").val($("#endDate").val()+" "+$("#endHour").val()+":00:00");
		}
	}
	
	function remind(promot){
		if($("#"+promot).is(":checked")){
			$("#"+promot).val('<%=BooleanEnum.YES %>');
		}else{
			$("#"+promot).val('<%=BooleanEnum.NO %>');
		}
	}
	
	function deleteById(){
		var id = $("#id").val();
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>schedule!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				if(data.result.success){
					setTimeout("parent.refresh();fb.end();", 2000);
				}
			});
		}
	}

</script>
</head>

<body>
<form action="<%=basePath %>schedule!update.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteById();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		</ul>
	</div>
</div>
<div class="divlays">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>主题：</td>
        <td class="layerright">
        	<input id="id" type="hidden" name="schedule.id" value="${result.value.id}"/>
        	<input name="schedule.title" type="text" class="inputauto" value="${result.value.title}"/></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>开始时间：</td>
        <td colspan="2" class="layerright">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		          	<td width="135"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		              <tr>
		                <td width="120">
		                	<input id="StartTime" name="schedule.startTime" type="hidden" value="${result.value.startTime }"/>
		                	<input id="proTime" name="schedule.promotTime" type="hidden" value="<fmt:formatDate value="${result.value.promotTime}" pattern="yyyy-MM-dd"/>"/>
		                	<input id="startDate" name="startDate" type="text" readonly="readonly" class="inputauto" value="<fmt:formatDate value="${result.value.startTime }" pattern="yyyy-MM-dd"/>" onclick="return showCalendar('startDate');" />
		                </td>
		                <td width="20"><img src="core/common/images/timeico.gif" style="position: relative; left:-1px;" width="20" height="22" onclick="return showCalendar('startDate');" /></td>
		              </tr>
            		</table></td>
		         	<td style="<c:if test="${result.value.wholeDay eq 'YES'}">display: none;</c:if>" id="starthour">
						<select id="startHour">
							<c:forEach begin="0" end="23" var="s">
								<fmt:formatNumber value="${s}" pattern="00" var="fmtS"/>
								<option value="${fmtS}" <c:if test="${fn:substring(result.value.startTime,fn:indexOf(result.value.startTime,' ')+1,fn:indexOf(result.value.startTime,' ')+3) eq fmtS}">selected="selected"</c:if> >${fmtS}:00</option>
							</c:forEach>
						</select>
					</td>
		        </tr>
	    	</table>
	    </td>
      </tr>
      <tr <c:if test="${result.value.setEndTime eq 'NO'}">style="display:none;"</c:if> id="endtime">
        <td class="layertdleft100">结束时间：</td>
	    <td colspan="2" class="layerright">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		          	<td width="135"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		              <tr>
		                <td width="120">
		                	<input id="EndTime" name="schedule.endTime" type="hidden" value="${result.value.endTime }"/>
		                	<input id="endDate" name="endDate" type="text" readonly="readonly" class="inputauto" value="<fmt:formatDate value="${result.value.endTime }" pattern="yyyy-MM-dd"/>" onclick="return showCalendar('endDate');" />
		                </td>
		                <td width="20"><img src="core/common/images/timeico.gif" style="position: relative; left:-1px;" width="20" height="22" onclick="return showCalendar('endDate');" /></td>
		              </tr>
            		</table></td>
		         	<td <c:if test="${result.value.wholeDay eq 'YES'}">style="display: none;"</c:if> id="endhour">
						<select id="endHour">
							<c:forEach begin="0" end="23" var="s">
								<fmt:formatNumber value="${s}" pattern="00" var="fmtS"/>
								<option value="${fmtS}" <c:if test="${fn:substring(result.value.endTime,fn:indexOf(result.value.endTime,' ')+1,fn:indexOf(result.value.endTime,' ')+3) eq fmtS}">selected="selected"</c:if> >${fmtS}:00</option>
							</c:forEach>
						</select>
					</td>
		        </tr>
	    	</table>
	    </td>
      </tr>
      <tr>
        <td class="layertdleft100">&nbsp;</td>
        <td class="layerright">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr>
	            <td width="20">
	            	<input type="checkbox" <c:if test="${result.value.wholeDay eq 'YES'}">checked="checked"</c:if> name="times" value="1" class="times" onclick="checkTime()"  />
		            <input type="hidden" id="wholeDay" name="schedule.wholeDay" value="${result.value.wholeDay.title}"/>
	            </td>
	            <td width="30">全天</td>
	            <td width="20">
	            	<input type="checkbox" <c:if test="${result.value.setEndTime eq 'YES'}">checked="checked"</c:if> name="times" value="2" class="times" onclick="checkTime()"/>
		            <input type="hidden" id="setEndTime" name="schedule.setEndTime" value="${result.value.setEndTime.title}"/>
	            </td>
	            <td>结束时间</td>
	            <td>&nbsp;</td>
	          </tr>
	        </table>
		</td>
      </tr>
	   <tr>
        <td class="layertdleft100">重复方式：</td>
        <td class="layerright">
        	<enum:select type="com.wiiy.oa.preferences.enums.RepeatEnum" name="schedule.repeatType" checked="result.value.repeatType"/>
       	</td>
      </tr>
      <tr>
        <td class="layertdleft100">提醒：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="80">
        		<enum:select type="com.wiiy.oa.preferences.enums.PromotEnum" name="schedule.promot" id="promot" checked="result.value.promot"/>
        	</td>
			<td width="135" id="SPECIALDAY"  class="layerright" <c:if test="${result.value.promot ne 'SPECIALDAY'}">style="display:none;"</c:if>><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120">
                	<input id="promotDetail" name="schedule.promotDetail" type="hidden" value="${result.value.promotDetail }"/>
                	<input id="promotDetailDate" type="text" readonly="readonly" class="inputauto" <c:if test="${result.value.promot eq 'SPECIALDAY'}">value="${fn:substring(result.value.promotDetail,0,fn:indexOf(result.value.promotDetail,' '))}"</c:if> onclick="return showCalendar('promotDetailDate');" />
                </td>
                <td width="20"><img src="core/common/images/timeico.gif" style="position: relative; left:-1px;" width="20" height="22" onclick="return showCalendar('promotDetailDate');" /></td>
              </tr>
            </table></td>
            <td id="promottime" class="layerright" <c:if test="${result.value.promot eq 'NOPROMOT'||result.value.promot eq 'NOW'}">style="display:none;"</c:if>>
				<select id="promotTime" style="height:22px;">
					<c:forEach begin="0" end="23" var="s">
						<fmt:formatNumber value="${s}" pattern="00" var="fmtS"/>
						<option value="${fmtS}" <c:if test="${fn:substring(result.value.promotDetail,fn:indexOf(result.value.promotDetail,' ')+1,fn:indexOf(result.value.promotDetail,' ')) eq fmtS}">selected="selected"</c:if> >${fmtS}:00</option>
					</c:forEach>
				</select>
			</td>
      	</tr>
      	</table></td>
      </tr>	
      <tr>
        <td class="layertdleft100">提醒方式：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
           	<td width=20><label><input id="sms" value="<%=BooleanEnum.YES %>" type="checkbox" name="schedule.sms" <c:if test="${result.value.sms eq 'YES'}">checked="checked"</c:if> onclick="remind('sms')" ></label></td>
			<td width=30>短信 </td>
			<td width=20><input id="defaultEmail" value="<%=BooleanEnum.YES %>" type="checkbox" name="schedule.defaultEmail" <c:if test="${result.value.defaultEmail eq 'YES'}">checked="checked"</c:if> onclick="remind('defaultEmail')"></td>
			<td width=50>邮件</td>
			<%-- <td width=20><input id="email" value="<%=BooleanEnum.YES %>" type="checkbox" name="schedule.email" <c:if test="${result.value.email eq 'YES'}">checked="checked"</c:if> onclick="remind('email')"></td>
			<td>外部邮件</td> --%>
			<td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
	  
      <tr>
        <td class="layertdleft100">备注：</td>
        <td class="layerright" style="padding-bottom:2px;"><label>
          <textarea name="schedule.memo" style="height:100px;"class="textareaauto">${result.value.memo}</textarea>
        </label></td>
      </tr>
    </table>
	<div class="hackbox"></div>
	</div>
</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
