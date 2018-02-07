$(function() {
	//Logout
	document.getElementById ("logoutButton").addEventListener ("click", function(){
		$.ajax({
			url: GARDEN.root + "user/logout",
			type: "POST"
		}).done(function(data) {
			window.location.href = "../html/login.html";
		});
	});

	//Makes it so button doesn't remain grey after you click on it
	$(".btn").mouseup(function(){
	    $(this).blur();
	})

});
