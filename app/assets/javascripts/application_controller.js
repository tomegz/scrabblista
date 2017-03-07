$(document).on('turbolinks:load', function() {

	setTimeout(function(){
        $('.error-message').remove();
    }, 2500);

   $('#q').focus(function(){
    	$('#q').val('');
    });
   $('#q').blur(function(){
   	  if ($('#q').val() == ""){
    	$('#q').val('Moje litery');
      }
    });

});
