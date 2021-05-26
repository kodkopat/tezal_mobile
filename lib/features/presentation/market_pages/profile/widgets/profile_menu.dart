import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

import '../../../../../core/languages/language.dart';
import '../../../../../core/page_routes/base_routes.dart';
import '../../../base_pages/about_us/about_us_page.dart';
import '../../../base_pages/contacts/contacts_page.dart';
import '../../../base_pages/settings/settings_page.dart';
import '../../../base_widgets/modal_log_out.dart';
import '../../../app_notifier.dart';
import '../../comments/comments_page.dart';
import '../../default_hours/default_hours_page.dart';
import '../../photos/photos_page.dart';
import '../../profile_info/profile_info_page.dart';
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
          text: Lang.of(context).profilePage,
          iconPath: "assets/images/ic_user.png",
          onTap: () async {
            Routes.sailor(ProfileInfoPage.route);
          },
        ),
        ProfileMenuItem(
          text: Lang.of(context).workingTimesPage,
          iconPath: "assets/images/ic_clock_rectangle.png",
          onTap: () async {
            Routes.sailor(DefaultHoursPage.route);
          },
        ),
        ProfileMenuItem(
          text: Lang.of(context).marketPhotosPage,
          iconPath: "assets/images/ic_image.png",
          onTap: () async {
            Routes.sailor(PhotosPage.route);
          },
        ),
        ProfileMenuItem(
          text: Lang.of(context).marketCommentsPage,
          iconPath: "assets/images/ic_comment.png",
          onTap: () async {
            Routes.sailor(CommentsPage.route);
          },
        ),
        _divider,
        ProfileMenuItem(
          text: Lang.of(context).sharePage,
          iconPath: Directionality.of(context) == TextDirection.ltr
              ? "assets/images/ic_send_left.png"
              : "assets/images/ic_send_right.png",
          onTap: () async {
            Routes.sailor(ContactsPage.route);
          },
        ),
        ProfileMenuItem(
          text: Lang.of(context).settingsPage,
          iconPath: "assets/images/ic_setting.png",
          onTap: () {
            Routes.sailor(SettingsPage.route);
          },
        ),
        ProfileMenuItem(
          text: Lang.of(context).aboutUsPage,
          iconPath: "assets/images/ic_info.png",
          onTap: () {
            Routes.sailor(AboutUsPage.route);
          },
        ),
        _divider,
        ProfileMenuItem(
          text: Lang.of(context).logOut,
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

                    Provider.of<AppNotifier>(
                      context,
                      listen: false,
                    ).refresh();
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
