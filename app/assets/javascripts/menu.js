$(document).ready(function(){
	$("#navigation .icon").click(toggle_menu);
});

function toggle_menu()
{
	$("#navigation").toggleClass("open");
}