import 'package:flutter/material.dart';

import '../home/home_page.dart';
import 'widgets/bottom_app_bar.dart';

class DashBoardPage extends StatefulWidget {
  static const route = "/customer_dashboard";

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with AutomaticKeepAliveClientMixin<DashBoardPage> {
  Widget? currentWidget;
  CustomBottomAppBar? bottomAppBar;

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
