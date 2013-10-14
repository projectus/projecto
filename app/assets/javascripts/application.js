
//= require jquery
//= require jquery.remotipart
//= require bootstrap
//= require_tree .

//$(function(){ $(document).foundation(); });

$(function(){
	window.setTimeout(function() {
	    $(".alert").fadeTo(500, 0).slideUp(500, function(){
	        $(this).remove(); 
	    });
	}, 2000);
});
/*
$(function() {
    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe("/messages/new", function(data) {
        eval(data);
    });
});
*/
