$( document ).ready(function() {
	$("#new_message").on("ajax:success", function(e, data, status, xhr){
	  $('#trainMail').html('<div class="container center-align"><h1>' + data["result"] + '</h1></div>')
	});

  $("#new_feedback").on("ajax:success", function(e, data, status, xhr){
    $('#feedbackFormWrapper').html('<div class="thankU"><h1 class="text-center">' + data["result"] + '</h1></div>')
  });

  $("#send_promo").on("ajax:success", function(e, data, status, xhr){
    if (data['status'] == 'ok') {
      $(this).parents('#promoModal').find('.thankU').show();
      $(this).parents('#promoModal').find('form').hide();
    }
    else if (data['status'] == 'error') {
      var nse = $(this).find('.new_solution_errors');
      nse.html('');
      $.each(data['errors'], function( index, value ) {
        nse.append('<div class="row"><div class="col-md-12"><p>' + value + '</p></div></div>');
      });
    }	 
  });

  $("#new_video").on("ajax:success", function(e, data, status, xhr){
    if (data['status'] == 'ok') {
      $(this).parents('.video-form').html("<h2>" + data["message"] + "</h2>");
    }
    else if (data['status'] == 'error') {
      var nse = $(this).find('.new_solution_errors');
      nse.html('');
      $.each(data['errors'], function( index, value ) {
        nse.append('<div class="row"><div class="col-md-12"><p>' + value + '</p></div></div>');
      });
    }  
  });

  $('#promoModal').on('hidden.bs.modal', function () {
    $(this).find('.new_solution_errors').html('');
    $(this).find('.thankU').hide();
    $(this).find('form').show();
    $(this).find('input[type=text],input[type=email],input[type=tel]').val('');
  })
});