
$(document).ready(function(){

    $('#preference').on("ajax:success", function(e, data, status, xhr){
       var maincontent = $('#maincontent')
       maincontent.empty();
       maincontent.append(data);
    }).bind("ajax:error", function(e, data, status, xhr){

    });

    $(document).on("ajax:success",'.sponsor-preferences', function(e, data, status, xhr){
        var maincontent = $('#maincontent')
        maincontent.empty();
        maincontent.append(data);
    }).bind("ajax:error", function(e, data, status, xhr){

    });

    $('#team_work').on("ajax:success", function(e, data, status, xhr){
        var maincontent = $('#maincontent')
        maincontent.empty();
        maincontent.append(data);
    }).bind("ajax:error", function(e, data, status, xhr){

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

    $('#semester').change(function(data) {
        var semester = document.getElementById("semester").value
        $.ajax({
                url: "solutions/solution-names?semester=" + semester,
                type: "GET",
            success: function(data,status){
                $('#names').html(data)
            }
        });
    });

    $('#solution').on("ajax:success", function(e, data, status, xhr){
        var maincontent = $('#maincontent')
        maincontent.empty();
        maincontent.append(data);
    }).bind("ajax:error", function(e, data, status, xhr){

        });

})
