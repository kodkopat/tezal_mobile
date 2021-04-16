// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../basket/basket_page.dart';
import '../../category/category_page.dart';
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
                      Icon(
                        item.iconData,
                        color: color,
                        size: 24,
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
      iconData: Feather.home,
      widget: HomePage(),
    ),
    __BottomNavigationBarListItem(
      index: 1,
      label: "جستجو",
      iconData: Feather.search,
      widget: SearchPage(),
    ),
    __BottomNavigationBarListItem(
      index: 2,
      label: "دسته‌بندی",
      iconData: Feather.grid,
      widget: CategoryPage(),
    ),
    __BottomNavigationBarListItem(
      index: 3,
      label: "سبد خرید",
      iconData: Feather.shopping_cart,
      widget: BasketPage(),
    ),
    __BottomNavigationBarListItem(
      index: 4,
      label: "پروفایل",
      iconData: Feather.user,
      widget: ProfilePage(),
    ),
  ];
}

class __BottomNavigationBarListItem {
  __BottomNavigationBarListItem({
    required this.index,
    required this.label,
    required this.iconData,
    required this.widget,
  });

  final int index;
  final String label;
  final IconData iconData;
  final Widget widget;
}
