class TimeModel {
  int? minutes;
  int? seconds;
  int? actualMinutes;
  int? actualSeconds;
  String? displayMinutes;
  String? displaySeconds;
  TimeModel(
      {this.minutes,
      this.seconds,
      this.actualMinutes = 0,
      this.actualSeconds = 0,
      this.displayMinutes = '',
      this.displaySeconds = ''});

  void updateDisplay() {
    this.displayMinutes = convertToTimeString(this.actualMinutes);
    this.displaySeconds = convertToTimeString(this.actualSeconds);
  }

  void updateActual() {
    this.actualMinutes = this.minutes;
    this.actualSeconds = this.seconds;
  }

  String convertToTimeString(number) {
    return number < 10 ? '0' + number.toString() : number.toString();
  }
}
