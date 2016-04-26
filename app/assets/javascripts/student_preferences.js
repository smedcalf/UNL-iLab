$(document).ready(function() {
	$("#student_priority_rating").change(function() {
		selected_value = $("#student_priority_rating").val();
		if (selected_value > 2) {
			$(".student_upload").show();
		} else {
			$(".student_upload").hide();
		}
	});

	$(".student_upload").hide();
});