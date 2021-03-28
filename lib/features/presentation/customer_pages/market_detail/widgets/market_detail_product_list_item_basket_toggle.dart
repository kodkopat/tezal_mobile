import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MarketDetailProductListItemBasketToggle extends StatefulWidget {
  MarketDetailProductListItemBasketToggle({
    Key key,
    @required this.onChange,
    this.defaultValue,
  }) : super(key: key);

  final bool defaultValue;
  final void Function(bool) onChange;

  @override
  _MarketDetailProductListItemBasketToggleState createState() =>
      _MarketDetailProductListItemBasketToggleState();
}

class _MarketDetailProductListItemBasketToggleState
    extends State<MarketDetailProductListItemBasketToggle>
    with
        AutomaticKeepAliveClientMixin<MarketDetailProductListItemBasketToggle> {
  bool value;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue ?? false;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()
        ..onTap(() {
          _changeValue();
          widget.onChange(value);
        }),
      style: ParentStyle()
        ..width(36)
        ..height(36)
        ..borderRadius(all: 4)
        ..background.color(Color(0xffEFEFEF))
        ..ripple(true),
      child: Icon(
        Feather.shopping_cart,
        color: !value ? Colors.black : Colors.red,
        size: 18,
      ),
    );
  }

  void _changeValue() {
    setState(() => value = !value);
  }

  @override
  bool get wantKeepAlive => true;
}
