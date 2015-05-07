<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction,com.site.Activator" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String basePath = BaseAction.rootLocation + request.getContextPath();
%>
        <!-- SLIDER -->
        <div id="outerslider">
        	<div id="slidercontainer">
            	
                
            	<section id="slider">
                	<div class="opacityslider"></div>
                	
                    <div id="slideritems" class="flexslider">
                        <ul class="slides">
                            <li>
                                <img src="<%=basePath%>/web/images/content/slide6.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/slide1.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/slide2.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/slide3.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/slide4.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/slide5.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/slide6.jpg" alt="" />
                            </li>
                        </ul>
                    </div>
                    
                    
                </section>
                
                <div id="thumbslider" class="container">
                <div class="twelve columns">
                    <div id="carouselslider" class="flexslider">
                          <ul class="slides">
                            <li>
                                <img src="<%=basePath%>/web/images/content/thumb6.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/thumb1.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/thumb2.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/thumb3.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/thumb4.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/thumb5.jpg" alt="" />
                            </li>
                            <li>
                                <img src="<%=basePath%>/web/images/content/thumb6.jpg" alt="" />
                            </li>
                          </ul>
                    </div>
                </div> 
                </div>
                
            </div>
        </div>
        <!-- END SLIDER -->