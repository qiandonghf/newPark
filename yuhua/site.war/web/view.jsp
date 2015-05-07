<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %> 

<%
	String basePath = BaseAction.rootLocation + request.getContextPath();
%>

<jsp:include page="header.jsp" />
<body>

<div id="bodychild">
	<div id="outercontainer">
    
	<jsp:include page="menu.jsp"/>
        
        <!-- AFTER HEADER -->
        <div id="outerafterheader">
        	<div id="headerimg"><img src="<%=basePath%>/web/images/header/header4.jpg" alt="" /></div>
            <div class="container">
                <div id="afterheader" class="twelve columns">
                	<div class="pagetitle-container">
                        <h1 class="pagetitle">${articleType.typeName}</h1>
                        <span class="pagedesc">这里是一段口号</span>
                    </div>
                </div>
            </div>
        </div>
        <!-- END AFTER HEADER -->
        
        
        <!-- MAIN CONTENT -->
        <div id="outermain">
        	<div class="container">
        	<section id="maincontent" class="twelve columns">
				<section id="content" class="positionleft nine columns alpha"> 
                	<div class="padcontent">
                            <h2 class="posttitle"><c:out value="${article.title}"/></h2>
                            <div class="entry-utility">
                                <fmt:formatDate value="${article.pubTime }" pattern="yyyy-MM-dd" /> &nbsp;&nbsp;/&nbsp;&nbsp;来源： ${article.source}
                            </div>                           
 							<h1 class="newlisttitle"></h1>
 							<div class="entry-content">
 
								${article.content}
<!--                             	<a href="single.html" class="more-link">阅读更多 &rarr;</a>
 -->                                <div class="clearfix"></div>
                            </div>
                    </div><!-- end padcontent -->
                </section><!-- end content -->
                <aside id="sidebar" class="positionright three columns omega">
                    <ul>
                         <li class="widget-container">
                            <h2 class="widget-title">${articleType.typeName}</h2>
                            <ul>
							<s:iterator value="articleTypeList" status="it" >
								<li >
									<a href='<s:property  value="%{urlPackage(articleTypeList[#it.index].id,tag)}"/>'><s:property  value="%{articleTypeList[#it.index].typeName}"/></a>
								</li>						
							</s:iterator>
                            </ul>
                        </li>
                    </ul>
                </aside><!-- end sidebar -->
                <div class="clear"></div><!-- clear float --> 
            </section>
            </div>
        </div>
        <!-- END MAIN CONTENT -->
        
    
        
<jsp:include page="footer.jsp"/>
        
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
