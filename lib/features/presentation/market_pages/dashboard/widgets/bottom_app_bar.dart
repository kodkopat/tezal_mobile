// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../orders/orders_page.dart';
import '../../products/products_page.dart';
import '../../profile/profile_page.dart';
import '../../wallet/wallet_page.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({required this.onIndexChanged});

  final void Function(Widget) onIndexChanged;

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int currentIndex = 0;
  var bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    print("textDirection: ${Directionality.of(context)}\n");

    return BottomAppBar(
      child: Parent(
        style: ParentStyle()
          ..height(56)
          ..padding(horizontal: 8),
        child: Row(
          textDirection: Directionality.of(context),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _BottomNavigationBarList.items(context).map(
            (item) {
              var color = item.index == currentIndex
                  ? Theme.of(context).primaryColor
                  : Colors.black;

              var iconPath = item.index == currentIndex
                  ? item.activeIconPath
                  : item.inactiveIconPath;

              return Expanded(
                flex: 1,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (currentIndex != item.index)
                      setState(() {
                        currentIndex = item.index;
                        widget.onIndexChanged(item.widget);
                      });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        iconPath,
                        fit: BoxFit.contain,
                        color: color,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(height: 4),
                      Txt(
                        item.label,
                        style: AppTxtStyles().footNote
                          ..fontSize(10)
                          ..textColor(color),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      notchMargin: 0.0,
      elevation: 8.0,
    );
  }
}

class _BottomNavigationBarList {
  static List<__BottomNavigationBarListItem> items(BuildContext context) => [
        __BottomNavigationBarListItem(
          index: 0,
          label: "سفارشات",
          activeIconPath: "assets/images/ic_document_filled.png",
          inactiveIconPath: "assets/images/ic_document.png",
          widget: OrdersPage(),
        ),
        __BottomNavigationBarListItem(
          index: 1,
          label: "محصولات",
          activeIconPath: "assets/images/ic_category_filled.png",
          inactiveIconPath: "assets/images/ic_category.png",
          widget: ProductsPage(),
        ),
        __BottomNavigationBarListItem(
          index: 2,
          label: "کیف پول",
          activeIconPath: "assets/images/ic_wallet_filled.png",
          inactiveIconPath: "assets/images/ic_wallet.png",
          widget: WalletPage(),
        ),
        __BottomNavigationBarListItem(
          index: 3,
          label: "حساب کاربری",
          activeIconPath: "assets/images/ic_user_filled.png",
          inactiveIconPath: "assets/images/ic_user.png",
          widget: ProfilePage(),
        ),
      ];
}

class __BottomNavigationBarListItem {
  __BottomNavigationBarListItem({
    required this.index,
    required this.label,
    required this.activeIconPath,
    required this.inactiveIconPath,
    required this.widget,
  });

  final int index;
  final String label;
  final String activeIconPath;
  final String inactiveIconPath;
  final Widget widget;
}
