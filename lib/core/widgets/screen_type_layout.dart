import 'package:flutter/widgets.dart';

import 'device_screen_type.dart';
import 'responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  const ScreenTypeLayout({
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
          if (desktop != null) return desktop!;
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          if (tablet != null) return tablet!;
        }

        return mobile;
      },
    );
  }
}
