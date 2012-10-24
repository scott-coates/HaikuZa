function cause_init (options) {
	$("#haiku-tooltip").popover({content:$("#haiku-tooltip-content").html(),trigger:"hover"});
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
		twttr.events.bind('tweet', function(event) {
		   $("#tweet-success").css('opacity',1);
		});

		(function(){
			var text = "5 syllables\n7 syllables\n5 syllables";
			var via = "just_add_girls";
			var hashtags = "17s";
			$("#write-haiku").attr('href','http://twitter.com/intent/tweet?text=' + encodeURI(text) + '&hashtags=' + encodeURI(hashtags) + '&via=' + encodeURI(via));
		})();

		$("#share-cauase").click(function(){
			var w = 450;
			var h = 350;
			var left = (screen.width/2)-(w/2);
  			var top = (screen.height/2)-(h/2);
			var text = "How would you change the world in 17 syllables?";
			var via = "just_add_girls";
			var url = "http://justaddgirls.com/17s?referer=" + options.user.screen_name;
			window.open('http://twitter.com/share?text=' + encodeURI(text) + '&url=' + encodeURIComponent(url)  + '&via=' + encodeURI(via), 'twitterPopup', 'status = 1, width='+w+', height='+h+', top='+top+', left='+left+' resizable = 0');
			return false;
		});
	}
}