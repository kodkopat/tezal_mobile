import 'package:flutter/material.dart';

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackWidth = parentBox.size.width;
    final double trackHeight = sliderTheme.trackHeight!; // 2.0
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
