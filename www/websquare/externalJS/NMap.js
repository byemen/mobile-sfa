function naverMap(){var ik9;if(navigator.userAgent.toLowerCase().indexOf("msie")!=-1&&document.all) ik9 = true;else ik9 = false;function akg8(_obj){return (typeof(_obj) != "undefined");}function bdhj7(_obj,xnu2){_obj.style.cursor=xnu2;if (xnu2=="point"){_obj.style.cursor="hand";}}window.nullFunc = function nullFunc(){};window.falseFunc = function falseFunc(){return false;};window.trueFunc = function trueFunc(){return true;};function i1(bvv1,fisk5){if (ik9){var bae5 = document.createElement("script");bae5.type="text/vbscript";bae5.text ='On Error Resume Next\n'+'Sub '+bvv1+'_FSCommand(ByVal command, ByVal args)\n'+'	Call '+bvv1+'_DoFSCommand(command, args)\n'+'End Sub\n';(document.getElementsByTagName("head")[0]).appendChild(bae5);}eval('window.'+bvv1+'_DoFSCommand = fisk5; ');}function d19(x2,bvv1,width,height){var l4;if (ik9){l4 = document.createElement('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/l4/swflash.cab#version=7,0,0,0" width="'+width+'" height="'+height+'" align="middle"/>');l4.id = bvv1;l4.appendChild(document.createElement('<param NAME="allowScriptAccess" value="always" />'));l4.appendChild(document.createElement('<param NAME="quality" VALUE="high" />'));l4.appendChild(document.createElement('<param NAME="bgcolor" VALUE="#ffffff" />'));l4.appendChild(document.createElement('<param NAME="wmode" VALUE="window" />'));l4.appendChild(document.createElement('<param NAME="movie" VALUE="'+x2+'" />'));}else{l4 = document.createElement('embed');l4.swLiveConnect = true;l4.quality="high";
l4.bgcolor="#ffffff";l4.wmode="window";l4.name = bvv1;l4.src = x2;l4.width = width;l4.height = height;l4.align = "middle";l4.allowScriptAccess = "always";l4.TYPE="application/x-shockwave-flash";l4.pluginspage="http://www.macromedia.com/go/getflashplayer";}return l4;}function getFlashMovieObject(movieName){if (window.document[movieName]){return window.document[movieName]; }else if (ik9){return document.getElementById(movieName);}else{if (document.embeds && document.embeds[movieName]) return document.embeds[movieName];}}function removeChild(_obj){while (_obj && _obj.childNodes.length>0){if (_obj.childNodes[0].childNodes.length>0){removeChild(_obj.childNodes[0]);}_obj.removeChild(_obj.childNodes[0]);}}function xyy2(e){if(ik9){window.event.cancelBubble = true;window.event.returnValue = false}else{if (e){e.cancelBubble = true;e.preventDefault();e.stopPropagation();}}}function uv8(a,b,c){var d = window.setTimeout(function(){b.apply(a)},c);return d;}function db8(width,height){this.set(width,height);}db8.prototype.set =function (width,height){this.width = width;this.height = height;return this;};db8.prototype.setWidth =function (width){this.width = width;return this;};db8.prototype.setHeight =function (height){this.height = height;return this;};db8.prototype.getWidth =
function (){return this.width;};db8.prototype.getHeight =function (){return this.height;};db8.prototype.add =function (width,height){return this.set(this.width+width,this.height+height);};db8.prototype.copy =function (_obj){if (_obj){_obj.set(this.width,this.height);return _obj;}else{return new db8(this.width,this.height);}};db8.prototype.equals =function(target){return ((this.width==target.width) && (this.height==target.height));};db8.prototype.toString =function(){return this.width+","+this.height;};function x1(x,y){this.set(x,y);}

x1.prototype.set =function (x,y){this.x = x;this.y = y;
return this;};

x1.prototype.setX =function (x){this.x = x;return this;};x1.prototype.setY =function (y){
this.y = y;return this;};
x1.prototype.getX =function (){return this.x;};x1.prototype.getY =function (){return this.y;};x1.prototype.add =function (x,y){return this.set(this.x+x,this.y+y);};x1.prototype.distance =function (fjqx1){return Math.sqrt((this.x - fjqx1.x)*(this.x - fjqx1.x) + (this.y - fjqx1.y)*(this.y - fjqx1.y));};x1.prototype.copy =function (_obj){if (_obj){_obj.set(this.x,this.y);return _obj;}else{return new x1(this.x,this.y);}};x1.prototype.equals =function(target){return ((this.x==target.x) && (this.y==target.y));};x1.prototype.toString =function(){return this.x+","+this.y;};function t9(){};t9.attachEvent =function (nlk8,sh5,oo4){if (nlk8.addEventListener){nlk8.addEventListener(sh5,oo4,false);}else if (nlk8.attachEvent){nlk8.attachEvent("on"+sh5,oo4);}
};t9.detachEvent =function (nlk8,sh5,oo4){if(nlk8.removeEventListener){nlk8.removeEventListener(sh5,oo4,false);}else if (nlk8.detachEvent){nlk8.detachEvent("on"+sh5,oo4);}};t9.sul2 =function (_obj,fisk5){return function(c){if(!c) c = window.event;if(c&&!c.target) c.target = c.srcElement;fisk5.call(_obj,c);}};t9.createCallback =function (_obj,fisk5){var ueit7 = function(){fisk5.apply(_obj,arguments)};return ueit7;};t9.rw5 =function(nlk8,sh5,_obj,dom){var c3;c3 = t9.sul2(_obj,dom);t9.attachEvent(nlk8,sh5,c3);return c3;};t9.addListener =function (nlk8,sh5,oo4){var j9 = t9.qf4(sh5);if (nlk8[j9]) nlk8[j9].push(oo4);else nlk8[j9] = new Array(oo4);};t9.bind=
function(nlk8,sh5,fueu9,oo4){var c3 = this.createCallback(fueu9,oo4);t9.addListener(nlk8,sh5,c3);return c3;};t9.removeListener =function (nlk8,sh5,oo4){var j9 = t9.qf4(sh5);var uhdm7 = nlk8[j9];if (uhdm7 && uhdm7.length>0){var flag = false;for (var i = 0;i<uhdm7.length;i++){if (uhdm7[i] == oo4){flag = true;}if (flag && i!=(uhdm7.length-1)){uhdm7[i] = uhdm7[i+1];}}if (flag){uhdm7.pop();}}};t9.trigger =function(nlk8,sh5){var j9 = t9.qf4(sh5);var uhdm7 = nlk8[j9];if(uhdm7&&uhdm7.length>0){var dvcx2 = new Array();for(var i = 2;i<arguments.length;i++){dvcx2.push(arguments[i]);}dvcx2.push(nlk8);for(var i = 0;i<uhdm7.length;i++){var fisk5 = uhdm7[i];if(fisk5){try{fisk5.apply(nlk8,dvcx2)}catch (g){}}}}};t9.qf4 =function (bvv1){return "_Event__"+bvv1;};t9.gm6 =function (event,_obj){var te0= new x1(0,0);if(akg8(event.offsetX)){var c = event.target||event.srcElement;while(c&&c!=_obj){te0.add(c.offsetLeft,c.offsetTop);try{c = c.offsetParent;}catch (e){c = _obj;}}te0.add(event.offsetX,event.offsetY);}else if(akg8(event.pageX)){te0.set(event.pageX,event.pageY);while(_obj){te0.add(-_obj.offsetLeft,-_obj.offsetTop);_obj = _obj.offsetParent;}}return te0;};t9.stopEvent =function (e){if(!e){e = window.event;}if(ik9){window.event.cancelBubble = true;}else{if (e){e.cancelBubble = true;}}};function mj5(src){this.src = src;bdhj7(this.src,"default");this.gsvi7 = new db8(0,0);this.cixt4 = new db8(this.src.offsetWidth , this.src.offsetHeight);this.vyo7 = new x1(0,0);this.nlk8 = this.src.setCapture?this.src:window;this.rk9 = t9.sul2(this,this.r44);this.e2 = t9.sul2(this,this.yw2);}mj5.prototype.nojp4 =function(a){if(!a) a = window.event;this.vyo7.set(a.clientX,a.clientY);bdhj7(this.src,"move");t9.attachEvent(this.nlk8,"mousemove",this.rk9);t9.attachEvent(this.nlk8,"mouseup",this.e2);if(this.src.setCapture){this.src.setCapture();}xyy2(a);t9.trigger(this,"startDrag");};mj5.prototype.yw2 =function(a){if(!a) a = window.event;bdhj7(this.src,"default");
t9.detachEvent(this.nlk8,"mousemove",this.rk9);t9.detachEvent(this.nlk8,"mouseup",this.e2);this.a15(a);if(document.releaseCapture){document.releaseCapture()}t9.trigger(this,"endDrag");};mj5.prototype.r44 =function (a){if(!a) a = window.event;this.a15(a);t9.trigger(this,"drag");};mj5.prototype.a15 =function (a){if(!a) a = window.event;var offset = new db8(this.gsvi7.width+(a.clientX - this.vyo7.x),this.gsvi7.height+(a.clientY - this.vyo7.y));this.move(offset);this.vyo7.set(a.clientX,a.clientY);offset = null;};mj5.prototype.x9 =function (a){if(!a) a = window.event;bdhj7(this.src,"default");t9.detachEvent(this.nlk8,"mousemove",this.rk9);t9.detachEvent(this.nlk8,"mouseup",this.e2);};mj5.prototype.move =function(offset){this.gsvi7.set(offset.width,offset.height);this.src.style.left =  offset.width;this.src.style.top =  offset.height;t9.trigger(this,"move");};function ecp0(amount){this.ticks = amount;this.tick = 0;}ecp0.prototype.mlqm3=function(){this.tick = 0;};ecp0.prototype.wqio1=function(){this.tick++;var a = Math.PI*(this.tick/this.ticks-0.5);return(Math.sin(a)+1)/2;};ecp0.prototype.pn4=function(){return this.tick<this.ticks};
	
	function fikm0(wqw2,width,height,showNaver){
if (!akg8(wqw2)){alert(' container는 올바른 div객체이어야 합니다. NMap객체를 비활성화 합니다. ');
for (var a in fikm0.prototype){this[a] = nullFunc;
}return;
}if (!akg8(showNaver)){this.showNaver = true;
}else{this.showNaver = showNaver;
}
//alert(12);
this.wqw2 = wqw2;
this.zcrs9 = true;
this.wqw2.style.overflow = "hidden";
if(this.wqw2.style.position!="absolute" && this.wqw2.style.position!="relative"){this.wqw2.style.position = "relative";
}if (!akg8(width)){width = this.wqw2.offsetWidth;
}else{this.wqw2.style.width = width;
}if (!akg8(height)){height = this.wqw2.offsetHeight;
}else{this.wqw2.style.height = height;
}this.cixt4 = new db8(width,height);
this.downpos = new db8(0,0);

this.mapEventList = new Array();
this.init();
}





fikm0.prototype.init =function (){this.spec = new NSpec();
this.scl1 = new x1(0,0);
		this.fjqx1 = new x1(0,0);
		this.n6 = new x1(0,0);
	this.ixu7 = new x1(0,0);
 this.yx9 = new x1(0,0);
 this.bk0= new Array();
this.t3 = new Array();
this.rk7 = new Array();
this.center = new x1(0.5,0.5);
this.svbr6 =  null;
this.elci1 = null;
this.ljip1 = false;
this.o9();
this.xxxh9();
this.zwa6();

this.euk7 = new mj5(this.div);
this.resizeType = new x1(0,0);
  this.m1 = new Array(0,0,0,0);
this.wheelAdapter = t9.sul2(this,this.xxf1);

this.infowin = new s7();
this.addOverlay(this.infowin);
if (this.showNaver){this.addControl(new ufqr1());
}this.uog0 = 'http://maps.naver.com/common/valid.php';
this.svbr6='66cad9a2fe40d5ab7b8ba028e9797960';
this.lcj2();
t9.bind(this.euk7,"drag",this,this.mpx3);
t9.bind(this.euk7,"startDrag",this,this.onStartDrag);
t9.bind(this.euk7,"endDrag",this,this.onEndDrag);
t9.bind(this.euk7,"move",this,this.if3);
var cbFunc;
cbFunc = t9.rw5(this.wqw2,"mousedown",this,this.tqff8);
this.mapEventList.push({src:this.wqw2,sh5:"mousedown",cbFunc:cbFunc});
cbFunc = t9.rw5(this.wqw2,"mousemove",this,this.vwr2);
this.mapEventList.push({src:this.wqw2,sh5:"mousemove",cbFunc:cbFunc});
cbFunc = t9.rw5(window,"resize",this,this.resize);
this.mapEventList.push({src:window,sh5:"resize",cbFunc:cbFunc});
cbFunc = t9.rw5(window,"beforeprint",this,this.g1);
this.mapEventList.push({src:window,sh5:"beforeprint",cbFunc:cbFunc});
cbFunc = t9.rw5(window,"afterprint",this,this.xmpo6);
this.mapEventList.push({src:window,sh5:"afterprint",cbFunc:cbFunc});
cbFunc = t9.rw5(this.wqw2,"click",this,this.click);
this.mapEventList.push({src:this.wqw2,sh5:"click",cbFunc:cbFunc});
cbFunc = t9.rw5(this.wqw2,"mouseup",this,this.mouseup);
this.mapEventList.push({src:this.wqw2,sh5:"mouseup",cbFunc:cbFunc});
cbFunc = t9.rw5(this.wqw2,"dblclick",this,this.ag8);
this.mapEventList.push({src:this.wqw2,sh5:"dblclick",cbFunc:cbFunc});
cbFunc = t9.rw5(this.wqw2,"contextmenu",this,this.contextmenu);
this.mapEventList.push({src:this.wqw2,sh5:"contextmenu",cbFunc:cbFunc});
cbFunc = t9.rw5(window,"load",this,this.load);
this.mapEventList.push({src:window,sh5:"load",cbFunc:cbFunc});
cbFunc = t9.rw5(window,"unload",this,this.unload);
this.mapEventList.push({src:window,sh5:"unload",cbFunc:cbFunc});
t9.trigger(this.wqw2,"ready");
};









fikm0.prototype.g1=function (){t9.trigger(this,"beforePrint");};fikm0.prototype.xmpo6=function (){t9.trigger(this,"afterPrint");};


fikm0.prototype.lcj2 =function (){var now = new Date();
var dkh2 = this.uog0+"?key="+this.svbr6+"&uri="+escape('http://192.168.100.70:9101/')+"&time="+now.getTime();

this.zr4 = o1.create(null,1,1,0,0,0);
t9.rw5(this.zr4,"error",this,this.n8);
this.zr4.src = dkh2;
};





fikm0.prototype.n8 =function (){this.zcrs9  =false;this.wqw2.style.display="none";};fikm0.prototype.load =function (){if (this.cixt4.equals(new db8(0,0))){this.resize();if (this.elci1!=null){this.setBound(this.elci1);}else{this.setCenterAndZoom(this.scl1,this.pra1);}}};fikm0.prototype.unload =function (){if (this.mapEventList!=null){for (var i=0;i<this.mapEventList.length;i++){t9.detachEvent(this.mapEventList[i].src,this.mapEventList[i].sh5,this.mapEventList[i].cbFunc);this.mapEventList[i] = null;}this.mapEventList = null;}this.qa0(this.paq1);t9.trigger(this,"unload");this.spec = null;this.fjqx1 = null;this.n6 = null;this.ixu7 = null;this.yx9 = null;this.bk0= null;this.rk7 = null;this.center = null;this.ljip1 = false;this.elci1 = null;this.wheelAdapter = null;this.infowin = null;this.overlay = null;this.infoLayer = null;this.markLayer = null;this.pathLayer = null;this.mapLayer = null;this.div = null;this.staticLayer = null;this.checkLayer=null;this.euk7 = null;removeChild(this.wqw2);this.wqw2 = null;};
fikm0.prototype.o9 =
function (){this.p43 = 0;	this.pra1 = 2;this.mapMode = 0; this.xug4 = true;this.g3 = this.spec.minLevel;this.u0 = this.spec.maxLevel;};fikm0.prototype.setMapmode =function(mode){this.mapMode = mode;};fikm0.prototype.d13 =function (zIndex){var b = document.createElement("div");b.style.position = "absolute";b.style.top = 0;b.style.left = 0;b.style.zIndex = zIndex;
if(ik9){b.unselectable = "on";b.onselectstart = falseFunc;}
else{b.style.MozUserSelect = "none"}return b;};fikm0.prototype.xxxh9 =function (){this.div = this.d13(0);this.wqw2.appendChild(this.div);this.staticLayer = this.d13(10);this.wqw2.appendChild(this.staticLayer);this.mapLayer = this.d13(10);this.div.appendChild(this.mapLayer);this.pathLayer = this.d13(15);this.div.appendChild(this.pathLayer);this.markLayer = this.d13(20);this.div.appendChild(this.markLayer);this.infoLayer = this.d13(30);this.div.appendChild(this.infoLayer);this.overlay = this.d13(100);this.div.appendChild(this.overlay);this.checkLayer = this.d13(-1000);this.wqw2.appendChild(this.checkLayer);
};fikm0.prototype.getHTMLSize =function(html){this.checkLayer.innerHTML = html;var size = new db8(this.checkLayer.offsetWidth,this.checkLayer.offsetHeight);this.checkLayer.innerHTML='';return size;};fikm0.prototype.getDomSize =function(dom){var parent = null;if (dom.parentNode){parent = dom.parentNode;parent.removeChild(dom);}this.checkLayer.appendChild(dom);
var size = new db8(this.checkLayer.offsetWidth,this.checkLayer.offsetHeight);this.checkLayer.removeChild(dom);if (parent!=null){parent.appendChild(dom);}parent = null;return size;};fikm0.prototype.zwa6 =function(){this.paq1 = new Array();this.overlayImages = new Array();this.wu9();this.p6();};fikm0.prototype.mpx3 =function (){t9.trigger(this,"drag");};fikm0.prototype.onStartDrag =function (){t9.trigger(this,"startDrag",this.getBound());};fikm0.prototype.onEndDrag =function (){t9.trigger(this,"endDrag",this.getBound());};fikm0.prototype.if3 =function (){this.h7();t9.trigger(this,"move",this.euk7.gsvi7);};fikm0.prototype.cbp1 =function (a){var b = t9.gm6(a,this.wqw2);
b.add(- Math.round((this.m1[0] - this.m1[2])/2),-Math.round((this.m1[1] - this.m1[3])/2));return new x1(b.x-Math.floor(this.cixt4.width/2),Math.floor(this.cixt4.height/2)-b.y);};fikm0.prototype.f03 =function (a){var diff = this.cbp1(a);var qdx7 = this.a32();qdx7.add(diff.x,diff.y);return qdx7;};fikm0.prototype.currentMousePoint =function (a){return this.spec.pixel2point(this.f03(a),this.p43);};fikm0.prototype.click =function (a){if(!a){a = window.event;}if (Math.pow((this.euk7.gsvi7.width - this.downpos.width),2)+Math.pow((this.euk7.gsvi7.height - this.downpos.height),2) < 100){t9.trigger(this,"click",this.currentMousePoint(a));}};fikm0.prototype.contextmenu =function (a){if(!a)
{a = window.event;}t9.trigger(this,"contextmenu");};fikm0.prototype.ag8=function(a){if(!a){a = window.event;}if (this.xug4){var diff = this.cbp1(a);this.pan(diff.x,diff.y);diff = null;}t9.trigger(this,"dblclick",this.currentMousePoint(a));};fikm0.prototype.xxf1 =function(a){if(!a){a = window.event;}var delta = a.wheelDelta;if(delta>0){this.zoomIn();}else if(delta<0){this.zoomOut();}a.cancelBubble = true;return false;};fikm0.prototype.move =function (x,y){if (this.xug4){var offset = this.euk7.gsvi7.copy();offset.add(x,y);this.euk7.move(offset);}};fikm0.prototype.pan =function (x,y){if (this.xug4){this.ecuj7 = new db8(-x,y);this.b0 = this.euk7.gsvi7.copy();this.zra3 = new ecp0(Math.max(20,Math.floor(Math.sqrt(x*x +y*y)/20)));this.n3();}};fikm0.prototype.n3 =function (){if (this.xug4){var factor = this.zra3.wqio1();this.euk7.move(new db8(this.b0.width + this.ecuj7.width * factor , this.b0.height + this.ecuj7.height * factor));this.mpx3();if (this.zra3.pn4()){this.uj2 = uv8(this,function(){this.n3()},10);}}};fikm0.prototype.setBoundOffset =function (left,top,right,bottom){if (left instanceof Array){this.m1 = left;}
else{this.m1 = new Array(left,top,right,bottom);}t9.trigger(this,"redraw");};fikm0.prototype.getBoundOffset =function (){return this.m1;};fikm0.prototype.getMapSize =
function (){return this.cixt4;};fikm0.prototype.f80 =function (){var left = this.ixu7.x*this.spec.tileSize + this.khc9.width  - this.euk7.gsvi7.width + this.m1[0];var right = this.ixu7.x*this.spec.tileSize + this.khc9.width + this.cixt4.width - this.euk7.gsvi7.width + this.m1[2];var top =(this.ixu7.y+1)*this.spec.tileSize - this.khc9.height + this.euk7.gsvi7.height - this.m1[1];var bottom = (this.ixu7.y+1)*this.spec.tileSize - this.khc9.height - this.cixt4.height + this.euk7.gsvi7.height - this.m1[3];return Array(left,top,right,bottom);};fikm0.prototype.getBound =function (){var distancePerPixel = this.spec.distancePerPixel(this.p43);var ff8 = this.f80();return Array(ff8[0]*distancePerPixel+ this.spec.minX,ff8[1]*distancePerPixel + this.spec.minY,ff8[2]*distancePerPixel+ this.spec.minX,ff8[3]*distancePerPixel + this.spec.minY);};fikm0.prototype.setBound =function (left,top,right,bottom){if (left instanceof Array){top = left[1];right = left[2];bottom = left[3];left = left[0];}var aqqy7 = new x1 (Math.round((left+right)/2),Math.round((top+bottom)/2));var width = right - left;var height = top - bottom;var xqgv4=this.u0;var distancePerPixel;for (var i = this.g3;i<=this.u0 ;i++){distancePerPixel = this.spec.distancePerPixel(i);if ( (this.cixt4.width - this.m1[0]-this.m1[2])*distancePerPixel>width && (this.cixt4.height- - this.m1[1]-this.m1[3])*distancePerPixel>height){xqgv4 =i;break;}}this.setCenterAndZoom(aqqy7,xqgv4);this.elci1 = new Array(left,top,right,bottom);};fikm0.prototype.getCenter =function (aqqy7){var tmp;if (!(aqqy7 instanceof x1)){aqqy7 =new x1(0,0);}tmp = this.spec.pixel2point(this.a32(),this.p43);aqqy7.set(tmp.x,tmp.y);tmp = null;return aqqy7;};fikm0.prototype.a32 =function (wvb8){if (!(wvb8 instanceof x1)){wvb8 =new x1(0,0);}wvb8.set(this.n6.x +  Math.round((this.m1[0] - this.m1[2])/2) +this.center.x * this.cixt4.width  + this.khc9.width - this.euk7.gsvi7.width,this.n6.y  -Math.round((this.m1[1] - this.m1[3])/2) - this.center.y * this.cixt4.height -  this.khc9.height + this.euk7.gsvi7.height);return wvb8;};fikm0.prototype.h7 =function (){var gsvi7 = this.euk7.gsvi7;var bhsl0 = new db8( this.yx9.x * this.spec.tileSize +  gsvi7.width, -this.yx9.y * this.spec.tileSize +  gsvi7.height);if(bhsl0.width <- this.khc9.width/2){this.br0(this.paq1,false);if (this.spec.hasOverlay()){this.br0(this.overlayImages,true);}}else if(bhsl0.width > this.khc9.width/2){this.z21(this.paq1,false);if (this.spec.hasOverlay()){this.z21(this.overlayImages,true);}}if(bhsl0.height <- this.khc9.height/2){this.kpn2(this.paq1,false);if (this.spec.hasOverlay()){this.kpn2(this.overlayImages,true);}}else if(bhsl0.height > this.khc9.height/2){this.ud4(this.paq1,false);if (this.spec.hasOverlay()){this.ud4(this.overlayImages,true);}}};fikm0.prototype.br0 =function (paq1,udo9){if (!udo9){this.yx9.x++;}var c = paq1.shift();paq1.push(c);var e = paq1.length-1;for(var d = 0;d<c.length;d++){
this.mb6(c[d],e,d,udo9);
}};fikm0.prototype.z21 =function (paq1,udo9){if (!udo9){this.yx9.x--;}var c = paq1.pop();if(c){paq1.unshift(c);for(var d = 0;d<c.length;d++){this.mb6(c[d],0,d,udo9);}}};fikm0.prototype.ud4 =function (paq1,udo9){if (!udo9){this.yx9.y++;}for(var c = 0;c<paq1.length;c++){var d = paq1[c].pop();paq1[c].unshift(d);this.mb6(d,c,0,udo9);
}};fikm0.prototype.kpn2 =function (paq1,udo9){if (!udo9){this.yx9.y--;}var b = paq1[0].length-1;for(var c = 0;c<paq1.length;c++){var d = paq1[c].shift();paq1[c].push(d);this.mb6(d,c,b,udo9);}};fikm0.prototype.resize=function(){if(this.cixt4.width!=this.wqw2.offsetWidth||this.cixt4.height!=this.wqw2.offsetHeight){var wvb8 = this.a32();wvb8.add((this.wqw2.offsetWidth-this.cixt4.width)*this.center.x*this.resizeType.x,(this.wqw2.offsetHeight-this.cixt4.height)*this.center.y*this.resizeType.y);this.cixt4.width = this.wqw2.offsetWidth;this.cixt4.height = this.wqw2.offsetHeight;this.wu9();this.p6();this.vn7(wvb8);wvb8 = null;}};fikm0.prototype.vwr2 =function (a){if(!a){a = window.event;}t9.trigger(this,"mousemove",this.currentMousePoint(a));};
fikm0.prototype.tqff8 =function (a){if(!a){a = window.event;}window.clearTimeout(this.uj2);switch (this.mapMode){
case 0:if (this.xug4){this.euk7.nojp4(a);}break;case 1:this.vn7(this.f03(a));this.zoomIn();break;case 2:this.vn7(this.f03(a));this.zoomOut();break;case 3:this.selectObj.startSelect(a);break;}this.euk7.gsvi7.copy(this.downpos);t9.trigger(this,"mousedown",this.currentMousePoint(a));};fikm0.prototype.mouseup =function (a){if(!a){a = window.event;}t9.trigger(this,"mouseup",this.currentMousePoint(a));
};fikm0.prototype.p6 =function(){this.ts3(this.paq1);};fikm0.prototype.setZoom =function(xqgv4){
if (this.p43 != xqgv4){this.elci1 = null;var jp2 = this.getCenter();var bu0 = this.p43;this.p43 = xqgv4;this.setCenter(jp2);t9.trigger(this,"zoom",this.p43,bu0);}};fikm0.prototype.getZoom =function (){return this.p43;};fikm0.prototype.setMinLevel =function (xqgv4){this.g3 = xqgv4;};fikm0.prototype.setMaxLevel =function (xqgv4){this.u0 = xqgv4;};fikm0.prototype.zoomIn =function(){if (this.p43 > this.g3){this.setZoom(this.p43 - 1);}};fikm0.prototype.zoomOut =function (){if (this.p43 <this.u0){this.setZoom(this.p43 + 1);}};fikm0.prototype.enableDrag =function(){this.xug4 =true;};fikm0.prototype.disableDrag =function(){this.xug4 =false;};fikm0.prototype.enableWheelZoom =function(){this.wqw2.onmousewheel = falseFunc;t9.attachEvent(this.wqw2,"mousewheel",this.wheelAdapter)};fikm0.prototype.disableWheelZoom =function(){this.wqw2.onmousewheel='';t9.detachEvent(this.wqw2,"mousewheel",this.wheelAdapter)};

fikm0.prototype.setCenterAndZoom =function (fjqx1,p43){var bu0 = -1;
p43 = parseInt(p43);
if(p43!=this.p43){bu0 = this.p43;
this.p43 = p43;
}this.pra1 = p43;
this.setCenter(fjqx1);
this.scl1.set(fjqx1.x,fjqx1.y);
if(bu0!=-1){t9.trigger(this,"zoom",this.p43,bu0);
}};

	
	
	
	fikm0.prototype.initPoint =function (){this.vn7(this.spec.point2pixel(this.scl1,this.p43));this.setZoom(this.pra1);this.mapMode = 0;};
	
	
	fikm0.prototype.setCenter =function (fjqx1){var ugll7;
if (fjqx1.x=='' || fjqx1.x==0 || fjqx1.y=='' || fjqx1.y==0){return;
}if (this.p43 == 0 ){this.p43 = 2;
t9.trigger(this,"zoom",this.p43,0);
}this.fjqx1.set(fjqx1.x,fjqx1.y);
ugll7 = this.spec.point2pixel(this.fjqx1,this.p43);
this.vn7(ugll7);
};

	
	
	fikm0.prototype.vn7 =function(ugll7){this.n6.set(ugll7.x - Math.round((this.m1[0] - this.m1[2])/2) -this.center.x * this.cixt4.width  - this.khc9.width , ugll7.y +Math.round((this.m1[1] - this.m1[3])/2) + this.center.y * this.cixt4.height +  this.khc9.height);
this.ixu7.set(Math.floor(this.n6.x / this.spec.tileSize),Math.floor(this.n6.y / this.spec.tileSize));
this.yx9.set(0,0);
var r46 = new db8(this.ixu7.x * this.spec.tileSize - this.n6.x , this.n6.y - (this.ixu7.y +1) * this.spec.tileSize);
if(r46.width < -this.khc9.width/2){this.ixu7.x++;
r46.width += this.spec.tileSize;
}else if(r46.width > this.khc9.width/2){
this.ixu7.x--;
r46.width -= this.spec.tileSize;
}if(r46.height < -this.khc9.height/2){
this.ixu7.y--;
r46.height += this.spec.tileSize;
}else if(r46.height > this.khc9.height/2){this.ixu7.y++;
r46.height -= this.spec.tileSize;
}var h = screen.updateInterval||0;
screen.updateInterval = 1000;
this.euk7.move(r46);
this.n6.add(r46.width,- r46.height);
this.ec8();
t9.trigger(this,"redraw");
screen.updateInterval = h;
};



fikm0.prototype.wu9 =function(){this.ubu4 = new db8(Math.ceil(this.cixt4.width / this.spec.tileSize) + 2,Math.ceil(this.cixt4.height / this.spec.tileSize) + 2);this.khc9 = new db8(Math.round((this.ubu4.width*this.spec.tileSize - this.cixt4.width)/2),Math.round((this.ubu4.height*this.spec.tileSize - this.cixt4.height)/2));};fikm0.prototype.vxhy9 =function(){return new Array(this.ixu7.x+this.yx9.x,this.ixu7.y+this.yx9.y,this.ixu7.x+this.ubu4.width+this.yx9.x,this.ixu7.y-this.ubu4.height+this.yx9.y);};fikm0.prototype.ts3 =function(xy4){var epvp2;while(xy4.length>this.ubu4.width){var column = xy4.pop();for(var i = 0;i<column.length;i++){this.mapLayer.removeChild(column[i]);
delete column[i];}}for(var i = xy4.length;i<this.ubu4.width;i++){xy4.push([]);}for(var i = 0;i<this.ubu4.width;i++){while(xy4[i].length>this.ubu4.height){var e = xy4[i].pop();this.mapLayer.removeChild(e);}for(var j = xy4[i].length;j<this.ubu4.height;j++){epvp2 = o1.create(null,this.spec.tileSize,this.spec.tileSize,0,0,0,this.mapLayer);epvp2.vwr7 = -1;epvp2.d03 = -1;xy4[i].push(epvp2);}}};fikm0.prototype.qa0 =function(xy4){
if (xy4!=null && this.mapLayer!=null){for (var i = 0;i<xy4.length;i++){for (var j = 0;j<xy4[i].length; j++ ){this.mapLayer.removeChild(xy4[i][j]);xy4[i][j]=null;}}}};fikm0.prototype.dzfl2 =function (r5){var b = new Array();for(var i = 0;i<r5.length;i++){for(var j = 0;j<r5[i].length;j++){var e = r5[i][j];e.xpos = i;e.ypos = j;var c = Math.min(i,r5.length-i-1);var d = Math.min(j,r5[i].length-j-1);if(c==0||d==0){e.gh0 = 0;}else{e.gh0 = c+d;}b.push(e);}}b.sort(function(g,h){return h.gh0-g.gh0});
return b;};

fikm0.prototype.ec8 =function (){var jnq9 = this.dzfl2(this.paq1);
for (var i = 0;i<jnq9.length;i++){this.mb6(this.paq1[jnq9[i].xpos][jnq9[i].ypos],jnq9[i].xpos,jnq9[i].ypos,false);
}};




fikm0.prototype.mb6 =function (epvp2,vwr7,d03,udo9){var p43 = this.getZoom();
var jqa6 = this.spec.getTileUrl(this.ixu7.x+vwr7+this.yx9.x,this.ixu7.y-d03+this.yx9.y,this.p43);
if (jqa6 != epvp2.src)

{
	epvp2.src = this.spec.preTileUrl;
}

if (!udo9){udo9 = false;
}{if (this.zcrs9){epvp2.src = jqa6;
var emptyTileUrl = this.spec.emptyTileUrl;
epvp2.onerror  = function (){epvp2.onerror=falseFunc;
epvp2.src=emptyTileUrl;
};
}}epvp2.style.left = (vwr7+this.yx9.x)*this.spec.tileSize - this.khc9.width;
epvp2.style.top = (d03-this.yx9.y)*this.spec.tileSize - this.khc9.height;
if (epvp2.vwr7 != -1 && epvp2.d03 !=-1){t9.trigger(this,"removeTile",p43,epvp2.vwr7,epvp2.d03);
}epvp2.vwr7 = this.ixu7.x+vwr7+this.yx9.x;
epvp2.d03 = this.ixu7.y-d03+this.yx9.y;
t9.trigger(this,"drawTile",p43,epvp2.vwr7,epvp2.d03);
};



fikm0.prototype.b198=function(ugll7,coord){if(!coord) coord = new x1(0,0);
coord.set(ugll7.x - this.ixu7.x*this.spec.tileSize - this.khc9.width ,(this.ixu7.y+1) *this.spec.tileSize - this.khc9.height - ugll7.y);
return coord;
};
fikm0.prototype.addOverlay =function (_obj,key){this.bk0.push(Array(_obj,key));
_obj.init(this);
_obj.redraw(this);
};
fikm0.prototype.removeOverlay =function (_obj){for (var i = 0;
(this.bk0 && i<this.bk0.length);
i++){if (_obj==this.bk0[i][0]){_obj.unload();
this.bk0.splice(i,1);
break;
}}};
fikm0.prototype.clearOverlays =function (key){var x6 = new Array();
var cnt = 0;
for (var i = 0;
this.bk0 && i<this.bk0.length;
i++){if (!(key && key!=this.bk0[i][1])){this.bk0[i][0].unload();
this.bk0[i] = null;
}else{x6[cnt] = this.bk0[i];
cnt++;
}}this.bk0 = x6;
};
fikm0.prototype.addControl =function (_obj){this.t3.push(_obj);
_obj.init(this);
_obj.redraw(this);
};
fikm0.prototype.removeControl =function (_obj){for (var i = 0;
i<this.t3.length;
i++){if (_obj==this.t3[i]){_obj.unload();
this.t3.splice(i,1);
break;
}}};
fikm0.prototype.c53 =function (_obj){var eyg0 = new Array();
var hkt5;
var id0;
for (var i = 0;
i<this.rk7.length ;
i++){eyg0[i] = this.rk7[i].getPos();
for (var j = 0;
j<i;
j++){hkt5 = (eyg0[j].x - eyg0[i].x) * (eyg0[j].x - eyg0[i].x);
id0 = (eyg0[j].y - eyg0[i].y) * (eyg0[j].y - eyg0[i].y);
if ((hkt5 < 9) && (id0<9)){
eyg0[i].add(5,5);
}}if (_obj == this.rk7[i]){
return eyg0[i];
}}};
fikm0.prototype.qtsr9 =function (_obj){this.rk7.push(_obj);
};
fikm0.prototype.f1 =function (_obj){for (var i = 0;
i<this.rk7.length ;
i++)
{if (this.rk7[i]==_obj){this.rk7.splice(i,1);
break;
}}};
fikm0.prototype.linkInfoWin =function (infowin){this.infowin = infowin;
};
fikm0.prototype.setInfoWin =function (fjqx1,content){this.infowin.set(fjqx1,content);
};
fikm0.prototype.showInfoWin =function (){this.infowin.showWindow();
};
fikm0.prototype.hideInfoWin =function(lij4){if (lij4){this.infowin.delayHideWindow(lij4);
}else{this.infowin.hideWindow();

}};




function o1(){};


o1.lqvn6 = 'http://static.naver.com/n/local/206/map/nvr/mapbg.png';

o1.sr1 =function (width,height,left,top,zIndex,ur4,wnw1){var n;
if (wnw1){n = wnw1.createElement("div");
}else{n = document.createElement("div");
}if (ur4){ur4.appendChild(n);
}n.style.position = "absolute";
n.oncontextmenu = falseFunc;
if (!zIndex) zIndex = 1;
n.style.zIndex = zIndex;
if (akg8(width)){n.style.width = width;
n.width = width;
}if (akg8(height)){n.style.height = height;
n.height = height;
}if (akg8(left)){n.style.left = left;
}if (akg8(top)){n.style.top = top;
}return n;
};

	
	
	
o1.tutr7 =function (gd9,width,height,left,top,zIndex,ur4,wnw1){if (ik9){var n = o1.sr1(width,height,left,top,zIndex,ur4,wnw1);
n.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+gd9+"',sizingMethod='image')";
}else{var n = o1.create(gd9,width,height,left,top,zIndex,ur4,wnw1);
}return n;
};


o1.create =function (gd9,width,height,left,top,zIndex,ur4,wnw1){var n;
if (wnw1){n = wnw1.createElement("img");
}else{n = document.createElement("img");
}if (ur4){ur4.appendChild(n);
}n.style.position = "absolute";
if(ik9){n.galleryImg = "no";
n.unselectable = "on";
n.onselectstart = falseFunc;
}else{n.style.MozUserSelect = "none"}n.oncontextmenu = falseFunc;
if (!zIndex) zIndex = 1;
n.style.zIndex = zIndex;
if (gd9)	n.src = gd9;
else	n.src = o1.lqvn6;

if (akg8(width)){n.style.width = width;
n.width = width;
}if (akg8(height)){n.style.height = height;
n.height = height;
}if (akg8(left)){n.style.left = left;
}if (akg8(top)){n.style.top = top;
}return n;
};




function vyk6(size,te0){this.align = "left";this.valign = "top";this.map = null;this.r5 = null;this.content=null;this.opacity = 1;this.zIndex = 0;if (size){this.setSize(size);}else{this.size = new db8(0,0);}if (te0){this.setPos(te0);}else{this.te0 = new x1(0,0);}}vyk6.prototype.init =function(map){this.map = map;this.r5 = this.map.d13(0);this.map.staticLayer.appendChild(this.r5);this.r5.style.overflow='hidden';this.r5.className ='noprint';t9.bind(this.map,"redraw",this,this.redraw);t9.bind(this.map,"unload",this,this.unload);t9.rw5(this.r5,"mousedown",this,this.f3);t9.rw5(this.r5,"mouseup",this,this.mouseUp);t9.rw5(this.r5,"click",this,this.click);t9.rw5(this.r5,"dblclick",this,this.dblclick);};vyk6.prototype.f3 =function (a){if(!a) a = window.event;t9.trigger(this,"mousedown");xyy2(a);};vyk6.prototype.mouseUp =function (a){if(!a) a = window.event;t9.trigger(this,"mouseup");};vyk6.prototype.click =
function (a){if(!a) a = window.event;t9.trigger(this,"click");
xyy2(a);};vyk6.prototype.dblclick =function (a){if(!a) a = window.event;t9.trigger(this,"dblclick");xyy2(a);};vyk6.prototype.unload =function(){this.map.staticLayer.removeChild(this.r5);this.r5 = null;this.map = null;};vyk6.prototype.setSize =function (size){this.size = size;if (this.r5!=null){this.r5.style.width = size.width;this.r5.style.height = size.height;}this.redraw();};vyk6.prototype.setPos =function (te0){this.te0 = te0;this.redraw();};vyk6.prototype.setZIndex =function (index){this.zIndex = index;this.redraw();};vyk6.prototype.setOpacity =function(opacity){this.opacity = opacity;this.redraw();};vyk6.prototype.setAlign =function(align){this.align = align;this.redraw();};vyk6.prototype.setValign =function(valign){this.valign = valign;this.redraw();};vyk6.prototype.setContent =function(content){if (this.r5){this.r5.innerHTML = content;}};vyk6.prototype.appendChild =function(dom){this.r5.appendChild(dom);};vyk6.prototype.removeChild =function(dom){this.r5.removeChild(dom);};vyk6.prototype.redraw =function(){if (this.map==null){return;}var te0 = this.getPos();this.r5.style.opacity = this.opacity;this.r5.style.filter ='alpha(opacity = '+(this.opacity*100)+')';this.r5.style.left = te0.x;this.r5.style.top = te0.y;this.r5.style.width = this.size.width;this.r5.style.height = this.size.height;this.r5.style.zIndex= this.zIndex;};vyk6.prototype.getPos =function (){var left,top;var m1 = this.map.getBoundOffset();switch (this.align){case "left":left = this.te0.x + m1[0];
break;case "center":left = Math.round((this.te0.x + (this.map.cixt4.width - m1[0] - m1[2]) - this.size.width)/2) + m1[0];break;case "right":left = this.map.cixt4.width - this.size.width - this.te0.x - m1[2];break;}switch (this.valign){case "top":top = this.te0.y + m1[1];break;case "center":top = Math.round((this.te0.y + (this.map.cixt4.height-m1[1]-m1[3]) - this.size.height)/2) + m1[1];break;case "bottom":top = this.map.cixt4.height - this.size.height - this.te0.y - m1[3];break;}return new x1(left,top);};function ufqr1(){this.setAlign("left");this.setValign("bottom");};ufqr1.prototype = new vyk6(new db8(68,17),new x1(5,5));ufqr1.prototype.init =function (map){vyk6.prototype.init.call(this,map);var mark= o1.tutr7("http://static.naver.com/n/local/206/map/nvr/logo.png",68,17,0,0,0);mark.className ='noprint';bdhj7(mark,"pointer");this.appendChild(mark);t9.rw5(mark,"click",this,this.goNaver);};ufqr1.prototype.goNaver =function (){window.open("http://maps.naver.com","_blank");};function w7(){this.setAlign("right");this.setValign("bottom");}w7.prototype = new vyk6(new db8(62,23),new x1(73,7));w7.prototype.init =function (map){vyk6.prototype.init.call(this,map);var button =o1.create('http://static.naver.com/n/local/206/map/0730/btn_save.gif',62,23,0,0,0);bdhj7(button,"pointer");this.appendChild(button);t9.rw5(button,"click",this,this.saveMap);};w7.prototype.saveMap =function(){var bound = this.map.getBound();var p43 = this.map.getZoom();document.location.href = 'http://down.maps.naver.com/?left='+bound[0]+'&top='+bound[1]+'&right='+bound[2]+'&bottom='+bound[3]+'&lvl='+p43;};function owv2(){this.setAlign("right");this.setValign("bottom");this.mapDiv = null;this.vsw5 = null;}owv2.prototype = new vyk6(new db8(62,23),new x1(7,7));owv2.prototype.set =function (mapDiv,vsw5){};owv2.prototype.init =function (map){vyk6.prototype.init.call(this,map);this.button =o1.create('http://static.naver.com/n/local/206/map/0730/btn_print.gif',62,23,0,0,0);bdhj7(this.button,"pointer");this.appendChild(this.button);t9.rw5(this.button,"click",this,this.w3);};owv2.prototype.g1 =function (){this.mapDiv.style.display="none";var bound = this.map.getBound();var p43 = this.map.getZoom();var m1 = this.map.getBoundOffset();var viewsize = this.map.getMapSize();this.wqw2.style.left = (-1*m1[0])+"px";this.wqw2.style.top = (-1*m1[1])+"px";this.vsw5.style.width = viewsize.width -(m1[0]+m1[2]);this.vsw5.style.height = viewsize.height-(m1[1]+m1[3]);this.map.wqw2.removeChild(this.map.div);this.wqw2.appendChild(this.map.div);this.vsw5.style.display="";};owv2.prototype.xmpo6 =function (){this.vsw5.style.display="none";this.wqw2.removeChild(this.map.div);this.map.wqw2.appendChild(this.map.div);this.mapDiv.style.display="";};owv2.prototype.w3 =function(){top.focus();openPrintMap();};owv2.prototype.unload =function (){this.vsw5.removeChild(this.wqw2);this.wqw2 = null;this.vsw5 = null;};function njx5(){this.setAlign("right");this.setValign("top");
}njx5.prototype = new vyk6(new db8(45,168),new x1(7,7));njx5.prototype.init =function (map){vyk6.prototype.init.call(this,map);this.setZIndex(1);this.jdi0 = t9.sul2(this,this.oyxn3);this.czqu5 = t9.sul2(this,this.move);this.rsh6 = t9.sul2(this,this.end);this.bar = o1.create('http://static.naver.com/n/local/206/map/0730/btn_stick.gif',22,13,11,39,10);this.appendChild(this.bar);t9.attachEvent(this.bar,"mousedown",this.jdi0);this.ynam5 = t9.bind(this.map,"redraw",this,this.redraw);var trli2 = o1.create('http://static.naver.com/n/local/206/map/0730/bg_size02.gif',45,168,0,0,0);trli2.style.border = "none";this.appendChild(trli2);t9.rw5(trli2,"click",this,this.zf2);
var erb8 = o1.create('http://static.naver.com/n/local/206/map/nvr/blank.gif',16,18,14,6,0);
this.appendChild(erb8);bdhj7(erb8,"pointer");t9.rw5(erb8,"click",this,this.zoomIn);var fo8 = o1.create('http://static.naver.com/n/local/206/map/nvr/blank.gif',16,18,14,142,0);this.appendChild(fo8);bdhj7(fo8,"pointer");t9.rw5(fo8,"click",this,this.zoomOut);if (!ik9){t9.rw5(trli2,"mouseout",this,this.end);}t9.bind(this.map,"zoom",this,this.u3);this.u3(this.map.getZoom());};njx5.prototype.zf2 =function (e,_obj){var event = e || window.event;var te0 = t9.gm6(event,event.target||event.srcElement);var y = te0.y;if (y<29){y = 29;}if (y>134 ){y = 134;}var xqgv4 = Math.round((y - 34) /10 +1);xqgv4 = Math.max(Math.min(xqgv4,11),1);this.map.setZoom(xqgv4);};njx5.prototype.zoomIn =function (){this.map.zoomIn();};njx5.prototype.zoomOut =function (){this.map.zoomOut();};njx5.prototype.oyxn3 =function (e){var event = e || window.event;this.snzo6 = event.clientY;this.scl1 = parseInt(this.bar.style.top);this.czqu5 = t9.rw5(this.bar,"mousemove",this,this.move);this.rsh6 = t9.rw5(this.bar,"mouseup",this,this.end);if(this.bar.setCapture){this.bar.setCapture();}};njx5.prototype.end =function (e){xqgv4 = Math.max(Math.min(Math.ceil((parseInt(this.bar.style.top) - 35) / 10 +1 ),11),1);
this.map.setZoom(xqgv4);t9.detachEvent(this.bar,"mousemove",this.czqu5);t9.detachEvent(this.bar,"mouseup",this.rsh6);if(document.releaseCapture){document.releaseCapture();}};njx5.prototype.u3 =function (xqgv4){var te0 = (xqgv4 -1) * 10 + 29;this.bar.style.top = te0;};njx5.prototype.move =function (e){var event = e || window.event;var te0 = this.scl1+event.clientY - this.snzo6;if (te0<26){te0 = 26;}if (te0>128 ){te0 = 128;}this.bar.style.top = te0;};njx5.prototype.unload =function (){this.removeChild(this.bar);this.bar = null;vyk6.prototype.unload.call(this);};function _miniMap(){this.setAlign("right");this.setValign("top");}_miniMap.prototype = new vyk6(new db8(182,207),new x1(7,7));_miniMap.prototype.init =function (map){vyk6.prototype.init.call(this,map);this.miniMapLayer = this.map.d13(0);this.appendChild(this.miniMapLayer);this.miniMapLayer.style.backgroundImage ='url(http://static.naver.com/n/local/206/map/0816/bg_map.gif)';this.miniMapLayer.style.width ="135px";this.miniMapLayer.style.height ="168px";var fep9;fep9 = o1.create('http://static.naver.com/n/local/206/map/0730/map_x.gif',6,5);fep9.style.top ="5px";fep9.style.right ="6px";bdhj7(fep9,"pointer");t9.rw5(fep9,"click",this,this.hideIMap);this.miniMapLayer.appendChild(fep9);var miniMap = this.map.d13(0);miniMap.style.position='relative';miniMap.style.left = 11;miniMap.style.top = 17;this.miniMapLayer.appendChild(miniMap);this.miniMap = new fikm0(miniMap,114,141,false);this.rect = new _rectangle();this.miniMap.addOverlay(this.rect);this.rect.setOpacity(0.5);this.MapBound2Mini();this.button = o1.create('http://static.naver.com/n/local/206/map/0730/btn_minimap.gif',45,18);this.button.style.bottom ="0px";this.button.style.right ="0px";bdhj7(this.button,"pointer");
this.button.style.display="none";t9.rw5(this.button,"click",this,this.e77);this.appendChild(this.button);t9.attachEvent(this.miniMapLayer,"mousewheel",t9.stopEvent);t9.bind(this.map,"zoom",this,this.MapBound2Mini);
t9.bind(this.map,"move",this,this.MapCenter2Mini);t9.bind(this.miniMap,"endDrag",this,this.miniCenter2Map);};_miniMap.prototype.MapCenter2Mini  =function (){this.miniMap.setCenter(this.map.getCenter());this.rect.setCenter(this.map.getCenter());};_miniMap.prototype.miniCenter2Map =function (){this.map.setCenter(this.miniMap.getCenter());};_miniMap.prototype.MapBound2Mini  =function (){var bound = this.map.getBound();var dx = Math.round((bound[2] - bound[0])*0.1);var dy = Math.round((bound[3] - bound[1])*0.1);this.rect.setBound(this.map.getBound());
bound[0] = bound[0] - dx;bound[1] = bound[1] - dy;bound[2] = bound[2] + dx;bound[3] = bound[3] + dy;this.miniMap.setBound(bound);};_miniMap.prototype.miniBound2Map =function (){this.map.setBound(this.miniMap.getBound());};_miniMap.prototype.e77 =function(){this.miniMapLayer.style.display="";this.button.style.display="none";};_miniMap.prototype.hideIMap =function(){this.miniMapLayer.style.display="none";this.button.style.display="";};function r4(){this.setAlign("right");this.setValign("top");}r4.prototype = new vyk6(new db8(182,189),new x1(7,7));r4.prototype.init =function (map){vyk6.prototype.init.call(this,map);this.obxw9 = this.map.d13(0);this.appendChild(this.obxw9);this.obxw9.style.backgroundImage ='url(http://static.naver.com/n/local/206/map/0816/bg_map.gif)';this.obxw9.style.width ="135px";this.obxw9.style.height ="168px";var fep9;fep9 = o1.create('http://static.naver.com/n/local/206/map/0730/map_x.gif',6,5);fep9.style.top ="5px";fep9.style.right ="6px";bdhj7(fep9,"pointer");t9.rw5(fep9,"click",this,this.hideIMap);this.obxw9.appendChild(fep9);this.l4 = d19('http://maps.naver.com/common/miniMap_2004.swf','indexMap',114,141);this.l4.style.position='absolute';this.l4.style.left = 11;this.l4.style.top = 17;this.obxw9.appendChild(this.l4);
i1('indexMap',t9.createCallback(this,this.getFlashAction));this.button = o1.create('http://static.naver.com/n/local/206/map/0730/btn_minimap.gif',45,18);this.button.style.bottom ="0px";this.button.style.right ="0px";bdhj7(this.button,"pointer");this.button.style.display="none";t9.rw5(this.button,"click",this,this.e77);this.appendChild(this.button);};r4.prototype.getFlashAction =function (cmd,arg){
if (cmd =="name"){this.j3(arg);}else if (cmd =="loadEnd"){}};r4.prototype.j3 =function (arg){var qy9 = new Array();qy9['seoul'] = new Array(299392,557728,324992,538528);qy9['incheon'] = new Array(261408,552704,287008,533504);qy9['busan'] = new Array(472448,306560,521074,268160);qy9['daejeon'] = new Array(332536,433445,360456,398303);qy9['daegu'] = new Array(431901,379866,469204,343424);qy9['kwangju'] = new Array(276700,296272,311127,273252);qy9['ulsan'] = new Array(491200,347828,535749,310080);qy9['kyunggi'] = new Array(277888,602368,380288,525568);qy9['kangwon'] = new Array(421504,619648,523904,542848);qy9['chungnam'] = new Array(229368,491776,367715,375440);qy9['chungbuk'] = new Array(361920,505984,413120,467584);qy9['kyongnam'] = new Array(426624,340992,510931,264192);qy9['kyongbuk'] = new Array(409088,473728,511488,396928);qy9['jeonnam'] = new Array(221952,309888,324352,233088);qy9['jeonbuk'] = new Array(254848,379520,357248,302720);qy9['jeju'] = new Array(240000,105280,291200,66880);this.map.setBound(qy9[arg]);};r4.prototype.e77 =function(){this.obxw9.style.display="";this.button.style.display="none";};r4.prototype.hideIMap =function(){this.obxw9.style.display="none";this.button.style.display="";};r4.prototype.selectArea =function (init)
{var curr = this.map.getCenter();var xmlhttp = new lzz2(0,1);if (akg8(init) && init==true){xmlhttp.loadhttp('/common/getNearDo/?x='+curr.x+'&y='+curr.y,t9.createCallback(this,this.initArea));}else{xmlhttp.loadhttp('/common/getNearDo/?x='+curr.x+'&y='+curr.y,t9.createCallback(this,this.setArea));}};r4.prototype.initArea  =function (areaName){if (areaName==''){return;}uv8(this,function (){this.setArea(areaName)},0);
return;};r4.prototype.setArea =function(areaName){if (areaName==''){return;}try{getFlashMovieObject('indexMap').SetVariable ("/obj:zone", areaName);}catch (e){}};function _dynamicOverlay(fjqx1,size){this.hideTimeout = null;this.map = null;this.r5 = null;this.opacity = 1;this.zIndex = 0;this.show = true;this.r70=0;this.content = '';this.fjqx1 = (akg8(fjqx1))?fjqx1:null;this.size = (akg8(size))?size:null;this.bound = null;}_dynamicOverlay.prototype.init =function (map){this.map = map;this.r5 = this.map.d13(0);this.r5.style.padding=this.r70+'px '+this.r70+'px '+this.r70+'px '+this.r70+'px ';this.r5.oncontextmenu=falseFunc;this.r5.onselectstart=falseFunc;this.r5.ondragstart=falseFunc;this.map.infoLayer.appendChild(this.r5);this.show = true;
this.redrawCallback = t9.bind(this.map,"redraw",this,this.redraw);t9.bind(this.map,"unload",this,this.unload);t9.bind(this.map,"zoom",this,this.calcSize);t9.rw5(this.r5,"mousedown",this,this.f3);t9.rw5(this.r5,"mouseup",this,this.mouseUp);t9.rw5(this.r5,"mouseover",this,this.mouseover);t9.rw5(this.r5,"mouseout",this,this.mouseout);t9.rw5(this.r5,"click",this,this.click);};_dynamicOverlay.prototype.f3 =function (a){if(!a) a = window.event;t9.trigger(this,"mousedown");};_dynamicOverlay.prototype.mouseUp =function (a){if(!a) a = window.event;t9.trigger(this,"mouseup");};_dynamicOverlay.prototype.mouseover =function (a){if(!a) a = window.event;t9.trigger(this,"mouseover");};_dynamicOverlay.prototype.mouseout =function (a){if(!a) a = window.event;t9.trigger(this,"mouseout");};_dynamicOverlay.prototype.click =function (a){if(!a) a = window.event;t9.trigger(this,"click");};_dynamicOverlay.prototype.setCenter =function(fjqx1){if (this.bound!=null){var dx = fjqx1.x - this.fjqx1.x;var dy = fjqx1.y - this.fjqx1.y;this.bound[0] +=dx;this.bound[1] +=dy;this.bound[2] +=dx;this.bound[3] +=dy;}this.fjqx1 = fjqx1;this.redraw();};_dynamicOverlay.prototype.setSize =function(size){this.bound = null;this.size = size;this.redraw();};_dynamicOverlay.prototype.setBound =function(bound){this.bound = bound;this.size = null;this.fjqx1 = new x1(Math.round((bound[0]+bound[2])/2),Math.round((bound[1]+bound[3])/2));};_dynamicOverlay.prototype.setContent =function(content){this.content = content;this.redraw();};_dynamicOverlay.prototype.setOpacity =function(opacity){this.opacity = opacity;this.redraw();};_dynamicOverlay.prototype.getPos =function (){return this.map.b198(this.map.spec.point2pixel(this.fjqx1,this.map.p43));};_dynamicOverlay.prototype.draw =function (left,top,width,height){this.r5.style.width = width+"px";this.r5.style.height =height+"px";this.r5.style.left =left+"px";this.r5.style.top = top+"px";this.r5.innerHTML = this.content;this.r5.style.opacity = this.opacity;this.r5.style.filter ='alpha(opacity = '+(this.opacity*100)+')';};_dynamicOverlay.prototype.redraw =function (){if (this.map ==null){return;}if (this.bound!=null){var left = this.bound[0];var top = this.bound[1];var right = this.bound[2];var bottom = this.bound[3];var pixel1 = this.map.b198(this.map.spec.point2pixel(new x1(left,top),this.map.p43));var pixel2 = this.map.b198(this.map.spec.point2pixel(new x1(right,bottom),this.map.p43));this.draw(pixel1.x,pixel1.y, (pixel2.x - pixel1.x) , (pixel2.y - pixel1.y));}else if (this.size !=null){var ugll7 = this.getPos();this.draw((ugll7.x - Math.round(this.size.width/2)),(ugll7.y - Math.round(this.size.height/2)),this.size.width,this.size.height);
}else{return;}};_dynamicOverlay.prototype.showWindow =function (){if (this.hideTimeout !=null){window.clearTimeout(this.hideTimeout);this.hideTimeout = null;}if (!this.show){this.show = true;t9.addListener(this.map,"redraw",this.redrawCallback);t9.addListener(this.map,"move",this.moveCallback);this.r5.style.display = '';this.redraw();}};_dynamicOverlay.prototype.hideWindow =function (){if (this.show){this.show = false;t9.removeListener(this.map,"redraw",this.redrawCallback);t9.removeListener(this.map,"move",this.moveCallback);this.r5.style.display = 'none';}};_dynamicOverlay.prototype.delayHideWindow =function (lij4){if (!lij4){lij4 = 500;}if (this.hideTimeout !=null){window.clearTimeout(this.hideTimeout);}this.hideTimeout = uv8(this,function(){this.hideWindow()},lij4);};_dynamicOverlay.prototype.unload =function (){this.hideWindow();this.r5.innerHTML='';this.map.infoLayer.removeChild(this.r5);this.r5 = null;this.te0 = null;this.redrawCallback = null;this.map = null;};function _shapeObject(){this.lineWeight = 1;this.lineColor='red';this.fillColor=null;};_shapeObject.prototype = new _dynamicOverlay();_shapeObject.prototype.setLineWeight =function (Weight){this.lineWeight = Weight;this.redraw();};_shapeObject.prototype.setLineColor =function (color){this.lineColor = color;this.redraw();};_shapeObject.prototype.setFillColor =function (color){this.fillColor = color;this.redraw();};function _rectangle(fjqx1,size){this.fjqx1 = fjqx1;this.size = size;};_rectangle.prototype = new _shapeObject();_rectangle.prototype.init =function (map){_shapeObject.prototype.init.call(this,map);this.innerLayer = this.map.d13(0);this.innerLayer.style.width='100%';this.innerLayer.style.height='100%';this.r5.appendChild(this.innerLayer);};_rectangle.prototype.draw =function (left,top,width,height){if (ik9){this.r5.style.width = (width+this.lineWeight)+"px";this.r5.style.height =(height+this.lineWeight)+"px";this.r5.style.left =(left-this.lineWeight/2)+"px";this.r5.style.top = (top-this.lineWeight/2)+"px";}else{this.r5.style.width = (width-this.lineWeight)+"px";this.r5.style.height =(height-this.lineWeight)+"px";this.r5.style.left =(left-this.lineWeight/2)+"px";this.r5.style.top = (top-this.lineWeight/2)+"px";}if (this.fillColor!=null){this.innerLayer.style.backgroundColor =this.fillColor;}this.innerLayer.innerHTML = this.content;this.r5.style.opacity = this.opacity;this.r5.style.filter ='alpha(opacity = '+(this.opacity*100)+')';this.r5.style.border=this.lineWeight+'px '+this.lineColor+' solid';};function _circle(fjqx1,size){this.fjqx1 = fjqx1;this.size = new db8(size,size);this.kg0 = null;};_circle.prototype = new _shapeObject();_circle.prototype.init =function (map){_shapeObject.prototype.init.call(this,map);};_circle.prototype.draw =function (left,top,width,height)
{this.r5.style.width = width+"px";this.r5.style.height =height+"px";this.r5.style.left =left+"px";this.r5.style.top = top+"px";if (ik9){this.drawIE(width,height);}else{this.drawFF(width,height);}};_circle.prototype.drawIE =function (width,height){if (this.kg0 ==null){this.kg0 = document.createElement("oval");this.kg0.style.position = "absolute";this.r5.appendChild(this.kg0);this.kg0.unselectable = "on";this.kg0.filled = "False";this.kg0.style.behavior = 'url(#default#VML);';this.fk4 = document.createElement("stroke");this.kg0.appendChild(this.fk4);this.fk4.style.behavior = 'url(#default#VML);';}var size = Math.min(width,height);this.kg0.style.left=Math.round((width - size)/2)+'px';this.kg0.style.top=Math.round((height- size)/2)+'px';this.kg0.style.width=(size-3)+'px';this.kg0.style.height=(size-3)+'px';this.kg0.strokeweight = this.lineWeight;this.kg0.strokecolor=this.lineColor;this.fk4.opacity = this.opacity;};_circle.prototype.drawFF =function (width,height)
{if (this.kg0 ==null){this.kg0 = document.createElement("canvas");this.kg0.style.position = "absolute";this.r5.appendChild(this.kg0);}if (width*height > (1200*1200)){this.r5.style.display="none";return;}this.r5.style.display="";var size = Math.min(width,height)+this.lineWeight;width +=this.lineWeight*2;height +=this.lineWeight*2;this.kg0.style.left=Math.round(( - this.lineWeight))+'px';this.kg0.style.top=Math.round((- this.lineWeight))+'px';this.kg0.width=width;this.kg0.height=height;var ctx;try{ctx= this.kg0.getContext("2d");}catch (e){ctx=null;}if (ctx){ctx.globalAlpha =this.opacity;ctx.strokeStyle =this.lineColor;ctx.lineWidth =this.lineWeight;ctx.scale(1,1);ctx.beginPath();ctx.arc(width/2,height/2,(size-this.lineWeight)/2,0,Math.PI*2,true);ctx.stroke();}};function s7(){this.hideTimeout = null;this.map = null;this.content = '';this.infoDiv = null;this.opacity=1;this.d04='';this.size = null;this.autoPosX = true;this.autoPosY = true;this.te0 = new x1(1,-1);this.currentPos = null;this.currentSize = null;this.offset = new db8(0,0);this.zIndex=1;this.jq5 = null;}s7.prototype.init =function (map,overlay){this.redrawCallback = t9.createCallback(this,this.redraw);
this.map = map;this.infoDiv = this.map.d13(0);if (akg8(overlay)){this.jq5 = overlay}else{this.jq5 = this.map.infoLayer;}this.jq5.appendChild(this.infoDiv);this.initWin();t9.rw5(this.infoDiv,"mouseout",this,this.mouseout);
t9.rw5(this.infoDiv,"mouseover",this,this.mouseover);t9.attachEvent(this.infoDiv,"mousedown",t9.stopEvent);t9.attachEvent(this.infoDiv,"click",t9.stopEvent);t9.attachEvent(this.infoDiv,"dblclick",t9.stopEvent);};s7.prototype.setPos =function (value){this.te0 = value; };s7.prototype.setZIndex =function (zIndex){this.zIndex = zIndex;if (this.currentPos){this.redraw();}};s7.prototype.setAutoPosX =function (value){this.autoPosX = value; };s7.prototype.setAutoPosY =function (value){this.autoPosY = value; };s7.prototype.setOffset =function (offset){this.offset = offset;};s7.prototype.initWin =function (){this.infoDiv.style.padding  ='0px 0px 0px 0px';this.infoDiv.style.display ="none";this.c50 = this.map.d13(0);this.infoDiv.appendChild(this.c50);this.c50.style.position = 'relative';this.c50.style.padding = '0px 0px 0px 0px';this.c50.style.left='0px';this.c50.style.top='0px';this.c50.noWrap = true;};s7.prototype.setOpacity =function(opacity){if (this.opacity!=opacity){this.opacity=opacity;this.redraw();}};s7.prototype.setSize =function (size){this.size = size;if (this.currentPos){this.redraw();}};s7.prototype.setPoint =function (fjqx1){this.fjqx1 = fjqx1;if (this.currentPos){this.redraw();}};s7.prototype.setContent =function (content){this.content = fjqx1;if (this.currentPos){this.redraw();}};
s7.prototype.set =function (fjqx1,content){this.fjqx1 = fjqx1;this.content = content;if (this.currentPos){this.redraw();}};s7.prototype.setClassName =function (d04){this.d04 = d04;if (this.currentPos){this.currentSize =null;this.redraw();}};s7.prototype.ku0 =function (){var c = this.map.b198(this.map.spec.point2pixel(this.fjqx1,this.map.p43));var top,left;
var hWidth,hHeight;if (this.size !=null){hWidth = this.size.width /2;hHeight = this.size.height /2;}
else{hWidth = this.infoDiv.offsetWidth /2;hHeight = this.infoDiv.offsetHeight /2;}var xPos,yPos; xPos = this.map.euk7.gsvi7.width + c.x;yPos = this.map.euk7.gsvi7.height + c.y;var leftPos = (xPos - hWidth +hWidth * this.currentPos.x);var rightPos = (xPos + hWidth + hWidth * this.currentPos.x);var topPos = (yPos - hHeight + hHeight * this.currentPos.y);var bottomPos =(yPos + hHeight + hHeight * this.currentPos.y);var cond1 = (rightPos - (this.map.cixt4.width - this.map.m1[2] - this.offset.width)); var cond2 = ((this.map.m1[0] + this.offset.width) - leftPos); var cond3 = ((this.map.m1[1] + this.offset.height) - topPos); var cond4 = (bottomPos - (this.map.cixt4.height - this.map.m1[3] - this.offset.height)); if (this.autoPosX){if ( ( this.currentPos.x ==1 &&  cond1>0 && cond1>cond2) || (this.currentPos.x ==-1 && cond2>0 && cond2>cond1 )){this.currentPos.x = this.currentPos.x *(-1);}}if (this.autoPosY){if ( ( this.currentPos.y ==1 &&  cond4>0 && cond4>cond3) || (this.currentPos.y ==-1 && cond3>0 && cond3>cond4 )){this.currentPos.y = this.currentPos.y *(-1);}}left = (xPos -hWidth + hWidth * this.currentPos.x) + this.offset.width * this.currentPos.x ;top = (yPos - hHeight + hHeight* this.currentPos.y)+ this.offset.height * this.currentPos.y;this.infoDiv.style.left = left - this.map.euk7.gsvi7.width;this.infoDiv.style.top = top - this.map.euk7.gsvi7.height;};s7.prototype.redraw =function (recalc){if (this.map ==null){return;}if (this.fjqx1 ==null){return;}if (this.infoDiv.style.display =="none"){return;}this.infoDiv.style.zIndex = this.zIndex;this.c50.className=this.d04;if (this.content!=null){this.c50.innerHTML = this.content;this.content = null;this.currentSize = null;}if ((this.currentSize ==null) || (recalc==true)){this.c50.style.width = '';this.c50.style.height = '';this.currentSize = this.map.getDomSize(this.c50);this.c50.style.width = this.currentSize.width;this.c50.style.height = this.currentSize.height;}if (this.size !=null){this.infoDiv.style.width = this.size.width;this.infoDiv.style.height = this.size.height;this.c50.style.width = this.size.width;this.c50.style.height = this.size.height;}if (this.opacity!=1){this.c50.style.opacity = this.opacity;this.infoDiv.style.filter ='alpha(opacity = '+(this.opacity*100)+')';}this.ku0();};s7.prototype.pan =function (){var c = this.map.b198(this.map.spec.point2pixel(this.fjqx1,this.map.p43));var xPos = this.map.euk7.gsvi7.width+c.x;var yPos = this.map.euk7.gsvi7.height+c.y - 40;var xPan = Math.min(Math.max(0, 10 - xPos), (this.map.cixt4.width - 10 - (xPos +this.infoDiv.clientWidth)));var yPan = Math.min(Math.max(0, 10 - (yPos - this.infoDiv.clientHeight)), (this.map.cixt4.height - 10 - yPos));this.map.pan(xPan,yPan);};s7.prototype.mouseover =function (a){if(!a) a = window.event;if (a){xyy2(a);}t9.trigger(this,"mouseover");};s7.prototype.mouseout =function (a){if(!a) a = window.event;if (a){xyy2(a);}t9.trigger(this,"mouseout");};s7.prototype.showWindow =function (){if (this.hideTimeout !=null){window.clearTimeout(this.hideTimeout);this.hideTimeout = null;}if (this.currentPos !=null){return;}this.currentPos = this.te0.copy();t9.addListener(this.map,"redraw",this.redrawCallback);t9.addListener(this.map,"move",this.redrawCallback);this.infoDiv.style.display = '';this.redraw();};s7.prototype.hideWindow =function (){if (this.currentPos==null){return;}this.currentPos = null;t9.removeListener(this.map,"redraw",this.redrawCallback);t9.removeListener(this.map,"move",this.redrawCallback);this.infoDiv.style.display = 'none';};s7.prototype.delayHideWindow =function (lij4){if (!lij4){lij4 = 500;}if (this.hideTimeout !=null){window.clearTimeout(this.hideTimeout);}this.hideTimeout = uv8(this,function(){this.hideWindow()},lij4);};s7.prototype.unload =function (){this.infoDiv.removeChild(this.c50);this.c50 = null;this.jq5.removeChild(this.infoDiv);this.infoDiv.innerHTML='';this.infoDiv = null;this.jq5 = null;this.te0 = null;this.redrawCallback = null;this.map = null;};function zzqm4(){this.f7='';}zzqm4.prototype = new s7();zzqm4.prototype.initWin =function (){this.setOffset(new db8(7,7));this.infoDiv.style.padding  ='0px 0px 0px 0px';this.setOpacity(1);this.infoDiv.style.display ="none";this.opl5 = this.map.d13(0);this.infoDiv.appendChild(this.opl5);this.opl5.style.position = 'relative';this.opl5.style.width = '304px';this.opl5.style.height = '42px';this.opl5.style.background = 'url(http://static.naver.com/n/local/206/map/0621/bg_info01.gif) no-repeat top';this.si5 = this.map.d13(0);this.opl5.appendChild(this.si5);this.si5.style.font = 'bold 12px 굴림,gulim,sans-serif';this.si5.style.color = '#333333';this.si5.style.left = '15px';this.si5.style.top = '12px';this.si5.style.r70 = '0';this.si5.style.padidng = '0';this.fep9 = o1.create("http://static.naver.com/n/local/206/map/0621/btn_x.gif",14,13,276,12,0);bdhj7(this.fep9,"pointer");this.opl5.appendChild(this.fep9);t9.rw5(this.fep9,"click",this,this.hideWindow);this.c50 = this.map.d13(0);this.infoDiv.appendChild(this.c50);this.c50.style.position = 'relative';this.c50.style.width = '304px';this.c50.style.background = 'url(http://static.naver.com/n/local/206/map/0621/bg_info01.gif) bottom';this.c50.style.paddingBottom = '8px';};zzqm4.prototype.set =function (fjqx1,si5,content){this.f7 = si5;s7.prototype.set.call(this,fjqx1,content);};zzqm4.prototype.redraw =function (){if (this.map ==null){return;}if (this.fjqx1 ==null){return;}if (this.infoDiv.style.display =="none"){return;}this.si5.innerHTML = this.f7;this.c50.style.width = '';this.c50.style.height = '';this.infoDiv.style.width = '';
this.infoDiv.style.height = '';this.c50.innerHTML = this.content;this.infoDiv.style.width =  this.c50.offsetWidth;this.infoDiv.style.height = this.opl5.offsetHeight+this.c50.offsetHeight;
s7.prototype.ku0.call(this);};zzqm4.prototype.unload =function(){this.opl5.removeChild(this.si5);this.si5 = null;this.infoDiv.removeChild(this.opl5);this.opl5 = null;s7.prototype.unload.call(this);};function adlo5(src,size,offset){this.src = src;this.size = size;if (offset){this.offset = offset;}
else{this.offset = new db8(Math.round(size.width/2),Math.round(size.height/2));}this.zIndex = 0;}adlo5.prototype.getOffset =function(){return this.offset;};adlo5.prototype.getSize =function(){return this.size;};adlo5.prototype.createObj =function (wnw1){var w07 = o1.create(this.src,this.size.width,this.size.height,0,0,0);
bdhj7(w07,"pointer");return w07;};function ub8(fjqx1,adlo5){this.map = null;this.fjqx1 = fjqx1;this.adlo5 = adlo5;this.m7 = false;this.iqd9 = null;this.infowin = null;this.w07 = this.adlo5.createObj();this.pr7 = new db8(1,1);this.shift = false;this.text = null;this.tnb6 = null;};ub8.prototype.setZindex =function(zIndex){this.w07.style.zIndex = zIndex;};ub8.prototype.setInfowin =function(infowin){this.infowin = infowin;};ub8.prototype.unsetInfowin =function(){this.infowin = null;};ub8.prototype.setText =function(text){if (this.tnb6 != null){this.tnb6.unload();this.tnb6 = null;}this.text = text;this.redraw();};ub8.prototype.setContent =function(content){this.content = content;};ub8.prototype.setTargeturl =function(iqd9){this.iqd9 = iqd9;this.w07.onclick = function (){window.open(iqd9,"_blank");};};ub8.prototype.unsetTargeturl =function(){this.iqd9 = null;this.w07.onclick ='';};ub8.prototype.setPropagationEvent =function(flag){this.m7 = flag;};ub8.prototype.setPoint =function (fjqx1){this.fjqx1 = fjqx1;this.redraw();};ub8.prototype.getPoint =function(fjqx1){if (!fjqx1){fjqx1 = this.fjqx1.copy();}else{fjqx1.set(this.fjqx1.x,this.fjqx1.y);}return fjqx1;};ub8.prototype.getPos =function (){var c = this.map.b198(this.map.spec.point2pixel(this.fjqx1,this.map.p43));var offset = this.adlo5.getOffset();var x = c.x - offset.width;var y = c.y - offset.height;return new x1(x,y);};ub8.prototype.init =function(map){this.map = map;this.map.markLayer.appendChild(this.w07);t9.rw5(this.w07,"mouseover",this,this.mouseover);t9.rw5(this.w07,"mouseout",this,this.mouseout);t9.rw5(this.w07,"mousedown",this,this.tqff8);t9.rw5(this.w07,"mouseup",this,this.mouseup);t9.rw5(this.w07,"click",this,this.click);t9.bind(this.map,"unload",this,this.unload);this.ynam5 = t9.bind(this.map,"redraw",this,this.redraw);};ub8.prototype.unload =function(){t9.removeListener(this.map,"zoom",this.ynam5);
if (this.tnb6 != null){
this.tnb6.unload();}if (this.map && this.map.markLayer){this.map.markLayer.removeChild(this.w07);this.map.f1(this);}this.w07 = null;this.infowin = null;};ub8.prototype.enableShift =function (){this.shift = true;this.map.qtsr9(this);this.redraw();};ub8.prototype.disableShift =function (){this.shift = false;this.map.f1(this);this.redraw();};ub8.prototype.redraw =function(recalc){var te0;if (!akg8(recalc)){recalc = false;}if (this.map == null){return;}if (this.shift){te0 = this.map.c53(this);}else{te0 = this.getPos();}this.w07.style.left = te0.x;this.w07.style.top = te0.y;this.w07.te0 = te0;if (this.text !=null){if (this.tnb6 == null){this.tnb6 =  new NInfoWindow();this.tnb6.init(this.map,this.map.markLayer);this.tnb6.set(this.fjqx1,this.text);this.tnb6.setAutoPosX(false);this.tnb6.setAutoPosY(false);this.tnb6.setPos(new NPoint(1,1));var size = this.adlo5.getSize();var offset = this.adlo5.getOffset();this.tnb6.setOffset(new NSize(-offset.width+size.width,-offset.height+2));this.tnb6.showWindow();this.tnb6.redraw(true);}else{this.tnb6.showWindow();this.tnb6.redraw(recalc);}
}else{if (this.tnb6 !=null){this.tnb6.hideWindow();}}};ub8.prototype.show =function (){this.w07.style.display = '';if (this.tnb6 !=null){this.tnb6.showWindow();}};ub8.prototype.hide =function ()
{this.w07.style.display = 'none';if (this.tnb6 !=null){this.tnb6.hideWindow();}};ub8.prototype.showInfoWin =function(content){this.map.setInfoWin(this.getPoint(),content);this.map.showInfoWin();};ub8.prototype.hideInfoWin =function(lij4){this.map.hideInfoWin(lij4);};ub8.prototype.showInfo =function(){if (this.infowin !=null){this.infowin.set(this.getPoint(),this.content);this.infowin.showWindow();}};ub8.prototype.click=function(a){if(!a) a = window.event;if (!this.m7 && a){xyy2(a);
}t9.trigger(this,"click",this.getPoint());};ub8.prototype.tqff8=function(a)
{
if(!a) a = window.event;if (!this.m7 && a){xyy2(a);}t9.trigger(this,"mousedown");};ub8.prototype.mouseup=function(a){if(!a) a = window.event;if (!this.m7 && a){xyy2(a);}t9.trigger(this,"mouseup");};ub8.prototype.mouseover=function(a){if(!a) a = window.event;if (!this.m7 && a){xyy2(a);}this.jhd8 = this.w07.style.zIndex;this.w07.style.zIndex = 999;this.w07.style.left = this.w07.te0.x - this.pr7.width;this.w07.style.top = this.w07.te0.y - this.pr7.height;this.showInfo();t9.trigger(this,"mouseover",this.getPoint());};ub8.prototype.setOverAmt =function (x,y){this.pr7.set(x,y);};ub8.prototype.mouseout=function(a){if(!a) a = window.event;if (!this.m7 && a){xyy2(a);}this.w07.style.zIndex = this.jhd8;this.w07.style.left = this.w07.te0.x;this.w07.style.top = this.w07.te0.y;if (this.infowin !=null){this.infowin.delayHideWindow();}t9.trigger(this,"mouseout");};function sh0(width,height,r70,parent){this.map = null;this.r5 =null;this.km3 = new Array();this.width = width;this.height = height;this.r70 = r70;this.xoit5 = new x1(-1000,-1000);this.l46 = false;this.parent = parent;this.leftTopPoint = new x1(0,0);this.vyd9 = false;this.weight = 10;this.color="#FF0000";this.opacity = 0.5;this.vny8 = null;this.kg0 = null;this.lmq8 = null;this.kacd5 = true;this.sy7 = false;}sh0.prototype.lf3 =function (x,y){this.leftTopPoint.set(x,y);};sh0.prototype.init =function(map){this.map = map;if (!this.parent){this.parent = this.map.pathLayer;}t9.bind(this.map,"beforePrint",this,this.g1);t9.bind(this.map,"afterPrint",this,this.xmpo6);t9.bind(this.map,"unload",this,this.unload);
};sh0.prototype.g1 =function (){if (this.obh0()){this.lmq8 = this.hc9(this.r5);}};sh0.prototype.xmpo6 =function (){if (this.lmq8!=null){this.r5.removeChild(this.lmq8);this.lmq8 = null;}};sh0.prototype.setWeight =function(weight){this.weight = weight;if (this.vny8!=null){if (ik9){this.vny8.weight = weight;}else{this.vny8.lineWidth = Math.round(weight*1.3);}}};sh0.prototype.getWeight =function(){return this.weight;};sh0.prototype.setColor =function(color){this.color = color;if (this.vny8!=null){if (ik9){this.vny8.color = color;
}else{this.vny8.strokeStyle = color;}}};sh0.prototype.getColor =function(){return this.color;};sh0.prototype.setOpacity =function(opacity){this.opacity = opacity;if (this.vny8!=null){if (ik9){this.vny8.opacity = opacity;}else{this.vny8.globalAlpha = opacity;}}};sh0.prototype.getOpacity =function(){return this.opacity;};sh0.prototype.redraw =function(){if (this.r5==null){this.r5 =this.tfh8();}this.polyline(this.r5);this.kacd5 = false;};sh0.prototype.show =function(){if (this.kacd5){this.redraw();}if (!this.obh0()){this.parent.appendChild(this.r5);this.l46 = true;}};sh0.prototype.hide =function(){if (this.obh0()){this.parent.removeChild(this.r5);this.l46 = false;}};sh0.prototype.tfh8 =function (){var r5 = document.createElement("div");r5.style.position = "absolute";r5.style.width = this.width+this.r70*2;r5.style.height = this.height+this.r70*2;r5.style.overflow ='hidden';return r5;};sh0.prototype.obh0 =function (){return this.l46;};sh0.prototype.setPos =function (left,top){this.r5.style.left = left - this.r70;this.r5.style.top = top - this.r70;};sh0.prototype.moveTo =function(fjqx1)
{this.km3.push(this.xoit5);this.lineTo(fjqx1);};sh0.prototype.lineTo =function(fjqx1){var ugll7 = new x1(fjqx1.x-this.leftTopPoint.x + this.r70,this.leftTopPoint.y-fjqx1.y + this.r70);ugll7.startArrow = fjqx1.startArrow;ugll7.endArrow = fjqx1.endArrow;this.sy7 = true;this.km3.push(ugll7);};sh0.prototype.fix =function(){if (this.sy7){for (var i = this.km3.length-1;i>1 ;i--){if (this.km3[i-1].equals(this.xoit5)){if (this.km3[i].equals(this.km3[i-2])){this.km3.splice(i-1,2);}}else{if (this.km3[i].equals(this.km3[i-1])){this.km3.splice(i,1);}}}this.sy7 = false;}
};sh0.prototype.printMode =function (flag){this.vyd9 = flag;};sh0.prototype.polyline =function (r5){if (this.kg0 !=null){r5.removeChild(this.kg0);}if (this.vyd9){this.kg0 = this.hc9(r5);}else{if (ik9){this.kg0=this.jkro7(r5);}else{this.kg0=this.tmv4(r5);}}};sh0.prototype.hc9 =function(r5){var jqa6 ='http://down.maps.naver.com/path.php?path='+this.km3.join(",")+"&width="+(this.width+this.r70*2)+"&height="+(this.height+this.r70*2)+"&line_width="+this.getWeight()+"&color="+this.getColor().substr(1);var kg0 =o1.create(jqa6,this.width+this.r70*2,this.height+this.r70*2,0,0);r5.appendChild(kg0);return kg0;};sh0.prototype.jkro7 =function(r5){var kg0,fk4;var path='';kg0 = document.createElement("shape");r5.appendChild(kg0);kg0.unselectable = "on";kg0.fill = false;kg0.filled = false;kg0.style.position = "absolute";kg0.style.behavior = 'url(#default#VML);';fk4 = document.createElement("stroke");kg0.appendChild(fk4);fk4.endcap = "flat";fk4.joinstyle = "round";fk4.opacity = this.getOpacity();fk4.color = this.getColor();fk4.style.behavior = 'url(#default#VML);';kg0.style.width = this.width+this.r70*2;kg0.style.height = this.height+this.r70*2;kg0.coordorigin = "0 0";kg0.coordsize = (this.width+this.r70*2)+" "+(this.height+this.r70*2);var path = '';var bmr5 = false;this.fix(); if (this.km3[1].startArrow){fk4.startarrow="Block";}else{fk4.startarrow="none";}if (this.km3[this.km3.length-1].endArrow){fk4.endarrow="Block";}else{fk4.endarrow="none";}for (var i = 0;i<this.km3.length;i++){if (this.km3[i].equals(this.xoit5)){i++;if (i<(this.km3.length-1)){path = path +" m "+this.km3[i]+" l ";bmr5 = true;}}else{if (bmr5){bmr5 = false;path = path + this.km3[i];}else{path = path + ","+ this.km3[i];}}}path = path + " e";kg0.path = path;fk4.weight = this.getWeight();kg0.style.left = 0;kg0.style.top = 0;this.vny8 = fk4;return kg0;};sh0.prototype.tmv4 =function(r5){var kg0 = document.createElement("canvas");r5.appendChild(kg0);kg0.style.position = "absolute";kg0.style.opacity = 0.5;kg0.width = this.width+this.r70*2;kg0.height = this.height+this.r70*2;kg0.style.left = 0;kg0.style.top = 0;if (kg0.getContext){var ctx = kg0.getContext('2d');
ctx.lineWidth = Math.round(this.getWeight()*1.3);ctx.globalAlpha = Math.pow(this.getOpacity(),1/7);ctx.lineCap = "butt";ctx.lineJoin = "round";ctx.lastArrowhead = true;ctx.translate(0,0);ctx.beginPath();ctx.strokeStyle  = this.getColor();for (var i = 0;i<this.km3.length;i++){if (this.km3[i].equals(this.xoit5)){i++;ctx.moveTo(this.km3[i].x,(this.km3[i].y));}ctx.lineTo(this.km3[i].x,(this.km3[i].y));if ((i%40)==0)	ctx.stroke();}ctx.stroke();this.vny8 = ctx;}return kg0;};sh0.prototype.unload =function(){if (this.map && this.parent){if (this.r5!=null){if (this.r5.parentNode == this.parent){this.parent.removeChild(this.r5);}this.r5 =null;}this.map = null;this.parent = null;}this.km3 = null;this.xoit5 = null;this.leftTopPoint = null;this.vny8 = null;};function hrb3(){this.map = null;this.jvdv6 = new Array();this.sqww7 = new Array();this.vyd9 = false;this.weight = 10;this.minWeight = 3;this.maxWeight = 20;this.color="#FF0000";this.opacity = 0.5;this.left = 999999;this.top = 0;this.right = 0;this.bottom = 999999;this.turnOnList = new Array();this.enable = false;this.addPoints.apply(this,arguments);this.pointIndex = 0;this.autoWeight = true;this.r70 = 5;this.arrow = 0;this.enable = false;}hrb3.prototype.enablePrint =function (){this.vyd9 = true;};hrb3.prototype.disablePrint =
function (){this.vyd9 = false;};hrb3.prototype.setArrow =function (value){this.arrow = value;if (this.jvdv6.length>0){this.jvdv6[0].startArrow=((this.arrow % 2) ==1);this.jvdv6[this.jvdv6.length-1].endArrow=(this.arrow >1);}};hrb3.prototype.b9 =function (xqgv4,uq6){if (!this.sqww7[xqgv4]){this.sqww7[xqgv4] = new Array();this.turnOnList[xqgv4] = new Array();}if (!this.sqww7[xqgv4][uq6.x]){this.sqww7[xqgv4][uq6.x] = new Array();}if (!this.sqww7[xqgv4][uq6.x][uq6.y]){var polylinePixel = new sh0(this.map.spec.tileSize,this.map.spec.tileSize,20,this.r5);polylinePixel.printMode(this.vyd9);polylinePixel.init(this.map);polylinePixel.lf3(uq6.x*this.map.spec.tileSize ,(uq6.y+1)*this.map.spec.tileSize);polylinePixel.uq6 = uq6.copy();this.sqww7[xqgv4][uq6.x][uq6.y] = polylinePixel;}return this.sqww7[xqgv4][uq6.x][uq6.y];};hrb3.prototype.l46 =function(xqgv4,vwr7,d03){if (this.sqww7[xqgv4] && this.sqww7[xqgv4][vwr7] && this.sqww7[xqgv4][vwr7][d03] && this.enable){var xv6 = this.sqww7[xqgv4][vwr7][d03];xv6.setWeight(this.getWeight());xv6.setColor(this.getColor());xv6.setOpacity(this.getOpacity());xv6.show();xv6.setPos( (vwr7-this.map.ixu7.x) *this.map.spec.tileSize - this.map.khc9.width, (this.map.ixu7.y- d03) * this.map.spec.tileSize  - this.map.khc9.height);this.turnOnList[xqgv4].push(xv6);}};hrb3.prototype.plox0 =function(xqgv4,vwr7,d03){
if (this.sqww7[xqgv4] && this.sqww7[xqgv4][vwr7] && this.sqww7[xqgv4][vwr7][d03] && this.enable){var xv6 = this.sqww7[xqgv4][vwr7][d03];xv6.hide();
for (var i=0;i<this.turnOnList[xqgv4].length;i++){if (xv6 == this.turnOnList[xqgv4][i]){this.turnOnList[xqgv4].splice(i,1);break;}}}};hrb3.prototype.init =function(map){this.map = map;this.r5 = this.map.d13(0);this.map.pathLayer.appendChild(this.r5);this.redrawCallback = t9.bind(this.map,"redraw",this,this.redraw);this.ynam5 = t9.bind(this.map,"zoom",this,this.z1);this.turnOnCallback = t9.bind(this.map,"drawTile",this,this.l46);this.turnOffCallback = t9.bind(this.map,"removeTile",this,this.plox0);t9.bind(this.map,"unload",this,this.unload);this.enable = true;this.z1(this.map.getZoom());};hrb3.prototype.vtho2 =function(){if (this.map !=null && this.enable && this.sqww7[this.j82]){var tvz0 =  this.map.vxhy9();for (var i = tvz0[0];i<tvz0[2]  ;i++ ){for (var j = tvz0[1];j>tvz0[3] ;j-- ){this.l46(this.j82,i,j);}}}};hrb3.prototype.a4 =function(xqgv4){if (this.map !=null && this.enable){while (this.turnOnList[xqgv4].length>0){this.turnOnList[xqgv4].pop().hide();}}};hrb3.prototype.lgrc0 =function (xqgv4,from,to){var tqq5,cx,cy;var left,top,right,bottom;var hpoint,vpoint;var	dx = (to.x>from.x)?1:-1;var	dy = (to.y>from.y)?1:-1;var w2 = this.map.spec.tileSize;var fromIndex = new x1(Math.floor((from.x)/w2),Math.floor((from.y)/w2));var toIndex = new x1(Math.floor((to.x)/w2),Math.floor((to.y)/w2));var partLine = this.b9(xqgv4,fromIndex);while (!toIndex.equals(fromIndex)){var ddx = dx;var ddy = dy;left = fromIndex.x * w2;top = (fromIndex.y +1)* w2;right = (fromIndex.x+1)*w2;bottom = (fromIndex.y)*w2;hpoint = (to.x>from.x)?right:left;vpoint = (to.y>from.y)?top:bottom;if (from.y == to.y){ddy = 0;cx = hpoint;cy = from.y;}else if (from.x == to.x){ddx=0;cx = from.x;cy = vpoint;}else{var ratio = (to.y - from.y)/(to.x - from.x);cy = from.y + (hpoint - from.x)*ratio;cx = from.x+ (vpoint - from.y)/ratio;if ((to.y - from.y)*(vpoint-cy) > 0){
ddy =0;cx = hpoint;}else if ((to.y - from.y)*(vpoint-cy) < 0){if ((hpoint-cx) !=0){ddx =0;}cy = vpoint;}}tqq5 = new x1(Math.round(cx),Math.round(cy));from.set(cx,cy);partLine = this.b9(xqgv4,fromIndex);partLine.lineTo(tqq5);fromIndex.set(Math.floor((from.x+ddx)/w2),Math.floor((from.y+ddy)/w2));partLine = this.b9(xqgv4,fromIndex);partLine.moveTo(tqq5);}partLine.lineTo(to);};hrb3.prototype.ut6 =function (xqgv4,jvdv6,index){var ugll7;var ovl5 =	this.map.spec.point2pixel(jvdv6[index],xqgv4);ovl5.startArrow = jvdv6[index].startArrow;ovl5.endArrow = jvdv6[index].endArrow;if (index == 0){this.b9(xqgv4,new x1(Math.floor(ovl5.x/this.map.spec.tileSize),Math.floor(ovl5.y/this.map.spec.tileSize))).moveTo(ovl5);}for (var i = index+1;i<jvdv6.length;i++){ugll7 = this.map.spec.point2pixel(jvdv6[i],xqgv4);ugll7.startArrow = jvdv6[i].startArrow;ugll7.endArrow = jvdv6[i].endArrow;if ( (Math.abs(ovl5.x - ugll7.x)+Math.abs(ovl5.y - ugll7.y))<8 && i<(jvdv6.length-1) && !ugll7.startArrow && ugll7.endArrow){continue;}this.lgrc0(xqgv4,ovl5,ugll7);ovl5 = ugll7;}};
hrb3.prototype.z1 =function(xqgv4,n60){this.j82 = xqgv4;if (!this.enable){return;}if (this.jvdv6.length<2){return;}if (n60){this.a4(n60);}if (this.sqww7[this.j82] && this.sqww7[this.j82]!=null){this.vtho2();return;}this.ut6(xqgv4,this.jvdv6,0);this.vtho2();};hrb3.prototype.setWeight =function(weight){this.weight = weight;
this.vtho2();};hrb3.prototype.getWeight =function(weight){var weight;if (this.autoWeight){weight = Math.min(Math.max(Math.round(this.weight/this.j82),this.minWeight),this.maxWeight);}else{weight = Math.min(Math.max(this.weight,this.minWeight),this.maxWeight);}return weight;};hrb3.prototype.setAutoWeight =function(flag){this.autoWeight = flag;};hrb3.prototype.setMinWeight =function(weight){this.minWeight = weight;};hrb3.prototype.setMaxWeight =function(weight){this.maxWeight = weight;};hrb3.prototype.setOpacity =function (opacity)
{this.opacity = opacity;this.vtho2();};hrb3.prototype.getOpacity =function (){return this.opacity;};hrb3.prototype.setColor =function (color){this.color = color;this.vtho2();};hrb3.prototype.getColor =function (){return this.color;};hrb3.prototype.addPoints =function(){if (this.jvdv6.length>0){this.jvdv6[this.jvdv6.length-1].endArrow=false;}for (var i = 0;i<arguments.length;i++){this.left = Math.min(this.left,arguments[i].x);this.top = Math.max(this.top,arguments[i].y);this.right = Math.max(this.right,arguments[i].x);this.bottom = Math.min(this.bottom,arguments[i].y);arguments[i].startArrow = false;arguments[i].endArrow = false;this.jvdv6.push(arguments[i]);}if (this.jvdv6.length>0){this.jvdv6[0].startArrow=((this.arrow % 2) ==1);this.jvdv6[this.jvdv6.length-1].endArrow=(this.arrow >1);}if (this.map !=null){var startIndex = this.jvdv6.length - arguments.length -1;if (startIndex >=0){if (!this.sqww7[this.j82]){this.sqww7[this.j82] = new Array();this.turnOnList[this.j82] = new Array();}for (var xqgv4 in this.sqww7){this.ut6(xqgv4,this.jvdv6,startIndex);}this.urdm6();this.enable =true;this.vtho2();
}}};hrb3.prototype.getBound =function (){return Array(this.left,this.top,this.right,this.bottom);};hrb3.prototype.getPoints =function (){return this.jvdv6;};hrb3.prototype.setPoint =function(index,fjqx1){if (this.jvdv6[index] instanceof x1){this.jvdv6[index].set(fjqx1.x,fjqx1.y);this.vncw6();}};hrb3.prototype.vncw6 =function(){this.tmr1();this.z1(this.j82);this.redraw();};hrb3.prototype.redraw =function(){if (this.map ==null){return;}this.vtho2();};hrb3.prototype.show =function(){this.enable = true;this.z1(this.j82);};hrb3.prototype.hide =function(){this.a4(this.j82);this.enable =false;};hrb3.prototype.urdm6 =function(){for (var xqgv4 in this.sqww7){for (var vwr7 in this.sqww7[xqgv4]){for (var d03 in this.sqww7[xqgv4][vwr7]){this.sqww7[xqgv4][vwr7][d03].kacd5 = true;}}}};hrb3.prototype.tmr1 =function(){for (var xqgv4 in this.sqww7){for (var vwr7 in this.sqww7[xqgv4])
{for (var d03 in this.sqww7[xqgv4][vwr7]){this.sqww7[xqgv4][vwr7][d03].unload();delete this.sqww7[xqgv4][vwr7][d03];this.sqww7[xqgv4][vwr7][d03] = null;}this.sqww7[xqgv4][vwr7] = null;}this.sqww7[xqgv4] = null;}};
hrb3.prototype.unload =function(){if (this.map && this.map.pathLayer){t9.removeListener(this.map,"zoom",this.ynam5);this.map.pathLayer.removeChild(this.r5);}this.tmr1();this.sqww7 = null;};function lzz2(xl3,nocache){if (window.XMLHttpRequest){this.vk2 = new XMLHttpRequest();}else if (window.ActiveXObject){this.vk2 = new ActiveXObject("Microsoft.XMLHTTP");}this.xl3 = (akg8(xl3))?xl3:0; this.nocache =(akg8(nocache))?nocache:0;	}lzz2.prototype.setType =function (xl3){this.xl3 = xl3;};lzz2.prototype.setCacheAction =function (nocache){this.nocache = nocache;};lzz2.prototype.loadhttp =function(iqd9,bbjv4){var vk2 = this.vk2;var ueit7 = this.ueit7;var dvcx2 = new Array();
dvcx2.push(vk2);dvcx2.push(this.xl3);for(var i = 1;i<arguments.length;i++){dvcx2.push(arguments[i]);}vk2.open("GET", iqd9, true);vk2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");if (this.nocache){vk2.setRequestHeader("If-Modified-Since", "0");}vk2.onreadystatechange = function() {ueit7.apply(this,dvcx2)};vk2.send(null);};lzz2.prototype.ueit7 =function(vk2,xl3,bbjv4){if (vk2 == null || vk2.readyState != 4) return;if(vk2.responseText.length == 0) return;var dvcx2 = new Array();if (xl3==0){dvcx2.push(vk2.responseText);}else{dvcx2.push(vk2.responseXML);}for(var i = 3;i<arguments.length;i++){dvcx2.push(arguments[i]);}if (vk2.status!=200){dvcx2[0]=null;}bbjv4.apply(this,dvcx2);};function _simpleMap(wqw2,x,y,xqgv4,width,height,iqd9,targetWin){var spec = new NSpec();wqw2.style.position='relative';wqw2.style.width=width+"px";wqw2.style.height=height+"px";wqw2.style.overflow='hidden';wqw2.oncontextmenu=falseFunc;wqw2.onselectstart=falseFunc;wqw2.ondragstart=falseFunc;var ugll7 = spec.point2pixel(new x1(x,y),xqgv4);var left = Math.round(ugll7.x - width/2);var top = Math.round(ugll7.y + height/2);var right = Math.round(ugll7.x + width/2);var bottom = Math.round(ugll7.y - height/2);var tileSize = spec.tileSize;var xOffset = left % tileSize;var yOffset = tileSize - top % tileSize;if (akg8(iqd9) && iqd9!=''){var link;link = document.createElement("A");link.href = iqd9;wqw2.appendChild(link);wqw2 = link;if (akg8(targetWin) && targetWin!='')
{link.target = targetWin;}}for(var i=Math.floor(left/tileSize); i<=Math.floor(right/tileSize); i++){for(j=Math.floor(top/tileSize); j>=Math.floor(bottom/tileSize); j--){var epvp2 = o1.create(spec.getTileUrl(i,j,xqgv4),tileSize,tileSize,(i - Math.floor(left/tileSize))*tileSize - xOffset,(Math.floor(top/tileSize) - j)*tileSize - yOffset,0,wqw2);epvp2.border=0;}}}window.NMap = fikm0;window.NImage = o1;window.NEvent = t9;window.NPoint = x1;window.NSize = db8;window.NIcon = adlo5;window.NMark = ub8;window.NPolyline = hrb3;window.NNaverMark = ufqr1;window.NSaveBtn = w7;window.NPrintBtn = owv2;window.NZoomControl = njx5;window.NIndexMap = r4;window.NMiniMap = _miniMap;window.NXmlhttp = lzz2;window.NInfoWindow = s7;window.NInfoWindowSkin = zzqm4;window.NStaticOverlay = vyk6;window.NDynamicOverlay = _dynamicOverlay;window.NRectangle = _rectangle;window.NCircle = _circle;window.NSimpleMap = _simpleMap;}naverMap();
function NSpec(){this.tileSize = 256;this.minX = 0;this.maxX = 999999;this.minY = 0;this.maxY = 999999;this.minLevel = 1;this.maxLevel = 11;this.emptyTileUrl = 'http://static.naver.com/n/local/206/map/nvr/mapbg_sea.png';this.preTileUrl = 'http://static.naver.com/n/local/206/map/nvr/mapbg.png';this.baseMapUrl = 'http://imap.local.naver.com/themap/LEVEL';}NSpec.prototype.distancePerPixel =function (k38){return Math.pow(2, k38-1);};NSpec.prototype.getRowCount =function (k38){var rowImageCount = Math.ceil((this.maxX - this.minX)  / (Math.pow(2, k38-1)* this.tileSize));return rowImageCount;};NSpec.prototype.getColCount =function (k38){var colImageCount = Math.ceil((this.maxY - this.minY) / (Math.pow(2, k38-1)* this.tileSize));return colImageCount;};NSpec.prototype.getTileUrl =function (xIndex,yIndex,k38){var rowImageCount = this.getRowCount(k38);var colImageCount = this.getColCount(k38);if (xIndex<0 || yIndex<0 || xIndex>=rowImageCount || yIndex>=colImageCount){return this.emptyTileUrl;}var zero = "00000";var xDir = Math.floor(xIndex/100).toString();xDir = zero.substr(0,5-xDir.length)+xDir;var yDir = Math.floor(yIndex/100).toString();yDir = zero.substr(0,5-yDir.length)+yDir;var dir = xDir + "-"+ yDir;xIndex = xIndex.toString();xIndex = zero.substr(0,5-xIndex.length)+xIndex;yIndex = yIndex.toString();yIndex = zero.substr(0,5-yIndex.length)+yIndex;k38 = k38.toString();k38 = zero.substr(0,2-k38.length)+k38;var ry3 = this.baseMapUrl + k38 + "/" + dir + "/" + xIndex+"-"+yIndex +".png";return ry3;};NSpec.prototype.getOverlayUrl =function (xIndex,yIndex,k38){return "";};



