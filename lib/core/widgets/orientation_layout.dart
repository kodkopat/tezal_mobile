import 'package:flutter/widgets.dart';

class OrientationLayout extends StatelessWidget {
  const OrientationLayout({
    required this.portrait,
    this.landscape,
  });

  final Widget portrait;
  final Widget? landscape;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return landscape ?? portrait;
        }
        return portrait;
      },
    );
  }
}
