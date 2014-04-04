$('a#add_star').on('click', function(e) {
  var item_id = $("#item_id").val();
  $.ajax({
    type: "POST",
    url: "/stars",
    data: { "star[site_id]": "chienowa", "star[item_id]": item_id, "star[url]": location.href },
    success: function(data) {
      set_stars();
    }
  });
});

$('a#remove_star').on('click', function(e) {
  var item_id = $("#item_id").val();
  $.ajax({
    type: "DELETE",
    url: "/stars",
    data: { site_id: "chienowa", item_id: item_id},
    success: function(data) {
      set_stars();
    }
  });
});

function set_stars() {
  var item_id = $("#item_id").val();
  $.ajax({
    type: "GET",
    url: "/stars/chienowa/" + item_id,
    success: function(data) {
      $("#stars").html(data);
    }
  });
}

