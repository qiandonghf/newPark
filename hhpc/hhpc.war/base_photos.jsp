<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
  <script type="text/javascript">
	var num = 0;//当前第一个
	var count = -1;
	var countli = -1;
	$(function (){
		count = $(".jidipic").attr("count");
		countli = $("#mycarousel li").size();//181
		$("#mycarousel").css("width",181*countli+"px");
		if(count > 0){
			abledButton("jcarousel-next");
		}
		$(".jcarousel-next").click(function(){
			if(num < count && count > 0){
				num++;
				if(num > 0)
					$(".scrollnav").children().eq(num-1).attr("src","images/icon_scrollnav.gif");
				$(".scrollnav").children().eq(num).attr("src","images/icon_scrollnav_hover.gif");
				abledButton("jcarousel-prev");
				if(num != count)
					$("#mycarousel").animate({'left':-num*5*181},'slow');
				else
					$("#mycarousel").animate({'left':-num*5*181+(5-countli%5)*181},'slow');
			}
			if(num >= count && count > 0){
				disabledButton("jcarousel-next");
			}
		});
		$(".jcarousel-prev").click(function(){
			if(num > 0 && count > 0){
				var pos = $("#mycarousel").css("left");
				pos = pos.substring(0,pos.length-2);
				num--;
				$(".scrollnav").children().eq(num+1).attr("src","images/icon_scrollnav.gif");
				$(".scrollnav").children().eq(num).attr("src","images/icon_scrollnav_hover.gif");
				abledButton("jcarousel-next");
				if(num > 0)
					$("#mycarousel").animate({'left':5*181+Number(pos)},'slow');
				else
					$("#mycarousel").animate({'left':-num*5*181},'slow');
			}
			if(num <=0 && count > 0){
				disabledButton("jcarousel-prev");
			}
		});
	});
	
	function disabledButton(cls){
		$("."+cls).addClass(cls+"-disabled");
		$("."+cls).addClass(cls+"-disabled-horizontal");
	}
	
	function abledButton(cls){
		$("."+cls).removeClass(cls+"-disabled");
		$("."+cls).removeClass(cls+"-disabled-horizontal");
	}
	</script>
  
	<c:set value="${fn:length(atts) }" var="count"></c:set>
	<% 
	   	int count = (Integer)pageContext.getAttribute("count");
	   	if(count % 5 == 0){
	   		count = count / 5 -1;
	   	}else
	   		count = count / 5;
   %>
 	<div class="jidipic" count="<%=count%>">
	<c:if test="${count > 0 }">
	    <div id="newPic">
	      <div class="col2">
	      <div class=" jcarousel-skin-tango" style="margin:0px;">
	      <div class="jcarousel-container jcarousel-container-horizontal" style="display: block;">
	      <div class="jcarousel-prev jcarousel-prev-horizontal jcarousel-prev-disabled jcarousel-prev-disabled-horizontal" style="display: block;"></div>
	      <div class="jcarousel-next jcarousel-next-horizontal jcarousel-next-disabled jcarousel-next-disabled-horizontal" style="display: block;"></div>
	      <div class="jcarousel-clip jcarousel-clip-horizontal">
	        <ul id="mycarousel" class="carousel-list jcarousel-list jcarousel-list-horizontal" style="left: 0px;margin:0 auto;;text-align:center;">
	          <c:forEach items="${atts }" var="attr">
	          <c:set value="${attr.oldName }" var="oldName"></c:set>
	          <%
	          	String oldName = pageContext.getAttribute("oldName").toString();
	          	int pos = oldName.lastIndexOf(".");
	          	String newName;
	          	if(pos != -1 && pos != oldName.length()){
	          		newName = oldName.substring(pos+1).toLowerCase();
	          		if("jpg".equals(newName) || "png".equals(newName) || 
	          				"gif".equals(newName) || "bmp".equals(newName)){
	          %>
	           <li class="jcarousel-item jcarousel-item-horizontal"> <a href="javascript:;" title="<%=oldName.substring(0,pos) %>"><img alt="<%=oldName.substring(0,pos) %>" src="core/resources/${attr.newName }" width="169" height="124"/></a>
	            <h4><a href="javascript:;"><%=oldName.substring(0,pos) %></a></h4>
	           </li>
	           <%}} %>
	          </c:forEach>
	        </ul>
	        </div></div></div>
	        <div class="scrollnav"> 
	        <c:if test="${count > 0 }">
	        	<c:forEach begin="0" end="<%=count%>" varStatus="status">
	        		<c:if test="${status.index == 0 }">
			        	<img src="images/icon_scrollnav_hover.gif"> 
	        		</c:if>
	        		<c:if test="${status.index != 0 }">
						<img src="images/icon_scrollnav.gif"/>	        		
					</c:if>
	        	</c:forEach>
	        </c:if>
	        </div>
	      </div>
	    </div>
	</c:if>
	</div>
