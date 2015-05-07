<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
			initTip();
			initForm();
        });
        
    	function initForm(){
    		$("#orgForm").validate({
    			rules: {
    				"org.name":"required"
    			
    			},
    			messages: {
    				"org.name":"请输入机构名称"
    		
    				
    			},
    			errorPlacement: function(error, element){
    				showTip(error.html());
    			},
    			submitHandler: function(form){
    				$('#orgForm').ajaxSubmit({ 
    			        dataType: 'json',		        
            			success:function(result) {
		                    if (result.success) {
		                        <c:if test="${org.new}">
		                        getOpener().addSubOrg(${org.parent.id}, result.value);
		                        fb.end();
		                        showTip("添加成功",2000);
		                        </c:if>
		                        <c:if test="${not org.new}">
		                        getOpener().updateOrg(result.value);
		                        fb.end();
		                        showTip("保存成功",2000);
		                        </c:if>
		                    } else {
	                            showTip(result.msg);
		                    }
		                }
    			    });
    			}
    		});
    	}
    </script>
</head>

<body>
<form name="orgForm" id="orgForm" method="post" action="${contextLocation}org!save.action">
    <input type="hidden" name="org.id" value="${org.id}"/>
    <input type="hidden" name="org.parent.id" value="${org.parent.id}"/>
    <!--basediv-->
    <div class="basediv">
        <!--titlebg-->
        <!--//titlebg-->
        <!--divlay-->
        <div class="divlays" style="margin:0px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="layertdleft"><span class="psred">*</span>机构名称：</td>
                    <td><label>
                        <input type="text" name="org.name" value="${org.name}" class="input220"/>
                    </label></td>
                </tr>
                <tr>
                    <td class="layertdleft">上级机构：</td>
                    <td>
                    &nbsp;${org.parent.name}
                    </td>
                </tr>
<!--                <tr>
                    <td class="layertdleft"><span class="psred">*</span>状态：</td>
                    <td>
                        <label>
							&nbsp;<enum:radio name="org.entityStatus" type="com.wiiy.commons.preferences.enums.EntityStatus" checked="org.entityStatus" />
                        </label>
                    </td>
                </tr>

                 <tr>
                    <td class="layertdleft">完成路径：</td>
                    <td>&nbsp;</td>
                </tr>
 -->                <tr>
                    <td class="layertdleft">备注：</td>
                    <td class="layerright">
                        <textarea name="org.memo" rows="4" class="textareaauto">${org.memo}</textarea>
                    </td>
                </tr>
            </table>
        </div>
        <!--//divlay-->
        <div class="hackbox"></div>
    </div>
    <!--//basediv-->
    <!--basediv-->
    <!--//basediv-->
    <div class="buttondiv">
        <label>
            <input name="Submit" type="submit" class="savebtn" value=""/>
        </label>
        <input name="Submit2" type="button" class="cancelbtn" value="" onclick="fb.end();"/>
    </div>
</form>
</body>
</html>
