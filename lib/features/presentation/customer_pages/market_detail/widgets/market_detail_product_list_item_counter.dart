import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../../core/styles/txt_styles.dart';

class MarketProductListItemCounter extends StatefulWidget {
  MarketProductListItemCounter({Key key}) : super(key: key);

  @override
  _MarketProductListItemCounterState createState() =>
      _MarketProductListItemCounterState();
}

class _MarketProductListItemCounterState
    extends State<MarketProductListItemCounter>
    with AutomaticKeepAliveClientMixin<MarketProductListItemCounter> {
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
          _CounterIcon(
            iconData: Feather.plus,
            onTap: _increament,
          ),
          Txt(
            "$counter",
            style: AppTxtStyles().body,
          ),
          _CounterIcon(
            iconData: Feather.minus,
            onTap: _decreament,
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
    this.size,
  }) : super(key: key);

  final IconData iconData;
  final void Function() onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..width(64)
        ..height(32)
        ..borderRadius(all: 4)
        ..ripple(true),
      child: Icon(
        iconData,
        color: Colors.black,
        size: size ?? 16,
      ),
    );
  }
}
