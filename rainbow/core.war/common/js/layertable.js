// JavaScript Document
function layertable(m){
	var layerid=document.getElementById('tableid');
	var layerli=layerid.getElementsByTagName('li');
	for(var i=0;i<layerli.length; i++){
		layerli[i].className="tabledivli";
		}
		layerli[m].className="tabledivli1";
	var tabname=document.getElementsByName('textname');
		for(var j=0; j<tabname.length;j++){
			tabname[j].style.display="none";
			}
		tabname[m].style.display="block";
	}
function parktab(m){
	var layerid=document.getElementById('tableid');
	var layerli=layerid.getElementsByTagName('li');
	for(var i=0;i<layerli.length; i++){
		layerli[i].className="apptabli";
		}
		layerli[m].className="apptabliover";
	var tabname=document.getElementsByName('textname');
		for(var j=0; j<tabname.length;j++){
			tabname[j].style.display="none";
			}
		tabname[m].style.display="block";
	}
function parklayer(){
	var disdiv=document.getElementById('parkdiv');
	if(disdiv.style.display=="none"){
		disdiv.style.display="block";
		}else{
		disdiv.style.display="none";	
			}
	
	}
function companylabel(){
	var company=document.getElementById('company_label');
	if(company.style.display=="none"){
		company.style.display="block";
		}
	else{
		company.style.display="none";
		}
	}
	
	function companylabel2(){
	var company=document.getElementById('company_label2');
	if(company.style.display=="none"){
		company.style.display="block";
		}
	else{
		company.style.display="none";
		}
	}
	
function customerspan(spanname){
	var span1=document.getElementById(spanname);
	//alert(span1);
		 span1.style.display="";

	}
function customerspanout(spanname){
	var span1=document.getElementById(spanname);
		//alert(span1);
		 span1.style.display="none";
	}