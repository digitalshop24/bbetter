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

$(document).ready(function(){
  $('.accordion li').click(function(e) {
    e.preventDefault(); //prevent the link from being followed
    $('.accordion li').removeClass('active');
    $(this).addClass('active');
  });

  $('.notifCarousel').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    responsive: [{
      breakpoint: 768,
      settings: {
         arrows: false,
         dots:false
      }
    }]
  });

  var initSlide = $('.weekCarousel').children().length - 1;
  $('.weekCarousel').slick({
    initialSlide: initSlide,
    slidesToShow: 1,
    slidesToScroll: 1,
    adaptiveHeight: true,
    dots:true,
    arrows: false,
    responsive: [{
      breakpoint: 768,
      settings: {
         arrows: false,
         dots:true
      }
    }]
  });
  $('.regFoodCarousel').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    dots:true,
    adaptiveHeight: true
  });
  $('.tariffsCarousel').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
    adaptiveHeight: true,
    dots:true
  });
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
    }]
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
  $('.aploadCarousel').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    dots:true
  });
  
  var tabs = $(".tabs-menu li.current a");
  tabs.each(function(){
    var tab = $(this).attr('href');
    $(tab).show();
    $(this).parents('.container').find(".tab-content.trPl").not(tab).css("display", "none");
  });

  $(".tabs-menu a").click(function(event) {
      event.preventDefault();
      if (!$(this).hasClass('disabled')) {
        $(this).parent().addClass("current");
        $(this).parent().siblings().removeClass("current");
        var tab = $(this).attr("href");
        $(this).parents('.container').find(".tab-content.trPl").not(tab).css("display", "none");
        $(tab).fadeIn();
      }
  });

  $('.closeNotif').click(function() {
    $('.notif').addClass('hidden');
  });

  $(document).on("click", "#inviteButton", function () {
     var promocode = $(this).data('promocode');
     $('#promo_promocode').val(promocode);
  });

});



function measureScrollBar() {
  // david walsh
  var scrollDiv = document.createElement('div')
  scrollDiv.className = 'scrollbar-measure'
  document.body.appendChild(scrollDiv)
  var scrollbarWidth = scrollDiv.offsetWidth - scrollDiv.clientWidth
  document.body.removeChild(scrollDiv)
  return scrollbarWidth
}

$(document.body)
.on('show.bs.modal', function () {
  if (this.clientHeight < window.innerHeight) return
  var scrollbarWidth = measureScrollBar()
  if (scrollbarWidth) $(document.body).css('padding-right', scrollbarWidth)
})
.on('hidden.bs.modal', function () {
  $(document.body).css('padding-right', 0)
});


$('[rel="popover"]').popover({
    container: 'body',
    html: true,
    content: function () {
        var clone = $($(this).data('popover-content')).clone(true).removeClass('hide');
        return clone; 
    }
}).click(function(e) {
    e.preventDefault();
});


