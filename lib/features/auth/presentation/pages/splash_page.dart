import 'package:division/division.dart';
import 'package:flutter/material.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../data/repositories/auth_repository.dart';

class SplashPage extends StatefulWidget {
  static const route = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final repository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Txt(
          "خوش آمدید",
          style: AppTxtStyles().body,
        ),
      ),
    );
  }
}
