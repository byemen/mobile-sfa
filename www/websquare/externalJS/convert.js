var _mModeNMap=11
var _mModeGMap=12
var _mCoordNaver=21
var _mCoordGoogle=22


function NGcoord(cb,ao,bn,c){
this.bf(cb,ao,bn,c)}
NGcoord.prototype.bf=

function(cb,ao,bn,c){
this.ao=this.bn=this.longitude=this.latitude=""
if(cb==_mCoordGoogle){
this.latitude=ao
this.longitude=bn
this.c=18-c
if(this.c<1)this.c=1
if(this.c>11)this.c=11
}else if(cb==_mCoordNaver){
this.ao=ao
this.bn=bn
this.c=c}} 




NGcoord.prototype.getCoordNaver=

function(){
c=this.c
if(c>11)c=11
if(c<1)c=1
if(!this.ao||!this.bn){
y=cd(this.latitude,this.longitude)
this.ao=y.ao
this.bn=y.bn}
return{cx:this.ao,cy:this.bn,c:c}}
NGcoord.prototype.getCoordGoogle=

function(){
c=18-this.c
if(!this.latitude||!this.longitude){
y=cc(this.ao,this.bn)
this.latitude=y.a
this.longitude=y.e}
return{latitude:this.latitude,longitude:this.longitude,c:c}}
NGcoord.prototype.getZoom=

function(){
return this.c}


function NGMap(u,n,ca,bz,bc){
this.u=u
z=n.getCoordNaver()
this.ah=new NGcoord(_mCoordNaver,z.cx,z.cy,z.c)
this.n=n
this.ae=ca
this.ab=bz
this.bc=bc
this.ap=null
this.bb=null
this.ba=null}
NGMap.prototype.getCoordinates=

function(){return this.n;}
NGMap.prototype.getCurrentMapMode=

function(){return this.u;}
NGMap.prototype.getNGMapObject=

function(){return this.ap;}
NGMap.prototype.getNMapObject=

function(){return this.bb;}
NGMap.prototype.getGMapObject=

function(){return this.ba;}
NGMap.prototype.saveCoordinates=

function(){
if(this.u==_mModeNMap){
j=this.bb.getCenter()
this.n.bf(_mCoordNaver,j.x,j.y,this.ap.getZoom())
}else{
j=this.ba.getCenter()
this.n.bf(_mCoordGoogle,j.y,j.x,this.ap.getZoom())}}
NGMap.prototype.setCenterPoint=

function(id){
this.bd=id}
NGMap.prototype.showCenterPoint=

function(){
if(this.bd){
t=this.bd
t.style.display=""
t.style.top=(700-t.style.height)/2+"px"
t.style.left=(550-t.style.width)/2+"px"
alert(t.style.width)}}
NGMap.prototype.changeMap=

function(){
this.saveCoordinates()
if(this.u==_mModeNMap){
this.u=_mModeGMap
this.ae.style.display="none"
this.ab.style.display=""
}else{
this.u=_mModeNMap
this.ae.style.display=""
this.ab.style.display="none"}
this.makemap()
GEvent.trigger(this,"change")}
NGMap.prototype.makemap=

function(){
if(this.u==_mModeNMap){
this.ap=this.q()}
else if(this.u==_mModeGMap){
this.ap=this.p()
}else{
return-1}
return this.ap}
NGMap.prototype.q=

