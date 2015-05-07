<%--@elvariable id="enums" type="java.util.Map<String, Map<String, String>>"--%>
<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.wiiy.commons.preferences.enums.EntityStatus"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
			initTip();
			initForm();
           $("#roleList > li").each(function(index,li){
          	  $(this).click(function(e){
         		  $(this).find("a").toggleClass("bgli");
         	  }); 
         	  $(this).dblclick(function(e){
         		  swap("#selectedRoles", "#roleList", this);
         	  }); 
            });
           $("#selectedRoles > li").each(function(index,li){
           	  $(this).click(function(e){
         		  $(this).find("a").toggleClass("bgli");
         	  }); 
         	  $(this).dblclick(function(e){
         		  swap("#roleList", "#selectedRoles", this);
         	  }); 
            });
           $("#goLeft").click(function(e){
        	   $("#roleList .bgli").each(function (index, a){
           		  swap("#selectedRoles", "#roleList", a.parentNode);
        	   });
             });
           $("#goRight").click(function(e){
        	   $("#selectedRoles .bgli").each(function (index, a){
           		  swap("#roleList", "#selectedRoles", a.parentNode);
        	   });
             });
           
	   		initUploadify("fileUpload");
        });
        
        function initForm() {
    		$("#userForm").validate({
    			rules: {
    				"user.username":"required",
    				"user.realName":"required",
    				"user.userType":"required",
    				"user.email" : {"required":true, "email":true},
    				"user_org_name" : "required",
        			"user.msn" : "email"
    			},
    			messages: {
    				"user.username":"请输入用户名",
    				"user.realName":"请输入用户真实姓名",
    				"user.userType":"请选择用户类型",
    				"user.email" : {"required":"请输入email", "email":"email格式不对"},
    				"user_org_name" : "请选择所属机构",
    				"user.msn" : "msn格式不对"
    			},
    			errorPlacement: function(error, element){
    				showTip(error.html());
    			},
    			submitHandler: function(form){
   	         	   $("#user_imagery").val($("#user_imagery_img").attr("src"));
    				$('#userForm').ajaxSubmit({ 
    			        dataType: 'json',		        
     					beforeSubmit:function(formData, jqForm, options) {
     						$("#selectedRoles > li").each(function(index, li){
     							formData[formData.length]={name:"user.roleRefList["+index+"].role.id", value:$(li).attr("roleId")};
     						});
     						return true;
     					},
     					success:function(root, statusText) {
     						if (root.result.success) {
     						    getOpener().refreshDataTables();
     						    fb.end();
     						    //parent.$.showMessage("保存成功！");
     						} else {
     						    showTip(root.result.msg);
     						}
     	                }
    			    });
    			}
    		});
        }
        
        function swap(targetUl, sourceUl, li) {
        	$(li).remove();
        	$(targetUl).append($(li));
        	$(li).find("a").removeClass("bgli");
         	$(li).click(function(e){
         		$(this).find("a").toggleClass("bgli");
         		}); 
        	$(li).dblclick(function(e) {
        		swap(sourceUl, targetUl, this);
        		});
        }
        function setSelectedOrg(selectedOrg) {
        	$("#user_org_id").val(selectedOrg.id);
        	$("#user_org_name").val(selectedOrg.name);
        }
        
    	function initUploadify(id){
    		$("#"+id).uploadify( {
    			'auto'				: true, //是否自动开始 默认true
    			//'multi'				: false, //是否支持多文件上传 默认true
    			'formData'			: {'module':'core','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
    			'uploader'			: "<%=BaseAction.rootLocation%>/core/upload.action",
    			'swf'				: uploadify.swf,//上传组件swf
    			'width'				: "30",//按钮图片的长度
    			'height'			: uploadify.height,//按钮图片的高度
    			'buttonText'		: "上传",
    			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
    			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
    			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
    			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
    			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
    			'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
    		});
    	}
    	function onUploadSuccess(file, data, response) {
    		$("#user_imagery_img").attr("src", "core/resources/"+$.parseJSON(data).path);
 		}
    	function startUpload(id){
    		$("#"+id).uploadify("upload");
    	}
    	function removeImagery() {
    		var userImagery = $("#user_imagery_img").attr("src");
    		$("#user_imagery_img").attr("src", userImagery + "-d");
    		$("#user_imagery").val("core/common/images/topxiao.gif");
    		$("#user_imagery_img").attr("src", "core/common/images/topxiao.gif");
    	}
    </script>
</head>

<body>
<c:choose>
    <c:when test="${user.new}"><c:set var="method" value="save"/></c:when>
    <c:otherwise><c:set var="method" value="update"/></c:otherwise>
</c:choose>
<form id="userForm" name="userForm" method="post" action="${contextLocation}user!${method}.action">
<input type="hidden" name="user.id" value="${user.id}" />
<!--basediv-->
<div id="scrollDiv" >			
<div class="basediv">
	<!--titlebg-->
	<div class="layertitle">基本信息</div>
	<!--//titlebg-->
	<!--divlay-->
	<div class="divlays">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="layertdleft"><span class="psred">*</span>用户名：</td>
              <td><label>
                <input name="user.username" type="text" class="input200" value="${user.username}"/>
              </label></td>
            </tr>
            <tr>
              <td class="layertdleft"><span class="psred">*</span>真实姓名：</td>
              <td><input name="user.realName" type="text" class="input200" value="${user.realName}"/></td>
            </tr>
            <tr>
              <td class="layertdleft"><span class="psred">*</span>管理员：</td>
              <td>&nbsp;
                 <enum:radio name="user.admin" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="user.admin" />
              </td>
            </tr>
            <tr>
              <td class="layertdleft"><span class="psred">*</span>用户类型：</td>
              <td>&nbsp;
                 <enum:radio name="user.userType" type="com.wiiy.commons.preferences.enums.UserTypeEnum" checked="user.userType" />
              </td>
            </tr>
            <tr>
              <td class="layertdleft">出生年月：</td>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="170"><input name="user.birthday" type="text" class="input170" id="user.birthday" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${user.birthday}"/>' /></td>
                  <td width=20><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left: -1px;" onclick="return showCalendar('user.birthday', 'y-mm-dd');"/></td>
			      <td>&nbsp;</td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td class="layertdleft">移动电话：</td>
              <td><input name="user.mobile" type="text" class="input200" value="${user.mobile}" /></td>
            </tr>
          </table>
          </td>
          <td valign="top">
          <table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
			<tr>
              <td width="96">
              <c:if test="${user.imagery != null}">
              <img id="user_imagery_img" src="${user.imagery}" width="107" height="110" class="touxian" />
              </c:if>
              <c:if test="${user.imagery == null}">
              <img id="user_imagery_img" src="core/common/images/topxiao.gif" width="107" height="110" class="touxian" />
              </c:if>
              </td>
              <td width="15" align="center" valign="bottom"><img src="core/common/images/xtopico3.png" width="13" height="13" onclick="removeImagery()" /></td>
              <td valign="top" style="padding-top:12px;">
				<input type="file" id="fileUpload" />
		      	<input  type="hidden" id="user_imagery" name="user.imagery" value="${user.imagery}"/>
		      </td>
            </tr>
          </table>
          </td>
        </tr>
      </table>
	  
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="layertdleft">固定电话：</td>
              <td><input name="user.telephone" type="text" class="input200" value="${user.telephone}" /></td>
            </tr>
            <tr>
              <td class="layertdleft"><span class="psred">*</span>Email：</td>
              <td><label>
                <input name="user.email" type="text" class="input200" value="${user.email}" />
              </label></td>
            </tr>
            <tr>
              <td class="layertdleft">MSN：</td>
              <td><input name="user.msn" type="text" class="input200" value="${user.msn}" /></td>
            </tr>

          </table></td>
          <td valign="top"><table width="99%" border="0" align="right" cellpadding="0" cellspacing="0">
            <tr>
              <td class="layertdleft">性别：</td>
              <td><label>
				&nbsp;<enum:radio name="user.gender" type="com.wiiy.commons.preferences.enums.GenderEnum" checked="user.gender" />
              </label></td>
            </tr>
            <tr>
              <td class="layertdleft"><span class="psred">*</span>所属机构：</td>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                  <input id="user_org_id" name="user.org.id" type="hidden" value="${user.org.id}"/>
                  <input id="user_org_name" name="user_org_name" type="text" class="input170" value="${user.org.name}" readonly="readonly"/>
                  </td>
                  <td align="right"><a href="javascript:void(0);" onclick="fbStart('选择机构','${contextLocation}org!select.action',520,400);"><img src="core/common/images/outdiv.gif" width="20" height="22" /></a></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td class="layertdleft">状态：</td>
              <td><label>
                <enum:select name="user.entityStatus" styleClass="data" type="com.wiiy.commons.preferences.enums.EntityStatus" checked="user.entityStatus"/>
              </label></td>
            </tr>
          </table></td>
        </tr>
      </table>
	  
	</div>
	<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="layertitle">用户角色</div>
	<!--//titlebg-->
	<!--roleleft-->
	<div class="roleleft">
		<div class="roletitle">所有角色</div>
		<div class="rolelist">
		<ul id="roleList">
		<c:forEach var="role" items="${roleList}">
			<c:if test="${empty selectedRoleIds[role.id]}">
			<li roleId="${role.id}"><a href="javascript:void(0);">${role.name}</a></li>
			</c:if>
		</c:forEach>
		</ul>
		</div>
	</div>
	<!--//roleleft-->
	<!--rolebtn-->
	<div class="rolebtn"><img id="goLeft" src="core/common/images/left.png" width="16" height="16"/><img id="goRight" src="core/common/images/right.png" width="16" height="16" /></div>
	<!--//rolebtn-->
	<!--roleleft-->
	<div class="roleleft">
		<div class="roletitle">已选角色</div>
		<div class="rolelist">
		<ul id="selectedRoles">
			<c:forEach var="userRoleRef" items="${user.roleRefs}">
			<li roleId="${userRoleRef.role.id}"><a href="javascript:void(0);">${userRoleRef.role.name}</a></li>
			</c:forEach>
		</ul>
		</div>
	</div>
	<!--//roleleft-->
	
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<div class="buttondiv">
  <label>
  <input name="Submit" type="submit" class="savebtn" value="" />
  </label>
  <input name="Submit2" type="button" class="cancelbtn" value="" onclick="fb.end()"/>
</div>
</div>
</form>
</body>
</html>
