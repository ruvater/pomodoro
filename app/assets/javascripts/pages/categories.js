categories_handler = function() {
  console.log("Categories!");

  addColorPicker('.colorpicker');

  function addColorPicker(object) {
    var getHex = function(color) {
      if (/^[0-9A-F]{3}$/i.test(color)) {
        return color[0] + color[0] + color[1] + color[1] + color[2] + color[2];
      }
      switch (color) {
        case 'black':
            return '000000';
        case 'red':
            return 'ff0000';
            break;
        default:
            return color;
      }
    }

    object.ColorPicker({
      onSubmit: function(hsb, hex, rgb, el) {
        $(el).val(hex);
        $(el).ColorPickerHide();
      },
      onBeforeShow: function () {
        $(this).ColorPickerSetColor(getHex(this.value));
      }
    })
    .bind('keyup', function() {
      $(this).ColorPickerSetColor(getHex(this.value));
    });
  }
}