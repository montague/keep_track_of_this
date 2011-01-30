/*
	development
*/
javascript:(function(){
	if(window._ktt === undefined){
		window._ktt_identifier = '040e42c0-ee57-012d-c8ac-001cb3ff73e3';
		if(console) console.log('requesting boostrap');
		var s = document.createElement('script') 
			,head = document.getElementsByTagName('head')[0];
		s.src = 'http://localhost:3000/bootstrap?' + new Date().getTime();
		head.appendChild(s);
	}
	else{
		if(console) console.log('ktt detected. no request made');
		window._ktt.go();
	}
})();


/*
	minified
*/

javascript:(function(){if(window._ktt===undefined){window._ktt_identifier='040e42c0-ee57-012d-c8ac-001cb3ff73e3';if(console)console.log('requesting boostrap');var s=document.createElement('script'),head=document.getElementsByTagName('head')[0];s.src='http://localhost:3000/bootstrap?'+new Date().getTime();head.appendChild(s);}
else{if(console)console.log('ktt detected. no request made');window._ktt.go();}})();


/* 
	production
*/
(function(){var s = document.createElement('script'); 
var fs = document.getElementsByTagName('script')[0];
s.src = 'http://ktt.heroku.com/bootstrap?' + new Date().getTime();
fs.parentNode.insertBefore(s,fs);
})();
