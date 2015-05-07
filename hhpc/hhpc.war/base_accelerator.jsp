<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${category.typeName }</title>

<!---样式---->
	<%-- <jsp:include page="style.jsp"></jsp:include> --%>
<!---样式结束----> 
<script>
<!--
/*第一种形式 第二种形式 更换显示样式*/
function setTab(m,n){
var tli=document.getElementById("menu"+m).getElementsByTagName("li");
var mli=document.getElementById("main"+m).getElementsByTagName("ul");
for(i=0;i<tli.length;i++){
   tli[i].className=i==n?"hover":"";
   mli[i].style.display=i==n?"block":"none";
}
}
//-->
</script>
</head>
<body>
<%-- <!---顶部开始---->
	<jsp:include page="header.jsp"></jsp:include>
<!---顶部结束----> 

<!---基地主体内容开始---->
<div class="contenter"> 
  
  <!---基地联系介绍内容开始---->
  <div class="jidijieshao">
    <ul id="white">
      <li class="title"><strong>${category.typeName }</strong></li>
      <li>联系电话：0571-7268002</li>
      <li>邮箱：jiangbeijidi@sina.com</li>
      <li>传真：0571-87985585 </li>
      <li>地址：杭州市滨江区江南大道3850号创新大厦12楼(310053) </li>
      <li class="but">
        <input onclick="location.href='serviceView.action?type=base';" name="shenqingruzhu" type="image" src="images/but_ruzhu.gif" />
      </li>
    </ul>
  </div>
  <!---基地联系介绍内容结束----> 
  
  <!---基地导航开始---->
  <div id="navmaster">
    <ul>
      <li id="ctl01_liIndex" class="M1Common M1">
        <div style="padding-top:27px;"><a href="index.action">首&nbsp;页</a></div>
      </li>
      <c:forEach items="${categoryList }" var="category" varStatus="status">
        <c:if test="${status.index == 0 }">
	      <li id="ctl01_liQCenter" class="M2Common M2">
	        <div style="padding-top:44px;"><a title="" href="${category.url }&id=${category.id }">${category.typeName }</a><span class="bordCss bordBottomCssN"></span></div>
	      </li>
        </c:if>
        <c:if test="${status.index == 1 }">
	      <li id="ctl01_liPrice" class="M3Common M3">
	        <div style="padding-top:32px;"><a style="padding:9px 0 0px 21px;" href="${category.url }&id=${category.id }">${category.typeName }</a></div>
	      </li>
        </c:if>
        <c:if test="${status.index == 2 }">
	      <li id="ctl01_liUseCase" class="M4Common M4">
	        <div style="padding-top:23px;"><a href="${category.url }&id=${category.id }">加速器</a><span class="bordCss bordBottomCssN"></span></div>
	      </li>
        </c:if><c:if test="${status.index == 3 }">
	      <li id="ctl01_liCustomer" class="M5Common M5">
	        <div style="padding-top:37px;text-align:left;padding-left:14px;"><a style="" href="${category.url }&id=${category.id }">创业苗圃</a></div>
	      </li>
        </c:if>
      </c:forEach>
      
    </ul>
    <div class="hackbox"></div>
  </div>
  
  <!---基地导航结束----> 
  
  <!---基地介绍开始----> 
  <!--第二种形式-->
  
  <div class="jidijieshaoneirong">
  <div id="tabs0">
    <ul class="menu0" id="menu0">
       <c:forEach items="${articleList }" var="article" varStatus="status">
       	   <c:if test="${status.index == 0 }">
		       <li onclick="setTab(0,0)" class="hover">${article.title }</li>
       	   </c:if>
       	   <c:if test="${status.index != 0 }">
		       <li onclick="setTab(0,${status.index })">${article.title }</li>
       	   </c:if>
       </c:forEach>
    </ul>
    <div class="main" id="main0">
	   <c:forEach items="${articleList }" var="article" varStatus="status">
       <c:if test="${status.index == 0 }">
       <ul class="block">
    		<li>${article.content }</li>
       </ul>
       </c:if>
       <c:if test="${status.index != 0 }">
       <ul>
    		<li>${article.content }</li>
       </ul>
       </c:if>
       </c:forEach>
    </div>
</div>
  </div>
  <div class="hackbox"></div>
  <!---基地介绍结束----> 
  
  <!---基地z照片介绍开始---->
  	<jsp:include page="base_photos.jsp"></jsp:include>
  <!---基地照片介绍结束----> 
  
  <!---基地最后一部分开始---->
  <div class="jidilast"> 
    
    <!---基地服务开始---->
    <div class="jidifuwu">
      <h1>基地服务</h1>
      <ul>
        <li class="topw"> <em> <img src="images/ico_01.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
        <li class="topw"> <em><img src="images/ico_02.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
        <li class="topw rigthw"> <em><img src="images/ico_03.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
        <li> <em> <img src="images/ico_04.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
        <li> <em> <img src="images/ico_05.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
        <li class="rigthw"> <em> <img src="images/ico_06.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
        <li> <em> <img src="images/ico_01.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
        <li> <em> <img src="images/ico_02.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
        <li class="rigthw"> <em> <img src="images/ico_03.gif" width="33" height="37" /></em> <span><a href="#">基地服务</a></span> </li>
      </ul>
    </div>
    <!---基地服务结束----> 
    
    <!---入驻基地开始---->
    <div class="ruzhuqiye">
      <h1>入驻企业</h1>
      <ul>
      	<c:forEach items="${customers }" var="customer">
	        <li><em><img src="images/ico3.gif" width="8" height="5" /></em><a href="enterpriseView.action?type=south&id=${customer.id }">『入驻企业』${customer.name }</a></li>
      	</c:forEach>
      </ul>
      <p><a href="enterprise.action?type=south" class="blue2"> 更多...</a></p>
    </div>
    <!---入驻基地结束----> 
    
    <!---联系方式开始---->
    <div class="lianxifangshi">
      <h1>申请入驻</h1>
      <p><span>联系方式：<a href="#"><img src="images/phone.gif" width="30" height="30" /></a> <a href="#"><img src="images/qq.gif" width="31" height="31" /></a><br />
        <strong>400-123- 4567</strong></span></p>
      <ul>
        <li class="dizhi"> <em><img src="images/adress.gif" width="12" height="16" /></em> <span>地址：杭州市滨江区江南大道3850号 创新大厦12楼（310053）</span> </li>
        <li> <em><img src="images/phone-15.gif" width="14" height="14" /></em> <span>电话 :86 -021-34639651</span> </li>
        <li> <em><img src="images/chuanzhen.gif" width="16" height="12" /></em> <span>传真 :86 -021-34660535</span> </li>
        <li> <em><img src="images/email.gif" width="14" height="14" /></em> <span>E-mail: manager@hang</span> </li>
      </ul>
    </div>
    <!---联系方式结束---->
    
    <div class="hackbox"></div>
  </div>
  
  <!---基地最后一部分结束---->
  
  <div class="hackbox"></div>
</div>

<!---基地主体内容结束----> 

<!---底部开始---->
	<jsp:include page="footer.jsp"></jsp:include>
<!---底部结束---->
 --%>
 <h4 style="text-align:center;padding-top:100px;">正在建设中……</h4>
</body>
</html>
