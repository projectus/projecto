
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


$(document).ready(function(){
    $("a[data-remote]").bind("click"), function(e, data, status, xhr){
        alert("ddd")
    }


    $(".down-arrow").bind("click", function(){
        $(".task-details-collapse").show();
    })



})