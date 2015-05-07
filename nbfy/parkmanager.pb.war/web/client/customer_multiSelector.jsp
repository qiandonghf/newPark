<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.crm.entity.CustomerLabel"%>
<%@page import="com.wiiy.crm.entity.CustomerLabelRef"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$("<div id=\"tip\" class=\"msgpage\"></div>").css("display","none").appendTo($("body"));
		$("#tree").tree({
			animate: true,
			checkbox: true,
			lines: true,
			onBeforeExpand: function(node){
				if(node.id){
					$("#tree").tree("options").url="<%=basePath%>customer!loadCustomer.action?labelId="+node.id;
				}
			},
			onBeforeLoad: function(node, param){
				if(node.id){
					$("#tip").html("请稍等，正在载入数据...").show();
				}
			},
			onLoadSuccess: function(node, data){
				$("#tip").hide();
			},
			onCheck: function(node,checked){
				$(this).tree('toggle', node.target);
				if(checked){
					if($(this).tree("isLeaf",node.target)){
						var customerId = $(node.target).find("input").val();
						var customerName = node.text.substring(0,node.text.indexOf('<'));
						showSelectedCustomers({id:customerId,name:customerName});
					} else {
						var childs = $(this).tree("getChildren",node.target);
						for(var i = 0; i < childs.length; i++){
							var node = childs[i];
							if($(this).tree("isLeaf",node.target)){
								var customerName = node.text.substring(0,node.text.indexOf('<'));
								var customerId = $(node.target).find("input").val();
								showSelectedCustomers({id:customerId,name:customerName});
							} else {
								var grandsons = $(this).tree("getChildren",node.target);
								for(var j = 0; j < grandsons.length; j++){
									var node = grandsons[j];
									var customerName = node.text.substring(0,node.text.indexOf('<'));
									var customerId = $(node.target).find("input").val();
									showSelectedCustomers({id:customerId,name:customerName});
								}
							}
						}
					}
				} else {
					var checkeds = $(this).tree("getChecked");
					$(".customerId").each(function(){
						var exist = false;
						for(var j = 0; j < checkeds.length; j++){
							var checked = checkeds[j];
							if($("#tree").tree("isLeaf",checked.target)){
								var customerId = $(checked.target).find("input").val();
								if(customerId==$(this).val()){
									exist = true;
									break;
								}
							}
						}
						if(!exist){
							$(this).parent().remove();
						}
					});
				}
			}
		});
	});
	function showSelectedCustomers(customer){
		if($("#customer"+customer.id).length==0){
			$("#customerUl").append(
				$("<li></li>",{id:"customer"+customer.id,
					mouseover:function(){$(this).find('span').show()},
					mouseout:function(){$(this).find('span').hide()}
				}).append(customer.name).append($("<input type=\"hidden\" class=\"customerId\" value=\""+customer.id+"\"/>")
				).append($("<span></span>",{click:function(){$(this).parent().remove();}}).hide())
			);
		}
	}
	function submitSelectedCustomer() {
		var customers = new Array();
		$(".customerId").each(function(index){
			var id = $(this).val();
			var name = $(this).parent().text();
			customers[index] = {id:id,name:name};
		});
		getOpener().setSelectedCustomers(customers);
		fb.end();
	}
</script>
</head>

<body>
	<div class="basediv">
		<table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td valign="top">
					<div class="userleftcontact" id="resizable" style="width: 240px;">
						<div class="titlebg">企业分类</div>
						<div class="treeviewdiv" style="overflow-Y:auto;height: 320px;" id="treeDiv">
							<ul id="tree">
								<li id="0" state="closed">
									<span>所有企业</span>
									<ul>
										<%-- <c:forEach items="${customerList}" var="customer" begin="0" end="10">
											<li>${customer.name}<input type="hidden" value="${customer.id}"/></li>
										</c:forEach> --%>
									</ul>
								</li>
								<c:forEach items="${customerCategoryList}" var="customerCategory">
								<li state="closed">
									<span>${customerCategory.name}</span>
									<ul>
										<c:forEach items="${customerLabelList}" var="customerLabel">
											<c:if test="${customerLabel.categoryId eq customerCategory.id}">
												<li id="${customerLabel.id}" state="closed">
													<span>${customerLabel.name}</span>
													<ul>
														<%-- <c:forEach items="${customerList}" var="customer">
															<%
																Customer customer = (Customer)pageContext.getAttribute("customer");
																for(CustomerLabelRef labelRef : customer.getLabelRefs()){
																	if(labelRef.getCustomerLabel().getId().longValue()==((CustomerLabel)pageContext.getAttribute("customerLabel")).getId().longValue()){
																		out.print("<li>"+customer.getName()+"<input type=\"hidden\" value=\""+customer.getId()+"\"/></li>");
																	}
																}
															%>
														</c:forEach> --%>
													</ul>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
								</c:forEach>
								<li state="closed">
									<span>我的分组</span>
									<ul>
										<c:forEach items="${myLabelList}" var="customerLabel">
											<li id="${customerLabel.id}" state="closed">
												<span>${customerLabel.name}</span>
												<ul>
													<%-- <c:forEach items="${customerList}" var="customer">
														<%
															Customer customer = (Customer)pageContext.getAttribute("customer");
															for(CustomerLabelRef labelRef : customer.getLabelRefs()){
																if(labelRef.getCustomerLabel().getId().longValue()==((CustomerLabel)pageContext.getAttribute("customerLabel")).getId().longValue()){
																	out.print("<li>"+customer.getName()+"<input type=\"hidden\" value=\""+customer.getId()+"\"/></li>");
																}
															}
														%>
													</c:forEach> --%>
												</ul>
											</li>
										</c:forEach>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</td>
				<td valign="top" class="customerdiv customerdiv2">
					<div class="userrightcontact" style="width: 240px;">
						<div class="titlebg">已选择的客户&nbsp;&nbsp;&nbsp;&nbsp;<span onclick="$('#customerUl').empty()" style="color:#06c; cursor:pointer; font-weight:normal;">清空</span></div>
						<div style="width:auto; height:315px; overflow-x:hidden; overflow-y:scroll"><ul id="customerUl"></ul></div>
					</div>
				</td>
			</tr>
		</table>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="submitSelectedCustomer()"><span><img src="core/common/images/accept.png">确认</span></a>
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end();"><span><img src="core/common/images/close.png">取消</span></a>
	</div>
</body>
</html>
