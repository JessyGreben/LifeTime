$(document).ready(function() {

  // $('#lifetime').on('click', function(event){
  //   event.preventDefault();
  //   $('#lifetime').each(function(){
  //     $("<div />", {
  //       text: "I'm new here."
  //     }).prependTo('#lifetime');
  //   });
  // });

  // $(window).bind('scroll', function(){
  //   $('#lifetime').css({ opacity: 0.5 })
  // });

  // $(window).scroll(function(){
  //     var fromtop = $(document).scrollTop();
  //     $('#lifetime').css({opacity: 100-fromtop});
  // });

  // $(document).on('scroll', function (e) {
  //     $('#lifetime').css('opacity', ($(document).scrollTop() / 200));
  // });

  $('#arrow').on('click', function(){
    $('html,body').animate({scrollTop: $('#mountain').offset().top}, 15000);
  });

});

//      https://localhost:3000/auth/jawbone
//      ProximaRegular
