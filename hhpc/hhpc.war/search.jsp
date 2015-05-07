<%@page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@page import="com.wiiy.commons.util.StringUtil"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String url = BaseAction.rootLocation+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=InitListener.webParam.getName() %></title>
<!---样式---->
	<jsp:include page="style.jsp"></jsp:include>
<!---样式结束---->
	<script type="text/javascript">
		function searchPage(page){
			var url = "<%=BaseAction.rootLocation+path%>search.action?searchContent=${searchContent}&page="+page;
			url = encodeURI(url);
			url = encodeURI(url);
			location.href = url;
		}
		$(function(){
			$("input[name='searchContent']").each(function(){
				$(this).val("${searchContent}");
			});
		});
	</script>
</head>
<body>

<!---顶部开始---->
	<jsp:include page="header.jsp"></jsp:include>
<!---顶部结束----> 
<!---导航开始---->
	<jsp:include page="navi.jsp"></jsp:include>
<!---导航结束----> 

<!---焦点图开始---->
	<jsp:include page="view_photo.jsp"></jsp:include>
<!---焦点图结束----> 

<!---主体内容开始---->
<div id="main" style="padding-top:25px;"> 
	<!---左侧标题开始---->
	<h1 class="Title5">
    	<p>当前位置：<a href="index.action">首页</a>&nbsp;&nbsp;》全文检索</p>
	</h1>
	<!---左侧标题结束----> 
	<div class="hackbox"></div>
	<!---全文检索开始---->
	<div id="search" style="padding-top:30px;" >
		<form action="<%=BaseAction.rootLocation %>/search.action" method="post" name="form" id="form2">
			<div id="">
		        <ul>
		            <li class="left"> <span class="TPL_username_1" id="searchs"></span>
		              <input name="searchContent" type="text" class="search_input" onblur="onblurs(this);" id="keyword2" onclick="clickText(this);" value="搜索站内信息"/>
		            </li>
		            <li class="right">
		              <input type="button" class="btn" onclick="doSearch('keyword2','form2');" value="" src="images/search.gif"  />
		            </li>
		        </ul>
			</div>
		</form>
    	<div class="hackbox"></div>
  	</div>
	<!---全文检索结束----> 
  
	<!---全文检索结果开始---->
	<div class="search_top"  > <span>在当前资源中</span>
	  <c:if test="${pager.total > 1 }">
	  	<c:if test="${pager.total == pager.page }">
		  <p>共有<font color="#FF0000">${pager.records }</font>项符合<font color="#FF0000">${searchContent }</font>的查询结果 ，以下是第 ${(pager.page-1)*10+1 } -  ${pager.records}项</p>
	  	</c:if>
	  	<c:if test="${pager.total != pager.page }">
		  <p>共有<font color="#FF0000">${pager.records }</font>项符合<font color="#FF0000">${searchContent }</font>的查询结果 ，以下是第 ${(pager.page-1)*10+1 } -  ${(pager.page)*10 } 项</p>
	  	</c:if>
	  </c:if>
	  <c:if test="${pager.total == 0 }">
		  <p>共有<font color="#FF0000">${pager.records }</font>项符合<font color="#FF0000">${searchContent }</font>的查询结果</p>
	  </c:if>
	  <c:if test="${pager.total == 1 }">
		  <p>共有<font color="#FF0000">${pager.records }</font>项符合<font color="#FF0000">${searchContent }</font>的查询结果 ，以下是第 ${(pager.page-1)*10+1 } - ${(pager.page-1)*10+pager.records } 项</p>
	  </c:if>
	</div>
	<!---全文检索结果结束----> 
	
	<!---全文检索翻页开始---->
	<div class="page" style="float:right;">
	  <ul>
	  	<c:if test="${pager.total > 1 }">
	  		<c:if test="${pager.page == 1 }">
			    <h1>
			    	<em class="pagepre"><a href="javascript:;">上一页</a></em>
			    	<em class="pagenext"><a href="javascript:searchPage(${pager.page+1 });">下一页</a></em>
			    </h1>
	  		</c:if>
	  		<c:if test="${pager.page != 1 }">
			    <h1>
			    	<em class="pagepre"><a href="javascript:searchPage(${pager.page-1 });">上一页</a></em>
			    	<c:if test="${pager.page != pager.total }">
			    	<em class="pagenext"><a href="javascript:searchPage(${pager.page+1 });">下一页</a></em>
			  		</c:if>
			    	<c:if test="${pager.page == pager.total }">
			    	<em class="pagenext"><a href="javascript:;">下一页</a></em>
			  		</c:if>
			    </h1>
	  		</c:if>
	  		<li>
	  		<c:if test="${pager.total <= 6}">
				<c:set value="${pager.total}" var="end"></c:set>	  			
	  		</c:if>
	  		<c:if test="${pager.total > 6}">
				<c:set value="6" var="end"></c:set>	  			
	  		</c:if>
	  		<c:forEach begin="1" end="${end}" var="num">
	  			<c:if test="${pager.page == num }">
	  				<span class="span">${num }</span>
	  			</c:if>
	  			<c:if test="${pager.page != num }">
	  				<a href="javascript:searchPage(${num });">${num }</a>
	  			</c:if>
	  		</c:forEach>
	  		<c:if test="${pager.total > 6 }">
	  			...<a href="javascript:searchPage(${pager.total });">${pager.total}</a>
	  		</c:if>
	  		</li>
	  	</c:if>
	  	<c:if test="${pager.total <= 1 }">
	  		<h1>
		    	<em class="pagepre"><a href="javascript:;">上一页</a></em>
		    	<em class="pagenext"><a href="javascript:;">下一页</a></em>
		    </h1>
		    <li><span class="span">1</span></li>
	  	</c:if>
	  </ul>
	</div>
	<!---全文检索翻页结束----> 
   	<div class="hackbox"></div>
	
	<!---主体内容右侧开始---->
  <div class="searchlist">
  	<c:set var="searchContent" value="${searchContent }"></c:set>
  	<c:forEach items="${articleList }" var="article" varStatus="status">
  		<c:set var="title" value="${article.title }"></c:set>
  		<c:set var="content" value="${article.contentText }"></c:set>
  		<c:set var="url" value="${article.articleType.url }"></c:set>
  		<% 
  			String title = pageContext.getAttribute("title").toString();
  			String content = pageContext.getAttribute("content").toString();
  			String searchContent = pageContext.getAttribute("searchContent").toString();
  			String typeUrl = pageContext.getAttribute("url").toString();
  			if(!"".equals(typeUrl)){
  				StringBuilder builder = new StringBuilder(typeUrl);
  				int pos = builder.indexOf(".action");
  				if(pos != -1){
  					builder.insert(pos, "View");
  					pos = builder.indexOf("?");
  					if(pos != -1){
	  					builder.append("&id=");
  					}else{
  						builder.append("?id=");
  					}
  					typeUrl = builder.toString();
  				}
  			}else{
  				typeUrl = "view.action?id=";
  			}
  			StringBuilder builder = new StringBuilder(content);
  			int pos = content.indexOf(searchContent);//关键字首次出现的位置
  			if(pos != -1){
  				content = builder.substring(pos);
  				builder.setLength(0);
  				builder.append(content);
  			}
  			if(pos > 0){
				builder.insert(0,"...");
			} 
  			if(builder.length() > 156){
				content = builder.substring(0,156);
				builder.setLength(0);
				builder.append(content);
				builder.append("...");
			}
  			content = builder.toString();
  		%>
	    <ul>
	      <li>${status.index+1+(pager.page-1)*10 } &nbsp;&nbsp;<span style="color:#ccc"><a href='<%=typeUrl %>${article.id}&categoryId=${article.articleType.id}' target='_blank' class="blue"><%=title.replaceAll(searchContent, "<font color='red'>"+searchContent+"</font>") %></a></span>&nbsp;<span style="color:#0000CC;font-size:12px"></span> </li>
	      <li class="bg">
	      	<%=content.replaceAll(searchContent, "<font color='red'>"+searchContent+"</font>") %>
          </li>
	      <li>
	      	<span><font onclick="location.href='<%=BaseAction.rootLocation+path+typeUrl %>${article.id}'" style="cursor:pointer;color:#007e01;margin-top:5px"><%=BaseAction.rootLocation+path+typeUrl %>${article.id}&nbsp;&nbsp;<fmt:formatDate value="${article.pubTime }" pattern="yyyy.MM.dd" />&nbsp;&nbsp;</font><span>
	      </li>
	    </ul>
  	</c:forEach>
  </div>
  
	<!---搜索页面底部内容开始---->
	<div class="search_fot">
		<!---全文检索开始---->
		<form action="<%=BaseAction.rootLocation %>/search.action" method="post" name="form" id="form3">
			<div id="search">
		        <ul>
		            <li class="left"> <span class="TPL_username_1" id="searchs"></span>
		              <input name="searchContent" type="text" class="search_input" onblur="onblurs(this);" id="keyword3" onclick="clickText(this);" value="搜索站内信息"/>
		            </li>
		            <li class="right">
		              <input type="button" class="btn" onclick="doSearch('keyword3','form3');" value="" src="images/search.gif"  />
		            </li>
		        </ul>
			</div>
		</form>
		<!---全文检索翻页开始---->
		<div class="page" style="float:right;padding-top:5px;padding-right:4px;height:32px;line-height:32px;">
		  <ul>
		  	<c:if test="${pager.total > 1 }">
		  		<c:if test="${pager.page == 1 }">
				    <h1>
				    	<em class="pagepre"><a href="javascript:;">上一页</a></em>
				    	<em class="pagenext"><a href="javascript:searchPage(${pager.page+1 });">下一页</a></em>
				    </h1>
		  		</c:if>
		  		<c:if test="${pager.page != 1 }">
				    <h1>
				    	<em class="pagepre"><a href="javascript:searchPage(${pager.page-1 });">上一页</a></em>
				    	<c:if test="${pager.page != pager.total }">
				    	<em class="pagenext"><a href="javascript:searchPage(${pager.page+1 });">下一页</a></em>
				  		</c:if>
				    	<c:if test="${pager.page == pager.total }">
				    	<em class="pagenext"><a href="javascript:;">下一页</a></em>
				  		</c:if>
				    </h1>
		  		</c:if>
		  		<li>
		  		<c:if test="${pager.total <= 6}">
					<c:set value="${pager.total}" var="end"></c:set>	  			
		  		</c:if>
		  		<c:if test="${pager.total > 6}">
					<c:set value="6" var="end"></c:set>	  			
		  		</c:if>
		  		<c:forEach begin="1" end="${end}" var="num">
		  			<c:if test="${pager.page == num }">
		  				<span class="span">${num }</span>
		  			</c:if>
		  			<c:if test="${pager.page != num }">
		  				<a href="javascript:searchPage(${num });">${num }</a>
		  			</c:if>
		  		</c:forEach>
		  		<c:if test="${pager.total > 6 }">
		  			...<a href="javascript:searchPage(${pager.total });">${pager.total}</a>
		  		</c:if>
		  		</li>
		  	</c:if>
		  	<c:if test="${pager.total <= 1 }">
		  		<h1>
			    	<em class="pagepre"><a href="javascript:;">上一页</a></em>
			    	<em class="pagenext"><a href="javascript:;">下一页</a></em>
			    </h1>
			    <li><span class="span">1</span></li>
		  	</c:if>
		  </ul>
		</div>
		<!---全文检索翻页结束----> 
	</div>
	<!---全文检索结束----> 
  
  
  <div class="hackbox"></div>
</div>
<!---主体内结束----> 

<!---底部开始---->
	<jsp:include page="footer.jsp"></jsp:include>
<!---底部结束---->
</body>
</html>

