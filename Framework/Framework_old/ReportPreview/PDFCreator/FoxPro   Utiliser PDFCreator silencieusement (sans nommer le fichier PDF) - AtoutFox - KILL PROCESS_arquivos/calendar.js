function calendar(DD){
  this.Version="1.3.002";
  this.cg="Cliquez ici pour afficher le calendrier";
  this.ec=0;
  this.op=0;
  this.nU=0;
  this.CL=new o(DD);
  this.ps=new Date();
  this.uC=this.ps.getFullYear();
  this.mw=glbCalendars.length;
  this.mU=Array(43);
  this.aryMonths=Array("Jan","Fév","Mar","Avr","Mai","Jui","Jui","Aou","Sep","Oct","Nov","Déc");
  this.aryDays=Array("D", "L","M","M","J","V","S","D");
  this.FullMonthNames=['Janvier','Févirer','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre'];
  this.FullDayNames=['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'];
  this.Aa="Veuillez sélectionner une date future";
  glbCalendars[glbCalendars.length]=this;
  this.kG="caldiv_"+this.mw;
  this.kb=false;
  this.xU=null;
  this.oL=null;
  this.dD=false;
  this.Ld=false;
  this.YC=0;
  this.GG=0;
  this.wT={ih:0,sT:0,VK:0,Ne:0};
  this.wX={ih:0,sT:0,VK:0,Ne:0};
  this.QZ={ih:0,sT:0,VK:0,Ne:0};
  this.Td="";
  this.Ka=false;
  var q=(navigator.userAgent.toLowerCase().indexOf("opera")!=-1);
  this.Pf=q?"title":"alt";
  this.GB=Array(3);
  this.li="";
  this.sL=null;
  this.sD=null;
  this.CU=null;
  this.OZ=this.CL.kW("FIELD")?eval(this.CL.kW("FIELD")):null;
  this.nW=this.CL.kW("FORMAT")?this.CL.kW("FORMAT"):"1";
  this.Yn=this.CL.kW("DELIMITER")?this.CL.kW("DELIMITER"):"/";
  this.wH=false;
  switch(this.nW){case "1": this.sc="DD"+this.Yn+"MM"+this.Yn+"YYYY";break;case "2": this.sc="YYYY"+this.Yn+"M"+this.Yn+"D";break;default:this.sc="M"+this.Yn+"D"+this.Yn+"YYYY";}
  this.pX=true;
  this.WN=false;
  this.KF=true;
  this.GU=2000;
  this.AV=1;
  this.sk=null;
  this.xK=null;
  this.nm=1;
  this.KL=1;
  this.IS=false;
  this.rx=true;
  this.ch=0;
  this.GA="basic";
  this.hi=0;
  if(this.CL.kW("ZEROS")) this.Td+="ZEROS\n";
  if(this.CL.kW("MOUSEOVER")) this.Td+="MOUSEOVER\n";
  if(this.CL.kW("SHOWDAYS")) this.Td+="SHOWDAYS\n";
  if(this.CL.kW("DELAY")) this.Td+="DELAY\n";
  if(this.CL.kW("BEGINONMONDAY")) this.Td+="BEGINONMONDAY\n";
  if(this.CL.kW("ICONLEFT")) this.Td+="ICONLEFT\n";
  if(this.CL.kW("ICONTOP")) this.Td+="ICONTOP\n";
  if(this.CL.kW("DIR")) this.Td+="DIR\n";
  if(this.CL.kW("MONTH")) this.Td+="MONTH\n";
  if(this.CL.kW("SHADOW")) this.Td+="SHADOW\n";
  if(this.CL.kW("CLOSE")) this.Td+="CLOSE\n";
  if(this.CL.kW("YEAR")) this.Td+="YEAR\n";
  if(this.CL.kW("MOVEMODE")) this.Td+="MOVEMODE\n";
  if(this.CL.kW("INVALID")) this.Td+="INVALID\n";
  var p;
  if(this.GA){if(this.GA.indexOf("/")>=0){p=this.GA.split("/");this.OA=p[p.length-1];}else{this.OA=this.GA?this.GA:"basic";}}else{this.OA=this.GA?this.GA:"basic";}this.QG=QG;this.JE=JE;this.Mh=Mh;this.rI=rI;this.DI=DI;this.IW=IW;this.FQ=FQ;this.ea=ea;this.WK=WK;this.PT=PT;this.rq=rq;this.HA=HA;this.Yh=Yh;this.wo=wo;this.wg=wg;this.Cj=Cj;this.tI=tI;this.QY=QY;this.writeCalendar=writeCalendar;this.dV=dV;this.xi=xi;this.cG=cG;this.ho=ho;this.nl=nl;this.qe=qe;this.rC=rC;this.PW=PW;this.sC=sC;this.cd=cd;this.OK=OK;this.kV=kV;this.EV=EV;this.me=me;this.eM=eM;this.Sl=Sl;this.setField=setField;this.RN=RN;f=this;

  function __PUBLIC__(){}
  function setField(W){if(f.OZ) f.OZ.value=RN(W);}
  function writeCalendar(){  var A; A=document.all?"onClick":"onMouseDown";var n=(document.all&&!document.getElementById)?"width:20;":"";var v=f.WN?"onMouseOver":A;var G;G=f.IS?"filter: progid:DXImageTransform.Microsoft.DropShadow(color=#777788,direction=135,strength=2);":"";var U=f.xK?"top:"+f.xK+";":"";U+=f.sk?"left:"+f.sk+";":"";U+=U.length>0?"position: absolute;":"";f.QY(); document.write("<img src='js/calendar/calendar.gif' border='0' align='top' style='vertical-align:middle;cursor:hand;"+U+"' "+v+"='glbCalendars["+f.mw+"].Sl();glbCalendars["+f.mw+"].QG(event);if (window.event)window.event.cancelBubble=true;' title='"+f.cg+"'>");  document.write("<div id='"+f.kG+"' ");document.write("onMouseOut='glbCalendars["+f.mw+"].PW();' ");document.write("style='"+G+n+"position:absolute;display:none;' class='"+f.OA+"-cl-body'> "); document.write(f.qe()); document.write("</div>"); if(f.KL){document.write("<div id='"+f.kG+"_year' ");document.write("onMouseOut='glbCalendars["+f.mw+"].PW();' ");document.write("onMouseOver='glbCalendars["+f.mw+"].rq(this);' ");document.write("style='position:absolute;display:none;background-color:white;'> "); document.write(f.nl()); document.write("</div>");} if(f.nm){document.write("<div id='"+f.kG+"_month' ");document.write("onMouseOut='glbCalendars["+f.mw+"].sC();' ");document.write("onMouseOver='glbCalendars["+f.mw+"].rq(this);' ");document.write("style='position:absolute;display:none;background-color:white;'> "); document.write(f.ho()); document.write("</div>");} document.write("<IFRAME src=\"javascript:false;\" style='DISPLAY: none; LEFT: 0px; POSITION: absolute; TOP: 0px;COLOR: #FFFFFF;BACKGROUND-COLOR: #FFFFFF;' frameBorder='0' scrolling='no' id='"+f.kG+"_ghost'></IFRAME>\n");document.write("<IFRAME src=\"javascript:false;\" style='DISPLAY: none; LEFT: 0px; POSITION: absolute; TOP: 0px;COLOR: #FFFFFF;BACKGROUND-COLOR: #FFFFFF;' frameBorder='0' scrolling='no' id='"+f.kG+"_ghost_mo'></IFRAME>\n");document.write("<IFRAME src=\"javascript:false;\" style='DISPLAY: none; LEFT: 0px; POSITION: absolute; TOP: 0px;COLOR: #FFFFFF;BACKGROUND-COLOR: #FFFFFF;' frameBorder='0' scrolling='no' id='"+f.kG+"_ghost_year'></IFRAME>\n");}
  function __DISPLAY__(){}
  function QG(t){var l,O,d; var W; t=b(t); d=f.rC(t); a(); if(hr) f.wH=true; if(document.getElementById){l=document.getElementById(f.kG);if(f.wH) O=document.getElementById(f.kG+"_ghost");}else if(document.all){l=document.all[f.kG];if(f.wH) O=document.all[f.kG+"_ghost"];}else l=document.layers[f.kG];f.xU=l;f.oL=O;if(f.Ld){if(f.wH){f.EV(O,l);O.style.display="block";}return false;}f.wo();clearInterval(f.sL); for(var s=0;s<glbCalendars.length;s++){if(glbCalendars[s]==f) glbCalendars[s].kb=true;else glbCalendars[s].kb=false;if(!glbCalendars[s].kb){glbCalendars[s].JE();}}if(l){l.style.zIndex=++iK; l.style.display="block";if(!f.YC){f.kV(l,d);}f.Ld=true;f.wT=h(l);if(f.wH){O.style.display="block";f.EV(O,l);}if(window.event){window.event.cancelBubble=true;window.event.returnValue=false;}}return false;}
  function IW(t){var l,F,H,O,d=f.rC(t);if(f.dD) return false;clearInterval(f.sL);if(document.getElementById){l=document.getElementById(f.kG);F=document.getElementById(f.kG+"_month");if(f.wH) O=document.getElementById(f.kG+"_ghost_mo");}else if(document.all){l=document.all[f.kG];F=document.all[f.kG+"_month"];if(f.wH) O=document.all[f.kG+"_ghost_mo"];}else{l=document.layers[f.kG];F=document.layers[f.kG+"_month"];}f.Mh();if(l){F.style.display="block";F.style.zIndex=++iK;f.me(l,F );f.wX=h(F);if(f.wH){f.EV(O,F );O.style.display="block";}}}
  function DI(t){var l,M,H,d=f.rC(t);if(f.dD) return false;clearInterval(f.sL);if(document.getElementById){l=document.getElementById(f.kG);M=document.getElementById(f.kG+"_year");if(f.wH) O=document.getElementById(f.kG+"_ghost_year");}else if(document.all){l=document.all[f.kG];M=document.all[f.kG+"_year"];if(f.wH) O=document.all[f.kG+"_ghost_year"];}else{l=document.layers[f.kG];M=document.layers[f.kG+"_year"];}f.rI();if(l){M.style.display="block";f.eM(l,M );M.style.zIndex=++iK;f.QZ=h(M);if(f.wH){f.EV(O,M );O.style.display="block";}}}
  function JE(){var l,O;if(!f.Ld) return false;if(document.getElementById){l=document.getElementById(f.kG).style;if(f.wH) O=document.getElementById(f.kG+"_ghost").style;}else if(document.all){l=document.all[f.kG].style;if(f.wH) O=document.all[f.kG+"_ghost"].style;}else{l=document.layers[f.kG];}if(l){l.display="none";if(f.wH) O.display="none";}if(f.KL) f.Mh();if(f.nm) f.rI();f.Ld=false;clearInterval(f.sL);}
  function rI(){var F,O;if(document.getElementById){F=document.getElementById(f.kG+"_month");if(F) F=F.style;if(f.wH) O=document.getElementById(f.kG+"_ghost_mo").style;}else if(document.all){F=document.all[f.kG+"_month"];if(F) F=F.style;if(f.wH) O=document.all[f.kG+"_ghost_mo"].style;}else{F=document.layers[f.kG+"_month"];}if(F){F.display="none";f.wX={ih:0,sT:0,VK:0,Ne:0};if(f.wH) O.display="none";}}
  function Mh(){var M,O;if(document.getElementById){M=document.getElementById(f.kG+"_year");if(M) M=M.style;if(f.wH) O=document.getElementById(f.kG+"_ghost_year").style;}else if(document.all){M=document.all[f.kG+"_year"];if(M) M=M.style;if(f.wH) O=document.all[f.kG+"_ghost_year"].style;}else{M=document.layers[f.kG+"_year"];}if(M){M.display="none";f.QZ={ih:0,sT:0,VK:0,Ne:0};if(f.wH) O.display="none";}}
  function __EVENTS__(){}
  function rq(argCell){clearInterval(f.sL);if(argCell.className==f.OA+"-cl-on-month") argCell.className=f.OA+"-cl-on-month-lit";else if(argCell.className==f.OA+"-cl-off-month") argCell.className=f.OA+"-cl-off-month-lit";else if(argCell.className==f.OA+"-cl-year") argCell.className=f.OA+"-cl-year-lit";}
  function HA(argCell){if(argCell.className==f.OA+"-cl-on-month-lit") argCell.className=f.OA+"-cl-on-month";else if(argCell.className==f.OA+"-cl-off-month-lit") argCell.className=f.OA+"-cl-off-month";else if(argCell.className==f.OA+"-cl-year-lit") argCell.className=f.OA+"-cl-year";}
  function FQ(){f.ps.setMonth(++f.op);QY();Yh(f.kG,qe());}
  function WK(){f.uC+=10;Yh(f.kG+"_year",nl());}
  function ea(){f.ps.setMonth(--f.op);QY();Yh(f.kG,qe());}
  function PT(){f.uC-=10;Yh(f.kG+"_year",nl());}
  function dV(td){var K=new Date(td.getAttribute(f.Pf));if(f.hi==1&&Date.parse(K.toLocaleString())<Date.parse(f.RN(Date()))){alert(f.Aa);}else if(f.hi==2&&Date.parse(K.toLocaleString())<=Date.parse(f.RN(Date()))){alert(f.Aa);}if(f.OZ) f.OZ.value=f.RN(K);if(f.rx) f.JE();f.li=f.OZ.value;}
  function cG(intYear,ob){f.ps.setFullYear(intYear);QY();Yh(f.kG,qe());f.kb=true;f.Mh(); if(window.event) event.cancelBubble=true;else ob.stopPropagation();}
  function xi(intMonth,ob){f.ps.setMonth(intMonth);QY();Yh(f.kG,qe());f.kb=true;f.rI(); if(window.event) event.cancelBubble=true;else ob.stopPropagation();}
  function __INTERNAL__(){}
  function RN(W){I=[ 'st','nd','rd','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','st','nd','rd','th','th','th','th','th','th','th','st' ];var C=f.sc;var V='DMYHdhmst'.split('' );var Q=new Array();var L=0;var E;var N=/\[(\d+)\]/;var Z=new Date(W);var R=Z.getDay();var T=Z.getDate();var u=Z.getMonth();var w=Z.getFullYear().toString();var Y=Z.getHours();var g=Z.getMinutes();var B=Z.getSeconds();var X=new Object();X[ 'D' ]=T;X[ 'd' ]=T+I[ T-1 ];X[ 'DD' ]=(T<10 )?'0'+T:T;X[ 'DDD' ]=f.FullDayNames[ R ].substring(0,3 );X[ 'DDDD' ]=f.FullDayNames[ R ];X[ 'M' ]=u+1;X[ 'MM' ]=(u+1<10 )?'0'+(u+1 ):u+1;X[ 'MMM' ]=f.FullMonthNames[ u ].substring(0,3 );X[ 'MMMM' ]=f.FullMonthNames[ u ];X[ 'Y' ]=(w.charAt(2 )=='0' )?w.charAt(3 ):w.substring(2,4 );X[ 'YY' ]=w.substring(2,4 );X[ 'YYYY' ]=w; for(var s=0;s<V.length;s++){E=new RegExp('('+V[ s ]+'+)' );while(E.test(C ) ){Q[ L ]=RegExp.$1;C=C.replace(RegExp.$1,'['+L+']' );L++;}}while(N.test(C ) ){C=C.replace(N,X[ Q[ RegExp.$1 ] ] );}return C;}
  function wo(){f.xU.onmousedown=f.wg;if(isNaN(parseInt(f.xU.style.left))) f.xU.style.left="0px";if(isNaN(parseInt(f.xU.style.top))) f.xU.style.top="0px";f.xU.qa=new Function();f.xU.TZ=new Function();f.xU.fA=new Function();}
  function wg(J){J=b(J);var sT=parseInt(f.xU.style.top);var ih=parseInt(f.xU.style.left);f.rI();f.Mh();f.xU.qa(ih,sT);f.dD=true;if(f.ch){f.YC=J.clientX;f.GG=J.clientY;f.Ka=false;}document.onmousemove=f.Cj;document.onmouseup=f.tI;return false;}
  function Cj(J){J=b(J);var Ff=J.clientY;var vX=J.clientX;var sT=parseInt(f.xU.style.top);var ih=parseInt(f.xU.style.left);var nC,iN;nC=ih+(vX-f.YC);iN=sT+(Ff-f.GG);if(f.ch>0){if(!f.Ka){f.xU.style.filter="progid:DXImageTransform.Microsoft.Alpha(opacity=60);";if(f.xU.style.cursor) f.xU.style.cursor="move";f.Ka=true;}f.xU.style["left"]=nC+"px";f.xU.style["top"]=iN+"px";f.YC=vX;f.GG=Ff;if(f.oL) f.oL.style.display="none";}f.xU.fA(nC,iN);return false;}
  function tI(){document.onmousemove=null;document.onmouseup=null;f.xU.TZ(parseInt(f.xU.style["left"]),parseInt(f.xU.style["top"]));if(f.ch){f.xU.style.filter="";if(f.xU.style.cursor) f.xU.style.cursor="arrow";f.wT=h(f.xU);if(f.oL){f.EV(f.oL,f.xU);f.oL.style.display="block";}if(f.ch>1){f.YC=0;f.GG=0;}}f.dD=false;}
  function QY(){var ut,Ep=0;var wh,ju;var Rx=f.ps;var s,rd=1;f.ec=Rx.getDate();f.op=Rx.getMonth();f.nU=Rx.getFullYear();ut=new Date(f.nU,f.op,1);  Ep-=ut.getDay()>0?ut.getDay():ut.getDay()+7;for(s=0;s<43;s++){f.mU[s]=new Date(ut.getFullYear(),ut.getMonth(),++Ep);}}
  function ho(){var innerHTML="";innerHTML+="<table cellspacing=0 cellpadding=0 border=0>";innerHTML+="<tr>";for(var s=0;s<12;s++){ if(s % 6==0) innerHTML+="</tr><tr>";innerHTML+="<td class='"+f.OA+"-cl-year' onMouseOver='glbCalendars["+f.mw+"].rq(this);' onMouseOut='glbCalendars["+f.mw+"].HA(this);' style='cursor: hand; cursor: pointer;' onClick='glbCalendars["+f.mw+"].xi("+s+",event);'>";innerHTML+=f.aryMonths[s];innerHTML+="</td>";}innerHTML+="</tr>";innerHTML+="</table>";return innerHTML;}
  function nl(){var innerHTML="";innerHTML+="<table cellspacing=0 cellpadding=0 border=0>";innerHTML+="<tr>";innerHTML+="<td class='"+f.OA+"-cl-year' onMouseOver='glbCalendars["+f.mw+"].rq(this);' onMouseOut='glbCalendars["+f.mw+"].HA(this);' style='cursor: hand; cursor: pointer;' onMouseDown='glbCalendars["+f.mw+"].WK();' align='center' valign='center'>";innerHTML+="<img src='js/calendar/up.gif' border='0'>";innerHTML+="</td>";innerHTML+="</tr>";for(var s=parseInt(f.uC);s>parseInt(f.uC)-10;s--){innerHTML+="<tr>";innerHTML+="<td class='"+f.OA+"-cl-year' onMouseOver='glbCalendars["+f.mw+"].rq(this);' onMouseOut='glbCalendars["+f.mw+"].HA(this);' style='cursor: hand; cursor: pointer;' onClick='glbCalendars["+f.mw+"].cG("+s+",event);'>";innerHTML+=s;innerHTML+="</td>";innerHTML+="</tr>";}innerHTML+="<tr>";innerHTML+="<td class='"+f.OA+"-cl-year' onMouseOver='glbCalendars["+f.mw+"].rq(this);' onMouseOut='glbCalendars["+f.mw+"].HA(this);' style='cursor: hand; cursor: pointer;' onMouseDown='glbCalendars["+f.mw+"].PT();' align='center' valign='center'>";innerHTML+="<img src='js/calendar/down.gif' border='0'>";innerHTML+="</td>";innerHTML+="</tr>";innerHTML+="</table>";return innerHTML;}
  function qe(){var innerHTML="";var p,jW,FW="none",nq="none";var hg; innerHTML+="<table cellspacing=0 cellpadding=0 border=0 id='cal'>"; innerHTML+="<tr class='"+f.GA+"-header-row'>"; innerHTML+="<td style='border:0' align='left' class='"+f.OA+"-cl-header' onMouseOver='glbCalendars["+f.mw+"].rq(this);'>"; innerHTML+="<img src='js/calendar/prev.gif' border='0' onClick='window.event.returnValue=false;return false;' onMouseDown='glbCalendars["+f.mw+"].ea();return false;' style='cursor:hand;cursor:pointer;'>"; innerHTML+="</td>";innerHTML+="<td style='border:0' align='center' class='"+f.OA+"-cl-header' onMouseOver='glbCalendars["+f.mw+"].rq(this);'>"; if(f.nm==2) FW="onMouseOver";else if(f.nm==1) FW="onClick"; innerHTML+="<span class='"+f.OA+"-cl-header' "+FW+"='return glbCalendars["+f.mw+"].IW(event);' "+(FW=="none"?"style='cursor:default;'":"style='cursor:hand;cursor:pointer;text-decoration:underline;'")+">";innerHTML+=f.aryMonths[f.op]; innerHTML+="</span>&nbsp;"; if(f.KL==2) nq="onMouseOver";else if(f.KL==1) nq="onClick"; innerHTML+="<span class='"+f.OA+"-cl-header' "+nq+"='return glbCalendars["+f.mw+"].DI(event);' "+(nq=="none"?"style='cursor:default;'":"style='cursor:hand;cursor:pointer;text-decoration:underline;'")+">";innerHTML+=f.nU;innerHTML+="</span>"; innerHTML+="</td>"; innerHTML+="<td style='border:0' align='right' class='"+f.OA+"-cl-header' onMouseOver='glbCalendars["+f.mw+"].rq(this);'>";innerHTML+="<img src='js/calendar/next.gif' border='0' onClick='window.event.returnValue=false;return false;' onMouseDown='glbCalendars["+f.mw+"].FQ();return false;' style='cursor:hand;cursor:pointer;'>";innerHTML+="</td>"; innerHTML+="</tr>"; innerHTML+="<tr>"; innerHTML+="<td colspan=4 style='background-color:white;'>"; innerHTML+="<table cellspacing=0 cellpadding=0 border=0 class=basic-cl-table>"; if(f.KF){innerHTML+="<tr class='"+f.OA+"-cl-days'>";for(var ih=0;ih<7;ih++){innerHTML+="<td class='"+f.OA+"-cl-day' onMouseOver='glbCalendars["+f.mw+"].rq(this);' onMouseOut='glbCalendars["+f.mw+"].HA(this);'>";innerHTML+=f.aryDays[f.AV+ih];innerHTML+="</td>";}innerHTML+="</tr>";} for(var s=1;s<42;){ innerHTML+="<tr>"; for(var rd=0;rd<7;++rd,s++){hg=RN(f.mU[s-1+f.AV]);jW=f.mU[s-1+f.AV].toGMTString(); p=f.mU[s-1+f.AV].getMonth()==f.op?"cl-on-month":"cl-off-month";if(f.hi==1&&Date.parse(f.mU[s-1+f.AV])<Date.parse(f.RN(Date()))){p=" "+f.OA+"-old";}else if(f.hi==2&&Date.parse(f.mU[s-1+f.AV])<=Date.parse(f.RN(Date()))){p=" "+f.OA+"-old";}else if(new Date(f.nW=="1"?r(f.OZ.value):f.OZ.value).toGMTString()==jW){p=" "+f.OA+"-tgt";}
  innerHTML+="<td class='"+f.OA+"-"+p+"' onMouseOver='glbCalendars["+f.mw+"].rq(this);' onMouseOut='glbCalendars["+f.mw+"].HA(this);' title='"+hg+"' style='cursor: hand; cursor: pointer; "+(aujourdhui(f.mU[s-1+f.AV])?"font-weight:bold;border:2px solid green;":"")+"' "+f.Pf+"='"+jW+"' onClick='glbCalendars["+f.mw+"].dV(this);'>"; innerHTML+=f.mU[s-1+f.AV].getDate(); innerHTML+="</td>";} innerHTML+="</tr>";}  innerHTML+="</table>"; innerHTML+="</td>"; innerHTML+="</tr>"; innerHTML+="</table>"; return(innerHTML);}

  function Yh(layerID,txt){if(document.getElementById){document.getElementById(layerID ).innerHTML=txt;}else if(document.all){document.all[layerID].innerHTML=txt;}else if(document.layers){with(document.layers[layerID].document){open();write(txt );close();}}return null;}
  function rC(J){var vJ=0;var Fv=0;if(!J) J=window.event;if(J){if(J.pageX||J.pageY){vJ=J.pageX;Fv=J.pageY;}else if(J.clientX||J.clientY){vJ=J.clientX+document.body.scrollLeft;Fv=J.clientY+document.body.scrollTop;}}var lc={ih:vJ,sT:Fv};return lc;}
  function PW(){if(f.sL){clearInterval(f.sL);f.sL=null;}f.sL=setInterval("glbCalendars["+f.mw+"].JE()",f.GU );}
  function sC(){if(f.CU){clearInterval(f.CU);f.CU=null;}f.CU=setInterval("glbCalendars["+f.mw+"].rI()",4000 );f.PW();}
  function cd(){if(f.sD){clearInterval(f.sD);f.sD=null;}f.sD=setInterval("glbCalendars["+f.mw+"].Mh()",4000 );f.PW();}
  function OK(int_num){var lc;if(int_num<=9){lc=f.pX?"0"+int_num:int_num;}else lc=int_num;return lc;}
  function kV(l,mouse_xy){var cn=h(l );var MV=c();if(cn["VK"]+mouse_xy["ih"]>MV["ih"]){l.style.left=mouse_xy["ih"]-cn["VK"];}else l.style.left=mouse_xy["ih"];if(cn["Ne"]+mouse_xy["sT"]>MV["sT"]) l.style.top=mouse_xy["sT"]-cn["Ne"];else l.style.top=mouse_xy["sT"];if(l.style.top<=0) l.style.top=1;if(l.style.left<=0) l.style.left=1;}
  function EV(ghost,l){var cn=h(l );if(cn.ih>0){ghost.style.left=cn.ih;ghost.style.top=cn.sT;ghost.style.width=cn.VK;ghost.style.height=cn.Ne;ghost.style.zIndex=0;ghost.style.filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';}}
  function me(l,mo){var AL=h(l );var cn=h(mo );var MV=c();var ru=AL["VK"] / 2;var cr=cn["VK"] / 2;var TY=AL["ih"]-(cr-ru);var Ta=AL["Ne"]+AL["sT"];mo.style.left=TY;if(Ta+cn["Ne"]>MV["sT"]) mo.style.top=Ta-cn["Ne"];else mo.style.top=Ta;}
  function eM(l,yr){var AL=h(l );var kD=h(yr );var MV=c();if(kD["VK"]+AL["ih"]+AL["VK"]>MV["ih"]) yr.style.left=MV["ih"]-kD["VK"];else yr.style.left=AL["ih"]+AL["VK"];if(kD["Ne"]+AL["sT"]>MV["sT"]) yr.style.top=AL["sT"];else yr.style.top=AL["sT"];}
  function Sl(){W=new Date(f.nW=="1"?r(f.OZ.value):f.OZ.value);if(isNaN(W)) f.ps=new Date();else f.ps=W;QY();Yh(f.kG,qe());}var f;}
  function m(){}
  function o(DD){this.Kp=new Array();this.lD=new Array();this.ux=ux;this.kW=kW;ux(DD,this );
  function ux(argStr,argConfig){var s,Sa;var BM,Uh;if(argStr) Sa=argStr.split(";");else return;var BM,Im,Wd;for(s=0;s<Sa.length;s++){Wd=Sa[s].indexOf(":");if(Wd>0){BM=Sa[s].substring(0,Wd).toUpperCase();Uh=Sa[s].substring(Wd+1,Sa[s].length);if(Uh.toLowerCase()=="true") Uh=true;else if(Uh.toLowerCase()=="false") Uh=false;argConfig.lD[s]=BM;argConfig.Kp[s]=Uh;}}}
  function kW(argKey){var s;for(s=0;s<this.lD.length;s++){if(this.lD[s]==argKey){return this.Kp[s];}}return null;}}
  function P(t){var GJ=false;var pV={ih:0,sT:0};if(window.event){pV.ih=event.clientX+document.body.scrollLeft;pV.sT=event.clientY+document.body.scrollTop;}else if(t){pV.ih=t.pageX;pV.sT=t.pageY;}for(var s=0;s<glbCalendars.length;s++){if(!k(pV,glbCalendars[s].wT)&&!k(pV,glbCalendars[s].wX)&&!k(pV,glbCalendars[s].QZ)){glbCalendars[s].JE();}else GJ=true;glbCalendars[s].kb=false;}}
  function k(gA,wT){if((gA.ih>wT.ih&&gA.ih<wT.ih+wT.VK)&&(gA.sT>wT.sT&&gA.sT<wT.sT+wT.Ne)) return true;return false;}
  function h(No){var UN={ih:0,sT:0,VK:0,Ne:0};if(No!=null){UN.Ne=No.offsetHeight;UN.VK=No.offsetWidth;while(No){UN.ih+=No.offsetLeft;UN.sT+=No.offsetTop;No=No.offsetParent;}return(UN);}}
  function c(){var UN={ih:0,sT:0};if(document.body.clientWidth){UN.ih+=document.body.clientWidth;UN.sT+=document.body.clientHeight;}else if(window.innerWidth){UN.ih+=window.innerWidth;UN.sT+=window.innerHeight;}return(UN);} var Sc="";if(typeof(document.media)=='string'&&document.getElementById&&document.all) Sc="ie6";else if(document.getElementById&&document.all) Sc="ie5";else if(document.getElementById&&!document.all) Sc="ns6";else if(document.all) Sc="ie4";else if(document.layers) Sc="ns4";else Sc="other";var iK=9999;switch(Sc){case "ie5":case "ie6":if(document.attachEvent) document.attachEvent('onclick',P );break;case "ns6": break;case "ns4":break;}
  function b(J){if(typeof J=='undefined') J=window.event;if(J){if(typeof J.layerX=='undefined') J.layerX=J.offsetX;if(typeof J.layerY=='undefined') J.layerY=J.offsetY;}return J;}
  function a(){if(Sc=="ie6"&&!window.opera){if(!document.getElementsByTagName("select")) hr=false;else hr=true;}else hr=false;}
  function r(TG){var S=TG,D;S=S.replace(/(\d+).(\d+).(\d+)/,'$3/$2/$1');S=S.replace(/^(\d\d\/)/,'20$1');D=new Date(S);return D;}      var glbCalendars=Array();var hr=Array();

  // Renvoie true si la date est aujourd'hui
  function aujourdhui($date)
  {
    var $hoy = new Date();
    return $hoy.getFullYear() == $date.getFullYear() && $hoy.getMonth() == $date.getMonth() && $hoy.getDate() == $date.getDate();
  }