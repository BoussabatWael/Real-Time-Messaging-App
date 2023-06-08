$(function(){
	$('button').click(function(){
		//username and password of the user
		var user = $('#txtUsername').val();
		var pass = $('#txtPassword').val();
		$.ajax({
			url: '/login',
			data: $('form').serialize(),
			type: 'POST',
			success: function(response){
				//logged in
				console.log(response);
			},
			error: function(error){
				//error
				console.log(error);
			}
		});
	});
});
