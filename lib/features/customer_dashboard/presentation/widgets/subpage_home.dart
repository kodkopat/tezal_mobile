import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/simple_app_bar.dart';

class HomeSubPage extends StatefulWidget {
  const HomeSubPage({Key key}) : super(key: key);

  @override
  _HomeSubPageState createState() => _HomeSubPageState();
}

class _HomeSubPageState extends State<HomeSubPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "خانه"),
        body: Center(
          child: Txt(
            "خانه",
            style: AppTxtStyles().body,
          ),
        ),
      ),
    );
  }
}
