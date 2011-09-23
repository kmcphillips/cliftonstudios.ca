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

    $("#nav ul li a").qtip({
        position: {
            my: "top center",
            at: "bottom center"
        },
        show: {
            delay: 0
        },
        style: {
            classes: "ui-tooltip-youtube ui-tooltip-shadow"
        }
    });
});

