$(document).ready(function() {
  $('.open-left').on('click', function(e) {
    e.preventDefault();
    if ($('.menu-left').css('width') == '0px') {
      openLeftMenu();
    }else{ ($('.menu-left').css('width') !== '0px')
      closeLeftMenu();
    }
  });
  $('.open-right').on('click', function(e) {
    e.preventDefault();
    if ($('.menu-right').css('width') == '0px') {
      openRightMenu();
    }else{ ($('.menu-right').css('width') !== '0px')
      closeRightMenu();
    }
  });
});
// Right Drawer
var openRightMenu = function(){
  $('.menu-right').show();
  $('.menu-right').animate({width:250, avoidTransforms:true }, 750);
  soundCloudin();
};

var closeRightMenu = function() {
  $('.menu-right').animate({width:0, avoidTransforms:true }, 750);
};
// Left Drawer
var openLeftMenu = function(){
  $('.menu-left').show();
  $('.menu-left').animate({width:250, avoidTransforms:true }, 750);
};

var closeLeftMenu = function() {
  $('.menu-left').animate({width:0, avoidTransforms:true }, 750);
};
