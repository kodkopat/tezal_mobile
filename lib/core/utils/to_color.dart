import 'package:flutter/material.dart';

extension ToColor on String {
  Color toColor() {
    if (this.isEmpty) return Colors.transparent;
    return Color(int.parse("0xff$this"));
  }
}
