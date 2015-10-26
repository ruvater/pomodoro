var layout_ready = function() {
  $("#toggle-sidebar").click(function(e) {
    $("#wrapper").toggleClass("toggled");
    if ($(this).hasClass(close_sidebar_icon_class)) {
      $(this).removeClass(close_sidebar_icon_class).addClass(open_sidebar_icon_class);
    } else {
      $(this).removeClass(open_sidebar_icon_class).addClass(close_sidebar_icon_class);
    }
  });
};

$(document).ready(layout_ready);
$(document).on('page:load',layout_ready);