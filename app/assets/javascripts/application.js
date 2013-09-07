
//= require jquery
//= require jquery_ujs

//= require_tree .
//= require bootstrap

//$(function(){ $(document).foundation(); });

$(function() {
    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe("/messages/new", function(data) {
        eval(data)
    });
});