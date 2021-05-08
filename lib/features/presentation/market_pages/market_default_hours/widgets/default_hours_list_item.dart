// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/market/market_default_hours_result_model.dart';

class MarketDefaultHoursListItem extends StatelessWidget {
  MarketDefaultHoursListItem({required this.marketDefaultHour});

  final MarketDefaultHour marketDefaultHour;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            "روز هفته: " + "${marketDefaultHour.dayOfWeek}",
            style: AppTxtStyles().body..textAlign.start(),
          ),
          Txt(
            "ساعت شروع: " +
                "${marketDefaultHour.startHour}:${marketDefaultHour.startMinute}",
            style: AppTxtStyles().body..textAlign.start(),
          ),
          Txt(
            "شاعت اتمام: " +
                "${marketDefaultHour.endHour}:${marketDefaultHour.endMinute}",
            style: AppTxtStyles().body..textAlign.start(),
          ),
        ],
      ),
    );
  }
}
