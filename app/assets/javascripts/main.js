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

});

$('.closeNotif').click(function() {
  $('.notif').addClass('hidden');
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
    document.getElementById("calRez").innerHTML = Math.round(rezult) + ' ккал';
  } else document.getElementById("calRez").innerHTML = 'Введите корректные данные'
  
}


$(document).ready(function() {

var fileSelect = document.getElementById("fileSelect"),
    fileElem = document.getElementById("fileElem"),
    fileSelect_2 = document.getElementById("fileSelect_2"),
    fileElem_2 = document.getElementById("fileElem_2"),
    fileSelect_3 = document.getElementById("fileSelect_3"),
    fileElem_3 = document.getElementById("fileElem_3"),
    fileSelect_4 = document.getElementById("fileSelect_4"),
    fileElem_4 = document.getElementById("fileElem_4"),
    fileSelect_5 = document.getElementById("fileSelect_5"),
    fileElem_5 = document.getElementById("fileElem_5"),
    fileSelect_6 = document.getElementById("fileSelect_6"),
    fileElem_6 = document.getElementById("fileElem_6"),
    fileSelect_6 = document.getElementById("fileSelect_7"),
    fileElem_6 = document.getElementById("fileElem_7");

fileSelect.addEventListener("click", function (e) {
  if (fileElem) {
    fileElem.click();
  }
  e.preventDefault(); // prevent navigation to "#"
}, false);
fileSelect_2.addEventListener("click", function (e) {
  if (fileElem_2) {
    fileElem_2.click();
  }
  e.preventDefault(); // prevent navigation to "#"
}, false);
fileSelect_3.addEventListener("click", function (e) {
  if (fileElem_3) {
    fileElem_3.click();
  }
  e.preventDefault(); // prevent navigation to "#"
}, false);
fileSelect_4.addEventListener("click", function (e) {
  if (fileElem_4) {
    fileElem_4.click();
  }
  e.preventDefault(); // prevent navigation to "#"
}, false);
fileSelect_5.addEventListener("click", function (e) {
  if (fileElem_5) {
    fileElem_5.click();
  }
  e.preventDefault(); // prevent navigation to "#"
}, false);
fileSelect_6.addEventListener("click", function (e) {
  if (fileElem_6) {
    fileElem_6.click();
  }
  e.preventDefault(); // prevent navigation to "#"
}, false);
fileSelect_7.addEventListener("click", function (e) {
  if (fileElem_7) {
    fileElem_7.click();
  }
  e.preventDefault(); // prevent navigation to "#"
}, false);

//$("#other").click(function() {
//  $("#target").click();
//});


$('#fileElem').change(function() {
  handleFiles(this.files, '#fileSelect', '#filelist');
});
$('#fileElem_2').change(function() {
  handleFiles(this.files, '#fileSelect_2', '#filelist_2');
});
$('#fileElem_3').change(function() {
  handleFiles(this.files, '#fileSelect_3', '#filelist_3');
});
$('#fileElem_4').change(function() {
  handleFiles(this.files, '#fileSelect_4', '#filelist_4');
});
$('#fileElem_5').change(function() {
  handleFiles(this.files, '#fileSelect_5', '#filelist_5');
});
$('#fileElem_6').change(function() {
  handleFiles(this.files, '#fileSelect_6', '#filelist_6');
});
$('#fileElem_7').change(function() {
  handleFiles(this.files, '#fileSelect_7', '#filelist_7');
});

function handleFiles(files, select, filelist) {
  
  $(select).addClass('hidden');
  var list = $("<ul style = 'display: inline-block; height: 300px; width: 49%;'></ul>");
  $(filelist).append(list);
  for (var i = 0, f; f = files[i]; i++) {
    var reader = new FileReader();
    reader.onload = (function(f) {
      return function(e) {
        var li = $("<li></li>");
        $(list).append(li);
        var a = $("<a href='#'></a>");
        $(li).append(a);
        $(a).append("<img style='width: 100%;' src='"+e.target.result +"'/>");
      };
    })(f);
    reader.readAsDataURL(f);
  }
}


$('.remove').live("click", function(event) {
  event.preventDefault();
  alert("Handler for .click() called.");
});


});

