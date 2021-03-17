import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/simple_app_bar.dart';

class SearchSubPage extends StatefulWidget {
  const SearchSubPage({Key key}) : super(key: key);

  @override
  _SearchSubPageState createState() => _SearchSubPageState();
}

class _SearchSubPageState extends State<SearchSubPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "جستجو"),
        body: Center(
          child: Txt(
            "جستجو",
            style: AppTxtStyles().body,
          ),
        ),
      ),
    );
  }
}
