<%@ page language="java"
	import="java.util.*,com.wiiy.commons.action.BaseAction"
	pageEncoding="UTF-8"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${category.typeName }</title>

<!---样式---->
<jsp:include page="style.jsp"></jsp:include>
<!---样式结束---->
<script>
<!--
	/*第一种形式 第二种形式 更换显示样式*/
	function setTab(m, n) {
		var tli = document.getElementById("menu" + m)
				.getElementsByTagName("li");
		var mli = document.getElementById("main" + m)
				.getElementsByTagName("ul");
		for (i = 0; i < tli.length; i++) {
			tli[i].className = i == n ? "hover" : "";
			mli[i].style.display = i == n ? "block" : "none";
		}
	}
	
	function openUrl(url){
		location.href=url;
	}
	$(function(){
		initTeam();
	});
	
	function initTeam(){
		$(".teamList").each(function(){
			var txt = $(this).text();
			var txts = txt.split("、");
			if(txts.length > 2){
				txt = txts[0].replace(/(^\s*)|(\s*$)/g, "")+"、"+txts[1].replace(/(^\s*)|(\s*$)/g, "")+"等";
			}
			$(this).text(txt);
		});
	}
//-->
</script>
</head>
<body style="background-color:#f7f7f7;">

	<!---顶部开始---->
	<jsp:include page="header.jsp"></jsp:include>
	<!---顶部结束---->

	<!---导航开始---->
	<jsp:include page="navi.jsp"></jsp:include>
	<!---导航结束---->

	<!---焦点图开始---->
		<div id="n_banner" style="margin-top:10px;position:relative;">
			<a target="_blank" style="background:url(about:blank);height:52px;width:188px;position:absolute;top:114px;right:140px;" href="garden.action?type=gardenApply"></a>
			<img src="images/toppic_cymp.gif" width="956" height="264" alt="杭州高兴区科技创业服务中心" />
		</div>

	<!---焦点图结束----> 

	<!---主体内容开始---->
	<div id="main" style="padding-top: 0px;">

		<!---第一部分开始---->
		<div id="tab1">

			<div class="tab1_top">
				<img src="images/tab1_topbg.gif" width="956" height="65" />
			</div>
			<div class="tab1_mid">
				<ul>
					<li>
						<p>${article.content}</p>
					</li>
				</ul>
				<div class="hackbox"></div>
			</div>
			<div class="tab1_bot">
				<img src="images/tab1_bbg.gif" width="956" height="70" />
			</div>

		</div>
		<!---第一部分侧结束---->
		<!---第2部分开始---->
		<div id="tab2">

			<div class="tab2_top">
				<img src="images/tab2_tbg.gif" width="956" height="65" />
			</div>
			<div class="tab2_mid">
				<ul>
					<li class="tab2_left">
						<h2>设立流程</h2>
						<p>
							1、	创业团队（个人）提出入驻申请；<br/>
							2、	科创中心创业苗圃管理办公室初审通过后，报科创中心主任办公会议批准；<br/>
							3、	获得批准的创业团队（个人）签订入驻协议，并办理相关手续；<br/>
							4、	团队（个人）正式入驻创业苗圃，开展创新创业活动。
						</p>
						<p>高新区创业中心网址：www.hhpc.gov.cn</p>
					</li>
					<li class="tab2_right">
						<h2>入圃资料</h2>
						<p>
							1、入圃申请表；<br/>
							2、创业计划书；<br/>
							3、身份证明；<br/>
							4、学籍或学历证明；<br/>
							5、其他。<br/>
						</p>
						<p>
							<a href="garden.action?type=gardenApply" target="_blank"><img src="images/but_ljrf.gif" width="210"
								height="55" /></a>
						</p>
					</li>
				</ul>
				<div class="sbtj">
					<h2>入圃条件</h2>
					<p>
						创新创业团队（个人）应符合以下条件：<br/>
						1、	主要创办人本科以上学历，35周岁以下；<br/>
						2、	有明确的创业计划书；<br/>
						3、	未成立公司的创业者及团队；<br/>
						4、	项目符合高新区（滨江）产业导向；<br/>
						5、	创业团队中入驻创业苗圃的人数原则上不超过4人。
					</p>
				</div>
			</div>
			<div class="tab2_bot">
				<img src="images/tab2_bbg.gif" width="956" height="70" />
			</div>

		</div>
		<!---第2部分侧结束---->
		<!---第3部分开始	苗圃团队---->
		<div id="tab3">

			<div class="tab3_top">
				<img src="images/tab3_tbg.gif" width="956" height="65"/>
				<a href="/enterprise.action?type=gardenApply&id=28">.more</a>
			</div>
			<div class="tab3_mid">
				<c:forEach items="${applies }" var="apply">
				<ul class="team">
					<c:set value="${apply.photo }" var="p"></c:set>
		         	 <% 
		         		String photo = "";
		         	 	if(pageContext.getAttribute("p") != null){
		         	 		photo = pageContext.getAttribute("p").toString();
			         	 	int pos = -1;
			         	 	if(photo != null && (pos=photo.lastIndexOf(".")) != -1){
			         	 		photo = photo.substring(0,pos)+"335-240"+photo.substring(pos);
			         	 	} 
		         	 	}
		         	 	int num =0;
		         	 %>
					<li style="height:399px;cursor:pointer;" onclick="openUrl('/enterpriseView.action?type=gardenApply&categoryId=28&id=${apply.id }');">
						<img src="core/resources/<%=photo %>" width="206" height="135" />
						<p>
							<span>名称：</span>${apply.projectName }
						</p>
						<p>
							<span class="teamList">成员：</span><k class="teamList">
							<c:if test="${not empty apply.memberName1 }">${apply.memberName1 }<%num++; %></c:if>
							<c:if test="${not empty apply.memberName2 }"><%if(num >0){%>、${apply.memberName2 }<%}num++; %></c:if>
							<c:if test="${not empty apply.memberName3 }"><%if(num >0){%>、${apply.memberName3 }<%}num++; %></c:if>
							<c:if test="${not empty apply.memberName4 }"><%if(num >0){%>、${apply.memberName4 }<%}num++; %></c:if>
							<c:if test="${not empty apply.memberName5 }"><%if(num >0){%>、${apply.memberName5 }<%}%></c:if>
							</k>
						</p>
						<p>
							<span>简介：</span><c:if test="${fn:length(apply.introduction)>100 }">${fn:substring(apply.introduction,0,100) }...</c:if><c:if test="${fn:length(apply.introduction)<=100 }">${apply.introduction}</c:if>
						</p>
					</li>
				</ul>
				</c:forEach>
			</div>
			<div class="tab3_bot">
				<img src="images/tab3_bbg.gif" width="956" height="70" />
			</div>
		</div>
		<!---第3部分侧结束---->
		<!---第4部分开始---->
		<div id="tab4">

			<div class="tab4_top">
				<img src="images/tab4_tbg.gif" width="956" height="65" />
			</div>
			<div class="tab4_mid">
				<ul>
					<c:forEach items="${agencies}" var="agency">
					<c:set value="${agency.memo }" var="memo"></c:set>
					<li><img src="images/hzjg.gif" width="85" height="86" />
						<p>
							<span>${agency.name }</span><a href="${agency.homePage }" class="huise">${agency.homePage }</a>
						</p>
						<p><c:if test="${fn:length(memo)>100 }">${fn:substring(memo,0,100) }...</c:if><c:if test="${fn:length(memo)<=100 }">${memo}</c:if></p>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="tab4_bot">
				<img src="images/tab4_bbg.gif" width="956" height="70" />
			</div>

		</div>
		<!---第4部分侧结束---->
		<!---第5部分开始---->
		<div id="tab5">

			<div class="tab5_top">
				<img src="images/tab5_tbg.gif" width="956" height="65" />
			</div>
			<div class="tab5_mid">
				<ul class="zhishilist left">
					<c:forEach items="${articleList}" var="article">
					<li><em><img src="images/ico5.gif" width="20" height="12" /></em>
						<a href="view.action?id=${article.id }" title="${article.contentText }" class="huise">${article.title} </a>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="tab5_bot">
				<img src="images/tab5_bbg.gif" width="956" height="70" />
			</div>

		</div>
		<!---第5部分侧结束---->


		<div class="hackbox"></div>
	</div>
	<!---主体内结束---->

	<!---底部开始---->
	<jsp:include page="footer.jsp"></jsp:include>
	<!---底部结束---->

</body>
</html>
