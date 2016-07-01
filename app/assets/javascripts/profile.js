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

$( document ).ready(function() {
  $('.new_summary,.edit_summary').change(function(){
    console.log('asd');
    $(this).find('input[type=submit]').removeClass('disabled');
    $(this).find('input[type=submit]').removeAttr('disabled');
  });
});