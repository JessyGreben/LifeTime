$(document).ready(function() {

  $('#lifetime').on('click', function(event){
    event.preventDefault();
    $('#lifetime').each(function(){
      $(this).show();
    });

  });

});
