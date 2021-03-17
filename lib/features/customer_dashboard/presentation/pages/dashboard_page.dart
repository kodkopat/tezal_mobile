import 'package:flutter/material.dart';

import '../widgets/bottom_app_bar.dart';
import '../widgets/subpage_home.dart';

class CustomerDashBoardPage extends StatefulWidget {
  static const route = "/customer_dashboard";

  @override
  _CustomerDashBoardPageState createState() => _CustomerDashBoardPageState();
}

class _CustomerDashBoardPageState extends State<CustomerDashBoardPage> {
  Widget currentWidget;
  CustomBottomAppBar bottomAppBar;

  void initializeState() {
    bottomAppBar = CustomBottomAppBar(
      onIndexChanged: (widget) {
        setState(() => currentWidget = widget);
      },
    );
    // TODO: must be access this widget from CustomBottomAppBar
    currentWidget = HomeSubPage();
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
