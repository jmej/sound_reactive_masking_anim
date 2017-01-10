$(document).ready(function(){
  var $moveable = $('.moveAble');

  //canvas gradiant setup
  var canvas = document.getElementsByTagName('canvas')[0],
    ctx = null,
    grad = null,
    body = document.getElementsByTagName('body')[0],
    color = 255;
    
  if (canvas.getContext('2d')) {
    ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, 800, 800);
    ctx.save();
    // Create radial gradient
    grad = ctx.createRadialGradient(0,0,0,0,0,800); 
    grad.addColorStop(0, '#000');
    grad.addColorStop(1, 'rgb(' + color + ', ' + color + ', ' + color + ')');
    // assign gradients to fill
    ctx.fillStyle = grad;
    // draw 600x600 fill
    ctx.fillRect(0,0,800,800);
    ctx.save();
    
  }

  $(document).mousemove(function(e){
    $moveable.css({'top': e.pageY-150,'left': e.pageX-150});
    var width = 800, 
      height = 433, 
      x = event.clientX, 
      y = event.clientY,
      rx = 800 * x / width,
      ry = 433 * y / height;
      var xc = ~~(256 * x / width);
      var yc = ~~(256 * y / height);
      grad = ctx.createRadialGradient(rx, ry, 0, rx, ry, 800); 
      grad.addColorStop(0, '#E00008');
      grad.addColorStop(1, '#001E80');
      // ctx.restore();
      ctx.fillStyle = grad;
      ctx.fillRect(0,0,800,800);
      // ctx.save();
  });
});

counter = 0;
  
function createCircle(){
  
  $("#circle-container").append("<div class='circle'></div>");
    
  // add "zoom" class
  setTimeout(function(){
      $(".circle:last-child").addClass("zoom");
  },10);
  
  // Remove circle
  setTimeout(function(){
      $(".circle:first-child").remove();
  },3000);
  counter++;
}

setInterval(function(){
    createCircle();
},500);


