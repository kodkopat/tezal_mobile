import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductListItemLikeToggle extends StatefulWidget {
  ProductListItemLikeToggle({
    Key key,
    @required this.onChange,
    this.defaultValue,
  }) : super(key: key);

  final bool defaultValue;
  final void Function(bool) onChange;

  @override
  _ProductListItemLikeToggleState createState() =>
      _ProductListItemLikeToggleState();
}

class _ProductListItemLikeToggleState extends State<ProductListItemLikeToggle>
    with AutomaticKeepAliveClientMixin<ProductListItemLikeToggle> {
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
        ..borderRadius(all: 8)
        // ..background.color(Color(0xffEFEFEF))
        ..ripple(true),
      child: Icon(
        Icons.favorite_rounded,
        color: !value
            ? Color(0xffEFEFEF).withOpacity(0.8)
            : Colors.red.withOpacity(0.8),
        size: 30,
      ),
    );
  }

  void _changeValue() {
    setState(() => value = !value);
  }

  @override
  bool get wantKeepAlive => true;
}
