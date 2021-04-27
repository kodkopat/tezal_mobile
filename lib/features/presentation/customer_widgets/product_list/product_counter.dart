// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';

class ProductListItemCounter extends StatefulWidget {
  ProductListItemCounter({
    required this.defaultValue,
    required this.step,
    required this.unit,
    required this.onIncrease,
    required this.onDecrease,
    required this.hieght,
  });

  final num defaultValue;
  final num step;
  final String unit;
  final void Function() onIncrease;
  final void Function() onDecrease;
  final double hieght;

  @override
  ProductListItemCounterState createState() => ProductListItemCounterState();
}

class ProductListItemCounterState extends State<ProductListItemCounter>
    with AutomaticKeepAliveClientMixin<ProductListItemCounter> {
  num counter = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    counter = widget.defaultValue;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..borderRadius(all: 6)
        ..background.color(Color(0xffEFEFEF)),
      child: counter == 0 || counter == 0.0
          ? Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: _CounterIcon(
                    iconData: Feather.plus,
                    height: widget.hieght,
                    onTap: _increament,
                    iconSize: 14,
                  ),
                ),
              ],
            )
          : Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: _CounterIcon(
                    iconData: Feather.plus,
                    height: widget.hieght,
                    onTap: loading ? () {} : _increament,
                    iconSize: 14,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: loading
                      ? AppLoading(size: 16)
                      : Txt(
                          (counter).toStringAsFixed(
                                  widget.step is double ? 1 : 0) +
                              " ${widget.unit} ",
                          gesture: Gestures()..onTap(() {}),
                          style: AppTxtStyles().footNote,
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: _CounterIcon(
                    iconData: Feather.minus,
                    height: widget.hieght,
                    onTap: loading ? () {} : _decreament,
                    iconSize: 14,
                  ),
                ),
              ],
            ),
    );
  }

  void _increament() async {
    setState(() => loading = true);
    counter = counter + widget.step;
    widget.onIncrease();
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() => loading = false);
  }

  void _decreament() async {
    if (counter == 0) return;
    setState(() => loading = true);
    widget.onDecrease();
    await Future.delayed(Duration(milliseconds: 1000));
    counter = counter - widget.step;
    setState(() => loading = false);
  }

  @override
  bool get wantKeepAlive => true;
}

class _CounterIcon extends StatelessWidget {
  const _CounterIcon({
    required this.iconData,
    required this.onTap,
    required this.height,
    required this.iconSize,
  });

  final IconData iconData;
  final void Function() onTap;
  final double height;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..height(height)
        ..borderRadius(all: 6)
        ..ripple(true),
      child: Icon(
        iconData,
        color: Colors.black,
        size: iconSize,
      ),
    );
  }
}
