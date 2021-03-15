import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezal/lang/Lang.dart';
import 'package:tezal/screens/Customer/widgets/AppBarNew.dart';

class PreviousOrdersPage extends StatefulWidget {
  @override
  _PreviousOrdersPageState createState() => _PreviousOrdersPageState();
}

class _PreviousOrdersPageState extends State<PreviousOrdersPage> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNew(title: Lang(context).previousOrders),
    );
  }
}
