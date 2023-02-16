// Making the side menu work

$(document).ready(function () {

    $('.menu-toggle').click(function (e) {

        var menu = $(this).data('show-dialog');

        $('.' + menu).toggleClass('side-menu-shown');

    });

    $('.side-menu-close').on('click', function () {
        $('.side-menu-basic').removeClass('side-menu-shown');
    });

    // $('.side-menu-basic a').on('click', function (e) {
    //     e.preventDefault();

    //     alert('You chose option ' + $(this).data('id'));
    // });

});