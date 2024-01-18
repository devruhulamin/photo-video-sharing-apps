import 'dart:math';

extension IntFormatter on int {
  String intToViewConvert() {
    if (this < 10) {
      return '0$this'; // Prefix with 0 for single-digit numbers
    } else {
      final suffixes = ['', 'k', 'm', 'b'];
      final suffixIndex = (log(this) / log(1000)).floor();
      final abbreviatedValue = this ~/ pow(1000, suffixIndex);
      return '${abbreviatedValue.toStringAsFixed(1)}${suffixes[suffixIndex]}';
    }
  }
}
