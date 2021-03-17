import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/simple_app_bar.dart';

class ProfileSubPage extends StatefulWidget {
  const ProfileSubPage({Key key}) : super(key: key);

  @override
  _ProfileSubPageState createState() => _ProfileSubPageState();
}

class _ProfileSubPageState extends State<ProfileSubPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "حساب کاربری"),
        body: Center(
          child: Txt(
            "حساب کاربری",
            style: AppTxtStyles().body,
          ),
        ),
      ),
    );
  }
}
