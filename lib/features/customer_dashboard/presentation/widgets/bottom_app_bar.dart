import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import 'subpage_basket.dart';
import 'subpage_home.dart';
import 'subpage_profile.dart';
import 'subpage_search.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({
    Key key,
    @required this.onIndexChanged,
  }) : super(key: key);

  final void Function(Widget) onIndexChanged;

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int currentIndex = 0;
  var bottomNavigationBarItems;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: bottomNavigationBar,
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      notchMargin: 0.0,
      elevation: 8.0,
    );
  }

  Widget get bottomNavigationBar {
    bottomNavigationBarItems = _BottomNavigationBarList.items.map(
      (item) {
        if (item == null) return SizedBox();

        var color = item.index == currentIndex
            ? AppTheme.customerPrimary
            : AppTheme.black.withOpacity(0.5);

        return Expanded(
          flex: 1,
          child: Parent(
            gesture: Gestures()
              ..onTap(() {
                setState(() {
                  currentIndex = item.index;
                  widget.onIndexChanged(item.widget);
                });
              }),
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
    ).toList();

    var bottomNavigationBar = Parent(
      style: ParentStyle()
        ..height(56)
        ..padding(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: bottomNavigationBarItems,
      ),
    );

    return bottomNavigationBar;
  }
}

class _BottomNavigationBarList {
  static final items = [
    __BottomNavigationBarListItem(
      index: 0,
      label: "خانه",
      iconData: Feather.home,
      widget: HomeSubPage(),
    ),
    __BottomNavigationBarListItem(
      index: 1,
      label: "جستجو",
      iconData: Feather.search,
      widget: SearchSubPage(),
    ),
    __BottomNavigationBarListItem(
      index: 2,
      label: "سبد خرید",
      iconData: Feather.shopping_bag,
      widget: BasketSubPage(),
    ),
    __BottomNavigationBarListItem(
      index: 3,
      label: "پروفایل",
      iconData: Feather.user,
      widget: ProfileSubPage(),
    ),
  ];
}

class __BottomNavigationBarListItem {
  __BottomNavigationBarListItem({
    @required this.index,
    @required this.label,
    @required this.iconData,
    @required this.widget,
  });

  final int index;
  final String label;
  final IconData iconData;
  final Widget widget;
}
