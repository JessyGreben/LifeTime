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

App.generateChart = function(lifeGainedLost) {
  return c3.generate({
    bindto: '.chart',
    data: {
      columns: [lifeGainedLost],
      type: 'bar',
      // labels: true,
    },
    color: {
      pattern: [App.barChartColors]
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
};


App.getLifeGainedLost = function(userId){
  return $.ajax({
    url: '/api/users/'+ userId +'/steps',
    type: 'get'
  });
};

App.updateChart = function(userId){
  var request = App.getLifeGainedLost();
  request.done(function(serverResponse) {
    chart(serverResponse);
  });
  request.fail(function() {
    console.log("error");
  });
}


// Right Drawer
App.openRightMenu = function(){
  $('.menu-right').show().animate({width:250, avoidTransforms:true }, 750);
  soundCloudin();
};

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

App.toggleMenuRight = function() {
  $('.menu-right').toggleClass('open');
};

App.toggleMenuLeft = function() {
  $('.menu-left').toggleClass('open');
};

$(document).ready(function() {

  $('.open-left').on('click', function(event) {
    event.preventDefault();
    App.toggleMenuLeft()
  });

  $('.open-right a').on('click', function(event) {
    event.preventDefault();
    App.toggleMenuRight();
  });

  App.renderChart();

});


