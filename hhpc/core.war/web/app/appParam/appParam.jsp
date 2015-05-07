<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
 <script>
$(document).ready(function() {
	initTip();
    $('#appParamForm').submit(function() {
        $(this).ajaxSubmit({
			success:function(result, statusText) {
				showTip(result.msg);
            }
        });
        return false;
    });
	////$("#resizable").resizable();
	$("#resizable").css("height",window.parent.document.documentElement.clientHeight-52);
	$("#appParamList").css("height",window.parent.document.documentElement.clientHeight-240);
	//右击菜单
	sendRequest("configDetail", $(".appli2").attr("bundleId"));

	$("#appul li").click(function(){
		$(this).attr("class", "appli2");
		$(this).siblings().attr("class", "appli1");
		$("#bundleId").val($(this).attr("bundleId"));
		sendRequest("configDetail", $(this).attr("bundleId"));
	});

});
function sendRequest(action, bundleId) {
    $.ajax({
        async : false,
        url:"core/appParam!"+action+".action",
        type:"post",
        data:{"bundleId" : bundleId},
        error:function (XMLHttpRequest, textStatus, errorThrown) {
            alert(errorThrown);
        },
        success:function(r) {
            if (r.success) {
            	$("#configContainer").empty();
            	$("#bundleId").val(bundleId);
            	if (!r.value || !r.value.configList) return;
            	$(r.value.configList).each(function(configIndex, config){
            		if (configIndex == 0) {
                		$("#configContainer").append("<tr><td colspan=\"2\" class=\"titlebg\">"+config.label+"</td></tr>");
                	} else {
                		$("#configContainer").append("<tr><td colspan=\"2\" class=\"titlebg\" style=\"border-top:1px solid #c9c9c9\">"+config.label+"</td></tr>");
            		}
            		$(config.parameterList).each(function (parameterIndex, parameter) {
            			var parameterHtml = "<tr><td class=\"layertdleft100\">"+parameter.entry.label+"：</td><td>";
            			switch (parameter.render) {
            			case "ckedit":
            				parameterHtml += "<label><textarea id=\"ck_content["+configIndex+"]\" name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" rows=\"8\" cols=\"120\">"+parameter.value+"</textarea></label></td></tr>";
            				break;
            			case "radio" :
            				parameterHtml += "<label>";
            				$(parameter.choices).each(function(index, choice){
            					if (parameter.value==choice.value) {
                					parameterHtml += "<input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"radio\" value=\""+choice.value+"\" checked=\"checked\"/>&nbsp;"+choice.label + "&nbsp;&nbsp;&nbsp;&nbsp;";
            					} else {
                					parameterHtml += "<input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"radio\" value=\""+choice.value+"\"/>&nbsp;"+choice.label + "&nbsp;&nbsp;&nbsp;&nbsp;";
            					}
            				});
            				parameterHtml += "</label></td></tr>";
            				break;
            			case "checkbox" :
            				parameterHtml += "<label>";
            				$(parameter.choices).each(function(index, choice){
            					if (_contained(parameter.splitValues, choice.value)) {//split parameter value to match
	            					parameterHtml += "<input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"checkbox\" value=\""+choice.value+"\" checked=\"checked\"/>&nbsp;"+choice.label + "&nbsp;&nbsp;&nbsp;&nbsp;";
            					} else {
	            					parameterHtml += "<input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"checkbox\" value=\""+choice.value+"\"/>&nbsp;"+choice.label + "&nbsp;&nbsp;&nbsp;&nbsp;";
            					}
            				});
            				parameterHtml += "</label></td></tr>";
            				break;
            			case "select" :
            				parameterHtml += "<label><select name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" value=\""+parameter.value+"\">";
            				$(parameter.choices).each(function(index, choice){
            					parameterHtml += "<option value=\""+choice.value+"\">"+choice.label+"</option>";
            				});
            				parameterHtml += "</label></td></tr>";
            				break;
            			case "select_user" :
            				parameterHtml += "<table><tr><td width=\"200\">";
            				parameterHtml += "<input id=\"config"+configIndex+"_"+parameterIndex+"\" name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"text\" value=\""+parameter.value+"\" class=\"input200\"/>";
            				parameterHtml += "</td><td width=\"20\">";
            				parameterHtml += "<img width=\"20\" height=\"22\" style=\"left: -2px; position: relative;\" onclick=\"selectUser('config"+configIndex+"_"+parameterIndex+"')\" src=\"core/common/images/outdiv.gif\"/>";
            				parameterHtml += "</td><td>&nbsp;";
            				parameterHtml += "</td></tr></table></td></tr>";
            				break;
            			case "textarea" :
            				parameterHtml += "<label><textarea name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" rows=\"8\" cols=\"120\">"+parameter.value+"</textarea></label></td></tr>";
            				break;
            			case "text" :
            			default :
            				parameterHtml += "<label><input name=\"configList["+configIndex+"].parameterList["+parameterIndex+"].value\" type=\"text\" value=\""+parameter.value+"\" class=\"input200\"/></label></td></tr>";
            			}
            			$("#configContainer").append(parameterHtml);
            		});
            	});
            } else {
            	alert(r.msg);
            }
        }
    });
}
function selectUser(id){
	$("#selectUserId").val(id);
	fbStart('选择用户','http://127.0.0.1:90/core/user!select.action?id='+$("#"+id).val(),520,400);
}
function setSelectedUser(user){
	$("#"+$("#selectUserId").val()).val(user.id);
}
function _contained(valueArray, value) {
	if (!valueArray || !valueArray.length) return false;
	for (var i = 0; i < valueArray.length; i ++) {
		if (value == valueArray[i]) return true;
	}
	return false;
}
function goTab(tabUri) {
	if ($("#bundleId").val() == null || $("#bundleId").val() == "") {
		location.href="${contextLocation}"+tabUri;
	} else {
		location.href="${contextLocation}"+tabUri+"?bundleId="+$("#bundleId").val();
	}
}
</script>
</head>

