import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sailor/sailor.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../addresses/addresses_page.dart';
import '../../liked_products/liked_products_page.dart';
import 'modal_about_us.dart';
import 'modal_log_out.dart';
import 'profile_menu_item.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: _ProfileMenu.items(context),
    );
  }
}

class _ProfileMenu {
  static var _divider = Divider(
    color: Colors.black12,
    thickness: 0.5,
    height: 0,
    indent: 36,
  );

  static List<Widget> items(BuildContext context) => [
        // ProfileMenuItem(
        //   text: "اطلاعات شخصی",
        //   iconData: Feather.user,
        //   onTap: () {},
        // ),

        ProfileMenuItem(
          text: "آدرس‌های من",
          iconData: Feather.map_pin,
          onTap: () {
            Routes.sailor(AddressesPage.route);
          },
        ),
        ProfileMenuItem(
          text: "سفارشات قبلی",
          iconData: Feather.shopping_bag,
          onTap: () {},
        ),
        ProfileMenuItem(
          text: "محصولات مورد علاقه",
          iconData: Feather.heart,
          onTap: () {
            Routes.sailor(LikedProductsPage.route);
          },
        ),
        _divider,

        // ProfileMenuItem(
        //   text: "پشتیبانی",
        //   iconData: Feather.life_buoy,
        //   onTap: () {},
        // ),

        // ProfileMenuItem(
        //   text: "قوانین و مقررات",
        //   iconData: Feather.file_text,
        //   onTap: () {},
        // ),

        ProfileMenuItem(
          text: "تنظیمات",
          iconData: Feather.settings,
          onTap: () {},
        ),

        ProfileMenuItem(
          text: "درباره ما",
          iconData: Feather.info,
          onTap: () {
            showDialog(
              context: context,
              useSafeArea: true,
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.2),
              builder: (context) {
                return AboutUsModal();
              },
            );
          },
        ),
        _divider,

        ProfileMenuItem(
          text: "خروج از حساب کاربری",
          iconData: Feather.log_out,
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
                    Routes.sailor.pop();
                    Routes.sailor.navigate(
                      "/",
                      navigationType: NavigationType.pushReplace,
                    );
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
