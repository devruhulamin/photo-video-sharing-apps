import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreem = bool Function(String);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen closeLoadingScreen;
  final UpdateLoadingScreem updateLoadingScreem;

  const LoadingScreenController(
      {required this.closeLoadingScreen, required this.updateLoadingScreem});
}
