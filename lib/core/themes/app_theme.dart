import 'package:flutter/material.dart';

class AppTheme {
  AppTheme({
    required this.context,
    required this.isDarkTheme,
  });

  final BuildContext context;
  final bool isDarkTheme;

  static final icons = Color(0xff4F4F4F);
  static final headTitle = Color(0xff4F4F4F);
  static final subTitle = Color(0xff828282);
  static final forms = Color(0xffE0E0E0);
  static final separator = Color(0xffF4F4F4);

  static final customerPrimary = Colors.green;
  static final customerPrimaryDark = Colors.green[700];
  static final customerPrimaryLight = Colors.green[400];
  static final customerAccent = Colors.orange;

  static ThemeData customerThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        primaryColor: customerPrimary,
        primaryColorDark: customerPrimaryDark,
        primaryColorLight: customerPrimaryLight,
        accentColor: customerAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xffFFFFFF),
        backgroundColor: Color(0xffFFFFFF),
        appBarTheme: AppBarTheme(
          elevation: 2.0,
          shadowColor: Color(0xffF4F4F4),
          iconTheme: IconThemeData(
            color: Color(0xff4F4F4F),
          ),
        ),
      );

  static final marketPrimary = Colors.blue;
  static final marketPrimaryDark = Colors.blue[700];
  static final marketPrimaryLight = Colors.blue[400];
  static final marketAccent = Colors.orange;

  static ThemeData marketThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        primaryColor: marketPrimary,
        primaryColorDark: marketPrimaryDark,
        primaryColorLight: marketPrimaryLight,
        accentColor: marketAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xffFFFFFF),
        backgroundColor: Color(0xffFFFFFF),
        appBarTheme: AppBarTheme(
          elevation: 2.0,
          shadowColor: Color(0xffF4F4F4),
          iconTheme: IconThemeData(
            color: Color(0xff4F4F4F),
          ),
        ),
      );

  static final deliveryPrimary = Colors.purple;
  static final deliveryPrimaryDark = Colors.purple[700];
  static final deliveryPrimaryLight = Colors.purple[400];
  static final deliveryAccent = Colors.orange;

  static ThemeData deliveryThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        primaryColor: deliveryPrimary,
        primaryColorDark: deliveryPrimaryDark,
        primaryColorLight: deliveryPrimaryLight,
        accentColor: deliveryAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xffFFFFFF),
        backgroundColor: Color(0xffFFFFFF),
        appBarTheme: AppBarTheme(
          elevation: 2.0,
          shadowColor: Color(0xffF4F4F4),
          iconTheme: IconThemeData(
            color: Color(0xff4F4F4F),
          ),
        ),
      );
}
