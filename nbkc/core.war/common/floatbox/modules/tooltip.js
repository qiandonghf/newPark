/* Floatbox v4.23 */
(function(){var a=true,b=false,c=null,d;fb.extend(fb.proto,{GT:function(){var e=this;e.IY=50;e.IZ=e.IY*0.001;e.JA=0;e.KN=e.KO=e.FS=e.FT=e.JW=-1;e.target=c;e.GR=function(f){e.KN=f.clientX+e.dx;e.KO=f.clientY+e.dy;e.target=f.target;if(e.FS===-1){e.FS=e.KN}if(e.FT===-1){e.FT=e.KO}if(typeof e.FV===fb.SE){e.FV()}};if(fb.ie){e.mousemoveHash=fb.DZ(e.GR)}e.IW=function(){var g=e.KN-e.FS,f=e.KO-e.FT;e.JW=Math.sqrt(g*g+f*f)/e.IZ;e.FS=e.KN;e.FT=e.KO;e.JA+=e.IY;if(e.JA&&typeof e.IX===fb.SE){e.IX()}};e.KA=function(h){e.H=h=h||document;var i=fb.DL(h[fb.QJ]||h[fb.UP]);if(i){var g=fb[fb.SL](i),f=fb[fb.SN](fb.Z);e.dx=g.left-f.left;e.dy=g.top-f.top}else{e.dx=e.dy=0}if(!fb.mobile){fb[fb.PC](h,fb.TK,e.GR,e.mousemoveHash)}};e.KH=function(){fb[fb.UX](e.H,fb.TK,e.GR,e.mousemoveHash);e.FV=c};e.KB=function(){e.JA=-e.IY;e.FS=e.FT=e.JW=-1;e.FE=setInterval(e.IW,e.IY);e.IW()};e.KI=function(){clearInterval(e.FE);e.IX=c}},KS:function(g,p,l){var s=this,r={doAnimations:b,colorTheme:"white",scrolling:"no",roundCorners:"all",cornerRadius:4,shadowType:"drop",shadowSize:4,showClose:b,titleAsCaption:b,enableKeyboardNav:b,padding:0,outerBorder:1,innerBorder:0,enableDragResize:b,enableDragMove:b,centerOnResize:b,attachToHost:b,moveWithMouse:b,placeAbove:b,timeout:0,delay:80,mouseSpeed:120,fadeDuration:3,defaultCursor:b,FI:a};function f(){var B=fb.KW,j=B.W,A=B.mo,t=s[fb.SL](B.node),i=s[fb.SN](s.Z);A.KI();n();if(j.attachToHost){A.KH();j.EK=t.height;j.boxTop=t.top-i.top+(j[fb.VG]==="halo"?j[fb.VF]:0)}else{B.hostLeft=t.left-i.left;B.EN=t.top-i.top;B.hostRight=B.hostLeft+t.width;B.EJ=B.EN+t.height;j.EK=s.O(j[fb.VF]+1,s.ie?19:21);j.boxTop=A.KO;if(j.placeAbove){j.boxTop-=5}}if(j[fb.TO]){B.KD=A.KN;B.KE=A.KO;B.FR=j[fb.QK]?i:{left:0,top:0};A.FV=function(){if(!fb.KW){return}if(fb.B){if(A.KN<B.hostLeft||A.KN>B.hostRight||A.KO<B.EN||A.KO>B.EJ){q()}else{if(fb.B.fbBox&&typeof B.AU==="number"){var C=fb.B.fbBox.style;C.left=(B.AU+A.KN-B.KD-B.FR.left)+"px";C.top=(B.AV+A.KO-B.KE-B.FR.top)+"px";if(j[fb.QK]){B.FR=s[fb.SN](s.Z)}}}}}}s.start(c,j);if(j.timeout){if(B.KR){clearTimeout(B.KR)}B.KR=s.I(function(){B.KR=c;q()},j.timeout*1000)}}function q(){if(!fb.KW){return}var j=fb.KW;j.mo.KI();j.mo.KH();clearTimeout(j.KR);fb.KW=j.AU=j.AV=j.node.GW=c;if(fb.B){var i=fb.B.M;if(s.ES){s.end(i)}else{s.U(fb.B.fbBox,0,j.W.fadeDuration,function(){s.end(i)})}}}function h(){s.E("ttEnd");if(fb.KW){s.V("ttEnd",q,50)}}function n(){s.E("ttEnd")}function v(t){var j=fb.X.length;while(j--){if(t===fb.X[j].node){return fb.X[j]}}return c}function k(B,j){this.GW=a;var A=v(j||this);if(!A){return}n();var t=A.mo,i=A.W;if(!(fb.KW&&fb.KW.node===(j||this))){if(fb.B){q()}fb.B=c;fb.KW=A;clearInterval(t.FE);t.KA(A.H);t.GR(B);if(j){f();return s[fb.VQ](B)}else{t.IX=function(){if(!fb.B&&(!i.delay||(t.JW<i.mouseSpeed&&t.JA>i.delay))){f()}};t.KB()}}}function o(i){if(!this.GW&&this.GX){this.GX(i)}s[fb.UX](this,fb.TK,o)}function m(i){if(fb.KW){h()}}s.extend(r,s.L.KX.tooltip,s.HU.KX.tooltip);var z=g.length;while(z--){var x=g[z],u=b,y=fb.X.length;while(y--){if(fb.X[y].node===x){u=a;break}}if(u){continue}var e=s.extend({},r),w={W:e,node:x,M:l};s.extend(e,s.HX(x[fb.SF]("data-fb-tooltip")));if(!e.source){continue}fb.X.push(w);e[fb.UZ]=0;e.modal=e.sameBox=b;if(e[fb.VB]===fb.TT){e[fb.QE]=0}if(e[fb.VG]===fb.TT){e[fb.VF]=0}if(e[fb.VF]>16){e[fb.VF]=16}if(s.mobile){e.attachToHost=a}if(e.attachToHost){e[fb.TO]=b}e[fb.QK]=e[fb.TO]&&!s.EQ&&!(s.ie9&&s.ie9betaSafe);e.afterBoxStart=function(){var i;if((i=fb.B&&fb.B.fbBox)){if(!s.mobile){i[fb.UD]=n;i[fb.UC]=h}s.U(i,0,0,0,0,s.HI())}};e.afterItemStart=function(){var i;if((i=fb.B&&fb.B.fbBox)){s.U(i,100,s.ES?0:e.fadeDuration)}};if(e.defaultCursor){x.style.cursor="default"}x[fb.UV]("title");w.mo=p.GS||(p.GS=new s.GT);w.H=p;x.GX=s[fb.PC](x,fb.TM,k,c,l);s[fb.PC](x,fb.TK,o,c,l);s[fb.PC](x,fb.TL,m,c,l);s[fb.PC](x,fb.VV,function(i){if(!x.KU){s[fb.UX](x,fb.TM,k);s[fb.UX](x,fb.TK,o);s[fb.UX](x,fb.TL,m);x.KU=a}return k(i,this)},c,l)}s[fb.PC](p,fb.VV,function(t){if(!fb.B||t.target.nodeName==="IFRAME"){return}if(!fb.B.fbBox||s[fb.TQ](fb.B.fbBox,t.target)){return}var j=fb.X.length;while(j--){if(s[fb.TQ](fb.X[j].node,t.target)){return}}q()})},tooltipLoaded:a})})();