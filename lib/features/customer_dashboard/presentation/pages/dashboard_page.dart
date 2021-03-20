import 'package:flutter/material.dart';

import '../../../customer_home/presentation/pages/home_page.dart';
import '../widgets/bottom_app_bar.dart';

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
    // must be access this widget from CustomBottomAppBar
    currentWidget = HomePage();
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
