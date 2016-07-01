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
    fileSelect_7 = document.getElementById("fileSelect_7"),
    fileElem_7 = document.getElementById("fileElem_7");

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
  
  // $(select).addClass('hidden');
  // $(filelist).removeClass('hidden');
  // var list = $("<ul style = ''></ul>");
  // $(filelist).append(list);
  for (var i = 0, f; f = files[i]; i++) {
    var reader = new FileReader();
    reader.onload = (function(f) {
      return function(e) {
        // var li = $("<li></li>");
        // $(list).append(li);
        // var a = $("<a href='#'></a>");
        // $(li).append(a);
        // $(a).append("<img style='width: 100%; position: relative; top: 48px;' src='"+e.target.result +"'/>");
        // $(a).append("<div style='width: 100%; height:300px; position: relative; top: 48px; background-image:url("+e.target.result +");'> </div>");

        
        $(select).empty()
        var url = 'background-image: url('+e.target.result+')';
        $(select).attr('style', url);
      };
    })(f);
    reader.readAsDataURL(f);
  }
}

});