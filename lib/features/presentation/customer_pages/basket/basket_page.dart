import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/simple_app_bar.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
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
