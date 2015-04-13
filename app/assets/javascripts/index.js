$(document).ready(function() {


  $('#arrow').on('click', function(){
    $('html,body').animate({scrollTop: $('#mountain').offset().top}, 7000);
  });

});
