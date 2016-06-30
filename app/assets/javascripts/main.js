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

  //console.log('AGE');
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

  $(".tabs-menu a").click(function(event) {
      event.preventDefault();
      $(this).parent().addClass("current");
      $(this).parent().siblings().removeClass("current");
      var tab = $(this).attr("href");
      $(".tab-content").not(tab).css("display", "none");
      $(tab).fadeIn();
  });

  $('.closeNotif').click(function() {
    $('.notif').addClass('hidden');
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
document.getElementById('calcCol').onclick = function() {
  var sex = document.getElementById("sex").value;
  var age = document.getElementById("age").value;
  var weight = document.getElementById("weight").value;
  var growth = document.getElementById("growth").value;
  var activity = document.getElementById("activity").value;
  var rezult;
  if (sex=='male') {
    rezult = (10*weight+6.25*growth-5*age+5)*activity;
  } else if (sex=='female') {
    rezult = (10*weight+6.25*growth-5*age+161)*activity;
  }
  if (rezult > 0) {
    document.getElementById("calRez").innerHTML = 'Ваша норма: ' + Math.round(rezult) + ' ккал';
  } else document.getElementById("calRez").innerHTML = 'Введите корректные данные'
  
}
