import 'package:flutter/material.dart';

class CustomScrollConfiguration extends StatelessWidget {
  final Widget child;

  CustomScrollConfiguration({
    @required this.child,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(behavior: MyBehavior(), child: child);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(context, child, axisDirection) => child;
}
