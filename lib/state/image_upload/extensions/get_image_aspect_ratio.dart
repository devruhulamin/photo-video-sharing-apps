import 'dart:async' show Completer;

import 'package:flutter/material.dart' as material;

extension GetImageAspectRation on material.Image {
  Future<double> getAspectRation() async {
    final completer = Completer<double>();
    image
        .resolve(const material.ImageConfiguration())
        .addListener(material.ImageStreamListener((imageInfo, synchronousCall) {
      final aspectRation = imageInfo.image.width / imageInfo.image.height;
      completer.complete(aspectRation);
      imageInfo.image.dispose();
    }));
    return completer.future;
  }
}
