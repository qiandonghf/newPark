function refresh(){
	if(fb.instances.length>1){
		fb.instances[fb.instances.length-2].getIframeDocument().location.reload();
	} else {
		var tab = $('#tt').tabs('getSelected');
		window.frames[$('#tt').tabs('getTabIndex',tab)].location.reload();
	}
}
function search(filters){
	var tab = $('#tt').tabs('getSelected');
	window.frames[$('#tt').tabs('getTabIndex',tab)].search(filters);
}
function getCurrentFrame(){
	var tab = $('#tt').tabs('getSelected');
	return window.frames[$('#tt').tabs('getTabIndex',tab)];
}
function initTab(){
	$("#tt").attr("style", "display:block");
	var width = document.documentElement.clientWidth;
	$('#tt').tabs({
	    border:false,
	    width:width-210
	});
	$(".tt").each(function() {
		attachMenuEvent(this);
	});
}

function attachMenuEvent(element) {
	$(element).click(function(e) {
		e.preventDefault();
		var icon = $(this).prev().find("img").attr("src");
		var plugin=$(this).text();
		if ($('#tt').tabs('exists',plugin)){
			$('#tt').tabs('select', plugin);
		} else {
			var url=$(this).attr("href");
			$('#tt').tabs('add',{
				title:plugin,
				iconCls:'icon-reload',
				content: '<iframe src="'+url+'" frameborder="0" height="'+(document.documentElement.clientHeight-147)+'" width="100%"></iframe>',
				closable:true
			});
		}
		addTabIcon(plugin,icon);
		return false;
	});
}

function addTabIcon(title,icon){
	var span = $('#tt').find("span:contains('"+title+"')");
	span.next().css("background","url('"+icon+"') no-repeat");
}

function initMenu(){
	$("#navlist li").each(function(){
		$(this).children().eq(1).bind("click",function(){
			if($(this).next().is(":hidden")){
				$(this).prev().removeClass("b").addClass("b1");
				$(this).parent().siblings().each(function(){
					$(this).children().eq(2).slideUp();
					$(this).children().eq(0).removeClass("b1").addClass("b");
				});
			} else {
				$(this).prev().removeClass("b1").addClass("b");
			}
			$(this).next().slideToggle();
		});
	});
}
function initHeight() {
	var height = document.documentElement.clientHeight-120;
	var subNavHeigth = document.documentElement.clientHeight - 160;
	var width = document.documentElement.clientWidth - 210;
	$("#subnav").css("height",subNavHeigth);
	$("#subscroll").css("height",height);
	$("#navlist").css("height",height-74);
	$("#tt").css("height",height);
	$("#tt").css("width",width);
}
function getSelectFrame(){
	var tab = $('#tt').tabs('getSelected');
	return window.frames[$('#tt').tabs('getTabIndex',tab)];
}
function leftHandle() {
	var leftWidth = 202;
	if($("#sub").css("display")=='none'){
		$("#sub").show();
		$('#tt').tabs("options").width=$('#tt').tabs("options").width-leftWidth;
		$(getSelectFrame().document).find(".contentDiv").each(function(){
			$(this).width($(this).width()-leftWidth);
		});
		$(getSelectFrame().document).find(".jqGridList").each(function(){
			$(this).setGridWidth(document.documentElement.clientWidth-leftWidth);
			var pager = $(getSelectFrame().document).find($(this).getGridParam("pager"));
			pager.css("width",(parseInt(pager.css("width"))-leftWidth));
		});
		var frames = getSelectFrame().window.frames;
		for(var i = 0; i < frames.length; i++){
			var frame = frames[i];
			$(frame.document).find(".contentDiv").each(function(){
				$(this).width($(this).width()-leftWidth);
			});
			$(frame.document).find(".jqGridList").each(function(){
				$(this).setGridWidth($(this).getGridParam("width")-leftWidth);
				var pager = $(frame.document).find($(this).getGridParam("pager"));
				pager.css("width",(parseInt(pager.css("width"))-leftWidth));
			});
		}
		$("#tt").css("width",$("#tt").width()-210).tabs("resize");
		$("#tt1").css("width",$("#tt1").width()-210);
		$("#tt2").css("width",$("#tt2").width()-210);
		$("#disbtn").attr("src","core/common/images/scrollleft.gif");
	} else {
		$("#sub").hide();
		$('#tt').tabs("options").width=$('#tt').tabs("options").width+leftWidth;
		$("#tt").css("width",$("#tt").width()+210).tabs("resize");
		$("#tt1").css("width",$("#tt1").width()+210);
		$("#tt2").css("width",$("#tt2").width()+210);
		$("#disbtn").attr("src","core/common/images/scrollright.gif");
		$(getSelectFrame().document).find(".contentDiv").each(function(){
			$(this).width($(this).width()+leftWidth);
		});
		$(getSelectFrame().document).find(".jqGridList").each(function(){
			$(this).setGridWidth($(this).getGridParam("width")+leftWidth);
			var pager = $(getSelectFrame().document).find($(this).getGridParam("pager"));
			pager.css("width",(parseInt(pager.css("width"))+leftWidth));
		});
		var frames = getSelectFrame().window.frames;
		for(var i = 0; i < frames.length; i++){
			var frame = frames[i];
			$(frame.document).find(".contentDiv").each(function(){
				$(this).width($(this).width()+leftWidth);
			});
			$(frame.document).find(".jqGridList").each(function(){
				$(this).setGridWidth($(this).getGridParam("width")+leftWidth);
				var pager = $(frame.document).find($(this).getGridParam("pager"));
				pager.css("width",(parseInt(pager.css("width"))+leftWidth));
			});
		}
	}
}
function menuHandle(element){
	if($(element).next().is(":hidden")){
		$(element).parent().children().first().children().first().attr("src","core/common/images/twomenu.gif");
		$(element).next().slideToggle();
		$(element).parent().siblings().slideUp();
		$(element).parent().siblings().children().first().children().first().attr("src","core/common/images/onemenu.gif");
	} else {
		$(element).parent().children().first().children().first().attr("src","core/common/images/onemenu.gif");
		$(element).next().slideToggle();
	}
}