//= require vendor/jquery
//= require vendor/jquery-ui
//= require vendor/jquery.fancybox
//= require vendor/jquery.qtip
//= require rails

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
