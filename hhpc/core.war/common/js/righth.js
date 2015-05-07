// JavaScript Document
function bodyheights(nameid1,height1,nameid2,height2){//获取屏幕高度
	var bodyh=window.parent.document.documentElement.clientHeight-height1;
	var bodyh1=window.parent.document.documentElement.clientHeight-height2;
	document.getElementById(nameid1).style.height=bodyh+"px";
	document.getElementById(nameid2).style.height=bodyh1+"px";
	}
	
	
function bodyheights2(nameid1,height1,nameid2,height2){//获取屏幕高度
	var objH = document.documentElement.clientHeight,
		bodyh=objH-height1,
		bodyh1=objH-height2,
		hArr=[];
		
		
	$(nameid1).height(bodyh);
	$(nameid2).height(bodyh1);
	
	hArr[0]=bodyh,hArr[1]=bodyh1;
	
	return hArr;
	
	
}
	
function bodyheightspm(){
	var bodyh=window.parent.document.documentElement.clientHeight-228;
	var bodymsgh=document.body.clientHeight-92;
	bodyh=Math.max(bodyh,bodymsgh);
	document.getElementById('resizable').style.height=bodyh+"px";
	document.getElementById('msglist').style.height=bodyh+"px";
	}

function treeviewdiv(nameid1,height1){
	var bodyh1=document.documentElement.clientHeight-height1;
	document.getElementById(nameid1).style.height=bodyh1+"px";
	}
	
//以上计算页面高度
function layerdis(){
	var layerdivid=document.getElementById('layerdiv');
	//alert(layerdivid);
	if(layerdivid.style.display=='none'){
		layerdivid.style.display='block';
		}
	else{
		layerdivid.style.display='none';
		}
	}
function angencylist(){
	var one=document.getElementById('one');
	var titleone=document.getElementById('titleone');
	if(one.style.display=='none'){
		one.style.display="block";
		titleone.className='open';
		}
	else{
		one.style.display="none";
		titleone.className='close';
		}
	}
function angencylist1(){
	var two=document.getElementById('two');
	var titletwo=document.getElementById('titletwo');
	if(two.style.display=='none'){
		two.style.display="block";
		titletwo.className='open';
		}
	else{
		two.style.display="none";
		titletwo.className='close';
		}
	}
function apptab(m){//应用管理
	var tab=document.getElementById('apptab');
	var tabli=tab.getElementsByTagName('li');
	//alert(tabli);
	for(var i=0; i<tabli.length;i++){
		tabli[i].className="apptabli";
		}
		tabli[m].className='apptabliover';
	var tabname=document.getElementsByName('appname');
	for(var j=0; j<tabname.length;j++){
		tabname[j].style.display="none";
		}
		tabname[m].style.display="block";
	}
function displaydiv(){
	var layer=document.getElementById('meterlayer');
	if(layer.style.display=="block"){
		layer.style.display="none";
		}else{
			layer.style.display="block";
			//alert();
		return false;
			}
	}
function searchdiv(){
	var searchs=document.getElementById('searchid');
	if(searchs.style.display=="none"){
		searchs.style.display="block";
		}
	else{
		searchs.style.display="none";
		}
	}
function fee_merter(){
	var fee=document.getElementById('fee_lefts');
	var leftpic=document.getElementById('leftpic');
	if(fee.style.display=='none'){
		fee.style.display='block';
		leftpic.src='../../images/scrollleft.gif';
		}
	else{
		fee.style.display='none';
		leftpic.src='../../images/scrollright.gif';
		}
	}