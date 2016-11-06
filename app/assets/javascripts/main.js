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

  $(window).on('scroll', function(event) {
    $('#favourite').fadeIn(800);
  });

});
