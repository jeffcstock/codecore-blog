// $(document).ready(function(){
//
//   var show_fav = function(){
//
//       $('.favourite').fadeIn(400, function(){
//         $(this).delay(3000).fadeOut(400);
//         console.log("DISPLAYING FAV");
//         return
//       };
//         $(document).scroll(show_fav);
//     });


$(document).ready(function(){

    $(window).scroll(function(){
        $('#favbutton').fadeIn(600);
        setTimeout(function(){
          $('#favbutton').fadeOut(600);
        }, 3000);
    });
});
