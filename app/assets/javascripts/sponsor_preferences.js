/**
 * Created by zwang on 2/24/14.
 */
$(document).ready(function(){

    $('#preference').on("ajax:success", function(e, data, status, xhr){
       var maincontent = $('#maincontent')
       maincontent.empty();
       maincontent.append(data);
    }).bind("ajax:error", function(e, data, status, xhr){
            alert('Error');
    });


//    $('form#preference').submit(function() {
//        var valuesToSubmit = $("form#preference").serialize();
//        var url = $(this).attr('action');
//        alert(url)
//        $.ajax({
//            url: $(this).attr('action'), //sumbits it to the given url of the form
//            data: valuesToSubmit,
//            dataType: "JSON", // you want a difference between normal and ajax-calls, and json is standard
//            success: function(){
//                alert("test")
//                $('#maincontent').html();
//            }
//        });
//        return false; // prevents normal behaviour
//    });
})