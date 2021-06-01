import 'package:flutter/material.dart';

import '../orders/orders_page.dart';
import 'widgets/bottom_app_bar.dart';

class DashBoardPage extends StatefulWidget {
  static const route = "/delivery_dashboard";

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  Widget? currentWidget;
  CustomBottomAppBar? bottomAppBar;

  void initializeState() {
    bottomAppBar = CustomBottomAppBar(
      onIndexChanged: (widget) {
        setState(() => currentWidget = widget);
      },
    );
    // must be access this widget from CustomBottomAppBar
    currentWidget = OrdersPage();
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentWidget,
      bottomNavigationBar: bottomAppBar,
    );
  }
}
