import 'dart:ui';

import 'package:flutter/services.dart';

class GoogleMapsUI {
  Future<Uint8List> getImageFromRawData(String image, double width) async {
    ByteData imageData = await rootBundle.load(image);
    Codec imageCodec = await instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );
    FrameInfo imageFrame = await imageCodec.getNextFrame();
    ByteData? imageByteData =
        await imageFrame.image.toByteData(format: ImageByteFormat.png);
    return imageByteData!.buffer.asUint8List();
  }
}
