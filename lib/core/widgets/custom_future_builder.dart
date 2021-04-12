import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  CustomFutureBuilder({
    required this.future,
    required this.successBuilder,
    required this.errorBuilder,
  });

  final Future<T> future;
  final Widget Function(BuildContext, T?) successBuilder;
  final Widget Function(BuildContext, String) errorBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return successBuilder(context, snapshot.data);
        } else {
          return errorBuilder(context, "${snapshot.error}");
        }
      },
    );
  }
}
