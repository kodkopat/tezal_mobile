import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/themes/app_theme.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRing(
        duration: Duration(milliseconds: 1000),
        color: AppTheme.red,
        lineWidth: 4,
        size: 36.0,
      ),
    );
  }
}
