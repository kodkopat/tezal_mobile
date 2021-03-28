import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LikedProductListItemLikeToggle extends StatefulWidget {
  const LikedProductListItemLikeToggle({
    Key key,
    @required this.onChange,
    this.defaultValue,
  }) : super(key: key);

  final bool defaultValue;
  final void Function(bool) onChange;

  @override
  _LikedProductListItemLikeToggleState createState() =>
      _LikedProductListItemLikeToggleState();
}

class _LikedProductListItemLikeToggleState
    extends State<LikedProductListItemLikeToggle>
    with AutomaticKeepAliveClientMixin<LikedProductListItemLikeToggle> {
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
        ..width(64)
        ..height(64)
        ..alignmentContent.center()
        ..background.color(Color(0xffEFEFEF).withOpacity(0.5))
        ..borderRadius(all: 8)
        ..ripple(true),
      child: Icon(
        Feather.heart,
        color: value ? Colors.red : Colors.black,
        size: 24,
      ),
    );
  }

  void _changeValue() {
    setState(() => value = !value);
  }

  @override
  bool get wantKeepAlive => true;
}
