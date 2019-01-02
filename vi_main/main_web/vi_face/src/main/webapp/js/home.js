$(function() {
	// 	addEventListener("load", function() {
	// 		setTimeout(hideURLbar, 0);
	// 	}, false);
	// 	function hideURLbar() {
	// 		window.scrollTo(0, 1);
	// 	}
	$("#slider").responsiveSlides({
		auto: true,
		nav: true,
		speed: 500,
		namespace: "callbacks",
		pager: true,
	});
	var menu_ul = $('.menu > li > ul'),
		menu_a = $('.menu > li > a');
	menu_ul.hide();
	menu_a.click(function(e) {
		e.preventDefault();
		if (!$(this).hasClass('active')) {
			menu_a.removeClass('active');
			menu_ul.filter(':visible').slideUp('normal');
			$(this).addClass('active').next().stop(true, true).slideDown('normal');
		} else {
			$(this).removeClass('active');
			$(this).next().stop(true, true).slideUp('normal');
		}
	})
});
