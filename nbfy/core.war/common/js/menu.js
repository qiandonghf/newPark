// JavaScript Document
function selheight(){//获取页面高度

	

	var bodyh=document.documentElement.clientHeight-30;
	var bodyw=document.documentElement.clientHeight-60;
	//alert(bodyw);
	//alert(bodyh);
	//bodyh=Math.max(bodyh,380);
	
    document.getElementById('subnav').style.height=bodyh-26+"px";
	
	 document.getElementById('navlist').style.height=bodyh-57+"px";
	 
	
	document.getElementById('subscroll').style.height=bodyh+"px";
	//document.getElementById('page').style.height=bodyw+"px";
	
	
	
		}
function pageheight(){//获取页面高度
	var bodyh=document.documentElement.clientHeight-30;
	var bodyW=document.documentElement.clientWidth-210;
	//alert(bodyW);
    document.getElementById('subnav').style.height=bodyh+"px";
	document.getElementById('subscroll').style.height=bodyh+"px";
	
	document.getElementById('navlist').style.height=bodyh-57+"px";
	document.getElementById('tt').style.width=bodyW+"px";
	document.getElementById('tt').style.height=bodyh+"px";
		}
		
		
		
function displays(){
	var dis=document.getElementById('sub');
		if(dis.style.display=='none'){
			dis.style.display='block';
			document.getElementById('disbtn').src='core/common/images/scrollleft.gif';
			}
		else{
			dis.style.display='none';
			document.getElementById('disbtn').src='core/common/images/scrollright.gif';
			}
	}
function menulist(m,d){
	var navlist=document.getElementById('navlist');
	var navlistdivs=navlist.getElementsByTagName('div');
	//alert(menuids.length);
	var em=document.getElementsByTagName('em');
	var emid=document.getElementById(m);
	var divid=document.getElementById(d);
	for(var i=0; i<em.length;i++){//em处理
		em[i].className="b";
		//alert("asdfads");
		}
		emid.className="b1";
	for(var j=0; j<navlistdivs.length;j++){
		//alert(navlistdivs[j].name);
		if(navlistdivs[j].name!='menuid') continue;
		navlistdivs[j].style.display="none";
		
		}
		divid.style.display="block";
	}
function menudlistwo(m,span){
	var div=document.getElementById(m);
	if(div.style.display=="none"){
		div.style.display="block";
		document.getElementById(span).src='core/common/images/twomenu.gif';
		}
		else{
		div.style.display="none";
		document.getElementById(span).src='core/common/images/onemenu.gif';
			}
	}
function layermenu(){//设置菜单效果
	var layermenu=document.getElementById('layeroutid');
	if(layermenu.style.display=="none"){
		layermenu.style.display="block";
	}else{
		layermenu.style.display="none";
	}
}
function menuHandle(element){
	if($(element).next().is(":hidden")){
		$(element).parent().children().first().children().first().attr("src","core/common/images/openeds.gif");
		$(element).next().slideToggle();
	} else {
		$(element).parent().children().first().children().first().attr("src","core/common/images/closeds.gif");
		$(element).next().slideToggle();
	}
}

function initMenu(){
	$("#navlist li").each(function(){
		$(this).children().eq(1).bind("click",function(){
			if($(this).next().is(":hidden")){
				$(this).next().slideToggle();
				$(this).prev().removeClass("b").addClass("b1");
				$(this).parent().siblings().each(function(){
					$(this).children().eq(2).slideUp();
					$(this).children().eq(0).removeClass("b1").addClass("b");
				});
			} else {
				$(this).next().slideToggle();
				$(this).prev().removeClass("b1").addClass("b");
			}
		});
	});
}