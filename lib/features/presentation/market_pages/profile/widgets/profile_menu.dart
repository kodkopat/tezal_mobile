import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../../../../core/languages/language.dart';
import '../../../../../core/page_routes/base_routes.dart';
import '../../../base_pages/about_us/about_us_page.dart';
import '../../../base_pages/contacts/contacts_page.dart';
import '../../../base_pages/settings/settings_page.dart';
import '../../../providers/customer_providers/basket_notifier.dart';
import '../../bank_card_informations/banks_card_informations.dart';
import 'modal_log_out.dart';
import 'profile_menu_item.dart';

class ProfileMenu extends StatelessWidget {
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
        ProfileMenuItem(
          text: "اطلاعات کارت بانکی"
          /* Lang.of(context).profileMenuItemSettings */,
          iconPath: "assets/images/ic_wallet.png",
          onTap: () async {
            Routes.sailor(BankCardInformationsPage.route);
          },
        ),
        _divider,
        ProfileMenuItem(
          text: "معرفی اپلیکیشن به دوستان"
          /* Lang.of(context).profileMenuItemSettings */,
          iconPath: Directionality.of(context) == TextDirection.ltr
              ? "assets/images/ic_send_left.png"
              : "assets/images/ic_send_right.png",
          onTap: () async {
            Routes.sailor(ContactsPage.route);
          },
        ),
        ProfileMenuItem(
          text: Lang.of(context).profileMenuItemSettings,
          iconPath: "assets/images/ic_setting.png",
          onTap: () {
            Routes.sailor(SettingsPage.route);
          },
        ),
        ProfileMenuItem(
          text: Lang.of(context).profileMenuItemAboutUs,
          iconPath: "assets/images/ic_info.png",
          onTap: () {
            Routes.sailor(AboutUsPage.route);
          },
        ),
        _divider,
        ProfileMenuItem(
          text: Lang.of(context).profileMenuItemLogOut,
          iconPath: Directionality.of(context) == TextDirection.ltr
              ? "assets/images/ic_log_out_left.png"
              : "assets/images/ic_log_out_right.png",
          showChevron: false,
          onTap: () {
            showDialog(
              context: context,
              useSafeArea: true,
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.2),
              builder: (context) {
                return LogOutModal(
                  onAccept: () async {
                    var secureStorage = FlutterSecureStorage();
                    await secureStorage.deleteAll();

                    var basketNotifier =
                        Provider.of<BasketNotifier>(context, listen: false);

                    basketNotifier.refresh();

                    Routes.sailor.pop();
                    Routes.sailor.navigate(
                      "/",
                      navigationType: NavigationType.pushReplace,
                    );

                    // Phoenix.rebirth(context);
                  },
                  onDiscard: () {
                    Routes.sailor.pop();
                  },
                );
              },
            );
          },
        ),
      ];
}
