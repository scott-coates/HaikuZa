function cause_init (options) {
	if(!options.signed_in){
		$(".cause-action").click(function(){
			$(".log-in").fadeIn();
			return false;
		});
		$(".retweet-haiku-button").click(function(){
			if(!$(this).next('div.log-in').length)
			{
				$(this).after($(".log-in:first").clone().removeClass('hide'));
			}
			return false;
		});
	}
	else{
		$("#write-haiku").click(function(){
			var w = 450;
			var h = 350;
			var left = (screen.width/2)-(w/2);
  			var top = (screen.height/2)-(h/2);
			var text = "@Just_Add_Girls\r\n5 syllables\r\n7 syllables\r\n5 syllables\r\n";
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
			// var url = options.share_url + "?referer=" + options.user.screen_name
			var url = "http://justaddgirls.com/17s?referer=" + options.user.screen_name;
			window.open('http://twitter.com/share?text=' + encodeURI(text) + '&url=' + encodeURIComponent(url), 'twitterPopup', 'status = 1, width='+w+', height='+h+', top='+top+', left='+left+' resizable = 0');
			return false;
		});
	}
}