<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>协会办公</title>
<link href="core/common/style/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/menu.js"></script>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tab.js"></script>
<link href="core/common/style/tab.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"> 
<!--tab滚动开始-->
$(document).ready(function(){
	$("#tab_menu").width($(".tabdiv").width()-255);
	$(".sharename").click(function(){
		if($(".share").css("right")=="0px"){
		$(".share").animate({right:"-272px"});
		}else{
		$(".share").animate({right:"0px"});
		}
	});
})
var a=0;
$(document).ready(function(){
initMenu();
  $(".leftframediv").click(function(){
  a=a-100;
  $("#tab_menu").animate({left:a+"px"},"slow");
  });
});
$(document).ready(function(){
  $(".rightramediv").click(function(){
  a=a+100;
  $("#tab_menu").animate({left:a+"px"},"slow");
  });
});
<!--tab滚动结束-->
var tab=null;
$( function() {
	  tab = new TabView( {
		containerId :'tab_menu',
		pageid :'page',
		cid :'tab_po',
		position :"top"
	});
	
});


$(document).ready(function() {
            $("#navlist dd a").each(function(index) {
                $(this).click(
                        function() {
							tab.add({
								id:"tabIndex"+index,
								url: $(this).attr("href"),
								title: $(this).text(),
								isClosed :true
							});
							return false;
                        })
            })
        });

</script>
</head>

<body onload="selheight();">

<div class="share">
	<div class="sharename"></div>
	<ul>
		<img id="shareimg" src="../images/im.png" />
	</ul>
	<div class="hackbox"></div>
</div>

<div class="layeroutdiv" id="layeroutid" style="display:none">
<div class="layeroutdivjt"></div>
<div class="layeroutclose"><img src="../images/closebnt.png" onclick="layermenu()" /></div>
<div class="layerout"  >
<div class="layerseave"><img src="../images/save.gif" width="75" height="22" /> &nbsp; <img src="core/common/images/cancel.gif" width="75" height="22" onclick="layermenu()" style="cursor:pointer;" /></div>
</div>
</div>

<!--contant-->
<div id="contant">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top">
		<div id="sub" style="display:block;">
			<!--subnav-->
			<div id="subnav">
			<!--topico-->
			<div id="topico">
				<ul>
					<li>
					<span class="ico1" onmousemove="this.className='ico1over'" onmouseout="this.className='ico1'"></span><span class="ico2" onmousemove="this.className='ico2over'" onmouseout="this.className='ico2'"></span><span class="ico3" onmousemove="this.className='ico3over'" onmouseout="this.className='ico3'"></span><span class="ico4" onmousemove="this.className='ico4over'" onmouseout="this.className='ico4'"></span><span class="ico5" onmousemove="this.className='ico5over'" onmouseout="this.className='ico5'"></span><span class="ico6" onmousemove="this.className='ico6over'" onmouseout="this.className='ico6'"></span><span class="ico8" onmousemove="this.className='ico8over'" onmouseout="this.className='ico8'" onclick="layermenu()"></span>
					</li>
				</ul>
			</div>
			<!--//topico-->
			<!--navlist-->
			<div id="navlist">
				<ul>
					<li class="li1"><em id="em1" class="b"></em><a href="javascript:void(0)" >会员信息管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div1" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanico"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.association/web/incubator/incubator_list.jsp">孵化器</a></dd>
								<dd class="menuli"><span class="spanico"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.association/web/cooperate/cooperate_list.jsp">合作机构</a></dd>
								<dd class="menuli"><span class="spanico"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.association/web/vip/vip_list.jsp">VIP管理</a></dd>
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
					<li class="li1" ><em id="em1" class="b"></em><a href="javascript:void(0)">信息发布管理</a></li>
					<li class="li1" ><em id="em1" class="b"></em><a href="javascript:void(0)">数据报送管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanico"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.association/web/data/data_nation.html">国家级</a></dd>
								<dd class="menuli"><span class="spanico"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.association/web/data/data_city.html">市级</a></dd>
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
				</ul>
			</div>
			<!--//navlist-->
			</div>
			
			<!--//subnav-->
		  </div>
		</td>
		<td><div id="subscroll"><img id="disbtn" src="core/common/images/scrollleft.gif" onclick="displays();" /></div></td>
        <td valign="top" id="content">
		<div class="tabdivall">
		<!--tabdiv-->
		<div class="tabdiv">
		<div class="rightramediv"><img src="core/common/images/rightframeico.gif" style="cursor:pointer;" /></div>
		<div class="leftframediv"><img src="core/common/images/leftframeico.gif" style="cursor:pointer;" /></div>
		<div id="tab_menu" style=" position:relative;"></div>
		</div>
		<!--//tabdiv-->
		</div>
		<div id="page"></div>
		</td>
      </tr>
  </table>
<!--footer-->
<div id="footer">Copyright ©2010 www.complay.com  |   Tel: 0571-88881234</div>
<!--//footer-->
</div>
<!--//contant-->
</body>
</html>
