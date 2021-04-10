import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/styles/txt_styles.dart';

class ProductListItemCounter extends StatefulWidget {
  ProductListItemCounter({
    Key key,
    this.defaultValue,
    this.step,
    this.unit,
    this.onIncrease,
    this.onDecrease,
    this.hieght,
  }) : super(key: key);

  final num defaultValue;
  final num step;
  final String unit;
  final void Function(num) onIncrease;
  final void Function(num) onDecrease;
  final double hieght;

  @override
  ProductListItemCounterState createState() => ProductListItemCounterState();
}

class ProductListItemCounterState extends State<ProductListItemCounter>
    with AutomaticKeepAliveClientMixin<ProductListItemCounter> {
  num counter;

  @override
  void initState() {
    super.initState();
    counter = widget.defaultValue ?? 0;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..borderRadius(all: 8)
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
                    onTap: _increament,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Txt(
                    widget.unit == null
                        ? (counter)
                            .toStringAsFixed(widget.step is double ? 1 : 0)
                        : (counter).toStringAsFixed(
                                widget.step is double ? 1 : 0) +
                            " ${widget.unit} ",
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
    counter = counter + widget.step;
    widget.onIncrease(counter);
    setState(() {});
  }

  void _decreament() {
    if (counter == 0) return;
    counter = counter - widget.step;
    widget.onDecrease(counter);
    setState(() {});
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
        ..borderRadius(all: 8)
        ..ripple(true),
      child: Icon(
        iconData,
        color: Colors.black,
        size: iconSize ?? 18,
      ),
    );
  }
}
