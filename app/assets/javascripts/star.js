$('a#add_star').on('click', function(e) {
  var item_id = $("#item_id").val();
  var comment = window.getSelection().toString();
  if(comment) {
    comment = '"' + comment + '"';
  }
  $.ajax({
    type: "POST",
    url: "/stars",
    data: { 
      "star[site_id]": "chienowa", 
      "star[item_id]": item_id, 
      "star[url]": location.href,
      "star[comment]": comment
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

$('#save_star_comment').on('click', function(e) {
  var item_id = $("#item_id").val();
  $.ajax({
    type: "PUT",
    url: "/stars",
    data: { 
      site_id: "chienowa", 
      item_id: item_id, 
      comment: $('#star_comment_modal textarea').val()
    },
    success: function(data) {
      set_stars();
      $('#star_comment_modal').modal('hide');
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
      $('#stars a.star_mine').on('click', function(e) {
        var img = $("#stars a.star_mine img");
        $('#star_comment_modal .modal-title').html(img.attr('alt'));
        $('#star_comment_modal textarea').val(img.attr('longdesc'));
        $('#star_comment_modal').modal();
        return false;
      });
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
