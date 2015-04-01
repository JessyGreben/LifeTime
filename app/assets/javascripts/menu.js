App = {};

App.barChartColors = function(dataPoint){
  if(typeof dataPoint == 'string'){
    return 'black';
  } else if(dataPoint.value >= 0){
    return '#29A329';
  } else {
    return '#C11919';
  }
}

App.closeRightMenu = function() {
  $('.menu-right').animate({width:0, avoidTransforms:true }, 750);
};
// Left Drawer
App.openLeftMenu = function(){
  $('.menu-left').show().animate({width:250, avoidTransforms:true }, 750);
};

App.closeLeftMenu = function() {
  $('.menu-left').animate({width:0, avoidTransforms:true }, 750);
};

App.toggleMenuRight = function() {
  $('.menu-right').toggleClass('open');
};

App.toggleMenuLeft = function() {
  $('.menu-left').toggleClass('open');
};

// Right Drawer
App.openRightMenu = function(){
  $('.menu-right').show().animate({width:250, avoidTransforms:true }, 750);
  soundCloudin();
};

App.generateChart = function(lifeGainedLost) {
  $('.chart').html('');
  $('.chart').data('current', 'barchart');
  return c3.generate({
    bindto: '.chart',
    data: {
      columns: 
        [lifeGainedLost]
        ,
      type: 'bar',
    },
    legend: {
      hide: true
    },
    color: {
      pattern: [App.barChartColors]
    },
    grid: {
      y: {
        lines: [{value: 0}]
      }
    },
    axis: {
      x: {
        label: {
          text: 'Last 14 days',
          position: 'outer-center'},
        tick: {
          values: [0,1,2,3,4,5,6,7,8,9,10,11,12,13] 
        }
      },
      y: {       
        label: {
          text: 'Life gained or lossed (mins)',
          position: 'outer-middle'
        },
      }
    },
    regions: [
      {axis: 'y', start: -85, end: 88, class: 'regionY5'},
      {axis: 'y', start: -85, end: 0, class: 'regionY5'},
      ]
  });
};

//************************ex.chart
App.generateTimeChart = function() {
  $('.chart').html('');
  $('.chart').data('current', 'timechart');
  return c3.generate({
   bindto: '.chart',
      // bindto: '.time-chart',
    data: {
      x: 'x',
      columns: [
      ['x', '2015-03-21', '2015-03-22', '2015-03-23', '2015-03-24', '2015-03-25', '2015-03-26', '2015-03-27', '2015-03-28', '2015-03-29', '2015-03-30', '2015-03-31', '2015-04-01','2015-04-02', '2015-04-03'],
        ["Day", -72, 82, -72, -72, -72, -72, 58, -72, -72, 82, 58, 58, 82, -72]
      ]
    },
    color: {
      pattern: [App.barChartColors]
    },
    grid: {
      y: {
        lines: [{value: 0}]
      }
    },
    legend: {
      hide: true
    },
    axis: {
        x: {
          label: {
          text: 'Last 14 days',
          position: 'outer-center'
        },
            type: 'timeseries',
            tick: {
                format: '%Y-%m-%d',
            }
        },
        y: {       
        label: {
          text: 'Life gained or lossed (mins)',
          position: 'outer-middle'
        },
      }
    },
    regions: [
      {axis: 'y', start: -80, end: -55, class: 'regionY'},
      {axis: 'y', start:-55, end: 0, class: 'regionY2'},
      {axis: 'y', start: 0, end: 58, class: 'regionY3'},
      {axis: 'y', start: 58, end: 85, class: 'regionY4'},
    ]
  });
};

App.toggleChart = function(data){

  if('timechart' == $('.chart').data('current'))
  {   
    App.renderChart();
  } else {
     App.generateTimeChart();
  }
}

App.getLifeGainedLost = function(userId){
  return $.ajax({
    url: '/api/users/'+ userId +'/steps',
    type: 'get'
  });
};

App.updateChart = function(userId){
  var request = App.getLifeGainedLost();
  request.done(function(serverResponse) {
    App.toggleChart(serverResponse);
  });
  request.fail(function() {
    console.log("error");
  });
}

App.renderChart = function(){
  var chartNode = $('.chart');
  if (chartNode.length <= 0) return;
  var userId = chartNode.data().userId;
  var request = App.getLifeGainedLost(userId);
  request.done(function(serverResponse) {
    App.generateChart(serverResponse);

  });
  request.fail(function() {
    console.log("error");
  });
}

var toggleChart = function() {
  $('.bar-graph').on('click', function(){
  var userId = $('.chart').data().userId
    App.toggleChart();
  });
};

$(document).ready(function() {  
  toggleChart(); 

  $('.open-left').on('click', function(event) {
    event.preventDefault();
    App.toggleMenuLeft()
  });

  $('.open-right a').on('click', function(event) {
    event.preventDefault();
    App.toggleMenuRight();
  });

  // $('.top-div').click(function(){
  //   if $('#expectancy').style.display == ""){
  //     $('#expectancy').style.display = 'none'
  //     $('#clock').style.display = ''
  //   } else {
  //     $('#expectancy').style.display = ''
  //     $('#clock').style.display = 'none'
  //   }
  // })
  App.renderChart();

  $('.graph').on('click', function(event) {
  event.preventDefault();
  var userId = $('.chart').data().userId
  $.ajax({
    url: '/users/'+ userId +'/graphs',
    type: 'GET',
    dataType: 'json'
  })
  .done(function(serverResponse) {
    console.log("success", serverResponse);

  })
  .fail(function() {
    console.log("error");
  });


  //   $('#clock').click(function(){
  //     $('#expectancy').css("display", "block")
  //   })
  // })


  // $(function(){
  //   $('.top-div').click(function(){
  //     $('#expectancy').toggleClass('hide');
  //   })
  // })

  // $('#expectancy').on('click', function(){
  //   $('#expectancy').css("display: none");
  //   $('#clock').css("display: block");
  // });

  // $('.intro').on('click', function(){
  //   $('#clock').css("display: none");
  //   $('#expectancy').css("display: block");
  // });

});

})
