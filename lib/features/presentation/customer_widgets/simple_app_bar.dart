// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../../core/page_routes/routes.dart';
import '../../../core/styles/txt_styles.dart';
import '../../../core/themes/app_theme.dart';
import '../customer_pages/basket/basket_page.dart';
import '../providers/customer_providers/basket_notifier.dart';

class SimpleAppBar {
  final BuildContext context;

  SimpleAppBar(this.context);

  AppBar create({
    required String text,
    bool? showBackBtn,
    bool? showBasketBtn,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,

      leading: (showBackBtn ?? false)
          ? Parent(
              gesture: Gestures()..onTap(() => Routes.sailor.pop()),
              style: ParentStyle()
                ..width(48)
                ..height(48)
                ..margin(all: 4)
                ..borderRadius(all: 24)
                ..alignmentContent.center()
                ..ripple(true),
              child: Image.asset(
                "assets/images/ic_arrow_right.png",
                fit: BoxFit.contain,
                color: Colors.white,
                width: 24,
                height: 24,
              ),
            )
          : SizedBox(),
      // titleSpacing: 1,
      centerTitle: true,
      title: Txt(
        text,
        style: AppTxtStyles().subHeading
          // ..margin(right: showBackBtn ?? false ? 4 : 16)
          ..textColor(AppTheme.white)
          ..textOverflow(TextOverflow.ellipsis)
          ..maxLines(1)
          ..bold(),
      ),
      actions: [
        if (showBasketBtn ?? false)
          Consumer<BasketNotifier>(
            builder: (context, provider, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Parent(
                    gesture: Gestures()
                      ..onTap(() {
                        Routes.sailor(BasketPage.route);
                      }),
                    style: ParentStyle()
                      ..width(48)
                      ..height(48)
                      ..margin(left: 4)
                      ..borderRadius(all: 24)
                      ..alignmentContent.center()
                      ..ripple(true),
                    child: Image.asset(
                      "assets/images/ic_shop_cart.png",
                      fit: BoxFit.contain,
                      color: Colors.white,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Positioned(
                    right: 2,
                    top: 12,
                    child: Visibility(
                      visible: provider.basketCount != null &&
                          provider.basketCount != 0,
                      child: Txt(
                        "${provider.basketCount}",
                        style: TxtStyle()
                          ..minWidth(16)
                          ..height(16)
                          ..padding(horizontal: 4, top: 1)
                          ..borderRadius(all: 8)
                          ..background.color(AppTheme.customerAccent)
                          ..fontSize(10)
                          ..bold()
                          ..textColor(Colors.white)
                          ..textAlign.center(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
