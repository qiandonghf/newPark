	function windowOpen(url,name,w,h) {
		window.open(url,name,'height='+h+',width='+w+',top=100,left=150,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
	}	
	
	function getMap() {//初始化map_,给map_对象增加方法，使map_像Map    
        var map_ = new Object();    
        map_.put = function(key, value) {    
            map_[key+'_'] = value;    
        };    
        map_.get = function(key) {    
            return map_[key+'_'];    
        };    
        map_.remove = function(key) {    
            delete map_[key+'_'];    
        };    
        map_.keyset = function() {    
            var ret = "";    
            for(var p in map_) {    
                if(typeof p == 'string' && p.substring(p.length-1) == "_") {    
                    ret += ",";    
                    ret += p.substring(0,p.length-1);    
                }    
            }    
            if(ret == "") {    
                return ret.split(",");    
            } else {    
                return ret.substring(1).split(",");    
            }    
        };    
        return map_;    
	}  

	Date.prototype.format = function(format) {  
	     var o = {  
	         "M+" :this.getMonth() + 1, // month  
	         "d+" :this.getDate(), // day  
	        "h+" :this.getHours(), // hour  
	         "m+" :this.getMinutes(), // minute  
	        "s+" :this.getSeconds(), // second  
	         "q+" :Math.floor((this.getMonth() + 3) / 3), // quarter  
	         "S" :this.getMilliseconds()  
	     // millisecond  
	    }  ;
	     if (/(y+)/.test(format)) {  
	        format = format.replace(RegExp.$1, (this.getFullYear() + "")  
	                .substr(4 - RegExp.$1.length));  
	     }  
	     for ( var k in o) {  
	         if (new RegExp("(" + k + ")").test(format)) {  
	             format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]  
	                     : ("00" + o[k]).substr(("" + o[k]).length));  
	        }  
	     }  
	     return format;  
	 } ;
	
	function fbStartOnScroll(names,add,widht,height){
		fb.start(add,"caption:"+names+" width:"+widht+" height:"+height+" outsideClickCloses:false showNewWindow:false caption2Pos:tr captionPos:tr controlsPos:tr colorTheme:blue showPrint:false mobileNewWindow:false enableDragResize:false roundCorners:top cornerRadius:0px outerBorder:1px innerBorder:0px  showNewWindowIcon:false resizeDuration:0 padding:0px panelPadding:0px imageFadeDuration:0 overlayFadeDuration:0 overlayOpacity:45");
	}
	
	function addTab(topWindow,plugin,url){
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
	
	function jqGridResizeRegister(){
		return;
		var list = arguments;
		var leftMenuWidth = 202;
		var leftSwitch = parent.$("#disbtn");
		var content = parent.$("#sub");
		if(!leftSwitch.attr("src")){
			leftSwitch = parent.parent.$("#disbtn");
			content = parent.parent.$("#sub");
		}
		leftSwitch.bind("click",function(){
			for(var i = 0 ; i < list.length; i++){
				if(content.is(":hidden")){
					$("#"+list[i]).setGridWidth($("#"+list[i]).getGridParam("width")+leftMenuWidth);
				} else {
					$("#"+list[i]).setGridWidth($("#"+list[i]).getGridParam("width")-leftMenuWidth);
				}
			}
		});
	}
	function getTabContentHeight(){
		return document.documentElement.clientHeight;
	}
	function getOpener(){
		if(fb.instances.length>1){
			return fb.instances[fb.instances.length-2].getIframeWindow();
		} else {
			var tab = parent.$('#tt').tabs('getSelected');
			return parent.window.frames[parent.$('#tt').tabs('getTabIndex',tab)];
		}
	}

	/**
	 * 获取jqgrid搜索条件(样式名：field data op dataType)
	 * @return {TypeName} 
	 */
	function getSearchFilters(){
		var filters = "{\"rules\":[";
		for(var i = 0; i < $(".field").size(); i++){
			if($(".data").get(i).value!=null && $(".data").get(i).value!=''){
				filters += "{\"field\":\""+$(".field").get(i).value+"\",\"op\":\""+$(".op").get(i).value+"\",\"data\":\""+$(".data").get(i).value+"\",\"dataType\":\""+$(".dataType").get(i).value+"\"},";
			}
		}
		filters = deleteLastCharWhenMatching(filters,",");
		filters += "]}";
		return filters;
	}
	function deleteLastCharWhenMatching(string,c){
		if(string.charAt(string.length-1)==c){
			string = string.substring(0,string.length-1);
		}
		return string;
	}
	/**
	 * 生成filters
	 * @param {Object} field 字段名
	 * @param {Object} data 数据
	 * @param {Object} op 操作符
	 * @param {Object} dataType 数据类型
	 * @return {TypeName} 
	 */
	function generateSearchFilters(field,op,data,dataType){
		if(data!=''){
			var filters = "{\"rules\":[";
			filters += "{\"field\":\""+field+"\",\"op\":\""+op+"\",\"data\":\""+data+"\",\"dataType\":\""+dataType+"\"},";
			deleteLastCharWhenMatching(filters,",");
			filters += "]}";
			return filters;
		} else return "";
	}

	function tabSwitch(defaultClass,activityClass,switchClass,index){
		if($("."+defaultClass).size()>0){
			$("."+activityClass).removeClass(activityClass).addClass(defaultClass);
			$("."+switchClass).hide();
			$("."+defaultClass+":eq("+index+")").removeClass(defaultClass).addClass(activityClass);
			$("."+switchClass+":eq("+index+")").show();
		}
	}
	/**
	 * 弹出搜索框</br>
	 * 参数列表</br>
	 * caption		弹出窗口的标题(string)</br>
	 * url			弹出窗口的URL(string)</br>
	 * width		弹出窗口的宽度(int)</br>
	 * height		弹出窗口的高度(int)</br>
	 */
	function fbSearch(){
		var url = "";
		var floatboxConfig = " outsideClickCloses:false showNewWindow:false boxColor:'#00478c' colorTheme:'black' padding:0px  panelPadding:0 outerBorder: 2 innerBorder: 0 roundCorners: 'none' showClose: true showOuterClose:false caption2Pos:tr captionPos:tl controlsPos:tr showMagCursor: yes overlayFadeDuration: 3.5 imageFadeDuration: 2 resizeDuration: 0 overlayOpacity:0";
		switch (arguments.length) {
		case 4:
			floatboxConfig = " height:"+arguments[3]+floatboxConfig;
		case 3:
			floatboxConfig = " width:"+arguments[2]+floatboxConfig;
		case 2:
			url = arguments[1];
		case 1:
			floatboxConfig = " caption:"+arguments[0]+floatboxConfig;
		}
		fb.start(url,floatboxConfig);
	}

	/**
	 * 弹出一个窗口</br>
	 * 参数列表</br>
	 * caption		弹出窗口的标题(string)</br>
	 * url			弹出窗口的URL(string)</br>
	 * width		弹出窗口的宽度(int)</br>
	 * height		弹出窗口的高度(int)</br>
	 * config		自定义配置参数</br>
	 */
	var floatboxConfig = " outsideClickCloses:false scrolling:no showNewWindow:false shadowType:hybrid caption2Pos:tr outerBorderColor:#737885 captionPos:tr enableDragMove:true controlsPos:tr colorTheme:blue showPrint:false mobileNewWindow:false enableDragResize:false stickyDragMove:true showMoveCursor:true roundCorners:top cornerRadius:0px outerBorder:2px innerBorder:0px showNewWindowIcon:false resizeDuration:0 padding:0px panelPadding:0px imageFadeDuration:0 overlayFadeDuration:0 overlayOpacity:45 shadowOpacity:0";
		
	function fbStart(){
		
		var url = "";
		var config = "";
		switch (arguments.length) {
		case 5:
			config = arguments[4];
		case 4:
			floatboxConfig = " height:"+arguments[3]+floatboxConfig;
		case 3:
			floatboxConfig = " width:"+arguments[2]+floatboxConfig;
		case 2:
			url = arguments[1];
		case 1:
			floatboxConfig = " caption:"+arguments[0]+floatboxConfig;
		}
		floatboxConfig = config+" "+floatboxConfig;
		fb.start(url,floatboxConfig);
	}
	
	function fbLockScreen(names,add,widht,height){
		fb.start(add,"caption:"+names+" width:"+widht+" height:"+height+"  showNewWindow:false caption2Pos:tr captionPos:tr controlsPos:tr colorTheme:blue showPrint:false mobileNewWindow:false enableDragResize:false roundCorners:top cornerRadius:0px outsideClickCloses:false showClose:false outerBorder:1px innerBorder:0px  showNewWindowIcon:false resizeDuration:0 padding:0px  panelPadding:0px imageFadeDuration:0 overlayFadeDuration:0 overlayOpacity:45");
	}

	function fbShow(url){
		fb.start("core/resources/"+url,"outsideClickCloses:true autoFitImages true boxColor: '#00478c',colorTheme: 'auto',padding: 0,panelPadding: 4,outerBorder: 2,innerBorder: 0,roundCorners: 'none',showClose: false,showOuterClose: true,captionPos: 'tc',showMagCursor: 'yes',overlayFadeDuration: 3.5,imageFadeDuration: 2,resizeDuration: 0");
	}
	
	//显示提示信息 第一个参数为提示信息 第二个参数为显示时间(选填 默认为1000ms)
	var tip;
	function showTip() {
		clearTimeout(tip);
		var text = "提示信息";
		var time = 1000;
		switch (arguments.length) {
		case 2:
			time = arguments[1];
		case 1:
			text = arguments[0];
		}
		document.getElementById("tip").innerHTML=text;
		document.getElementById("tip").style.display = "block";
		tip = window.setTimeout(function () {
			document.getElementById("tip").style.display = "none";
		}, time);
	}
	function hiddenTip(){
		document.getElementById("tip").style.display = "none";
	}
	function initTip(){
		$("<div id=\"tip\" class=\"msgpage\"></div>").css("display","none").appendTo($("body"));
		$("<div id=\"loading\" class=\"mloading\"></div>").bind("ajaxSend", function(){
			$(this).show();
		}).bind("ajaxComplete", function(){
			$(this).hide();
		}).css("display","none").append($("<img />",{src:"core/common/images/zoomloader.gif"})).appendTo($("body"));
	}
	function getParam(id){
		if(getOb(id)!=null && getValue(id)!=null && getValue(id)!='')
			return '&'+id+'='+getValue(id);
		return "";
	}
	function getParams(){
		var result = '';
		for(var i = 0;i < arguments.length; i++){
			result += getParam(arguments[i]);
		}
		return result;
	}
	
	function notNull(id,msg){
		if(getOb(id)!=null && getOb(id).value!=''){
			return true;
		} else {
			showTip("请输入"+msg);
			focus(id);
			return false;
		}
	}
	function isNull(id,msg){
		if(getOb(id)==null || getOb(id).value==''){
			return true;
		}
	}
	
	function checkSelect(id,msg){
		if(getOb(id)!=null && getOb(id).value!=''){
			return true;
		} else {
			showTip("请选择"+msg);
			focus(id);
			return false;
		}
	}
	
	//删除左右两端的空格 此方法只适用于较短字符串 大量字符串请别想办法
	function trim(str){
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}
	//删除左边的空格 此方法只适用于较短字符串 大量字符串请别想办法
	function ltrim(str){
		return str.replace(/(^\s*)/g,"");
	}
	//删除右边的空格 此方法只适用于较短字符串 大量字符串请别想办法
	function rtrim(str){
		return str.replace(/(\s*$)/g,"");
	}
	
	function CharMode(iN) {
		if (iN >= 48 && iN <= 57) //数字 
			return 1;
		if (iN >= 65 && iN <= 90) //大写字母 
			return 2;
		if (iN >= 97 && iN <= 122) //小写 
			return 4;
		else
			return 8; //特殊字符 
	}
	//计算出当前密码当中一共有多少种模式 
	function bitTotal(num) {
		modes = 0;
		for (var i = 0; i < 4; i++) {
			if (num & 1)
				modes++;
			num >>>= 1;
		}
		return modes;
	}
	//返回密码的强度级别 
	function checkStrong(sPW) {
		if (sPW.length <= 4)
			return 0; //密码太短 
		Modes = 0;
		for (var i = 0; i < sPW.length; i++) {
			//测试每一个字符的类别并统计一共有多少种模式. 
			Modes |= CharMode(sPW.charCodeAt(i));
		}
		return bitTotal(Modes);
	}
	//验证Email
	function checkEmail(id,msg){
		var norm = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
		return checkOb(id,norm,msg);
	}
	//验证QQ
	function checkQq(id,msg){
		var norm = /[1-9][0-9]{4,}/;
		return checkOb(id,norm);
	}
	//验证账号
	function checkAccount(id,msg){	
		var norm = /^[\u4e00-\u9fa5a-zA-Z0-9_]{1,30}$/;
		return checkOb(id,norm);
	}
	//验证邮编
	function checkPost(id,msg){
		var norm = /^\d{6}$/;
		return checkOb(id,norm,msg);
	}
	//验证浮点数
	function checkDouble(id,msg){
		var norm = /^\d{1,12}(?:\.\d{1,2})?$/;
		return checkOb(id,norm,msg);
	}
	//验证浮点数值(参数为值 如 1.23)
	function checkDoubleValue(value){
		var norm = /^-?\d{1,12}(?:\.\d{1,2})?$/;
		return checkValue(value,norm);
	}
	//验证整数
	function checkInt(id,msg){
		var norm = /^[1-9]\d*$/;
		return checkOb(id,norm,msg);
	}
	//验证整数值(参数为值 如 123)
	function checkIntValue(value){ 
		if(value==0){
			return true;
		}
		var norm = /^[1-9]\d*$/;
		return checkValue(value,norm);
	}
	//验证手机
	function checkMobile(id,msg){
		var norm = /^0{0,1}1[3,5,8][0-9]{9}$/;
		return checkOb(id,norm,msg);
	}
	//验证电话(格式为xxx-xxxxxxxx xxxx-xxxxxxx xxxxxxxxxxx)
	function checkPhone(id,msg){
		var norm = /\d{3}-?\d{8}|\d{4}-?\d{7}/;
		return checkOb(id,norm,msg);
	}
	//验证字符串长度
	function checkLength(id,min,max){
		return getValue(id).length>=min && getValue(id).length<=max;
	}
	//验证字符串是否超过最大长度(如验证用户名最长不能超过50位)
	function checkMaxLength(id,max){
		return getValue(id).length<=max;
	}
	//验证字符串是否小于最小长度(如验证密码最短为4位)
	function checkMinLength(id,min){
		return getValue(id).length>=min;
	}
	//验证身份证号码(15到18位数字)
	function checkIdentityCard(id,msg){
		var norm = /d{15}|d{18}/;
		return checkOb(id,norm,msg);
	}
	//验证汉字
	function checkHanzi(id,msg){
		var norm = /[\u4e00-\u9fa5]/;
		return checkOb(id,norm,msg);
	}
	//验证IP
	function checkIp(id,msg){
		var norm = /^(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.)(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.){2}([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))$/;
		return checkOb(id,norm,msg);
	}
	function checkPage(value){
		var norm = /^[1-9]\d*$/;
		return checkValue(value+"",norm);
	}
	function checkValue(value,norm){
		return value.search(norm) >= 0;
	}
	function checkEqual(id,id2){
		return getValue(id)==getValue(id2);
	}
	function checkOb(id,norm,msg){
		if(getValue(id).search(norm) < 0){
			showTip(msg+"格式错误");
			return false;
		}
		return true;
	}
	function getValue(id){
		return getOb(id).value;
	}
	function getOb(id){
		return document.getElementById(id);
	}
  	function clear(id){
		getOb(id).value="";
		focus(id);
  	}
  	function focus(id){	
  		if(getOb(id)!=null)
		getOb(id).focus();
  	}
  	function escId4JQuery(id) {
  		var ret = id.replace(/:/g,"\\:");
        ret = ret.replace(/\./g,"\\.");
        ret = ret.replace(/\//g,"\\/");
        ret = ret.replace(/\$/g,"\\$");
        ret = ret.replace(/\[/g,"\\[");
        ret = ret.replace(/\]/g,"\\]");
        return ret;
  	}