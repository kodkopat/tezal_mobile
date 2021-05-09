// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/update_market_default_hours_model.dart';

class EditMarketDefaultHoursListItem extends StatelessWidget {
  EditMarketDefaultHoursListItem({
    required this.updateMarketDefaultHour,
    required this.onChange,
  });

  final UpdateMarketDefaultHoursModel updateMarketDefaultHour;
  final void Function(UpdateMarketDefaultHoursModel) onChange;

  @override
  Widget build(BuildContext context) {
    var startHourOnChanged = (value) {
      onChange(updateMarketDefaultHour..startHour = int.parse(value));
    };
    var startMinuteOnChanged = (value) {
      onChange(updateMarketDefaultHour..startMinute = int.parse(value));
    };
    var endHourOnChanged = (value) {
      onChange(updateMarketDefaultHour..endHour = int.parse(value));
    };
    var endMinuteOnChanged = (value) {
      onChange(updateMarketDefaultHour..endMinute = int.parse(value));
    };

    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Txt(
            "روز هفته: " + "${updateMarketDefaultHour.dayOfWeek}",
            style: AppTxtStyles().body..textAlign.start(),
          ),
          SizedBox(height: 4),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Txt("از: ", style: AppTxtStyles().body),
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  _TimeTextInput(onChanged: startHourOnChanged),
                  Txt(" : ", style: AppTxtStyles().body),
                  _TimeTextInput(onChanged: startMinuteOnChanged),
                ],
              ),
              Txt("تا: ", style: AppTxtStyles().body),
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  _TimeTextInput(onChanged: endHourOnChanged),
                  Txt(" : ", style: AppTxtStyles().body),
                  _TimeTextInput(onChanged: endMinuteOnChanged),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeTextInput extends StatelessWidget {
  _TimeTextInput({required this.onChanged});

  final void Function(String) onChanged;

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
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 36,
      alignment: Alignment.center,
      child: TextFormField(
        maxLines: 1,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
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
    );
  }
}
