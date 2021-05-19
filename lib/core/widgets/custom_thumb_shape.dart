import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  CustomThumbShape({this.thumbRadius = 8.0});

  final double thumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final rectCircle = Rect.fromCircle(center: center, radius: thumbRadius);
    final rectBorder = Rect.fromCircle(center: center, radius: thumbRadius + 2);

    final fillPaintCircle = Paint()
      ..style = PaintingStyle.fill
      ..color = sliderTheme.activeTrackColor!;
    final fillPaintBorder = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    canvas.drawOval(rectBorder, fillPaintBorder);
    canvas.drawOval(rectCircle, fillPaintCircle);
  }
}
