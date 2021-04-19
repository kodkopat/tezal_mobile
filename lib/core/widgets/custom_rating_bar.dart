// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/txt_styles.dart';
import '../themes/app_theme.dart';
import 'custom_slider_theme.dart';

class CustomRatingBar extends StatefulWidget {
  const CustomRatingBar({
    required this.labelText,
    required this.textCtrl,
  });

  final String labelText;
  final TextEditingController textCtrl;

  @override
  _CustomRatingBarState createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  late double _sliderValue;

  final _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0.0,
    borderSide: BorderSide(
      style: BorderStyle.solid,
      color: Colors.black12,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
  );

  @override
  void initState() {
    super.initState();
    _sliderValue = 50;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(
          widget.labelText,
          style: AppTxtStyles().body
            ..padding(right: 4)
            ..bold(),
        ),
        Row(
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: CustomSliderTheme(
                  child: Slider(
                    min: 0,
                    max: 100,
                    value: _sliderValue,
                    onChanged: sliderOnChange,
                    activeColor: AppTheme.customerPrimary,
                    inactiveColor: Color(0xffEFEFEF),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 64,
              height: 36,
              alignment: Alignment.center,
              child: TextFormField(
                maxLines: 1,
                controller: widget.textCtrl..text = "${_sliderValue.round()}",
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.number,
                onFieldSubmitted: txtCtrlOnFieldSubmited,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(
                  border: _outlineInputBorder,
                  enabledBorder: _outlineInputBorder,
                  focusedBorder: _outlineInputBorder,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void sliderOnChange(double value) {
    setState(() {
      _sliderValue = value;
      widget.textCtrl.text = "${_sliderValue.round()}";
    });
  }

  void txtCtrlOnFieldSubmited(String value) {
    var temp = int.parse(value);
    if (temp <= 100) {
      setState(() {
        _sliderValue = temp.toDouble();
      });
    }
  }
}
