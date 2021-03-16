import 'package:flutter/material.dart';

class AppTheme {
  AppTheme({
    @required this.context,
    @required this.isDarkTheme,
  });

  final BuildContext context;
  final bool isDarkTheme;

  static final Color red = Color(0xffFF6161);
  static final Color green = Color(0xff16C682);
  static final Color blue = Color(0xff3D74FA);
  static final Color yellow = Color(0xffF9C158);

  static final Color black = Color(0xff000000);
  static final Color white = Color(0xffFFFFFF);

  static final Color headTitle = Color(0xff4F4F4F);
  static final Color subTitle = Color(0xff828282);
  static final Color icons = Color(0xff4c5264);

  static final Color forms = Color(0xffE0E0E0);
  static final Color separator = Color(0xffF4F4F4);

  ThemeData themeData() {
    return ThemeData(
      fontFamily: "Shabnam",
      primarySwatch: Colors.blue,
      primaryColor: isDarkTheme ? black : white,
      disabledColor: Color(0xff4C5264).withOpacity(0.5),
      iconTheme: IconThemeData(
        color: isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4C5264),
      ),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      backgroundColor: isDarkTheme ? Color(0xff141415) : Color(0xffFAFAFA),
      cardColor: isDarkTheme ? Color(0xff1B1B1C) : Color(0xffFFFFFF),
      dividerColor: isDarkTheme ? Color(0xff212122) : Color(0xffE0E0E0),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 14,
          letterSpacing: 0.5,
          fontWeight: FontWeight.normal,
          color: isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4C5264),
        ),
      ),
      scaffoldBackgroundColor:
          isDarkTheme ? Color(0xff141415) : Color(0xffFAFAFA),
      appBarTheme: AppBarTheme(
        elevation: 1.0,
        shadowColor: isDarkTheme ? Color(0xffFAFAFA) : Color(0xff141415),
        color: isDarkTheme ? Color(0xff141415) : Color(0xffFAFAFA),
        iconTheme: IconThemeData(
          color: isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4C5264),
        ),
      ),
    );
  }
}
