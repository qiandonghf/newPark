<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %> 
<%@ page language="java"
	import="java.util.*,com.wiiy.commons.action.BaseAction"
	pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path;
%>

			<div class="col-md-3 col-md-pull-9">
			

				<!--leftmenu-->

				<div class="leftbox">
					<h4 class="leftmenutitle">
						<span>${categoryName}</span>
					</h4>
					<ul class="leftmenu">
						<s:iterator value="articleTypeList" status="it" >
							<li >
								<a href='<s:property  value="%{urlPackage(articleTypeList[#it.index].id)}"/>'><s:property  value="%{articleTypeList[#it.index].typeName}"/></a>
							</li>						
						</s:iterator>
					</ul>
				</div>
				<div class="leftbox2">
					<h4 class="leftmenutitle">
						<span>新闻中心</span>
					</h4>
					<ul class="address">
						<li class=""><label>公司电话：</label><span>0571-86649937</span></li>
						<li class=""><label>公司传真：</label><span>0571-86649937</span></li>
						<li class=""><label>Email：</label><span>snny22@163.com</span>
						</li>
						<li class=""><label>公司地址：</label><span>杭州市潮王路238号银地大厦401、403室</span></li>

					</ul>

				</div>
			</div>