NSpec.prototype.point2pixel =function (btl9,k38,xy9){if (btl9.x < 1000 && btl9.y<1000){var rPi = 0.017453292519943295769236907684886*btl9.y;
var rRa = 0.017453292519943295769236907684886*btl9.x;
var pisin = Math.sin(rPi);
var picos = Math.cos(rPi);
var rasin = Math.sin(rRa);
var racos =Math.cos(rRa);
var N = 6378137/Math.sqrt(1-0.006694380023*Math.pow(pisin,2));
var x = N*picos*racos;
var y = N*picos*rasin;
var z = N*0.993305619977*pisin;
x = 0.99999365785117869872075251249818*x -0.0000077181207516259621548395974995055*y -0.000011378548411314686763572580262666*z+199.93697229671405142927691940621;
y = 0.0000077182489540369321597844930023589*x + 0.9999936579489134788651988334656*y + 0.0000056334114236354349173011755576005*z -475.96134708077061386485589052705;
z = 0.000011378461449986070709082894738975*x -0.000005633587067558207380200534464914*y + 0.99999365787901312218869356114176*z-603.09853087125394807161980964984;
var p = Math.sqrt(x*x+y*y);
var se = Math.atan(z*1.0033539847638925564430562597465/p);
var rlat = 0.017453292519943295769236907684886*Math.atan((z+42707.885257228807440494917*Math.pow(Math.sin(se),3))/(p - 42565.122482506000045897475*Math.pow(Math.cos(se),3)))*57.295779513082320876798154814105;
var rlon = 0.017453292519943295769236907684886*(( Math.atan(y/x)*57.295779513082320876798154814105+180) % 180);
var cosLat = Math.cos(rlat);
var sinLat = Math.sin(rlat);
var tanLat = Math.tan(rlat);
var T = tanLat*tanLat;
var C = 0.0067192187991747599714330873895849*cosLat*cosLat;
var A = (rlon - 2.2340214425527418584623241836654)*cosLat;
var N = 6377397.155 / Math.sqrt(1-0.006674372231802145*sinLat*sinLat);
var M = 6366742.5202314743369239222465416*rlat - 15988.638531385768492064062332845*Math.sin(2*rlat) + 16.729953800426316723459165714505*Math.sin(4*rlat) - 0.02178477152380798738902016376989*Math.sin(6*rlat) + 0.000030766695473929338984277087438294*Math.sin(8*rlat) - 0.000000044343824227622457999678717675*Math.sin(10*rlat);
var X = 400000+0.9999*N*(A+Math.pow(A,3)/6*(1-T+C) + Math.pow(A,5)/120*(5-18*T+T*T+72*C-0.389714690352136022));
var Y = -3606656.9999754393786+0.9999*(M + N*tanLat*(A*A/2 + Math.pow(A,4)/24*(5-T+9*C+4*C*C)+Math.pow(A,6)/720*(58.9842343602475723-58*T+T*T+600*C)));
btl9 = new NPoint(Math.round(X),Math.round(Y));
}if (!xy9){xy9 = new NPoint();
}var distancePerPixel =	this.distancePerPixel(k38);
xy9.set(Math.round((btl9.x - this.minX)/distancePerPixel),Math.round((btl9.y - this.minY)/distancePerPixel));
return xy9;
};



NSpec.prototype.pixel2point =function (xy9,k38,btl9){if (!btl9){btl9 = new NPoint();}var distancePerPixel =	this.distancePerPixel(k38);btl9.set(Math.round(xy9.x*distancePerPixel)+this.minX,Math.round(xy9.y*distancePerPixel)+this.minY);return btl9;};NSpec.prototype.hasOverlay = falseFunc;