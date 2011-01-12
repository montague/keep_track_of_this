window._ktt = (function () {
		
		function get_script(url,success){
			var script = document.createElement('script')
			,head = document.getElementsByTagName('head')[0]
			,done = false;
			script.src = url;
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
			var saveBtn = jQuery('<button id="ktt_save">save</button>').click(function(){
				//submit and close
				alert('saving: ' + _ktt_identifier);
				jQuery('#ktt_container').fadeOut();
			})
			.wrap('<div/>');
			
			var closeX = jQuery('<span id="ktt_close" style="float:right;">X</span>')
			.click(function(){
				//just close
				alert('closing');
				jQuery('#ktt_container').fadeOut();
			})
			.hover(function(){
				jQuery(this).css('cursor','pointer');
			},function(){
				jQuery(this).css('cursor','');
			});
			
			//build main conatiner	
			jQuery([
				'<div id="ktt_container" style="display:none;">'
					,'subject: <input type="text" name="ktt_subject"/>'
					,'<br/><br/>'
					,'remember this:<br/>'
					,'<textarea name="ktt_to_remember"></textarea>'							
				,'</div>'
				].join('')).css({
					position: 'fixed'
					,height: '300px'
					//,width: '220px'
					,'margin-left': '-110px'
					,top: '0px'
					,left: '50%'
					,padding: '5px 10px'
					,'z-index': '1001'
					,'font-size': '12px'
					,color: '#222'
					,'background-color': '#f99'
				})
				.append(saveBtn)
				.prepend(closeX)
				.appendTo('body');
		};
		
	return {
		go: function (){
			/*
			make sure we have jquery loaded and available before we start surgery...
			*/
			if(typeof jQuery==="undefined"){
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
		}

				
	};
})();
window._ktt.go();