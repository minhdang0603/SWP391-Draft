$(document).ready(function () {
    // Show or hide the "Back to Top" button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            $('#back-to-top').fadeIn();
        } else {
            $('#back-to-top').fadeOut();
        }
    });

    // Smooth scroll to top
    $('#back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1000);
        return false;
    });
});
