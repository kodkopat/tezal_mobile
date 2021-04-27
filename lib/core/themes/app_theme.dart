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

  static final marketPrimary = Colors.blue;
  static final marketPrimaryDark = Colors.blue[700];
  static final marketPrimaryLight = Colors.blue[400];
  static final marketAccent = Colors.orange;

  static final deliveryPrimary = Colors.purple;
  static final deliveryPrimaryDark = Colors.purple[700];
  static final deliveryPrimaryLight = Colors.purple[400];
  static final deliveryAccent = Colors.orange;

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
          // color: Color(0xffFAFAFA),
          iconTheme: IconThemeData(
            color: Color(0xff4F4F4F),
          ),
        ),
      );

  static ThemeData marketThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        primaryColor: marketPrimary,
        primaryColorDark: marketPrimaryDark,
        primaryColorLight: marketPrimaryLight,
        accentColor: marketAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData deliveryThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        primaryColor: deliveryPrimary,
        primaryColorDark: deliveryPrimaryDark,
        primaryColorLight: deliveryPrimaryLight,
        accentColor: deliveryAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  // ThemeData themeData() {
  //   return ThemeData(
  //     fontFamily: "Shabnam",
  //     primarySwatch: Colors.blue,
  //     primaryColor: isDarkTheme ? black : white,
  //     disabledColor: Color(0xff4C5264).withOpacity(0.5),
  //     iconTheme: IconThemeData(
  //       color: isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4C5264),
  //     ),
  //     brightness: isDarkTheme ? Brightness.dark : Brightness.light,
  //     backgroundColor: isDarkTheme ? Color(0xff141415) : Color(0xffFAFAFA),
  //     cardColor: isDarkTheme ? Color(0xff1B1B1C) : Color(0xffFFFFFF),
  //     dividerColor: isDarkTheme ? Color(0xff212122) : Color(0xffE0E0E0),
  //     textTheme: TextTheme(
  //       bodyText1: TextStyle(
  //         fontSize: 14,
  //         letterSpacing: 0.5,
  //         fontWeight: FontWeight.normal,
  //         color: isDarkTheme ? Color(0xffF4F4F4) : Color(0xff4C5264),
  //       ),
  //     ),
  //     scaffoldBackgroundColor:
  //         isDarkTheme ? Color(0xff141415) : Color(0xffFAFAFA),

  //   );
  // }
}
