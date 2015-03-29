$(document).ready(function() {

  $('#lifetime').scroll(function(event){
    event.preventDefault();
    console.log(this);
    $('#lifetime').each(function(){
      $(this).show();
    });

  })

});
