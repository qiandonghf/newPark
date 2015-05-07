<%@page import="com.wiiy.crm.preferences.enums.ContractTypeEnum"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String action = request.getParameter("action");
%>
<script type="text/javascript">
		$(function(){
			initTip();
			initForm();
			init();
		});
		function setSelectedUser(contect){
			$("#contectName").val(contect.name);
			$("#contectId").val(contect.id);
		}
		function setSelectedCustomer(customer){
			$("#customerId").val(customer.id);
			$("#customerName").val(customer.name);
		}
		function selectContect(){
			fbStart('选择负责人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
		}
		function generateCode(){
			var name = $("#contractModel :selected").val();
			$.post("<%=basePath%>contract!generateCode.action?contractModel="+name,function(data){
				if(data.result.success){
					$("#contractNo").val(data.result.value);
				}
			});
		}
		function initForm(){
			$("#form1").validate({
				rules: {
					"contract.name":"required",
					"contract.contractNo":"required",
					"contract.signDate":"required",
					"contract.totalAmount":"number",
					"customerName":"required",
					"contectName":"required",
					"contract.startDate":"required",
					"contract.endDate":"required"
				},
				messages: {
					"contract.name":"请输入合同名称",
					"contract.contractNo":"请输入合同编号",
					"contract.signDate":"请选择签订日期",
					"contectName":"请选择负责人",
					"customerName":"请选择企业",
					"contract.startDate":"请选择有效日期开始时间",
					"contract.endDate":"请选择有效日期结束时间"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					if($("#endDate").val()<$("#startDate").val()){
						showTip("有效日期开始时间不能小于有效日期结束时间",3000); 
						return;
					}
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		getOpener().reloadList();
				        		getOpener().needConfirmClose = false;
				        	}
				        } 
				    });
				}
			});
		}
		function reloadSubjectRentList(){
			$("#subjectRentList").trigger("reloadGrid");
		}
		function mySelected(cal, date) {
			  cal.sel.value = date; // just update the date in the input field.
			  if (cal.dateClicked && (cal.sel.id == "sel1" || cal.sel.id == "sel3"))
			    // if we add this call we close the calendar on single-click.
			    // just to exemplify both cases, we are using this only for the 1st
			    // and the 3rd field, while 2nd and 4th will still require double-click.
			    cal.callCloseHandler();
			  if(cal.sel.id=="startDate"){
				  $("#receiveDate").val(date);
				  var ss = date.split("-");
				  var startDate = new Date(ss[0],ss[1],ss[2]);
				  startDate.setFullYear(startDate.getFullYear()+1);
				  startDate.setMonth(startDate.getMonth()-1);
				  startDate.setDate(startDate.getDate()-1);
				  startDate = startDate.format("yyyy-MM-dd");
				  $("#endDate").val(startDate);
			  }
			}
		function myShowCalendar(id){
			var el = document.getElementById(id);
			  if(el==null) el = id;
			    // first-time call, create the calendar.
			    var cal = new Calendar(false, null, mySelected, closeHandler);
			    // uncomment the following line to hide the week numbers
			    // cal.weekNumbers = false;
			    calendar = cal;                  // remember it in the global var
			    cal.setRange(1900, 2200);        // min/max year allowed.//更改起始年月
			    cal.create();
			 
			  //calendar.setDateFormat(format);    // set the specified date format
			  calendar.parseDate(el.value);      // try to parse the text in field
			  calendar.sel = el;                 // inform it what input field we use
			  // the reference element that we pass to showAtElement is the button that
			  // triggers the calendar.  In this example we align the calendar bottom-right
			  // to the button.
			  calendar.showAtElement(el, "B");        // show the calendar
			  return false;
		}

	</script>
	<input type="hidden" value="${result.value.id}" id="contractId" name="contract.id"/>
	<div class="basediv">
		<div class="titlebg">基本信息</div>
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>合同名称：</td>
					<td class="layerright"><input name="contract.name" value="${result.value.name}" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred">*</span>合同编号：</td>
					<td class="layerright" width="270">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="contractNo" name="contract.contractNo" value="${result.value.contractNo}" type="text" style="width: 150px;" class="inputauto" /></td>
									<td><select id="contractModel" style="height: 21px">
		            					<option>Z</option>
		            					<option>S</option>
		            				</select></td>
								<td width="80" align="center"><img src="core/common/images/auto.gif" width="75" height="22" onclick="generateCode()"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">座落位置：</td>
					<td class="layerright"><input name="contract.address" value="${result.value.address }" type="text" class="inputauto" style="width:99%;"/></td>
					<td class="layertdleft100">合同期限：</td>
			      	<td class="layerright"><table border="0" cellspacing="0" cellpadding="10">
			        	<tbody>
			          		<tr>
								<td width="110"><input id="startDate" readonly="readonly" name="contract.startDate" type="text" value="<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>" class="inputauto" onclick="myShowCalendar('startDate')"/></td>
								<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="myShowCalendar('startDate')"/></td>
								<td width="10"><span style="padding-left:4px;padding-right:4px;">—</span></td>
								<td width="110"><input id="endDate" readonly="readonly" name="contract.endDate" value="<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="showCalendar('endDate')"/></td>
								<td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('endDate')"/></td>
								<td>&nbsp;</td>
							</tr>
			        	</tbody>
		      		</table></td>
		    	</tr>
		    	<tr>
					<td class="layertdleft100">厂房用途：</td>
					<td class="layerright"><input name="contract.purpose" value="${result.value.purpose }" type="text" class="inputauto" style="width:99%;" /></td>
					<td class="layertdleft100">装修期：</td>
					<td class="layerright"><table border="0" cellspacing="0" cellpadding="10">
						<tbody>
							<tr>
					            <td width="80"><input id="decorateStartDate" name="contract.decorateStartDate" value="<fmt:formatDate value="${result.value.decorateStartDate}" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('decorateStartDate');" /></td>
					            <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('decorateStartDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
					            <td>&nbsp;至&nbsp;</td>
					            <td width="80"><input id="decorateEndDate" name="contract.decorateEndDate" value="<fmt:formatDate value="${result.value.decorateEndDate}" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('decorateEndDate');" /></td>
					            <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('decorateEndDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
			          		</tr>
						</tbody>
					</table></td>
		    	</tr>
		    	<tr>
					<td class="layertdleft100">租金支付方式：</td>
					<td class="layerright">
						<enum:select type="com.wiiy.crm.preferences.enums.RentBillPlanEnum" name="contract.payType" checked="result.value.payType"/>
					</td>
					<td class="layertdleft100">负责人：</td>
					<td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
				       	<tr>
							<td width="265"><input id="contectName" name="contectName" type="text" class="inputauto" readonly="readonly" value="${result.value.manager.realName}" /><input type="hidden" id="contectId" value="${result.value.managerId}" name="contract.managerId" type="text" class="inputauto" /></td>
							<td><img src="core/common/images/outdiv.gif" style="position: relative;left:-4px;" width="20" height="22" onclick="selectContect()" style="cursor:pointer"/></td>
						</tr>
				    </table></td>
				</tr>
		    	
		    	<tr>
		       		<td class="layertdleft100">总建筑面积</td>
		      		<td class="layerright" ><input name="contract.overallFloorage" value="${result.value.overallFloorage }" type="text" class="inputauto" style="width:55%;" /> 平方米</td>
		      		<td class="layertdleft100">签订日期：</td>
		     		<td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
				        <tr>
							<td><input id="signDate" readonly="readonly" name="contract.signDate" type="text" value="<fmt:formatDate value="${result.value.signDate}" pattern="yyyy-MM-dd"/>" class="inputauto" onclick="showCalendar('signDate')"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('signDate')"/></td>
						</tr>
				    </table></td>
		      	</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="265"><input id="customerName" name="contract.customerName" type="text" class="inputauto" value="${result.value.customer.name}" readonly="readonly" /><input type="hidden" value="${result.value.customerId}" id="customerId" name="contract.customerId" type="text" class="inputauto" /></td>
								<td><img src="core/common/images/outdiv.gif" style="position: relative;left:-4px;" width="20" height="22" onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);" style="cursor:pointer"/></td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100">房屋交付时间：</td>
			      	<td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
			        	<tbody>
				          	<tr>
								<td><input id="receiveDate" readonly="readonly" name="contract.receiveDate" type="text" class="inputauto" value="<fmt:formatDate value="${result.value.receiveDate}" pattern="yyyy-MM-dd"/>" onclick="showCalendar('receiveDate')"/></td>
								<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('receiveDate')"/></td>
							</tr>
			        	</tbody>
			      </table></td>
				</tr>
				<tr>
			     	<td class="layertdleft100">合同总金额</td>
			      	<td class="layerright" ><input name="contract.totalAmount" value="${result.value.totalAmount }" type="text" class="inputauto" style="width:83%;" /> 元</td>
		       	</tr>
				<tr>
			    	<td class="layertdleft100">租金额度：</td>
			    	<td colspan="3" class="layerright"><textarea name="contract.rentAmount" rows="2" class="textareaauto">${result.value.rentAmount }</textarea></td>
			    </tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>