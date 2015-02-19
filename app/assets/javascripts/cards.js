// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var handles = ".move";
var sort_items = "tbody tr";

$(document).ready(function(){
	$("table.sortable").sortable({
		handle: handles,
		placeholder: "placeholder",
		items: sort_items,
		stop: save_sorter,
		helper: fix_helper
	});
});

function save_sorter(e, d){
	var script = $(e.target).data("action");
	var data = [];
	$(e.target).find(sort_items).each(function(){
		data.push($(this).data("key"));
	});
	$.post(script,{order: data.join(",")}, handle);
}

function handle(data){
	if ( data )
	{
		switch(data.code)
		{
			case "sort_updated":
				$("table.sortable").effect("highlight");
				break;
		}
	}
}
function fix_helper(c, a) {
	var b = a.children();
	var d = a.clone();
	d.children().each(function(e){
		$(this).width(b.eq(e).width());
	});
	return d;
}


