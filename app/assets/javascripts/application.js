//= require jquery
//= require jquery-ui
//= require rails
//= require jquery.fancybox
//= require jquery.qtip

$(document).ready(function(){
  $("a.thumb").fancybox({
    'transitionIn' : 'elastic',
    'transitionOut' : 'elastic',
    'speedIn' : 200,
    'speedOut' : 200,
      'titlePosition' : 'inside',
      'overlayOpacity' : 0.3,
      'overlayColor' : '#666',
      'cyclic' : true,
      'hideOnContentClick' : true
  });
});
