import 'dart:ui';

import 'package:division/division.dart';
import 'package:flutter/scheduler.dart';

class AppTxtStyles {
  AppTxtStyles() {
    bool isDarkTheme =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

    title = TxtStyle()
      ..textDirection(TextDirection.rtl)
      ..textAlign.center(true)
      ..textColor(isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4F4F4F))
      ..letterSpacing(0.25)
      ..fontWeight(FontWeight.normal)
      ..fontSize(32);

    subTitle = TxtStyle()
      ..textDirection(TextDirection.rtl)
      ..textAlign.center(true)
      ..textColor(isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4F4F4F))
      ..letterSpacing(0.0)
      ..fontWeight(FontWeight.normal)
      ..fontSize(24);

    heading = TxtStyle()
      ..textDirection(TextDirection.rtl)
      ..textAlign.center(true)
      ..textColor(isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4F4F4F))
      ..letterSpacing(0.15)
      ..fontWeight(FontWeight.normal)
      ..fontSize(20);

    subHeading = TxtStyle()
      ..textDirection(TextDirection.rtl)
      ..textAlign.center(true)
      ..textColor(isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4F4F4F))
      ..letterSpacing(0.15)
      ..fontWeight(FontWeight.normal)
      ..fontSize(16);

    body = TxtStyle()
      ..textDirection(TextDirection.rtl)
      ..textAlign.center(true)
      ..textColor(isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4F4F4F))
      ..letterSpacing(0.5)
      ..fontWeight(FontWeight.normal)
      ..fontSize(14);

    footNote = TxtStyle()
      ..textDirection(TextDirection.rtl)
      ..textAlign.center(true)
      ..textColor(isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4F4F4F))
      ..letterSpacing(0.4)
      ..fontWeight(FontWeight.normal)
      ..fontSize(12);
  }

  TxtStyle title;
  TxtStyle subTitle;
  TxtStyle heading;
  TxtStyle subHeading;
  TxtStyle body;
  TxtStyle footNote;
}
