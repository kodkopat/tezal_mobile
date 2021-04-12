// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class ProductListItemLikeToggle extends StatefulWidget {
  const ProductListItemLikeToggle({
    Key? key,
    required this.defaultValue,
    required this.onChange,
  }) : super(key: key);

  final bool defaultValue;
  final void Function(bool) onChange;

  @override
  _ProductListItemLikeToggleState createState() =>
      _ProductListItemLikeToggleState();
}

class _ProductListItemLikeToggleState extends State<ProductListItemLikeToggle>
    with AutomaticKeepAliveClientMixin<ProductListItemLikeToggle> {
  bool value = false;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
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
