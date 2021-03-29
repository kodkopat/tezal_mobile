import 'package:flutter/material.dart';

import '../home/home_page.dart';
import 'widgets/bottom_app_bar.dart';

class CustomerDashBoardPage extends StatefulWidget {
  static const route = "/customer_dashboard";

  @override
  _CustomerDashBoardPageState createState() => _CustomerDashBoardPageState();
}

class _CustomerDashBoardPageState extends State<CustomerDashBoardPage>
    with AutomaticKeepAliveClientMixin<CustomerDashBoardPage> {
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
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentWidget,
      bottomNavigationBar: bottomAppBar,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
