<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java"
	import="java.util.*,com.wiiy.commons.action.BaseAction"
	pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path;
%>


<!DOCTYPE html>
<html lang="zh-cn">
	<jsp:include page="head.jsp" />
<%-- 	<script type="text/javascript" src="core/common/js/jquery.js"></script>
	<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
	<script type="text/javascript">	
	$(function(){
		initList();'
	}
	function initlist()){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/indexlist.action,
		   success	: function(data){
			   $("#"+id+"7").text(data.data7);
			   $("#"+id+"15").text(data.data15);
			   $("#"+id+"30").text(data.data30);
		   }

		});
	}
	</script> --%>
	<body>
    <div class="jumbotron">
        <div class="container">
            <div class="row">
                <div class="bannerindex">
                	<a class="erweima" href="">
                	</a>
                </div>
            </div>
        </div>
    </div>
	<div class="container features-section-wrapper" id="features">
        <div class="row">
            <div class="span4 feature-wrapper">
                <h4 class="feature-title">关于我们<a class="more" href="<%=BaseAction.rootLocation%>/content.action"></a></h4>
                <div class="feature-text">
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;“彩宏科技”致力于成为“为企业技术创新战略决策提供专业解决方案”的顾问专家机构，凭借多年的咨询服务经验，已经成为科技咨询领域的领先者，向客户提供高品质的咨询服务，受到业界合作伙伴一致的好评。
              <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;彩虹科技拥有丰富的企业家、科研院所、科技人才、创投机构、社会中介的资源，熟悉国家科技产业政策、高新技术企业产业政策，科技企业孵化器政策、大学生创业、人才政策、中小板和创业板上市法律法规、规则知识，建有由上千家企业构建的高新技术企业数据库、200多名省内外专家组成的专家库。
                </div>
            </div>
            <div class="span4 feature-wrapper" style="width:477px;">
                <h4 class="feature-title">新闻动态<a class="more" href="#"></a></h4>
                <div class="feature-text">
                 <ul>
          		<c:forEach items="${articleList}" var="article" varStatus="s">
				  <li><a href="<%=BaseAction.rootLocation%>/content.action?article.id=${article.id}&categoryName=政策资讯">${article.title}</a><span><fmt:formatDate value="${article.pubTime }" pattern="yyyy-MM-dd" /></span></li>
				  </c:forEach>
				</ul>   
                </div>
            </div>
            <div class="span4 feature-wrapper">
                <h4 class="feature-title">联系方式<a class="more" href="#"></a></h4>
                <div class="feature-text">
                 <img src="<%=BaseAction.rootLocation%>/web/image/contact2.jpg" width="266" height="92" />
				  <p><label>公司电话：</label><span>0571-86649937</span></p>
				  <p><label>公司传真：</label><span>0571-86649937</span></p>
				  <p><label>Email：</label><span>snny22@163.com</span></p> 
				  <p><label>公司地址：</label><span>杭州市滨江区长河路475号和瑞科技园T3 301   邮编：310005</span></p>
			 </div>
            </div>
        </div>

       

    </div>
	<jsp:include page="foot.jsp" />
	
	</body>
</html>


