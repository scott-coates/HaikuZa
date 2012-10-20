function cause_init (options) {
	if(!options.signed_in){
		$(".cause-action").click(function(){
			$(".log-in").fadeIn();
			return false;
		});
	}
	else{
		$("#write-haiku").click(function(){
			var w = 450;
			var h = 350;
			var left = (screen.width/2)-(w/2);
  			var top = (screen.height/2)-(h/2);
			var text = "@Just_Add_Girls\r\nline1\r\nline2\r\nline3\r\n";
			var hashtags = "17s";
			window.open('http://twitter.com/share?text=' + encodeURI(text) + '&hashtags=' + encodeURI(hashtags), 'twitterPopup', 'status = 1, width='+w+', height='+h+', top='+top+', left='+left+' resizable = 0');
			return false;
		});

		$("#share-cauase").click(function(){
			var w = 450;
			var h = 350;
			var left = (screen.width/2)-(w/2);
  			var top = (screen.height/2)-(h/2);
			var text = "help me get some points yo!";
			var url = "http://mysite.com/test";
			window.open('http://twitter.com/share?text=' + encodeURI(text) + '&url=' + encodeURIComponent(url), 'twitterPopup', 'status = 1, width='+w+', height='+h+', top='+top+', left='+left+' resizable = 0');
			return false;
		});
	}
}