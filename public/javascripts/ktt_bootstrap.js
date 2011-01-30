window._ktt = (function () {
		
		function get_script(url,success){
			var script = document.createElement('script')
			,head = document.getElementsByTagName('head')[0]
			,done = false;
			script.src = url;
			//google "jquerify bookmarklet" for my inspiration here
			script.onload = script.onreadystatechange=function(){
				if(!done && (!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete')){
					done = true;
					success();
					script.onload = script.onreadystatechange = null;
					head.removeChild(script);
				}
			};
			head.appendChild(script);
		};
	
		function create_form(){
			//save button
			var saveBtn = jQuery('<button>save</button>')
				.css({
					float: 'right'
					,width: '50px'
					,margin: '12px 0px'
				})
				.click(function(){
					var $s = jQuery('#ktt_s')
						,$c = jQuery('#ktt_c');
					var url = [
								'http://localhost:3000/ktt?'
								,'u=', _ktt_identifier
								,'&s=', encodeURIComponent($s.val())
								,'&c=', encodeURIComponent($c.val())
								].join('');
					console && console.log(url);
					if(jQuery.trim($s.val()).length > 0){//only require the subject
						new Image().src = url;
						$s.val('');
						$c.val('');
					}
					jQuery('#ktt_container').fadeOut();
				});
			
			//close 
			var closeX = jQuery('<span id="ktt_close" style="float:right;">X</span>')
				.css({
					'font-size': '1em'
					,'color': '#000'
				})
				.click(function(){
					jQuery('#ktt_container').fadeOut();
				})
				.hover(function(){
					jQuery(this).css('cursor','pointer');
				},function(){
					jQuery(this).css('cursor','');
				});
			
			//build main container	
			var $win = jQuery([
				'<div id="ktt_container" style="display:none;">'
					,'<div style="font-size:16px; margin-bottom: 4px;">keep track of this</div>'
					,'subject: <br/><input type="text" id="ktt_s"/>'
					,'<br/><br/>'
					,'remember this:<br/>'
					,'<textarea id="ktt_c"></textarea><br/>'							
				,'</div>'
				].join('')).css({
					position: 'fixed'
					,height: '400px'
					,width: '310px'
					,'margin-left': '-110px'
					,top: '0px'
					,left: '50%'
					,padding: '5px 20px'
					,'z-index': '1001'
					,'font-size': '12px'
					,color: '#222'
					,'background-color': '#EEE'
					,border: '1px solid black'
				})
				.append(saveBtn)
				.prepend(closeX);
			$win.appendTo('body');
			//styles for inputs
			jQuery('#ktt_s').css({
				width: '300px'
				,height:'20px'
				,'font-size': '16px'
				,color: '#000'
			});
			jQuery('#ktt_c').css({
				height: '200px'
				,width: '300px'
				,'font-size':'16px'
				,color: '#000'
			})
		};
		
	return {
		go: function (){
			/*
			make sure we have jquery loaded and available before we start surgery...
			*/
			if(typeof jQuery==="undefined"){
				console && console.log('loading jquery');
				get_script('http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js', function(){
					_ktt.show_form();
				});
			}
			else{
				_ktt.show_form();
			}
		},

		show_form: function (){
			if (jQuery('#ktt_container').length == 0){
				create_form();
			}
			jQuery('#ktt_container').fadeIn();
			jQuery('#ktt_s').focus();
		}

				
	};
})();
window._ktt.go();