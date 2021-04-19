import 'package:flutter/material.dart';

import 'custom_thumb_shape.dart';
import 'custom_track_shape.dart';

class CustomSliderTheme extends StatelessWidget {
  CustomSliderTheme({required this.child});

  final Slider child;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: CustomThumbShape(),
      ),
      child: child,
    );
  }
}
