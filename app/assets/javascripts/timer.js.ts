declare type callback = () => void;

class Timer {

  private time_left : number;
  private interval : any;

  private timeFormat(time : number) {
    return '' + Math.floor(time / 10) + (time % 10)
  }

  constructor(private options : TimerOptions) {

  }

  updateTimerHtml(total_seconds : number) {
    var hours : number = Math.floor(total_seconds / 3600);
    var minutes : number = Math.floor((total_seconds - hours*3600) / 60);
    var seconds : number = total_seconds - hours*3600 - minutes*60;

    document.getElementById(this.options.hour_id).innerHTML = this.timeFormat(hours);
    document.getElementById(this.options.minute_id).innerHTML = this.timeFormat(minutes);
    document.getElementById(this.options.second_id).innerHTML = this.timeFormat(seconds);
  }

  start() {
    this.time_left = this.options.second_length;
    this.updateTimerHtml(this.time_left);
    var self = this;
    console.time('a');
    this.interval = setInterval(function() { self.check_timer(self) }, 1000);
  }

  check_timer(scope : any) {
    scope.time_left--;
    scope.updateTimerHtml(scope.time_left);
    if (scope.time_left == 0) {
      console.timeEnd('a');
      clearInterval(scope.interval);
      scope.options.onFinish();
    }
  }
}

interface TimerOptions {
  hour_id : string;
  minute_id : string;
  second_id : string;
  onFinish : callback;
  second_length : number;
}