categories_handler = function() {
  console.log("Categories!");

  addColorPicker($('.background-colorpicker'));


  var colors = { black: '000000', red: 'ff0000' };
  function addColorPicker(object) {
    var getHex = function(color) {
      return color in Object.keys(colors) ? colors[color] : color;
    }

    var getColor = function(hex) {
      for(var key in colors) {
        if (colors[key] == hex) return key;
      }
      return hex;
    }

    object.ColorPicker({
      onSubmit: function(hsb, hex, rgb, el) {
        $(el).val(getColor(hex));
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