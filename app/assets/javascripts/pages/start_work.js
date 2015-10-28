start_work_handler = function() {
  console.log("Start work!");
  var cycle_counter = 0;

  var startAjaxForm = function(object,onSuccess,onFailure) {
    object.submit(function() {
      $.ajax({
        type: object.attr('method'),
        url: object.attr('action'),
        data: object.serialize(),
        dataType: 'json',
        success: onSuccess,
        error: function() {
          alert("ERROR!");
        }
      })
      return false;
    });
  }

  startAjaxForm($('#start-cycle-form'), function(json) {
    var length = window.cycle_minutes;
    $('#start-cycle-form').hide();
    var t = new Timer({
      second_length: length * 60,
      minute_id: 'timer-minute',
      hour_id: 'timer-hour',
      second_id: 'timer-second',
      onFinish: function() {
        $('#finish-cycle-form #cycle_minutes_duration').val(window.cycle_minutes);
        $('#finish-cycle-form').show();
      }
    });
    t.start();
  });

  startAjaxForm($('#finish-cycle-form'), function(json) {
    $('#start-break-form #break_is_long').val(++cycle_counter % cycles_to_long_break == 0);
    $('#finish-cycle-form').hide();
    $('#start-break-form').show();

    var time = Date.parse(json.started_at);

    var html = $('#cycles tr.hidden').get(0).outerHTML;
    html = html.replace(/#name/, json.description);
    html = html.replace(/#category/, json.category_name);
    html = html.replace(/#background/, json.background);
    html = html.replace(/#white_text/, json.white_text);
    // TODO fix time format to one with rounding
    html = html.replace(/#time/, time.getHours() + ':' + time.getMinutes());
    $('#cycles').prepend(html);
  });

  startAjaxForm($('#start-break-form'), function(json) {
    var length = cycle_counter % cycles_to_long_break == 0 ? long_break_minutes : short_break_minutes;
    $('#start-break-form').hide();
    var t = new Timer({
      second_length: length * 60,
      minute_id: 'timer-minute',
      hour_id: 'timer-hour',
      second_id: 'timer-second',
      onFinish: function() {
        $('#finish-break-form #break_minutes_duration').val(cycle_counter % cycles_to_long_break == 0 ? long_break_minutes : short_break_minutes);
        $('#finish-break-form').show();
      }
    });
    t.start();
  });

  startAjaxForm($('#finish-break-form'), function(json) {
    $('#finish-break-form').hide();
    $('#start-cycle-form').show();
  });
}
