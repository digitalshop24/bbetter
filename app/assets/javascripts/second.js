$( document ).ready(function() {
	$("#new_message").on("ajax:success", function(e, data, status, xhr){
	  $('#trainMail').html('<div class="container center-align"><h1>' + data["result"] + '</h1></div>')
	});

	$("#new_feedback").on("ajax:success", function(e, data, status, xhr){
	  $('#feedbackFormWrapper').html('<div class="thankU"><h1 class="text-center">' + data["result"] + '</h1></div>')
	});
});