function(){
n=this.n.getCoordNaver()
var ao=n.cx
var bn=n.cy
var c=n.c
if(this.bb){
this.bb.setCenterAndZoom(new NPoint(ao,bn),c)
}else{
var aq=new NMap(this.ae)
var be=new NZoomControl()
be.setAlign("left")
aq.addOverlay(be)
aq.setCenterAndZoom(new NPoint(ao,bn),c)
var bo=new NInfoWindowSkin()
NEvent.addListener(bo,"mouseover",bo.showWindow)
NEvent.addListener(bo,"mouseout",

function(){bo.delayHideWindow(8000);})
aq.addOverlay(bo)
if(this.bc){
var aw=new NInfoWindow()
aq.addOverlay(aw)
aw.setOpacity(0.7)
var bj="<table cellpadding=5 cellspacing=0><tr><td nowrap style='background-color: #FF4009;color:#FFFFFF;font-size: 14px' ><b>"+this.bc+"</b></td></tr></table>"
z=this.ah.getCoordNaver()
aw.set(new NPoint(z.cx,z.cy),bj)
aw.showWindow()}
aq.addOverlay(new NSaveBtn())
var bx=new NPrintBtn()
bx.set(document.getElementById('mapShow'),document.getElementById('mapPrint'))
aq.addOverlay(bx)
var cm=new NMark(new NPoint(0,0),new NIcon('http://sstatic.naver.com/search/local/icon3/ico_arrow.gif',new NSize(27,39),new NSize(12,35)))
z=this.ah.getCoordNaver()
cm.setPoint(new NPoint(z.cx,z.cy))
cm.show()
aq.addOverlay(cm)
this.bb=aq}
return this.bb}
NGMap.prototype.p=

function(){
n=this.n.getCoordGoogle()
var latitude=n.latitude
var longitude=n.longitude
var c=n.c
if(this.ba){
this.ba.setCenter(new GLatLng(latitude,longitude),c,G_SATELLITE_TYPE)
}else{
var aq=new GMap2(this.ab)
aq.setCenter(new GLatLng(latitude,longitude),c,G_SATELLITE_TYPE)
aq.addControl(new GLargeMapControl())
z=this.ah.getCoordGoogle()
var bi=new GMarker(new GLatLng(z.latitude,z.longitude))
aq.addOverlay(bi)
if(this.bc){
var bj="<table cellpadding=5 cellspacing=0><tr><td nowrap style='font-size: 12px' ><b>"+this.bc+"</b></td></tr></table>"
bi.openInfoWindowHtml(bj)
GEvent.addListener(bi,"click",

function(){bi.openInfoWindowHtml(bj);})}
this.ba=aq}
return this.ba}




function cj(ds,dr,dq,dp,ag){
return ds*ag-dr*Math.sin(2.0*ag)+dq*Math.sin(4.0*ag)-dp*Math.sin(6.0*ag)}


function cu(ao){
return 1.0-0.25*ao*(1.0+ao/16.0*(3.0+1.25*ao))}


function ct(ao){
return 0.375*ao*(1.0+0.25*ao*(1.0+0.46875*ao))}


function cs(ao){
return 0.05859375*ao*ao*(1.0+0.75*ao)}


function cr(ao){
return ao*ao*ao*(35.0/3072.0)}


function dn(ao){
ad=1.0+ao
dg=1.0-ao
return Math.sqrt(Math.pow(ad,ad)*Math.pow(dg,dg))}


function cw(value){
if(Math.fabs(value)>1.0)value=(value>0?1:-1)
return Math.asin(value)}


function bg(ax,r,as){
if(as==1){
w=6378137.0
av=6356752.3142
var at=6377397.155
var bh=6356078.96325
}else{
at=6378137.0
bh=6356752.3142
w=6377397.155
av=6356078.96325}
var dc=128
var db=-481
var da=-664
bm=as*dc
bl=as*db
ci=as*da
ar=av/w
dw=1.0-ar
an=1.0-ar*ar
ch=at-w
cg=av/w-bh/at
df=w*(1.0-an)/Math.pow(1.0-an*Math.sin(r)*Math.sin(r),1.5)
cv=w/Math.sqrt(1.0-an*Math.sin(r)*Math.sin(r))
o=((((-bm*Math.sin(r)*Math.cos(ax)-bl*Math.sin(r)*Math.sin(ax))+ci*Math.cos(r))+ch*cv*an*Math.sin(r)*Math.cos(r)/w)+cg*(df/ar+cv*ar)*Math.sin(r)*Math.cos(r))/df
l=(-bm*Math.sin(ax)+bl*Math.cos(ax))/(cv*Math.cos(r))
cq=r+o
co=ax+l
return{e:co,a:cq}}
var d=6377397.155
var bk=6356078.96325
var b=0.9999
var x=2.23402144255274
var aa=0.663225115757845
var ai=600000.0
var ak=400000.0

