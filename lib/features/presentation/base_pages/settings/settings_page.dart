import 'package:flutter/material.dart';

import '../../../../core/languages/language.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/settings_menu.dart';

class SettingsPage extends StatelessWidget {
  static const route = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).settingsPage,
        showBackBtn: true,
      ),
      body: SettingsMenu(),
    );
  }
}
