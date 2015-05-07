<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.commons.preferences.enums.TitleEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
	});
	function setSelectedUser(user){
		$("#hostId").val(user.id);
		$("#host").val(user.realName);
	}
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
</script>
</head>

<body style=" background:#fff">
<!--basediv-->
<div id="scrollDiv" class="basediv" style="height:360px; overflow-y:scroll; overflow-x:hidden">
  <!--divlays-->
  <div class="divlays" style="margin:0px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">


	  <tr>
        <td class="layertdleft100">称谓：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
           		 <search:choose dataType="com.wiiy.commons.preferences.enums.TitleEnum" field="appellation" op="eq">
           		 	<enum:select type="com.wiiy.commons.preferences.enums.TitleEnum" styleClass="data"/>
           		 </search:choose>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
		
	  <tr>
        <td class="layertdleft100">出生年月：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310"><table width="100%" border="0" cellspacing="0" cellpadding="10">
				<tr>
					<td width="120">
						<search:choose dataType="java.util.Date" field="birthday" op="ge">
							<input class="data inputauto" id="birthday" onclick="return showCalendar('birthday')"/>
						</search:choose>
					</td>
					<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer; position: relative; left:-1px;" onclick="return showCalendar('birthday')"/></td>
					<td align="center">&nbsp;</td>
				</tr>
			</table></td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <label></label></td>
      </tr>
      <tr>
        <td class="layertdleft100">姓名：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
           		 <search:input dataType="string" field="name" op="cn" inputClass="inputauto"/>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">手机号码：</td>
        <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
           		 <search:input dataType="string" field="mobile" op="cn" inputClass="inputauto"/>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">固定电话：</td>
        <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
             	<search:input dataType="string" field="homeTel" op="cn" inputClass="inputauto"/>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">Email：</td>
        <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
          		  <search:input dataType="string" field="email" op="cn" inputClass="inputauto"/>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">QQ：</td>
        <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
            	<search:input dataType="string" field="qq" op="cn" inputClass="inputauto"/>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">MSN：</td>
        <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
            	<search:input dataType="string" field="msn" op="cn" inputClass="inputauto"/>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
      	<td class="layertdleft100">职务：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="position" op="cn" inputClass="inputauto"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
      <tr>
      	<td class="layertdleft100">单位名称：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="company" op="cn" inputClass="inputauto"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
      <tr>
      	<td class="layertdleft100">单位地址：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="companyAddr" op="cn" inputClass="inputauto"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
      <tr>
      	<td class="layertdleft100">单位电话：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="officeTel" op="cn" inputClass="inputauto"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
      <tr>
      	<td class="layertdleft100">单位传真：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="fax" op="cn" inputClass="inputauto"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
      <tr>
      	<td class="layertdleft100">家庭地址：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="homeAddr" op="cn" inputClass="inputauto"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
      <tr>
      	<td class="layertdleft100">家庭邮编：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="zipcode" op="cn" inputClass="inputauto"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
      <tr>
      	<td class="layertdleft100">配偶：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="spouse" op="cn" inputClass="inputauto"/>
					</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
      <tr>
      	<td class="layertdleft100">子女：</td>
      	<td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="310">
					<search:input dataType="string" field="child" op="cn" inputClass="inputauto"/>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
      	</tr>
    </table>
  </div>
  <!--//divlays-->
</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="button" class="search_cx" value=""  onclick="search();"/>
  </label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</body>
</html>
