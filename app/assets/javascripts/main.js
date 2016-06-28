$(function() {
  $('a.navWlaker[href*="#"]:not([href="#"])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html, body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      }
    }
  });
});

$('.accordion li').click(function(e) {
    e.preventDefault(); //prevent the link from being followed
    $('.accordion li').removeClass('active');
    $(this).addClass('active');
});

$(document).ready(function(){

  $('.beforeAfter').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
    responsive: [{
      breakpoint: 768,
      settings: {
         arrows: false,
         dots:true
      }
    }
    ]
  });

  $('.feedbackCarousel').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    responsive: [{
      breakpoint: 768,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false
      }
    }]
  });

  $('.partners').slick({
    slidesToShow: 4,
    slidesToScroll: 4,
    responsive: [{
      breakpoint: 768,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false
      }
    }]
  });

});
