import 'package:flutter/foundation.dart';

class PercentChecker {
  final double firstLimit;
  final double middleLimit;
  final double finalLimit;

  PercentChecker({
    @required this.firstLimit,
    @required this.middleLimit,
    @required this.finalLimit,
  });

  PercentChecker.common()
      : this(
          firstLimit: 30.0,
          middleLimit: 60.0,
          finalLimit: 100.0,
        );

  void inRange(
    double percent, {
    @required Function() onFirstPart,
    @required Function() onMiddlePart,
    @required Function() onFinalPart,
  }) {
    if (percent <= firstLimit) {
      onFirstPart();
    } else if (percent <= middleLimit) {
      onMiddlePart();
    } else if (percent <= finalLimit) {
      onFinalPart();
    }
  }
}
