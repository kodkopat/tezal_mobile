import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/simple_app_bar.dart';

class BasketSubPage extends StatefulWidget {
  const BasketSubPage({Key key}) : super(key: key);

  @override
  _BasketSubPageState createState() => _BasketSubPageState();
}

class _BasketSubPageState extends State<BasketSubPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "سبد خرید"),
        body: Center(
          child: Txt(
            "سبد خرید",
            style: AppTxtStyles().body,
          ),
        ),
      ),
    );
  }
}
