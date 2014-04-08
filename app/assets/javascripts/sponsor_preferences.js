
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

    $('#team_work').on("ajax:success", function(e, data, status, xhr){
        var maincontent = $('#maincontent')
        maincontent.empty();
        maincontent.append(data);
    }).bind("ajax:error", function(e, data, status, xhr){
            alert(data.value)
            alert('Error');
    });

    $('#checkAll').click(function() {
        if (this.checked) {
            $('.display :checkbox').each(function() {
                this.checked = true;
            });
        } else {
            $(':checkbox').each(function() {
                this.checked = false;
            });
        }
    });

})
