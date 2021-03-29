import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/styles/txt_styles.dart';

class ProductListItemCounter extends StatefulWidget {
  ProductListItemCounter({
    Key key,
    this.hieght,
  }) : super(key: key);

  final double hieght;

  @override
  ProductListItemCounterState createState() => ProductListItemCounterState();
}

class ProductListItemCounterState extends State<ProductListItemCounter>
    with AutomaticKeepAliveClientMixin<ProductListItemCounter> {
  int counter = 0;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..borderRadius(all: 4)
        ..background.color(Color(0xffEFEFEF)),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: _CounterIcon(
              iconData: Feather.plus,
              height: widget.hieght,
              onTap: _increament,
            ),
          ),
          Expanded(
            flex: 1,
            child: Txt(
              "$counter",
              style: AppTxtStyles().body,
            ),
          ),
          Expanded(
            flex: 1,
            child: _CounterIcon(
              iconData: Feather.minus,
              height: widget.hieght,
              onTap: _decreament,
            ),
          ),
        ],
      ),
    );
  }

  void _increament() {
    setState(() => counter++);
  }

  void _decreament() {
    if (counter > 0) setState(() => counter--);
  }

  @override
  bool get wantKeepAlive => true;
}

class _CounterIcon extends StatelessWidget {
  const _CounterIcon({
    Key key,
    @required this.iconData,
    @required this.onTap,
    this.height,
    this.iconSize,
  }) : super(key: key);

  final IconData iconData;
  final void Function() onTap;
  final double height;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..height(height ?? 36)
        ..borderRadius(all: 4)
        ..ripple(true),
      child: Icon(
        iconData,
        color: Colors.black,
        size: iconSize ?? 18,
      ),
    );
  }
}