/* 구글을 -> 네이버로 */
function cd(a,e){
au=bk/d
var v=1.0-au*au
var az=v/(1.0-v)
if(v<0.00001)m_dDstInd=1.0;else m_dDstInd=0.0
var dj=Math.sqrt(v)
var bw=cu(v)
var bv=ct(v)
var bu=cs(v)
var bt=cr(v)
var cf=d*cj(bw,bv,bu,bt,aa)
e=e*Math.PI/180.0
a=a*Math.PI/180.0
y=bg(e,a,1)
e=y.e
a=y.a
var am
var af,h
var cz,by
var dh,cl,m,cp
var ad,de,dl
am=e-x
af=Math.sin(a)
h=Math.cos(a)
if(m_dDstInd!=0){
dh=h*sin(am)
if((Math.abs(Math.abs(dh)-1.0))<0.0000000001){return-1;}}
else{
dh=0
ao=0.5*d*b*Math.log((1.0+dh)/(1.0-dh))
ad=Math.acos(h*Math.cos(am)/Math.sqrt(1.0-dh*dh))
if(a<0){
ad=-ad
bn=d*b*(ad-aa)}}
cz=h*am
by=cz*cz
cl=az*h*h
cp=Math.tan(a)
m=cp*cp
ad=1.0-v*af*af
de=d/Math.sqrt(ad)
dl=d*cj(bw,bv,bu,bt,a)
ao=b*de*cz*(1.0+by/6.0*(1.0-m+cl+by/20.0*(5.0-18.0*m+m*m+72.0*cl-58.0*az)))+ak
bn=b*(dl-cf+de*cp*(by*(0.5+by/24.0*(5.0-m+9.0*cl+4.0*cl*cl+by/30.0*(61.0-58.0*m+m*m+600.0*cl-330.0*az)))))+ai
return{ao:ao,bn:bn}}

/* 네이버를 -> 구글로 */
function cc(ao,bn){
au=bk/d
var i=1.0-au*au
var al=i/(1.0-i)
if(i<0.00001)m_dSrcInd=1.0;else m_dSrcInd=0.0
var di=Math.sqrt(i)
var bs=cu(i)
var br=ct(i)
var bq=cs(i)
var bp=cr(i)
var ce=d*cj(bs,br,bq,bp,aa)
var ad
var ag
var ay
var du
var af,h,k
var cl,dd,m,dx,de,dv,dm,cn
var dt,dy,dk,au
var ck=6
if(m_dSrcInd!=0){
dt=exp(ao/(d*b))
dk=0.5*(dt-1.0/dt)
au=aa+bn/(d*b)
dy=Math.cos(au)
ad=Math.sqrt((1.0-dy*dy)/(1.0+dk*dk))
a=cw(ad)
if(au<0)
a*=-1
if((dk==0)&&(dy==0))
e=x
else
e=Math.atan(dk/dy)+x}
ao-=ak
bn-=ai
ad=(ce+bn/b)/d
ag=ad
du=0
while(true){
ay=((ad+br*Math.sin(2.0*ag)-bq*Math.sin(4.0*ag)+bp*Math.sin(6.0*ag))/bs)-ag
ag=ag+ay
if(Math.abs(ay)<=0.0000000001)break
if(du>=ck)return-1
du++}
if(Math.abs(ag)<(Math.PI/2)){
af=Math.sin(ag)
h=Math.cos(ag)
k=Math.tan(ag)
cl=al*h*h
dd=cl*cl
m=k*k
dx=m*m
ad=1.0-i*af*af
de=d/Math.sqrt(ad)
dv=de*(1.0-i)/ad
dm=ao/(de*b)
cn=dm*dm
a=ag-(de*k*cn/dv)*(0.5-cn/24.0*(5.0+3.0*m+10.0*cl-4.0*dd-9.0*al-cn/30.0*(61.0+90.0*m+298.0*cl+45.0*dx-252.0*al-3.0*dd)))
e=x+(dm*(1.0-cn/6.0*(1.0+2.0*m+cl-cn/20.0*(5.0-2.0*cl+28.0*m-3.0*dd+8.0*al+24.0*dx)))/h)}
else{
a=Math.PI*0.5*Math.sin(bn)
e=x}
y=bg(e,a,-1)
return{e:y.e*180/Math.PI,a:y.a*180/Math.PI}}
