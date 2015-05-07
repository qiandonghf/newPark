<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>无标题文档</title>
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>


</head>

<body>
<div class="basediv">
<!--userleft-->
<div class="userleftcontact">
<div class="titlebg">客户分类</div>
<div class="agencylist">
            <ul>
			 <li class="endbg"><span class="listspanico"><img src="core/common/images/leaf.gif" /></span><a href="javascript:void(0)">所有客户</a>
              <li class="close" id="titleone"><span class="listspanico1"><img src="core/common/images/opened.gif" /></span><a href="javascript:void(0)" onclick="angencylist();">按部门</a>
                    <div style="display:none" id="one">
					  <ul>
						<li class="endbg" oncontextmenu="showmenu();return false;"><span class="listspantwo"><img src="core/common/images/leaf.gif" /></span>标签一</li>
						<li class="end" oncontextmenu="showmenu();return false;"><span class="listspantwo"><img src="core/common/images/leaf.gif" /></span>标签</li>
						<li class="end"><span class="listspantwo"><img src="core/common/images/leaf.gif" /></span>标签三</li>
					  </ul>
                    </div>
              </li>
              <li class="close" id="titleone"><span class="listspanico1"><img src="core/common/images/closed.gif" /></span><a href="javascript:void(0)">按角色</a>
            </ul>
          </div>
</div>
<!--//userleft-->
<!--userright-->
<div class="userrightcontact">
<div class="titlebg">用户列表</div>
	<!--searchdiv-->
	<div class="searchdiv">
	<form id="form2" name="form2" method="post" action="">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td width="185"><label>
					  <input name="textfield32" type="text" class="inputauto" />
					</label></td>
					<td><label>
					  &nbsp; 
					  <input name="Submit3" type="submit" class="search_cx" value="" />
					</label></td>
				  </tr>
				</table>
	  </form>
	</div>
	<!--//searchdiv-->
	<!--userrightdiv-->
	<div class="userrightdivC">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="35" class="tdleftc"><label>
        <input type="checkbox" name="checkbox" value="checkbox" />
      </label></td>
      <td width="30" class="tdleftc">序列</td>
      <td width="100" class="tdleftc">姓名</td>
      <td class="tdrightc">所属机构</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">1</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">2</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">3</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">4</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">5</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">6</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">7</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">8</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">9</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
      <td class="contacttd"><label>
        <input type="checkbox" name="checkbox2" value="checkbox" />
      </label></td>
      <td class="contacttd">10</td>
      <td class="contacttd">张三</td>
      <td class="contacttd">设计部</td>
    </tr>
  </table>
	</div>
	<!--userrightdiv-->
	 <!--分页开始-->
            <div class="page">
              <ul>
                <li> <span class="first"></span><span class="pre"></span><span>显示1-6 </span><span class="next"></span><span class="last"></span>共10条</li>
              </ul>
            </div>
            <!--分页结束-->
  
</div>
<!--userright-->
<div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</body>
</html>
