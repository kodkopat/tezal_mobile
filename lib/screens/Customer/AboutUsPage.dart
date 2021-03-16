import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../lang/Lang.dart';
import 'widgets/AppBarNew.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNew(title: Lang(context).aboutUs),
    );
  }
}
