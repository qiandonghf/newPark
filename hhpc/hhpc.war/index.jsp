<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@page import="com.wiiy.commons.util.StringUtil"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String path = request.getContextPath().replaceAll("\\/", "");
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
	function checkEmail(id){
		var temp = $("#"+id).val();
		var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
		if(re.test(temp)){
			save('mail');
		}else{
			alert('请输入有效的E_mail！');
			return;
		}
	}
	
	function dealAction(id){
		setTimeout("location.reload();",400);
	}
	$(function(){
		$("#ifocus_btn ul li").each(function(i){
			$(this).click(function(){
				$($(this).siblings(".current")).removeClass("current").addClass("normal");
				$(this).addClass("current");
				$("#ifocus_piclist").animate({top:-i*200},'slow');
			});
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
<div class="index_banner" id="banner_tabs" style="margin-top:2px;">
  <ul>
    <li class="first"></li>
    <li class="second" style="positon:relative;overflow:hidden;">
    	<a href="garden.action?type=incubation" target="_blank" style="position:absolute;width:106px;left:357px;top:117px;height:33px;"></a>
    	<a href="garden.action?type=gardenApply" target="_blank" style="position:absolute;width:106px;left:357px;top:160px;height:33px;"></a>
    </li>
    <li class="third"></li>
  </ul>
  <cite><span class="cur">1</span><span>2</span><span>3</span></cite> </div>
	<script type="text/javascript">
			(function(){
		        if(!Function.prototype.bind){
		            Function.prototype.bind = function(obj){
		                var owner = this,args = Array.prototype.slice.call(arguments),callobj = Array.prototype.shift.call(args);
		                return function(e){e=e||top.window.event||window.event;owner.apply(callobj,args.concat([e]));};
		            };
		        }
		    })();
		    var banner_tabs = function(id){
		        this.ctn = document.getElementById(id);
		        this.adLis = null;
		        this.btns = null;
		        this.animStep = 0.2;//动画速度0.1～0.9
		        this.switchSpeed = 5;//自动播放间隔(s)
		        this.defOpacity = 1;
		        this.tmpOpacity = 1;
		        this.crtIndex = 0;
		        this.crtLi = null;
		        this.adLength = 0;
		        this.timerAnim = null;
		        this.timerSwitch = null;
		        this.init();
		    };
		    banner_tabs.prototype = {
		        fnAnim:function(toIndex){
		            if(this.timerAnim){window.clearTimeout(this.timerAnim);}
		            if(this.tmpOpacity <= 0){
		                this.crtLi.style.opacity = this.tmpOpacity = this.defOpacity;
		                this.crtLi.style.filter = 'Alpha(Opacity=' + this.defOpacity*100 + ')';
		                this.crtLi.style.zIndex = 0;
		                this.crtIndex = toIndex;
		                return;
		            }
		            this.crtLi.style.opacity = this.tmpOpacity = this.tmpOpacity - this.animStep;
		            this.crtLi.style.filter = 'Alpha(Opacity=' + this.tmpOpacity*100 + ')';
		            this.timerAnim = window.setTimeout(this.fnAnim.bind(this,toIndex),50);
		        },
		        fnNextIndex:function(){
		            return (this.crtIndex >= this.adLength-1)?0:this.crtIndex+1;
		        },
		        fnSwitch:function(toIndex){
		            if(this.crtIndex==toIndex){return;}
		            this.crtLi = this.adLis[this.crtIndex];
		            for(var i=0;i<this.adLength;i++){
		                this.adLis[i].style.zIndex = 0;
		            }
		            this.crtLi.style.zIndex = 2;
		            this.adLis[toIndex].style.zIndex = 1;
		            for(var i=0;i<this.adLength;i++){
		                this.btns[i].className = '';
		            }
		            this.btns[toIndex].className = 'cur'
		            this.fnAnim(toIndex);
		        },
		        fnAutoPlay:function(){
		            this.fnSwitch(this.fnNextIndex());
		        },
		        fnPlay:function(){
		            this.timerSwitch = window.setInterval(this.fnAutoPlay.bind(this),this.switchSpeed*1000);
		        },
		        fnStopPlay:function(){
		            window.clearTimeout(this.timerSwitch);
		        },
		        init:function(){
		            this.adLis = this.ctn.getElementsByTagName('li');
		            this.btns = this.ctn.getElementsByTagName('cite')[0].getElementsByTagName('span');
		            this.adLength = this.adLis.length;
		            for(var i=0,l=this.btns.length;i<l;i++){
		                with({i:i}){
		                    this.btns[i].index = i;
		                    this.btns[i].onclick = this.fnSwitch.bind(this,i);
		                    this.btns[i].onclick = this.fnSwitch.bind(this,i);
		                }
		            }
		            this.adLis[this.crtIndex].style.zIndex = 2;
		            this.fnPlay();
		            this.ctn.onmouseover = this.fnStopPlay.bind(this);
		            this.ctn.onmouseout = this.fnPlay.bind(this);
		        }
		    };
		    var player1 = new banner_tabs('banner_tabs');
		</script> 
<!---焦点图结束----> 

<!---主体内容开始---->
<div id="main"> 
  
  <!---主体内容左侧开始---->
  <div id="mainleft"> 
    
    <!---最新动态开始---->
    <div class="gongnews">
      <div class="left">最新动态</div>
      <div class="center">
			<marquee direction="left" amount=10  scrollamount="3">
			<c:forEach items="${zxdt }" var="newTypes">
				<span style="inline-block;margin-right:50px;">
					<a href="view.action?id=${newTypes.id }">${newTypes.title }</a>
					&nbsp;<fmt:formatDate value="${newTypes.createTime }" pattern="yyyy-MM-dd" />
				</span>
			</c:forEach>
			</marquee>
      </div>
      <div class="right"></div>
    </div>
    <!---最新动态结束----> 
    
    <!--indexnews-->
    
    <div class="indexnews" > 
      <!---左侧标题开始---->
      <h1 class="Title">
        <p>新闻资讯</p>
        <span><a href="list.action?id=${wzzxId }">. more</a></span></h1>
      <!---左侧标题结束----> 
      
      <!--flash-->
      
      <div id="ifocus">
        <div class="flash"  id="ifocus_pic">
          <div id="ifocus_piclist" style="left:0; top:0;">
            <ul>
				<c:forEach items="${tpzx }" var="article">
				<c:set value="${article.photo }" var="photo"></c:set>
				<%
					String photo = pageContext.getAttribute("photo").toString();
					if(photo != null){
						int pos = photo.lastIndexOf(".");
						String end = photo.substring(pos);
						photo = photo.substring(0,pos)+"335-240"+end;
					}
				%>
					<li>
						<a href="view.action?id=${article.id }" target="_blank" title="${article.title }">
							<img src="core/resources/<%=photo %>" alt="${article.title }" />
						</a>
					</li>
				</c:forEach>
            </ul>
          </div>
          
          <div id="ifocus_opdiv"></div><div id="ifocus_tx">
            <ul>
            	<% int index = 0; %>
            	<c:forEach items="${tpzx }" var="article">
					<%	index++;
						if(index == 1) {
					%>
						<li class="current"></li>
					<%}else{ %>
						<li class="normal"></li>
					<%} %>
				</c:forEach>
            </ul>
          </div>
        </div>
        <div id="ifocus_btn">
          <ul>
          	<% index = 0; %>
           	<c:forEach items="${tpzx }" var="article">
           	<c:set value="${article.photo }" var="photo"></c:set>
				<%
					String photo = pageContext.getAttribute("photo").toString();
					if(photo != null){
						int pos = photo.lastIndexOf(".");
						String end = photo.substring(pos);
						photo = photo.substring(0,pos)+"335-240"+end;
					}
				%>
				<%	index++;
					if(index == 1) {
				%>
					<li class="current"><img title="${article.title }" src="core/resources/<%=photo %>" alt="${article.title }" /></li>
				<%}else{ %>
					<li class="normal"><img title="${article.title }" src="core/resources/<%=photo %>" alt="${article.title }" /></li>
				<%} %>
			</c:forEach>
          </ul>
        </div>
      </div>
      
      <!--//flash--> 
      
      <!--indexnewlist-->
      <div class="indexnewlist">
        <ul>
          <c:forEach items="${wzzx}" var="article">
	          <li><span><fmt:formatDate value="${article.pubTime }" pattern="MM-dd"/></span><em><img src="images/red_ico.gif" width="4" height="7" /></em><a href="view.action?id=${article.id }" target="_self" title="${article.title }">${article.title }</a></li>
          </c:forEach>
        </ul>
      </div>
      <!--//indexnewlist-->
      
      <div class="hackbox"> </div>
    </div>
    <!--//indexnews--> 
    
    <!---左侧第三部分开始---->
    <div class="indexpartthree"> 
      
      <!---通知公告开始---->
      <div class="tzgglist"> 
        <!---左侧标题开始---->
        <h1 class="Title">
          <p>通知公告</p>
          <span><a href="list.action?id=${tzggId }">. more</a></span></h1>
        <!---左侧标题结束---->
        <ul>
          <c:forEach items="${tzgg}" var="article">
	          <li><span><fmt:formatDate value="${article.pubTime }" pattern="MM-dd"/></span><em><img src="images/red_ico.gif" width="4" height="7" /></em><a href="view.action?id=${article.id }" target="_self" title="${article.title }">${article.title }</a></li>
          </c:forEach>
        </ul>
      </div>
      <!---通知公告结束----> 
      
      <!---扶持政策开始---->
      <div class="fczelist"> 
        <!---左侧标题开始---->
        <h1 class="Title">
          <p>扶持政策</p>
          <span><a href="list.action?id=${fczcId }">. more</a></span></h1>
        <!---左侧标题结束---->
        <ul>
          <c:forEach items="${fczc}" var="article">
	          <li><span><fmt:formatDate value="${article.pubTime }" pattern="MM-dd"/></span><em><img src="images/red_ico.gif" width="4" height="7" /></em><a href="view.action?id=${article.id }" target="_self" title="${article.title }">${article.title }</a></li>
          </c:forEach>
        </ul>
      </div>
      <!---扶持政策结束---->
      <div class="hackbox"></div>
    </div>
    <!--左侧第三部分结束--> 
    
    <!---左侧第四部分开始---->
    <div class="indexpartfour">
      <div style="width:691px;height:1px;overflow:hidden;background-color:#c41210; margin-bottom:6px;"></div>
      <!---左侧标题开始---->
      <h1 class="Title">
        <p>服务平台</p>
        <span></span></h1>
      <!---左侧标题结束---->
      <ul>
      	<%index = 1; %>
      	<c:forEach items="${serviceTypes }" var="serviceType">
      		<c:if test="${not empty serviceType.url }">
      			<c:if test="${fn:indexOf(serviceType.url, '?') != -1}">
	        		<li>
	        			<a href="${serviceType.url }&categoryId=${serviceType.id}">
	        				<img border="0" src="images/server_ico<%=index++ %>.gif" />
	        			</a>
	        			<span><a href="${serviceType.url }&categoryId=${serviceType.id}">${serviceType.typeName}</a></span>
	        		</li>
         		</c:if>
         		<c:if test="${fn:indexOf(serviceType.url, '?') == -1}">
         			<li>
	        			<a href="${serviceType.url }?categoryId=${serviceType.id}">
	        				<img border="0" src="images/server_ico<%=index++ %>.gif" />
	        			</a>
	        			<span><a href="${serviceType.url }?categoryId=${serviceType.id}">${serviceType.typeName}</a></span>
	        		</li>
         		</c:if>
      		</c:if>
      		<c:if test="${empty serviceType.url }">
      			<li>
        			<a href="serviceView.action?categoryId=${serviceType.id}">
        				<img border="0" src="images/server_ico<%=index++ %>.gif" />
        			</a>
        			<span><a href="serviceView.action?categoryId=${serviceType.id}">${serviceType.typeName}</a></span>
        		</li>
      		</c:if>
      	</c:forEach>
      </ul>
    </div>
    <!--左侧第四部分结束--> 
    
    <!---左侧第五部分开始---->
    <div class="indexpartfive"> 
      
      <!---企业专栏开始---->
      <div class="tzgglist"> 
        <!---左侧标题开始---->
        <h1 class="Title">
          <p>企业专栏</p>
          <span><a href="${qyzlType.url }&id=${qyzlType.id }">. more</a></span></h1>
        <!---左侧标题结束---->
        <ul>
          <c:forEach items="${qyzl}" var="dto">
	          <li>
	          	<span><fmt:formatDate value="${dto.time }" pattern="MM-dd"/></span>
	          	<em><img src="images/red_ico.gif" width="4" height="7" /></em>
	          	<a href="enterpriseView.action?type=customer&categoryId=${dto.category.id }&id=${dto.id }" title="${dto.name }">${dto.name }</a>
	          </li>
          </c:forEach>
        </ul>
      </div>
      <!---企业专栏结束----> 
      
      <!---创业导师开始----> 
      <!--park-->
      <div class="teacher"> 
        <!---左侧标题开始---->
        <h1 class="Title">
          <p>${cydsType.typeName }</p>
          <span><a href="${cydsType.url }?id=${cydsId }">. more</a></span></h1>
        <!---左侧标题结束---->
        <c:if test="${fn:length(cyds) > 0 }">
        <ul>
          <c:forEach items="${cyds }" var="article" begin="0" end="1">
          	<li> 
          		<a href="showView.action?id=${article.id }">
          			<c:if test="${empty article.photo }"><img width="60" height="60" src="core/common/images/topxiao.gif" /></c:if>
          			<c:if test="${not empty article.photo }"><img width="60" height="60" src="core/resources/${article.photo }" /></c:if>
          		</a>
            	<p><span><a href="showView.action?id=${article.id }">${article.title }</a></span> </p>
            	<p class="text">${article.content }</p>
          </li>
          </c:forEach>
        </ul>
        <div class="teachers">
        	<c:forEach items="${cyds }" var="article" begin="2">
        		<a href="showView.action?id=${article.id }">${article.title }</a>
        	</c:forEach>
        </div>
        </c:if>
        <div class="hackbox"></div>
      </div>
    </div>
    <!--创业导师开始jieshu -->
    <div class="hackbox"></div>
  </div>
  <!---主体内容左侧结束----> 
  
  <!---主体内容右侧开始---->
  <div id="mainright"> 
    
    <!---主体内容右侧广告图片开始---->
    <!-- <div class="poppic">
      <ul>
        <li><img src="images/yuanqu_pop.gif" /></li>
        <li><img src="images/yuanqu_pop.gif" /></li>
      </ul>
    </div> -->
    <!---主体内容右侧广告图片结束----> 
    
    <!---孵化基地开始---->
    <div class="fhjd">
      <h1 class="Title">
        <p>${fhjdType.typeName }</p>
        <span></span></h1>
		<ul>
			<c:forEach items="${fhjd }" var="article">
			<c:set value="${article.contentText }" var="content"></c:set>
			<c:set value="${article.articleType }" var="type"></c:set>
			<li>
			  <p class="left"><a href="${type.url }&categoryId=${type.id }"><img width="87" height="63" src="core/resources/${article.photo }"/></a> <span><a href="${type.url }&categoryId=${type.id }">${type.typeName }</a></span></p>
			  <div class="text" title="${content}">
			  	<c:if test="${fn:length(content)>42 }">
			  		${fn:substring(content,0,41) }...
			  	</c:if>
			  	<c:if test="${fn:length(content)<=42 }">
			  		${content}
			  	</c:if>
			  </div>
			</li>
			</c:forEach>
		</ul>
    </div>
    <!---孵化基地结束----> 
    
    <!---邮件订阅开始---->
    <div class="yjdy">
      <h1 class="Title2">邮件订阅<span>(已有${yjdy }人订阅)</span></h1>
      <form action="<%=basePath %>save.action?type=mail" method="post" id="mail">
      <h3>
          <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="158"><input id="mailTxt" name="mail.email" type="text" class="input_yjdy" /></td>
              <td><input name="提交" type="button" style="cursor:pointer;" onclick="checkEmail('mailTxt')" class="but_yjdy" value="邮件订阅"/></td>
            </tr>
          </table>
      </h3>
      </form>
    </div>
    <!---邮件订阅结束----> 
    
     <!---下载中心开始---->
    <div class="xzzxlist"> 
      <!---左侧标题开始---->
      <h1 class="Title">
        <p>下载中心</p>
        <span><a href="${xzzxType.url }&categoryId=${xzzxType.id }">. more</a></span>
      </h1>
      <!---左侧标题结束----> 
      <ul>
          <c:forEach items="${xzzx}" var="document">
          <c:set value="${document.name }" var="name"></c:set>
          <%
          String name = pageContext.getAttribute("name").toString();
          int pos = name.lastIndexOf(".");
          if(pos != -1 && pos < name.length()){
        	  name = name.substring(0,pos);
          }
          %>
	          <li>
	          	<span><fmt:formatDate value="${document.pubTime }" pattern="MM-dd"/></span>
	          	<em><img src="images/red_ico.gif" width="4" height="7" /></em>
	          	<a href="core/resources/${document.fileName }?name=<%=name %>" title="<%=name %>"><%=name %></a>
	          </li>
          </c:forEach>
        </ul>
      </div>
    <!---下载中心结束---->
    
    
    <!---联系我们开始---->
    <div class="lxwm"> 
      <!---左侧标题开始---->
      <h1 class="Title">
        <p>联系我们</p>
      </h1>
      <!---左侧标题结束----> 
      <span> 
		      地址：${contactInfo.address }<br />
		      电话：${contactInfo.phone }<br />
		      传真：${contactInfo.fax }<br />
		      邮箱：${contactInfo.email }<br />
      </span> </div>
    <!---联系我们结束---->
    
    <div class="hackbox"></div>
  </div>
  <!---主体内容右侧结束---->
  
  <div class="hackbox"></div>
</div>
<!---主体内结束----> 

<!---底部开始---->
	<jsp:include page="footer.jsp"></jsp:include>
<!---底部结束---->

<!---漂浮广告开始---->

<!---自动移动开始---->
	<c:if test="${not empty floatAd && floatAd.enable eq 'YES' }">
	<div id="floatAdd" style="z-index: 10003; left: 708px; position: absolute; top: 599px; height: 52px; visibility: visible;">
		<c:if test="${not empty floatAd.url}">
			<c:if test="${fn:indexOf(floatAd.url,'http://') != -1}">
				<a href="${floatAd.url}" target="_blank">
			</c:if>
			<c:if test="${fn:indexOf(floatAd.url,'http://') == -1}">
				<a href="http://${floatAd.url}" target="_blank">
			</c:if>
		</c:if>
		<c:if test="${empty floatAd.url}">
			<a href="javascript:;" target="_blank">
		</c:if>
			<c:if test="${floatAd.resourceType eq 'IMAGE' && not empty floatAd.resourcePath}">
			<img src="core/resources/${ floatAd.resourcePath }" border="0" <c:if test="${not empty floatAd.width }">width="${floatAd.width }"</c:if><c:if test="${not empty floatAd.height }">height="${floatAd.height }"</c:if>  />
			</c:if>
		</a>
	</div>
	</c:if>
<!---自动移动结束---->
	<script language="javascript">
		function addEvent(obj,evtType,func,cap){
			cap=cap||false;
			if(obj.addEventListener){
				obj.addEventListener(evtType,func,cap);
				return true;
			}else if(obj.attachEvent){
				if(cap){
					obj.setCapture();
					return true;
				}else{
					return obj.attachEvent("on" + evtType,func);
				}
			}else{
				return false;
			}
		}
		function getPageScroll(){
			var xScroll,yScroll;
			if (self.pageXOffset) {
				xScroll = self.pageXOffset;
			} else if (document.documentElement && document.documentElement.scrollLeft){
				xScroll = document.documentElement.scrollLeft;
			} else if (document.body) {
				xScroll = document.body.scrollLeft;
			}
			if (self.pageYOffset) {
				yScroll = self.pageYOffset;
			} else if (document.documentElement && document.documentElement.scrollTop){
				yScroll = document.documentElement.scrollTop;
			} else if (document.body) {
				yScroll = document.body.scrollTop;
			}
			arrayPageScroll = new Array(xScroll,yScroll+10);
			return arrayPageScroll;
		}

		function GetPageSize(){
			var xScroll, yScroll;
			if (window.innerHeight && window.scrollMaxY) { 
				xScroll = document.body.scrollWidth;
				yScroll = window.innerHeight + window.scrollMaxY;
			} else if (document.body.scrollHeight > document.body.offsetHeight){
				xScroll = document.body.scrollWidth;
				yScroll = document.body.scrollHeight;
			} else {
				xScroll = document.body.offsetWidth;
				yScroll = document.body.offsetHeight;
			}
			var windowWidth, windowHeight;
			if (self.innerHeight) {
				windowWidth = self.innerWidth;
				windowHeight = self.innerHeight;
			} else if (document.documentElement && document.documentElement.clientHeight) {
				windowWidth = document.documentElement.clientWidth;
				windowHeight = document.documentElement.clientHeight;
			} else if (document.body) {
				windowWidth = document.body.clientWidth;
				windowHeight = document.body.clientHeight;
			} 
			if(yScroll < windowHeight){
				pageHeight = windowHeight;
			} else { 
				pageHeight = yScroll;
			}
			if(xScroll < windowWidth){ 
				pageWidth = windowWidth;
			} else {
				pageWidth = xScroll;
			}
			arrayPageSize = new Array(pageWidth,pageHeight-2,windowWidth-20,windowHeight-10) 
			return arrayPageSize;
		}

		var AdMoveConfig=new Object();
		AdMoveConfig.IsInitialized=false;
		AdMoveConfig.ScrollX=0;
		AdMoveConfig.ScrollY=0;
		AdMoveConfig.MoveWidth=0;
		AdMoveConfig.MoveHeight=0;
		AdMoveConfig.Resize=function(){
			var winsize=GetPageSize();
			AdMoveConfig.MoveWidth=winsize[2];
			AdMoveConfig.MoveHeight=winsize[3];
			AdMoveConfig.Scroll();
		}
		
		AdMoveConfig.Scroll=function(){
			var winscroll=getPageScroll();
			AdMoveConfig.ScrollX=winscroll[0];
			AdMoveConfig.ScrollY=winscroll[1];
		}

		addEvent(window,"resize",AdMoveConfig.Resize);
		addEvent(window,"scroll",AdMoveConfig.Scroll);

		function AdMove(id){
			if(!AdMoveConfig.IsInitialized){
			AdMoveConfig.Resize();
			AdMoveConfig.IsInitialized=true;
			}
			var obj=document.getElementById(id);
			obj.style.position="absolute";
			var W=AdMoveConfig.MoveWidth-obj.offsetWidth;
			var H=AdMoveConfig.MoveHeight-obj.offsetHeight;
			var x = W*Math.random(),y = H*Math.random();
			var rad=(Math.random()+1)*Math.PI/6;
			var kx=Math.sin(rad),ky=Math.cos(rad);
			var dirx = (Math.random()<0.5?1:-1), diry = (Math.random()<0.5?1:-1);
			var step = 1;
			var interval;
			this.SetLocation=function(vx,vy){x=vx;y=vy;}
			this.SetDirection=function(vx,vy){dirx=vx;diry=vy;}
			obj.CustomMethod=function(){
				obj.style.left = (x + AdMoveConfig.ScrollX) + "px";
				obj.style.top = (y + AdMoveConfig.ScrollY) + "px";
				rad=(Math.random()+1)*Math.PI/6;
				W=AdMoveConfig.MoveWidth-obj.offsetWidth;
				H=AdMoveConfig.MoveHeight-obj.offsetHeight;
				x = x + step*kx*dirx;
				if (x < 0){dirx = 1;x = 0;kx=Math.sin(rad);ky=Math.cos(rad);} 
				if (x > W){dirx = -1;x = W;kx=Math.sin(rad);ky=Math.cos(rad);}
				y = y + step*ky*diry;
				if (y < 0){diry = 1;y = 0;kx=Math.sin(rad);ky=Math.cos(rad);} 
				if (y > H){diry = -1;y = H;kx=Math.sin(rad);ky=Math.cos(rad);}
			}
			this.Run=function(){
				var delay = 15;
				interval=setInterval(obj.CustomMethod,delay);
				obj.onmouseover=function(){clearInterval(interval);}
				obj.onmouseout=function(){interval=setInterval(obj.CustomMethod, delay);}
			}
		}
		
		function closead(id){
			var obj = document.getElementById(id);
			obj.style.visibility = "hidden";
		}
		<c:if test="${not empty floatAd && floatAd.enable eq 'YES' }">
			var ad1=new AdMove("floatAdd");
			ad1.Run();
		</c:if>
	</script>
<!---漂浮广告结束---->
</body>
</html>

