/*
	as coded
*/
(function(){var s = document.createElement('script'); 
var fs = document.getElementsByTagName('script')[0];
s.src = 'http://localhost:3000/javascripts/ktot_bootstrap.js';
fs.parentNode.insertBefore(s,fs);
})();
/*
	google closure minified: http://closure-compiler.appspot.com/home
	
	user the version below for the bookmarklet
*/
var s=document.createElement("script");s.src="http://localhost:3000/ktot_bootstrap.js";document.getElementsByTagName("head")[0].appendChild(s);