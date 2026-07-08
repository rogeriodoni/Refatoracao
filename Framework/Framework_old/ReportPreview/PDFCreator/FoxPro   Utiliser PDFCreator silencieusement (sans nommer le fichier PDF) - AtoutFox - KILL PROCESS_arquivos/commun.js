var $ie = navigator.appVersion.indexOf("MSIE") > 0;

var $ieVersion = 0;
if($ie)
  var $ieVersion = getIeVersion();

// Renvoie la version de IE
function getIeVersion() {
  var $arVersion = navigator.appVersion.split("MSIE");
  return parseFloat($arVersion[1]);
}

// Cache un élément
function cacher($element) {
  if(typeof($element) == "string")
    $element = document.getElementById($element);
  $element.style.display = "none";
}

// Montre un élément
function montrer($element) {
  if(typeof($element) == "string")
    $element = document.getElementById($element);
  $element.style.display = "block";
}

// Pour l'horloge digitale
function heureDigitale($element) {
  var $date = new Date();
  $element.innerHTML = $date.getHours().toString() + ":" + ($date.getMinutes() < 10 ? "0": "") + $date.getMinutes().toString();
  setTimeout("heureDigitale(document.all." + $element.id + ")", 60000);
}

// Centre un élément sur l'explorateur ouvert
function centrer($element) {
 $element.style.left = document.body.scrollLeft + (document.body.clientWidth - $element.clientWidth) / 2;
 $element.style.top = document.body.scrollTop + (document.body.clientHeight - $element.clientHeight) / 2;
}

// Joue un son
function jouerSon($wav) {
  document.write("<embed src='/sons/" + $wav + "' hidden=true autostart=true loop=false></embed>");
}

// Etend automatiquement des textareas en hauteur en fonction de leurs contenus
// $maxrows : integer (hauteur maximum jusqu'à laquelle la TEXTAREA s'étend)
function textAreaExtend($textArea, $maxHeight, $minHeight) {
  if($textArea.style.height == "" || parseInt($textArea.style.height) <= $maxHeight) {
    $textArea.style.height = $textArea.value.split("\n").length * 20;
    if($textArea.style.height == "2px")
      $textArea.style.height = 100;
    if(parseInt($textArea.style.height) < $minHeight)
      $textArea.style.height = $minHeight;
    if(parseInt($textArea.style.height) > $maxHeight)
      $textArea.style.height = $maxHeight;
  }
}

// Encode une chaîne pour la passer dans une url
function urlEncode($plainText) {
  $plainText = $plainText.toString();
	var $safeChars = "0123456789" +
                   "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
                   "abcdefghijklmnopqrstuvwxyz" +
                   "-_.!~*'()";
	var $hex = "0123456789ABCDEF";
	var $encoded = "";
	for (var $i = 0; $i < $plainText.length; $i++) {
		var $ch = $plainText.charAt($i);
	    if ($ch == " ") {
		    $encoded += "+";
		} else if ($safeChars.indexOf($ch) != -1) {
		    $encoded += $ch;
		} else {
		    var $charCode = $ch.charCodeAt(0);
			if ($charCode > 255) {
				$encoded += "+";
			} else {
				$encoded += "%";
				$encoded += $hex.charAt(($charCode >> 4) & 0xF);
				$encoded += $hex.charAt($charCode & 0xF);
			}
		}
	}
	return $encoded;
}

// Pour afficher un popup
function popup($id, $url, $width, $height) {
  window.open($url, $id, "status=yes,toolbar=no,menubar=no,resizable=yes,location=no,scrollbars=no,width=" + $width + ",height=" + $height);
}

// Renvoie la position "left" d'un élément par rapport au haut de la page
function left($element) {
  var $left = 0;
  while($element.tagName != "BODY") {
    $left += $element.offsetLeft;
    $element = $element.offsetParent;
  }
  return $left;
}

/*
affiche un éléments sous la souris
empêche que l'élément sorte de l'écran
*/
function afficherSousSouris($event, $element) {

  // Dimension et position de l'écran
  var $w0 = window.document.body.clientWidth;
  var $h0 = window.document.body.clientHeight;
  var $t0 = document.body.scrollTop;
  var $l0 = document.body.scrollLeft;

  // Dimension et position de l'élément
  var $w = $element.scrollWidth;
  var $h = $element.scrollHeight;
  var $t = $t0 + $event.clientY + 15;
  var $r = null;
  var $l = $l0 + $event.clientX + 15;
  var $b = null;

  // Dépassement à droite
  if($l + $w > $l0 + $w0) {
    $l = $l0 + $w0 - $w;
    $r = -$l0;
  }
  // Dépassement en bas
  if($t + $h > $t0 + $h0) {
    $t = $l0 + $h0 - $h;
    $b = -$t0;
  }
  
  // Si la souris est sur l'élement, alors on déplasse l'élément au dessus à gauche
  if ($event.clientX > $l && $event.clientX < ($l + $w) && $event.clientY > $t && $event.clientY < ($t + $h)) {
    $r = $w0 - $event.clientX + 5;
    $t = $t0 + ($event.clientY - $h) - 5;
  }

  // Positionnement de l'objet
  if($r != null) {
    $element.style.left = null;
    $element.style.right = $r;
  }
  else {
    $element.style.left = $l;
    $element.style.right = null;
  }
  if($b != null) {
    $element.style.top = "";
    $element.style.bottom = $b;
  }
  else {
    $element.style.top = $t;
    $element.style.bottom = "";
  }
}

