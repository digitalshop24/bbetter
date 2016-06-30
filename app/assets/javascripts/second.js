$( document ).ready(function() {
	$("#new_message").on("ajax:success", function(e, data, status, xhr){
	  $('#trainMail').html('<div class="container center-align"><h1>' + data["result"] + '</h1></div>')
	});
});