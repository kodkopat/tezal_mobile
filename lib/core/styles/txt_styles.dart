import 'dart:ui';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class AppTxtStyles {
  AppTxtStyles()
      : title = TxtStyle()
          ..textDirection(TextDirection.rtl)
          ..textAlign.center(true)
          ..textColor(
              /* isDarkTheme ? Colors.white : Colors.black */ Colors.black)
          ..letterSpacing(0.25)
          ..fontWeight(FontWeight.normal)
          ..fontSize(32),
        subTitle = TxtStyle()
          ..textDirection(TextDirection.rtl)
          ..textAlign.center(true)
          ..textColor(
              /* isDarkTheme ? Colors.white : Colors.black */ Colors.black)
          ..letterSpacing(0.0)
          ..fontWeight(FontWeight.normal)
          ..fontSize(24),
        heading = TxtStyle()
          ..textDirection(TextDirection.rtl)
          ..textAlign.center(true)
          ..textColor(
              /* isDarkTheme ? Colors.white : Colors.black */ Colors.black)
          ..letterSpacing(0.15)
          ..fontWeight(FontWeight.normal)
          ..fontSize(20),
        subHeading = TxtStyle()
          ..textDirection(TextDirection.rtl)
          ..textAlign.center(true)
          ..textColor(
              /* isDarkTheme ? Colors.white : Colors.black */ Colors.black)
          ..letterSpacing(0.15)
          ..fontWeight(FontWeight.normal)
          ..fontSize(16),
        body = TxtStyle()
          ..textDirection(TextDirection.rtl)
          ..textAlign.center(true)
          ..textColor(
              /* isDarkTheme ? Colors.white : Colors.black */ Colors.black)
          ..letterSpacing(0.5)
          ..fontWeight(FontWeight.normal)
          ..fontSize(14),
        footNote = TxtStyle()
          ..textDirection(TextDirection.rtl)
          ..textAlign.center(true)
          ..textColor(
              /* isDarkTheme ? Colors.white : Colors.black */ Colors.black)
          ..letterSpacing(0.4)
          ..fontWeight(FontWeight.normal)
          ..fontSize(12) {
    /* bool isDarkTheme =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark; */
  }

  TxtStyle title;
  TxtStyle subTitle;
  TxtStyle heading;
  TxtStyle subHeading;
  TxtStyle body;
  TxtStyle footNote;
}
