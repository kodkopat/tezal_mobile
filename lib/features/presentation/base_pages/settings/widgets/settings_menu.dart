import 'package:flutter/material.dart';

import '../../../../../core/languages/language.dart';
import '../../language_selector/language_selector_page.dart';
import '../../update_detail/update_detail_page.dart';
import 'settings_menu_item.dart';

class SettingsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8),
      children: _ProfileMenu.items(context),
    );
  }
}

class _ProfileMenu {
  static var _divider = Divider(
    color: Colors.black12,
    thickness: 0.5,
    height: 0,
    indent: 56,
  );

  static List<Widget> items(BuildContext context) => [
        SettingsMenuItem(
          text: Lang.of(context).settingNotification,
          iconPath: "assets/images/ic_bell.png",
          onTap: () {
            // Routes.sailor(WalletPage.route);
          },
        ),
        _divider,
        SettingsMenuItem(
          text: Lang.of(context).settingsLanguage,
          iconPath: "assets/images/ic_document.png",
          onTap: () async {
            await showDialog(
              context: context,
              barrierColor: Colors.transparent,
              builder: (context) => LanguagesSelectorPage(),
            );
          },
        ),
        _divider,
        SettingsMenuItem(
          text: Lang.of(context).settingsUpdate,
          iconPath: "assets/images/ic_refresh.png",
          onTap: () async {
            await showDialog(
              context: context,
              barrierColor: Colors.transparent,
              builder: (context) => UpdateDetailPage(),
            );
          },
        ),
      ];
}
