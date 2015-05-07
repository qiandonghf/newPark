<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>园区动力_新</title>
<link href="core/common/style/index.css" rel="stylesheet" type="text/css" />
<link href="core/web/newdesktop/style/newindex.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/tab.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/style.css" media="screen"/>

<script type="text/javascript" src="core/common/js/menu.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tab.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.paginate.js" ></script>

<script type="text/javascript">
	var onPage = 1;
	var onPage2 = 1;
	var onPage3 = 1;
	$(document).ready(function(){
		initNoticePager();
		initNewsPager();
		initParkInfoPager();
	});
	
	function initParkInfoPager(){
		$.post("<%=BaseAction.rootLocation%>/parkmanager.cms/article!parkInformationPages.action",function(data){
			var pager = data.pager;
			if(pager.total>0){
				parkInfojPaginate(pager.total);
			}else{
				var img = "core/common/images/noimg.png";
				var a = "<a href='javascript:void(0)'><img src='"+img+"' width='228' height='170' /></a>"
				var li = "<li>"+a+"</li>";
				$("#pic").append(li);
				$("#parkInfo").empty();
				var ul = "<ul class='newslistc'><li style='text-align:center;'>暂无数据</li></ul>";
			    $("#parkInfo").append(ul);
				//$("#parkList").append("<div style='text-align: center;'><span style='font-size:30px;'>暂无数据</span></div>");
			}
		});
	}
	
	function parkInfojPaginate(totalCount){
		initParkInfoList(1);
		$("#parkInfoPage").paginate({
			count 		: totalCount,
			start 		: 1,
			display     : 8,
			border					: true,
			border_color			: '#ddd',
			text_color  			: '#15b',
			background_color    	: '#fff',	
			border_hover_color		: '#ccc',
			text_hover_color  		: '#fff',
			background_hover_color	: '#446b8c', 
			images					: false,
			mouse					: 'press',
			onChange     			: function(page){
										if(onPage2 == page){
											return;
										}
										initParkInfoList(page);
										onPage2 = page;
									  }
		});
	}
	
	function initParkInfoList(page){
		if(page!=null){
			$("#parkInfo").empty();
			$("#pic").empty();
			$.post("<%=BaseAction.rootLocation%>/parkmanager.cms/article!parkInformations.action?page="+page,function(data){
				if(data.photoArticle!=null){
					var articleLi="";
					var li = "";
					var id = data.photoArticle.id;
					var title = data.photoArticle.title;
					var img = "core/resources/"+data.photoArticle.photo;
					img = img.split(".")[0]+"335-240.png";
					var a = "<a href='javascript:void(0)' onclick='viewById("+id+")'><img src='"+img+"' width='228' height='170' /></a>"
					li += "<li>"+a+"</li>";
					articleLi += li;
					$("#pic").append(articleLi);
				}else{
					var articleLi="";
					var li = "";
					var img = "core/common/images/noimg.png";
					var a = "<a href='javascript:void(0)'><img src='"+img+"' width='228' height='170' /></a>"
					li += "<li>"+a+"</li>";
					articleLi += li;
					$("#pic").append(articleLi);
				}
				if(data.articleList!=null){
					var articleList = data.articleList;
					var articleLi = "";
					for(var i = 0;i<articleList.length;i++){
						var li = "";
						var id = articleList[i].id;
						var title = articleList[i].title;
						var toped = articleList[i].toped;
						var pubTime = "";
						if(articleList[i].pubTime!=null){
							pubTime = articleList[i].pubTime.substring(0,10);
						}
						//<em><img src='core/web/newdesktop/images/hot.png' width='20' height='9' /></em>
						li += "<li><span>"+pubTime+"</span>";
						if(toped.title == '是'){
							li += "【置顶】";
						}
						li +="<a href='javascript:void(0)' onclick='viewById("+id+")'>"+title+"</a></li>";
						articleLi += li;
					}
					$("#parkInfo").append(articleLi);
				}
			});
		}
	}
	
	function initNewsPager(){
		$.post("<%=BaseAction.rootLocation%>/parkmanager.cms/rss!counts.action",function(data){
			var pager = data.pager;
			if(pager.total>0){
				newsJPaginate(pager.total);
			}else{
				$("#newsList").empty();
				var ul = "<ul class='newslistc'><li style='text-align:center;'>暂无数据</li></ul>";
			    $("#newsList").append(ul);
				//$("#newsList").append("<div style='text-align: center;'><span style='font-size:30px;'>暂无数据</span></div>");
			}
		});
	}
	
	function newsJPaginate(totalCount){
		initNewsList(1);
		$("#newsPage").paginate({
			count 		: totalCount,
			start 		: 1,
			display     : 8,
			border					: true,
			border_color			: '#ddd',
			text_color  			: '#15b',
			background_color    	: '#fff',	
			border_hover_color		: '#ccc',
			text_hover_color  		: '#fff',
			background_hover_color	: '#446b8c', 
			images					: false,
			mouse					: 'press',
			onChange     			: function(page){
										if(onPage3 == page){
											return;
										}
										initNewsList(page);
										onPage3 = page;
									  }
		});
	}
	
	function initNewsList(page){
		if(page!=null){
			$("#newsList").empty();
			$.post("<%=BaseAction.rootLocation%>/parkmanager.cms/rss!desktopList.action?page="+page,function(data){
				if(data.contentDtos!=null){
					var contentDtos = data.contentDtos;
					var webContentLi = "";
					for(var i = 0;i<contentDtos.length;i++){
						var li = "";
						var id = contentDtos[i].id;
						var url = contentDtos[i].url;
						var title = contentDtos[i].title;
						if(title.length>20){
							title = title.substring(0,20)+'...';
						}
						var source = contentDtos[i].source;
						var date = "";
						if(contentDtos[i].date!=null){
							date = contentDtos[i].date.substring(0,10);
						}
						li += "<li><span>"+date+"</span>";

						//li += "【置顶】";
						
						li +="<a href='javascript:void(0)' onclick=\"openNews('"+url+"')\">"+title+"</a><font>("+source+")</font></li>";
						webContentLi += li;
					}
					$("#newsList").append(webContentLi);
				}
			});
		}
	}
	
	function openNews(url){
		window.open(url,'查看新闻','height=500,width=700,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
	}
	
	function initNoticePager(){
		$.post("<%=BaseAction.rootLocation%>/parkmanager.cms/article!insideWebArticleCounts.action",function(data){
			var pager = data.pager;
			if(pager.total>0){
				jPaginate(pager.total);
			}else{
				$("#noticeList").empty();
			    var ul = "<ul class='newslistc'><li style='text-align:center;'>暂无数据</li></ul>";
			    $("#noticeList").append(ul);
				//$("#noticeList").append("<div style='text-align: center;'><span style='font-size:30px;'>暂无数据</span></div>");
			}
		});
	}
	
	function jPaginate(totalCount){
		initNoticeList(1);
		$("#noticePage").paginate({
			count 		: totalCount,
			start 		: 1,
			display     : 8,
			border					: true,
			border_color			: '#ddd',
			text_color  			: '#15b',
			background_color    	: '#fff',	
			border_hover_color		: '#ccc',
			text_hover_color  		: '#fff',
			background_hover_color	: '#446b8c', 
			images					: false,
			mouse					: 'press',
			onChange     			: function(page){
										if(onPage == page){
											return;
										}
										initNoticeList(page);
										onPage = page;
									  }
		});
	}
	
	function initNoticeList(page){
		if(page!=null){
			$("#noticeList").empty();
			$.post("<%=BaseAction.rootLocation%>/parkmanager.cms/article!insideWebArticleList.action?page="+page,function(data){
				if(data.articleList!=null){
					var articleList = data.articleList;
					var articleLi = "";
					for(var i = 0;i<articleList.length;i++){
						var li = "";
						var id = articleList[i].id;
						var title = articleList[i].title;
						var toped = articleList[i].toped;
						var pubTime = "";
						if(articleList[i].pubTime!=null){
							pubTime = articleList[i].pubTime.substring(0,10);
						}
						li += "<li><span>"+pubTime+"</span>";
						if(toped.title == '是'){
							li += "【置顶】";
						}
						li +="<a href='javascript:void(0)' onclick='viewById("+id+")'>"+title+"</a></li>";
						articleLi += li;
					}
					$("#noticeList").append(articleLi);
				}
			});
		}
	}
	
	function viewById(id){
		var url = '<%=BaseAction.rootLocation%>/parkmanager.cms/article!deskTopView.action?id='+id;
		window.open(url,'查看','height=500,width=820,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
	}

</script>
</head>
<!--<body mousedown-1066583751="function(k){try{fb.BK=k.clientX;fb.BL=k.clientY;fb.BJ=k.target;fb.I(function(){try{fb.BK=fb.BL=fb.BJ=c}catch(l){}},250)}catch(k){}}" onmousedown-1066583751="function(s){if(!s){var i=h[fb.UJ];s=i&&i[fb.UP]&&i[fb.UP].event}if(s&&!s.target){s.target=s.srcElement}try{if(h&&h[o]){return h[o](s)}}catch(r){}}">-->
<body>

<div id="contant2" style="overflow-y: auto;">

<div id="news_contenter" class="main"  style="padding-top:20px;padding-left: 20px;">
    <div class="newsleft">
    <div class="newslist" style="height: 220px;position: relative;">
    <h3>园区公告</h3>
    <ul id="noticeList" class="newslistc">
    </ul>
    <div class="pagination pagination-small pull-al-rt" style="bottom: 1px;" >
		<div id="noticePage">
        </div>
    </div>
   </div>
    
    <div class="newslist newszixun" style="height: 258px;position: relative;" >
    <h3>园区资讯</h3>
    <div id="parkList">
	   	<ul class="pic" id="pic">
	    </ul>
	    <ul class="newslistc" id="parkInfo">
	    </ul>
    </div>
	<div class="pagination pagination-small pull-al-rt" style="bottom: 1px;">
		<div id="parkInfoPage">
        </div>
    </div>
</div>
</div>
    <div class="newsright">
    
    
    <div class="newslist zidingyi" style="height:500px;">
    <h3>自定义</h3> <!-- <div class="pic"><em><a href="#"><img src="core/web/newdesktop/images/ico_shezhi.gif" width="17" height="17" /></a></em></div> <div class="pic" style="padding-top: 5px;padding-right: 15px;"><em><a href="#"><img src="core/web/newdesktop/images/heart3.png" width="20" height="20" /></a></em></div>-->
    
    <ul id="newsList" class="newslistc" >
    	
    </ul>
    <div class="pagination pagination-small pull-al-rt" style="bottom: 1px;" >
		<div id="newsPage">
        </div>
    </div>
    </div>
  </div>
</div>



</div>


</body>
</html>
