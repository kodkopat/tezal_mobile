import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_icons/flutter_icons.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../about_us/about_us_page.dart';
import '../../addresses/addresses_page.dart';
import '../../liked_products/liked_products_page.dart';
import '../../orders/orders_page.dart';
import '../../wallet/wallet_page.dart';
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
        // ProfileMenuItem(
        //   text: "اطلاعات شخصی",
        // iconData: Feather.user,
        //   onTap: () {},
        // ),

        ProfileMenuItem(
          text: "آدرس‌های من",
          // iconData: Feather.map_pin,
          iconPath: "assets/images/ic_location.png",
          onTap: () {
            Routes.sailor(AddressesPage.route);
          },
        ),
        ProfileMenuItem(
          text: "کیف پول من",
          // iconData: Feather.credit_card,
          iconPath: "assets/images/ic_wallet.png",
          onTap: () {
            Routes.sailor(WalletPage.route);
          },
        ),
        ProfileMenuItem(
          text: "سفارشات قبلی",
          // iconData: Feather.shopping_bag,
          iconPath: "assets/images/ic_shop_basket.png",
          onTap: () {
            Routes.sailor(OrdersPage.route);
          },
        ),
        ProfileMenuItem(
          text: "محصولات مورد علاقه",
          // iconData: Feather.heart,
          iconPath: "assets/images/ic_heart.png",
          onTap: () {
            Routes.sailor(LikedProductsPage.route);
          },
        ),
        _divider,

        // ProfileMenuItem(
        //   text: "پشتیبانی",
        // iconData: Feather.life_buoy,
        //   onTap: () {},
        // ),

        // ProfileMenuItem(
        //   text: "قوانین و مقررات",
        // iconData: Feather.file_text,
        //   onTap: () {},
        // ),

        ProfileMenuItem(
          text: "تنظیمات",
          // iconData: Feather.settings,
          iconPath: "assets/images/ic_setting.png",
          onTap: () {},
        ),

        ProfileMenuItem(
          text: "درباره ما",
          // iconData: Feather.info,
          iconPath: "assets/images/ic_info.png",

          onTap: () {
            Routes.sailor(AboutUsPage.route);
          },
        ),
        _divider,

        ProfileMenuItem(
          text: "خروج از حساب کاربری",
          // iconData: Feather.log_out,
          iconPath: "assets/images/ic_log_out.png",
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
