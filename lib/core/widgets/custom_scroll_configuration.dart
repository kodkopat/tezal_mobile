import 'package:flutter/material.dart';

class CustomScrollConfiguration extends StatelessWidget {
  CustomScrollConfiguration({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: child,
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(context, child, axisDirection) => child;
}
