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

    var chart = function(lgl) {
      c3.generate({
        bindto: '.chart',
        data: {
          columns: [
              lgl,
          ],
          type: 'bar',
          // labels: true,
          },
          color: {
            pattern: [
              function(dataPoint){
                if(typeof dataPoint == 'string'){
                  return 'black';
                } else if(dataPoint.value >= 0){
                  return '#29A329';
                } else {
                  return '#C11919';
                }
              }
            ]
          },
          grid: {
            y: {
              lines: [{value: 0}],
              label: {
                text: 'Life gained or lossed (mins)',
                position: 'outer-middle'
              },
            }
          },
        });
    }


//     var chart = function(lgl) { c3.generate({
//       bindto: '.chart',
//     data: {
//         columns: [
//             lgl,
//             // ['data2', -50, 150, -150, 150, -50, -150],
//             // ['data3', -100, 100, -40, 100, -150, -50]
//         ],
//         groups: [
//             ['data1', 'data2']
//         ],
//         type: 'bar',
//         labels: true
//     },
//     grid: {

//       // debugger
//         y: {
//           lines: [{value: 0, text: 'Lable 50 for y', position: 'middle'}]
//         }
//     }
// });
//       }

// regions: [
//         {axis: 'x', end: 1, class: 'regionX'},
//         {axis: 'x', start: 2, end: 4, class: 'regionX'},
//         {axis: 'x', start: 5, class: 'regionX'},
//         {axis: 'y', end: 50, class: 'regionY'},
//         {axis: 'y', start: 80, end: 140, class: 'regionY'},
//         {axis: 'y', start: 400, class: 'regionY'},
//         {axis: 'y2', end: 900, class: 'regionY2'},
//         {axis: 'y2', start: 1150, end: 1250, class: 'regionY2'},
//         {axis: 'y2', start: 1300, class: 'regionY2'},
//     ]




    var userId = $('#clock').data().id
    $.ajax({
      url: '/api/users/'+ userId +'/steps',
      type: 'get'
    })
    .done(function(serverResponse) {
      chart(serverResponse);
    })
    .fail(function() {
      console.log("error");
    });

    //  var userId = $('#clock').data().id
    // $.ajax({
    //   url: '/api/users/'+ userId +'/steps',
    //   type: 'get'
    // })
    // .done(function(serverResponse) {
    //   chart(serverResponse);
    // })
    // .fail(function() {
    //   console.log("error");
    // });

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
