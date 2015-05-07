<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.wiiy.core.entity.User"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Date now = new Date();
SimpleDateFormat format = new SimpleDateFormat();
%>
<script type="text/javascript">
function myAddTab(topWindow,plugin,url,iconUrl){
	var tabs = topWindow.$('#tt');
	if (tabs.tabs('exists',plugin)){
		tabs.tabs('select', plugin);
		var tab = tabs.tabs('getSelected');
		tabs.tabs('update', {
			tab: tab,
			options: {
				content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>'
			}
		});
		var span = tabs.find("span:contains('"+plugin+"')");
		span.addClass("tabs-with-icon");
	} else {
		var icon = topWindow.$(".tt:contains('"+plugin+"')").prev().find("img").attr("src");
		if(typeof(icon) == "undefined"){
			icon = iconUrl;
		}
		tabs.tabs('add',{
			title:plugin,
			iconCls:'icon-reload',
			content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>',
			closable:true
		});
		var span = tabs.find("span:contains('"+plugin+"')");
		span.next().css("background","url('"+icon+"') no-repeat");
	}
}
</script>
<div class="console-info">
        	<div class="console-info-text"><span><%=CoreActivator.getSessionUser(request).getRealName()%></span><span>${mottoStr}</span></div>
        	
            <div class="console-info-right">
            	
                <div class="console-date"><%format.applyPattern("yyyy年MM月dd号 E");out.print(format.format(now)); %></div>
                
                  <div class="user_btn">
                  	<div class="btn" style="margin-right:5px;">
	                      	<div class="btn-pnt" href="javascript:void(0)" id="signout"><img src="core/common/images/leave.png" />签退</div>
	                      <!--弹出层-->
	                         <div class="oaworklist"  style=" display:none;">
				             	<div id="sign2" class="oaworklistcon">
				               	</div>
			                 </div>
                          <!--弹出层-->
                        </div>
                    	 <div class="btn">
	                      	 <div class="btn-pnt" href="javascript:void(0)" id="signin"><img src="core/common/images/reach.png" />签到</div>
	            		  <!--弹出层-->
				             <div class="oaworklist"  style="display:none;">
				                 <div id="sign1" class="oaworklistcon" >
				                 </div>
				             </div>
			              <!--弹出层-->
	                     </div>
                   </div>
            </div>
        </div>
        <div class="user_task">
                <ul>
                    <li>
						<c:forEach items="${coreWorkbenchTipDtoList}" var="coreWorkbenchTipDto">
							<c:if test="${coreWorkbenchTipDto.name ne '签到签退'&& coreWorkbenchTipDto.name ne '园区概况'}">
								<img src="${coreWorkbenchTipDto.icon}" />${coreWorkbenchTipDto.name}<a href="javascript:void(0)" onclick="myAddTab(parent.parent,'${coreWorkbenchTipDto.tabName}','<%=BaseAction.rootLocation %>/${coreWorkbenchTipDto.url}','${coreWorkbenchTipDto.icon}')"><input type="hidden" class="dataUrl" value="<%=BaseAction.rootLocation %>/${coreWorkbenchTipDto.dataUrl}"/><strong>[<span>0</span>]</strong>&nbsp&nbsp&nbsp&nbsp</a>
							</c:if>	
						</c:forEach>
						<c:forEach items="${coreWorkbenchTipDtoList}" var="coreWorkbenchTipDto">
	                        <c:if test="${coreWorkbenchTipDto.name eq '签到签退'}">
								<input type="hidden" class="workArrangeUrl" value="<%=BaseAction.rootLocation %>/${coreWorkbenchTipDto.dataUrl}"/>                         	  
	                        </c:if>
	                    </c:forEach>
						<c:forEach items="${coreWorkbenchTipDtoList}" var="coreWorkbenchTipDto">
	                        <c:if test="${coreWorkbenchTipDto.name eq '园区概况'}">
								<input type="hidden" class="generalSituationOfParkUrl" value="<%=BaseAction.rootLocation %>/${coreWorkbenchTipDto.dataUrl}"/>                         	  
	                        </c:if>
	                    </c:forEach>
					</li>
					<c:choose>
						<c:when test="${email eq '您还未配置邮箱'}">
							<li style="margin-left: -17px"><img src="core/common/images/icon_mail.png"/>邮件<a href="javascript:void(0)" onclick="myAddTab(parent.parent,'${name }','<%=BaseAction.rootLocation %>/${url}','core/common/images/console.png')"><c:if test="${fn:length(email) gt 3 }">[${fn:substring(email,0,3)}...]</c:if><c:if test="${fn:length(email) le 3 }">[${email }]</c:if></a></li>
						</c:when>
						<c:otherwise>
							<li style="margin-left: -17px">
								<img src="core/common/images/icon_mail.png"/>邮件
								<a href="javascript:void(0)" 
									title="${emailInfo}"
									onclick="addTab(parent.parent,
									'${name }',
									'<%=BaseAction.rootLocation %>/${url}')">
									<c:if test="${fn:length(email) gt 3 }">
										[${fn:substring(email,0,3)}...]
									</c:if>
									<c:if test="${fn:length(email) le 3 }">
										[${email }]
									</c:if>
								</a>
							</li>
						</c:otherwise>
					</c:choose>
                </ul>
            </div>
       <div class="add_list">
        <span>新建：</span><a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'联系人','<%=BaseAction.rootLocation %>/parkmanager.pb/web/client/contect_list.jsp')" style="margin-right: 6px">联系人</a>
        <c:if test="${not empty accessibleModuleMenuIds['oa_schedule_tasking']}">
        	<a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'工作任务','<%=BaseAction.rootLocation %>/parkmanager.oa/web/task2/task_list1.jsp')" style="margin: 6px">工作</a>
        </c:if>
        <c:if test="${not empty accessibleModuleMenuIds['oa_schedule_manager']}">
        	<a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'日程管理','<%=BaseAction.rootLocation %>/parkmanager.oa/schedule!list.action')" style="margin: 6px">日程</a>
        </c:if>
        <c:if test="${not empty accessibleModuleMenuIds['oa_document_personal']}">
        	<a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'个人文档','<%=BaseAction.rootLocation %>/parkmanager.oa/web/document/personaldocuments_list.jsp')" style="margin: 6px">文档</a>
        </c:if>
        <c:if test="${not empty accessibleModuleMenuIds['oa_workReport_myReport']}">
        	<a href="javascript:void(0)" title="" onclick="myAddTab(parent.parent,'我的汇报','<%=BaseAction.rootLocation %>/parkmanager.oa/workReport!list.action','/parkmanager.oa/web/images/oaico/task_13_min.png')" style="margin: 6px">周报</a>
        </c:if>
        <c:if test="${not empty accessibleModuleMenuIds['oa_mail_inbox']}">
        	<a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'发件箱','<%=BaseAction.rootLocation %>/parkmanager.oa/mail!sendList.action')" style="margin: 6px">邮件</a>
        </c:if>
        <c:if test="${not empty accessibleModuleMenuIds['pb_projectManagement_my']}">
        	<a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'我的项目','<%=BaseAction.rootLocation %>/parkmanager.pb/investment!myList.action')" style="margin: 6px">项目</a>
        </c:if>
        <c:if test="${not empty accessibleModuleMenuIds['pb_news']}">
        	<a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'企业信息','<%=BaseAction.rootLocation %>/parkmanager.pb/web/client/customer_list.jsp')" style="margin: 6px">客户</a>
        </c:if>
        <c:if test="${not empty accessibleModuleMenuIds['pb_contractMessage']}">
			<a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'合同信息','<%=BaseAction.rootLocation %>/parkmanager.pb/web/contract/contract_list.jsp')" style="margin:6px">合同</a>
       	</c:if>
        <c:if test="${not empty accessibleModuleMenuIds['oa_contact']}">
			<a href="javascript:void(0)" title="" onclick="addTab(parent.parent,'我的联系单','<%=BaseAction.rootLocation %>/core/contact!listMyAll.action')" style="margin:6px">联系单</a>
       	</c:if>
       </div>     