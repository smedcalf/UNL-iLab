
$(document).ready(function(){

    $('#preference').on("ajax:success", function(e, data, status, xhr){
       var maincontent = $('#maincontent')
       maincontent.empty();
       maincontent.append(data);
    }).bind("ajax:error", function(e, data, status, xhr){
            alert('Error');
    });

    $(document).on("ajax:success",'.sponsor-preferences', function(e, data, status, xhr){
        var maincontent = $('#maincontent')
        maincontent.empty();
        maincontent.append(data);
    }).bind("ajax:error", function(e, data, status, xhr){
            alert('Error');
    });

})
