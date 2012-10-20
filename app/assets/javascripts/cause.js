function cause_init (options) {
	if(!options.signed_in){
		$(".cause-action").click(function(){
			$(".log-in").fadeIn();
			return false;
		});
	}
}