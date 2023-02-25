extension DateTimeX on DateTime {
  int get unixTimestamp {
    return millisecondsSinceEpoch ~/ 1000;
  }
}
