function cause_init (options) {
	$("#write-haiku").popover({content:$("#haiku-tooltip-content").html(),trigger:"hover"});
	if(!options.signed_in){
		$(".cause-action").click(function(){
			$(".log-in").fadeIn();
			return false;
		});

		$(document).on("click",".retweet-haiku-button",function(event){
			if(!$(this).next('div.log-in').length)
			{
				$(this).after($(".log-in:first").clone().removeClass('hide'));
			}
			event.preventDefault();
			event.stopPropagation();
			return false;
		});
	}
	else{
		//$(".cause-image").click(function(event) {
		twttr.events.bind('tweet', function(event) {
		   $(window).focus(function() {
			   	$(this).unbind('focus');
			   	$('html, body').animate({scrollTop:0}, 'slow');
			   	$("#tweet-success").slideDown('slow');
			   	setTimeout(function(){$("#tweet-success").css('opacity',1);},1000);
		   });
		   if(window._gaq)
			   {
			   window._gaq.push(['_trackEvent', 'Haikus', 'Tweet', options.user.screen_name]);
			}
		});

		twttr.events.bind('retweet', function(event) {
		   $("#tweet-success").css('opacity',1);
		   if(window._gaq)
			   {
			   window._gaq.push(['_trackEvent', 'Haikus', 'Retweet', options.user.screen_name]);
			}
		});

		(function(){
			var text = "5 syllables / 7 syllables / 5 syllables";
			var via = "haiku_za";
			var hashtags = "geekitude";
			$("#write-haiku").attr('href','http://twitter.com/intent/tweet?text=' + encodeURI(text) + '&hashtags=' + encodeURI(hashtags) + '&via=' + encodeURI(via));
		})();

		$("#share-cauase").click(function(){
			var w = 450;
			var h = 350;
			var left = (screen.width/2)-(w/2);
  			var top = (screen.height/2)-(h/2);
			var text = "Express your inner geek";
			var via = "haiku_za";
			var url = "http://haikuza.com/express-your-inner-geek?referer=" + options.user.screen_name;
			window.open('http://twitter.com/share?text=' + encodeURI(text) + '&url=' + encodeURIComponent(url)  + '&via=' + encodeURI(via), 'twitterPopup', 'status = 1, width='+w+', height='+h+', top='+top+', left='+left+' resizable = 0');
			return false;
		});
	}

	if(options.referer)
	{
		if(window._gaq)
		{
			window._gaq.push(['_trackEvent', 'Haikus', 'Referal', options.referer.screen_name]);
		}
	}
}