<body>
<!--container-->
<input type="hidden" id="selectUserId"/>
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="182" valign="top">
			<div class="agency" id="resizable" >
			<!--titlebg-->
			<div class="titlebg">应用列表</div>
			<!--//titlebg-->
			<!--applist-->
			<div class="applist">
				<ul id="appul">
					<c:forEach var="app" items="${appDtoList}" varStatus="rowStatus">
					<c:if test="${empty bundleId and rowStatus.first}">
						<li class="appli2" bundleId="${app.bundleId}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${not empty bundleId and app.bundleId eq bundleId}">
						<li class="appli2" bundleId="${app.bundleId}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${empty bundleId and not rowStatus.first}">
						<li class="appli1" bundleId="${app.bundleId}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${not empty bundleId and app.bundleId ne bundleId}">
						<li class="appli1" bundleId="${app.bundleId}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
			<!--//applist-->
            </div></td>
        <td width="100%" valign="top">
		<!--msglist-->
		<div class="msglist" id="msglist">
		
		<!--titlebg-->
			<div class="titlebg">应用信息</div>
		 <!--//titlebg-->
		<!--appmsglist-->
		<div class="appmsglist">
			<!--apptab-->
			<div class="apptab" id="apptab">
				<ul>
					<li class="apptabli" ><a href="javascript:goTab('appConsole.action')">应用信息</a></li>
					<li class="apptabliover" ><a href="javascript:goTab('appParam.action')">应用参数</a></li>
					<li class="apptabli"><a href="javascript:goTab('dataDict.action')">数据字典</a></li>
				</ul>
			</div>
			<!--//apptab-->
			<form id="appParamForm" name="appParamForm" method="post" action="${contextLocation}appParam!update.action">
		    <input type="hidden" id="bundleId" name="bundleId" value="-1" />
			<!--appname应用参数-->
			<div class="appname">
			  <div id="appParamList" style="height:400px;overflow-x: hidden;overflow-y: auto;">
			      <table width="100%" border="0" cellspacing="0" cellpadding="0" id="configContainer">
                  </table>
		      </div>
			</div>
			<!--appname-->
			
			<!--buttondivpage-->
			<div class="buttondivpage">
			    <label>
			    <input name="Submit" type="submit" class="savebtn" value="" />
                </label>
			</div>
            </form>
			<!--//buttondivpage-->
		</div>
		<!--//appmsglist-->
        </div>
		<!--//msglist-->		
		</td>
      </tr>
  </table>
</div>
<!--//container-->
</body>
</html>
