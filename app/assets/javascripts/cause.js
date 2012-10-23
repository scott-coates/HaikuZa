function cause_init (options) {
	if(!options.signed_in){
		$(".cause-action").click(function(){
			$(".log-in").fadeIn();
			return false;
		});

		$(document).on("click",".retweet-haiku-button",function(){
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
			var text = "@my17syllables\r\n5 syllables\r\n7 syllables\r\n5 syllables\r\n";
			var hashtags = "haiku";
			window.open('http://twitter.com/share?text=' + encodeURI(text) + '&hashtags=' + encodeURI(hashtags), 'twitterPopup', 'status = 1, width='+w+', height='+h+', top='+top+', left='+left+' resizable = 0');
			return false;
		});

		$("#share-cauase").click(function(){
			var w = 450;
			var h = 350;
			var left = (screen.width/2)-(w/2);
  			var top = (screen.height/2)-(h/2);
			var text = "help me get some points yo!";
			var url = "http://justaddgirls.com/17s?referer=" + options.user.screen_name;
			window.open('http://twitter.com/share?text=' + encodeURI(text) + '&url=' + encodeURIComponent(url), 'twitterPopup', 'status = 1, width='+w+', height='+h+', top='+top+', left='+left+' resizable = 0');
			return false;
		});

		$(document).on("click",".retweet-haiku-button",function(){
			var w = 450;
			var h = 350;
			var left = (screen.width/2)-(w/2);
  			var top = (screen.height/2)-(h/2);
			var text = $(this).parents('.row-fluid:first').find('p.haiku-content').html();
			window.open('http://twitter.com/share?text=' + encodeURI(text), 'twitterPopup', 'status = 1, width='+w+', height='+h+', top='+top+', left='+left+' resizable = 0');
			return false;
		});
	}
}