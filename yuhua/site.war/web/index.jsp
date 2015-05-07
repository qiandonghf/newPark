
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	String basePath = BaseAction.rootLocation + request.getContextPath();
%>

<jsp:include page="header.jsp" />
<body>
<div id="bodychild">
	<div id="outercontainer">
    
	<jsp:include page="menu.jsp"/>
        
	<jsp:include page="slider.jsp"/>
               
        <!-- MAIN CONTENT -->
        <div id="outermain" class="homepage">
        	<div class="container">
        	<section id="maincontent" class="twelve columns">
            
            	<div class="highlight-content">
<!--                 	<h1>欢迎入驻宁波镇海海外人才创业创新基地</h1>
 -->                </div>
                
                <div class="nine columns alpha">
                
                	<div class="one_half firstcols lastcols">
                        <div class="padsmallright">
                            <h3  style="font-size:18px; font-family:verdana,arial,sans-serif;">创业创新基地</h3>
                            <img src="<%=basePath%>/web/images/content/pic1.jpg" alt="" class="scale-with-grid imgborder alignnone" />
                            <p>宁波镇海创业创新基地是镇海区打造海外高层次人才和大学生创业创新聚集高地的重要平台，是带动全区经济社会转型升级的重要引擎</p>
                            <p>基地融留学生创业园、海外人才创业园、大学生创业园、镇海网络创业园于一体，采取政府与企业联合共建的运营模式，提供商务配套服务设施、生活服务设施，并提供一系列完善创业服务。</p>
                        </div>
                    </div>
                    
                    <div class="linever" style="height:340px;"></div>
                    
                    <div class="one_half firstcols lastcols">
                    	<div class="padsmallleft">
                           <h3  style="font-size:18px; font-family:verdana,arial,sans-serif;">园区资讯</h3>
                           <c:forEach items="${articleList}" var="article" varStatus="s">
                            <h5 class="margin_bottom_small"><a href="<%=basePath%>/view.action?article.id=${article.id}&tag=menu.info">${article.title}</a></h5>
                            <p>${fn:substring(article.contentText,0,60)}</p>
                           </c:forEach>
                    	</div>
                    </div>
                </div>
                <div class="three columns omega">
                    <ul class="ts-accordion">
                        <li>
                            <h2 class="accordion-title"  style="font-size:14px; font-family:verdana,arial,sans-serif;"><span class="accordion-icon"></span>科技孵化器</h2>
                            <div class="accordion-content">这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.</div>
                        </li>
                        <li>
                            <h2 class="accordion-title"  style="font-size:14px; font-family:verdana,arial,sans-serif;"><span class="accordion-icon"></span>创新创业基地</h2>
                            <div class="accordion-content">这里是文字介绍. 这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.</div>
                        </li>
                        <li>
                            <h2 class="accordion-title"  style="font-size:14px; font-family:verdana,arial,sans-serif;"><span class="accordion-icon"></span>大学生创业园</h2>
                            <div class="accordion-content">这里是文字介绍. 这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.</div>
                        </li>
                        <li>
                            <h2 class="accordion-title"  style="font-size:14px; font-family:verdana,arial,sans-serif;"><span class="accordion-icon"></span>镇海网络创业园</h2>
                            <div class="accordion-content">这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍.这里是文字介绍. </div>
                        </li>
                    </ul>
                </div>
                
                
                <div class="clear"></div><!-- clear float --> 
            </section>
            </div>
        </div>
        <!-- END MAIN CONTENT -->
        
        <!-- FOOTER SIDEBAR -->
        <div id="outerfootersidebar">
        	<div class="container">
                <div id="footersidebarcontainer" class="twelve columns"> 
                    <footer id="footersidebar">
                    <div id="footcol1" class="three columns alpha">
                    <ul>
                        <li class="widget-container">
                            <h2 class="widget-title">关于我们</h2>
                            <p>这里是关于宁波裕华的一段文字介绍</p>
                            <p>这里是关于宁波裕华的一段文字介绍. </p>
                        </li>
                    </ul>
                    </div>
                    <div id="footcol2" class="three columns">
                        <ul>
                            <li class="widget-container">
                                <h2 class="widget-title">合作商家</h2>
                                <div class="gallery-pic">
                                	<a href="#"><img src="<%=basePath%>/web/images/content/gal1.jpg" alt="" /></a>
                                    <a href="#"><img src="<%=basePath%>/web/images/content/gal2.jpg" alt="" /></a>
                                    <a href="#"><img src="<%=basePath%>/web/images/content/gal3.jpg" alt="" class="nomargin" /></a>
                                    <a href="#"><img src="<%=basePath%>/web/images/content/gal4.jpg" alt="" /></a>
                                    <a href="#"><img src="<%=basePath%>/web/images/content/gal5.jpg" alt="" /></a>
                                    <a href="#"><img src="<%=basePath%>/web/images/content/gal6.jpg" alt="" class="nomargin" /></a>
                                </div>
                                <div class="clear"></div>
                            </li>
                        </ul>
                    </div>
                    <div id="footcol3" class="three columns">
                        <ul>
                          <li class="widget-container">
                            <h2 class="widget-title">咨询</h2>
                            <div id="">
                            	一些相关的中文说明文字死了的飞机手榴弹发蓝色的房间里圣诞节发牢骚剪短发李四剪短发交流交流记录看见了科技局李经理记录就科德国法国. </p>
                            </div><!-- twitter container (don't remove) -->
                          </li>
                        </ul>
                    </div>
                    <div id="footcol4" class="three columns omega">
                        <ul>
                            <li class="widget-container">
                                <h2 class="widget-title">联系地址</h2>
                                <div class="textwidget">
                                <p>宁波裕华实业实业有限公司<br />
                                宁波镇海经济技术开发区1188号</p>
                                <p>
                                电话: +62 34534512345<br />
                                传真: +62 56676712346<br />
              电子邮件: <a href="mailto:testmail@yourdomain.com">testmail@yourdomain.com</a><br />
                                网址: <a href="http://www.cycxjd.com" class="colortext">www.cycxjd.com</a>
                                </p>
                                
                                </div>
                          </li>
                        </ul>
                    </div>
                    <div class="clear"></div>
                    </footer>
                    
                </div>
            </div>
        </div>

        <!-- END FOOTER SIDEBAR -->
        
<jsp:include page="footer.jsp" />
        
	</div><!-- end outercontainer -->
</div><!-- end bodychild -->

<!-- ////////////////////////////////// -->
<!-- //      Javascript Files        // -->
<!-- ////////////////////////////////// -->
<script type="text/javascript" src="<%=basePath%>/web/js/jquery-1.6.4.min.js"></script>

<!-- jQuery Superfish -->
<script type="text/javascript" src="<%=basePath%>/web/js/hoverIntent.js"></script> 
<script type="text/javascript" src="<%=basePath%>/web/js/superfish.js"></script> 
<script type="text/javascript" src="<%=basePath%>/web/js/supersubs.js"></script>

<!-- jQuery Flexslider -->
<script type="text/javascript" src="<%=basePath%>/web/js/jquery.flexslider-min.js"></script>
<script type="text/javascript">
jQuery(window).load(function() {
  // The slider being synced must be initialized first
  jQuery('#carouselslider').flexslider({
    animation: "slide",
    controlNav: false,
    animationLoop: false,
    slideshow: false,
    itemWidth: 157,
    itemMargin:0,
    asNavFor: '#slideritems'
  });
   
  jQuery('#slideritems').flexslider({
    animation: "fade",
	directionNav: false,
    controlNav: false,
    animationLoop: false,
    slideshow: true,
    sync: "#carouselslider"
  });
});

</script>	


<!-- jQuery Dropdown Mobile -->
<script type="text/javascript" src="<%=basePath%>/web/js/tinynav.min.js"></script>

<!-- jQuery Tweetable -->
<script type="text/javascript" src="<%=basePath%>/web/js/jquery.tweetable.js"></script>

<!-- Custom Script -->
<script type="text/javascript" src="<%=basePath%>/web/js/custom.js"></script>

<!-- Demo Switcher -->
<script type="text/javascript" src="<%=basePath%>/web/js/jquery.cookie.js"></script>


</body>
</html>
