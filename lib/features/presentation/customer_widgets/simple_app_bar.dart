import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../../core/page_routes/routes.dart';
import '../../../core/styles/txt_styles.dart';
import '../../../core/themes/app_theme.dart';
import '../customer_pages/basket/basket_page.dart';
import '../providers/customer_providers/basket_notifier.dart';

class SimpleAppBar {
  AppBar create(
    BuildContext context, {
    @required String text,
    bool showBackBtn,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 1,
      title: Row(
        children: [
          if (showBackBtn ?? false)
            Parent(
              gesture: Gestures()..onTap(() => Routes.sailor.pop()),
              style: ParentStyle()
                ..width(48)
                ..height(48)
                ..margin(right: 4)
                ..borderRadius(all: 24)
                ..ripple(true),
              child: Icon(
                Feather.arrow_right,
                color: Colors.white,
                size: 24,
              ),
            ),
          Txt(
            text,
            style: AppTxtStyles().subHeading
              ..margin(right: showBackBtn ?? false ? 4 : 16)
              ..textColor(AppTheme.white)
              ..textOverflow(TextOverflow.ellipsis)
              ..maxLines(1)
              ..bold(),
          ),
        ],
      ),
      actions: [
        if (ModalRoute.of(context).settings.name != BasketPage.route)
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
                      ..ripple(true),
                    child: Icon(
                      Feather.shopping_cart,
                      color: Colors.white,
                      size: 24,
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
                          ..padding(horizontal: 4)
                          ..borderRadius(all: 8)
                          ..background.color(Colors.red)
                          ..fontSize(10)
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
