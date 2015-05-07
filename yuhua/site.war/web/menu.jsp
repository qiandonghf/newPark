<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction,com.site.Activator" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %> 
<%
	String basePath = BaseAction.rootLocation + request.getContextPath();
	String site = Activator.getAppConfig().getConfig("sys").getParameter("sys.site");
	String email = Activator.getAppConfig().getConfig("sys").getParameter("sys.email");
%>

<script type="text/javascript">

function AddFavorite(sURL, sTitle)
{
    try
    {
        window.external.addFavorite(sURL, sTitle);
    }
    catch (e)
    {
        try
        {
            window.sidebar.addPanel(sTitle, sURL, "");
        }
        catch (e)
        {
            alert("加入收藏失败，请使用Ctrl+D进行添加");
        }
    }
}

function SetHome(obj,vrl){
    try{
            obj.style.behavior='url(#default#homepage)';
            obj.setHomePage(vrl);
    }
    catch(e){
            if(window.netscape) {
                    try {
                            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                    }
                    catch (e) {
                            alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
                    }
                    var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                    prefs.setCharPref('browser.startup.homepage',vrl);
             }
    }
}


</script>
        
        <!-- HEADER -->
        <div id="outerheader">
        	
            <header id="top">
            	<div class="container">
                    <div class="twelve columns">
                        <div id="logo" class="three columns alpha"><a href="<%=basePath%>/index.action"><img src="<%=basePath%>/web/images/logo23.jpg" alt="" /></a></div>
                        <div id="headerright" class="nine columns omega">
                        	<span class="txttopright">热线: 0571-88888888</span>
                            <ul class="sn">
                                <li><a title="收藏本页" href="#"  onclick="AddFavorite(window.location,document.title)"><span style="background:url(<%=basePath%>/web/images/social/shoucang.png)" class="icon-img"></span></a></li>
                                <li><a title="发邮件" href="#"><span style="background:url(<%=basePath%>/web/images/social/gplus.png)" class="icon-img"></span></a></li>
                                <li><a title="设为首页" href="#"  onclick="SetHome(this,window.location)"><span style="background:url(<%=basePath%>/web/images/social/facebook.png)" class="icon-img"></span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <section id="navigation">
                    <div class="container">
                        <nav id="nav-wrap" class="twelve columns">
                            <ul id="topnav" class="sf-menu">
                                <li class="current"><a href="<%=basePath%>/index.action">首页</a></li>
                                
                                <li><a href="#">关于我们</a>
                                    <ul>
									<s:iterator value="articleTypeListAboutUs" status="a" >
										<li >
											<a href='<s:property  value="%{urlPackage(articleTypeListAboutUs[#a.index].id,'menu.aboutus')}"/>'><s:property  value="%{articleTypeListAboutUs[#a.index].typeName}"/></a>
										</li>						
									</s:iterator>
                                    </ul>
                                </li>

                                
                                <li><a href="#">创业基地</a>
								    <ul>
									<s:iterator value="articleTypeListBase" status="b" >
										<li >
											<a href='<s:property  value="%{urlPackage(articleTypeListBase[#b.index].id,'menu.base')}"/>'><s:property  value="%{articleTypeListBase[#b.index].typeName}"/></a>
										</li>						
									</s:iterator>
                                    </ul>
								</li>
								
								<li><a href="#">创业服务</a>
                               		<ul>
									<s:iterator value="articleTypeListServ" status="c" >
										<li >
											<a href='<s:property  value="%{urlPackage(articleTypeListServ[#c.index].id,'menu.serv')}"/>'><s:property  value="%{articleTypeListServ[#c.index].typeName}"/></a>
										</li>						
									</s:iterator>
                                    </ul>
                                </li>   
                                 
                                <li><a href="#">创业政策</a>
                                 <ul>
								<s:iterator value="articleTypeListPolicy" status="d" >
										<li >
											<a href='<s:property  value="%{urlPackage(articleTypeListPolicy[#d.index].id,'menu.policy')}"/>'><s:property  value="%{articleTypeListPolicy[#d.index].typeName}"/></a>
										</li>						
									</s:iterator>
                                        </ul>
    	
                                </li>
                                
                                <li><a href="#">园区资讯</a>
                                    <ul>
								<s:iterator value="articleTypeListInfo" status="e" >
										<li >
											<a href='<s:property  value="%{urlPackage(articleTypeListInfo[#e.index].id,'menu.info')}"/>'><s:property  value="%{articleTypeListInfo[#e.index].typeName}"/></a>
										</li>						
									</s:iterator>
                                    </ul>
                                </li>    
                                
								<li><a href="#">联系我们</a></li>
                            </ul><!-- topnav -->
                        </nav><!-- nav -->	
                        <div class="clear"></div>
                      </div>
                </section>
                <div class="clear"></div>
            </header>
        </div>
        <!-- END HEADER -->