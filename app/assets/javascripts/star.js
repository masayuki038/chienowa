$('a#add_star').on('click', function(e) {
  var item_id = $("#item_id").val();
  $.ajax({
    type: "POST",
    url: "/stars",
    data: { 
      "star[site_id]": "chienowa", 
      "star[item_id]": item_id, 
      "star[url]": location.href,
      "star[comment]": window.getSelection().toString()
    },
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
      var mine = $(".star_mine")[0];
      if(mine) {
        $("#add_star").hide();
        $("#remove_star").show();
      }else{
        $("#remove_star").hide();
        $("#add_star").show();
      }        
      $('#stars a').on('click', function(e) {
        return false;
      });
      // $('#stars a').attr('data-toggle', 'hover');
      $('#stars img').popover({
        html: true,
        placement: 'bottom',
        trigger: "hover",
        title: function(){
          return $(this).attr('alt');
        },
        content: function(){
          return $(this).attr('longdesc');
        }
      });
    }
  });
}

function printProperties(obj) {
  var properties = '';
  for (var prop in obj){
    properties += prop + "=" + obj[prop] + "\n";
  }
  return properties;
}
