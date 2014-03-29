$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
    var target = $(e.target).attr("href")
    if(target == '#preview') { 
        $.ajax({
            type: "POST",
            url: "/item/preview",
            data: $("#content").val(),
            error: function(data){
                alert("There was a problem");
            },
            success: function(data){
                $("#preview-content").html(data);
            }
        });
    }
});