// Navigue sur l'URL si l'utilisateur répond oui à la question
function confirmNavigate($question, $url) {
  if(confirm($question))
    navigate($url);
}

// Maximise une fenêtre
function maximize() {
  window.resizeTo(screen.availWidth, screen.availHeight);
}

// Renvoie l'objet XmlHttp
function getXMLHttpRequest() {
  if($ieVersion >= 7)
    var $xhr = new XMLHttpRequest();
  else if(document.all)
    var $xhr = new ActiveXObject("Microsoft.XMLHTTP") ;
	else
    var $xhr = new XMLHttpRequest();
  return $xhr;
}

// Fonction pour mettre en place Ajax
function ajax($page, $element, $eval) {
  var $imgAjax = document.getElementById("imgAjax");
  if($imgAjax != null)
    $imgAjax.style.display = "block";
  var $xhr = getXMLHttpRequest();
	$xhr.open("GET", $page);
	$xhr.onreadystatechange = function() {
    if ($xhr.readyState == 4) {
      var $result = $xhr.responseText;
      if(typeof($element) == "string") {
        $element = document.getElementById($element);
        $element.innerHTML = $result;
        pngFix($element);
      }
      if(typeof($eval) == "string")
        eval($eval);
      if($imgAjax != null)
        $imgAjax.style.display = "none";
    }
  }
  $xhr.setRequestHeader("Content-Type", "text/xml; charset=utf-8");
  $xhr.send(null);
}

// Renvoie le code hexadécimal d'un nombre
function hexa($n) {
 var $cars = "0123456789abcdef";
 var $hexa = "";
 var $hexa_m = $n;
 for(var $i=0; $i < 8; $i++) {
   $hexa = $cars.charAt(Math.abs($hexa_m)%16) + $hexa;
   $hexa_m = Math.floor($hexa_m/16);
 }
 for(var $i=0; $i < 8; $i++) {
  if($hexa.substr(0, 1) == "0")
    $hexa = $hexa.substr(1);
 }
 return $hexa;
}

// Renvoie le code d'un caractère
function asc($c) {
  $c = $c.charAt(0);
  for (var $i = 0; $i < 256; ++$i) {
    var $h = $i.toString (16);
    if($h.length == 1)
      $h = "0" + $h;
    $h = "%" + $h;
    $h = unescape ($h);
    if ($h == $c)
      break;
  }
  return $i;
}

// Convertit une chaîne en hexadécimal
function stringToHexa($str) {
  var $hexa = "";
  for(var $i=0; $i<$str.length; $i++) {
    $hexa += hexa(asc($str.charAt($i)));
  }
  return $hexa;
}

// Corrige le pb des PNGs sous IE <= 6
function pngFix($element) {
  if($ieVersion < 5.5 || $ieVersion >= 7)
    return;
  if(typeof($element) != "object")
    var $images = document.images;
  else
    var $images = $element.getElementsByTagName("IMG");
  var $regExp = new RegExp(".*png$");
  $regExp.ignoreCase = true;
  var $src = "";
  for(var $i=0; $i < $images.length; $i++) {
    $src = $images[$i].src;
    if($regExp.test($src)) {
      $images[$i].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + $src + "', sizingMethod='scale')";
      $images[$i].src = "/images/empty.gif";
    }
  }
}

// Pour changer l'adresse
function navigate($url) {
  window.location = $url;
}

// Affiche ou cache un élément
function showHide($element, $display) {
  $element.style.display = $element.style.display == "none" ? $display : "none";
}

// Copie le contenu d'un élément HMLT (textarea, ...) dans le presse papier
function copy2Clipboard($element) {
  var $textRange = document.body.createTextRange();
  $textRange.moveToElementText($element);
  $textRange.execCommand("Copy");
}

/**********************************************************************
Lecture et Ecriture des Cookies
*/

function Cookie() {

  this.lire = function Cookie_lire($param) {
    var $tab = document.cookie.split("; ");
    var $cookie;
    for(var $i=0; $i < $tab.length; $i++) {
      $cookie = $tab[$i].split("=")
      if($cookie[0] == $param) {
        return $cookie[1];
      }
    }
    return "";
  }

  this.ecrire = function Cookie_ecrire($param, $value) {
    var $expire = new Date();
    $expire.setTime($expire.getTime() + (300*24*3600*1000)); // 300 jours
  	document.cookie = $param + "=" + escape($value) + "; expires=" + $expire.toGMTString();
  }
}

/**********************************************************************
Classe pour HtmlTable
*/

var TABLE = new HtmlTable();
function HtmlTable() {

  this.oldClassName = "";
  
  this.over = function HtmlTable_over($tr) {
    this.oldClassName = $tr.className;
    $tr.className = "over";
  }

  this.out = function HtmlTable_out($tr) {
    $tr.className = this.oldClassName;
    this.oldClassName = "";
  }

  this.click = function HtmlTable_click($e, $url) {
    var $target = $e.srcElement ? $e.srcElement : $e.target;
    if($target.tagName != "INPUT" && $target.tagName != "IMG" && $target.tagName != "A")
      navigate($url);
  }

}