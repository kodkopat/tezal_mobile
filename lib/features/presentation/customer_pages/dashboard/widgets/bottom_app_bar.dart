// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../basket/basket_page.dart';
import '../../home/home_page.dart';
import '../../profile/profile_page.dart';
import '../../search/search_page.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({required this.onIndexChanged});

  final void Function(Widget) onIndexChanged;

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar>
    with AutomaticKeepAliveClientMixin<CustomBottomAppBar> {
  int currentIndex = 0;
  var bottomNavigationBarItems;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Parent(
        style: ParentStyle()
          ..height(56)
          ..padding(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _BottomNavigationBarList.items.map(
            (item) {
              var color = item.index == currentIndex
                  ? AppTheme.customerPrimary
                  : AppTheme.black;

              var iconPath = item.index == currentIndex
                  ? item.activeIconPath
                  : item.inactiveIconPath;

              return Expanded(
                flex: 1,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
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

  @override
  bool get wantKeepAlive => true;
}

class _BottomNavigationBarList {
  static final items = [
    __BottomNavigationBarListItem(
      index: 0,
      label: "خانه",
      activeIconPath: "assets/images/ic_home_filled.png",
      inactiveIconPath: "assets/images/ic_home.png",
      widget: HomePage(),
    ),
    __BottomNavigationBarListItem(
      index: 1,
      label: "جستجو",
      activeIconPath: "assets/images/ic_search_filled.png",
      inactiveIconPath: "assets/images/ic_search.png",
      widget: SearchPage(),
    ),
    __BottomNavigationBarListItem(
      index: 2,
      label: "سبد خرید",
      activeIconPath: "assets/images/ic_shop_cart_filled.png",
      inactiveIconPath: "assets/images/ic_shop_cart.png",
      widget: BasketPage(),
    ),
    __BottomNavigationBarListItem(
      index: 3,
      label: "پروفایل",
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
