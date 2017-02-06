var rotation = 0;

$(document).ready(function() {
	$(window).on("load", function() {
		$('.main-content').animate({ opacity: 1 }, 300);

		$('button[data-loading-text]').on('click', function () {
			var btn = $(this)

			if(($("#login-username").val() == null) || ($("#login-username").val() == null) || ($("#login-password").val() == null) || ($("#login-password").val() == "")) {

			} else {
				btn.button('loading')
			}

		});

		$(".tablesorter").tablesorter();

		$('.nav-icon').click(function() {
			$('nav').toggleClass('responsive');
			rotateIcon();
		});
		
		setTimeout(function() {
			$('.alert').fadeOut('slow');
		}, 4000);
	});
});

function rotateIcon() {
	rotation = (rotation == 90) ? 0 : 90;
	$('.nav-icon').find('i').first().rotate(rotation);
}

//ROTATION FUNCTION
jQuery.fn.rotate = function(degrees) {
	$(this).css({
		'-webkit-transform': 'rotate(' + degrees + 'deg)',
		'-moz-transform': 'rotate(' + degrees + 'deg)',
		'-ms-transform': 'rotate(' + degrees + 'deg)',
		'transform': 'rotate(' + degrees + 'deg)'
	});
	return $(this);
}
