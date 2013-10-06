
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

//$(function(){ $(document).foundation(); });

/*
$(function() {
    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe("/messages/new", function(data) {
        eval(data);
    });
});
*/


$(function(){
    $(".nav-li").mouseover(function(){
        $(this).children(".li-hover-top").css("visibility", "visible")
    }).mouseout(function(){
        $(this).children(".li-hover-top").css("visibility", "hidden")
    });
});